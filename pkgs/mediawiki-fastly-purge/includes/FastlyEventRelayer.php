<?php
declare( strict_types=1 );

namespace MediaWiki\Extension\FastlyPurge;

use Psr\Log\LoggerInterface;
use Wikimedia\EventRelayer\EventRelayer;

class FastlyEventRelayer extends EventRelayer {
	/** @var string[] */
	private array $batchQueue = [];
	private float $lastFlushTime;

	private const BATCH_SIZE = 256;

	/**
	 * @param array<string, mixed> $params Configuration parameters
	 * @param FastlyApiClient $apiClient
	 * @param LoggerInterface $fastlyLogger
	 */
	public function __construct(
		array $params,
		private readonly FastlyApiClient $apiClient,
		private readonly LoggerInterface $fastlyLogger
	) {
		parent::__construct( $params );
		$this->lastFlushTime = microtime( true );

		// Register shutdown function to flush any remaining URLs
		register_shutdown_function( [ $this, 'flushBatch' ] );
	}

	/**
	 * @param string $channel
	 * @param array<int, array<string, mixed>> $events
	 */
	protected function doNotify( $channel, array $events ): bool {
		// Only handle CDN URL purge events
		if ( $channel !== 'cdn-url-purges' ) {
			return true;
		}

		$urls = [];
		foreach ( $events as $event ) {
			if ( isset( $event['url'] ) && is_string( $event['url'] ) ) {
				// MediaWiki guarantees full URLs are passed to CdnCacheUpdate::purge()
				$urls[] = $event['url'];
			}
		}

		if ( !$urls ) {
			return true;
		}

		// Add URLs to batch queue
		$this->batchQueue = array_merge( $this->batchQueue, $urls );

		// Remove duplicates
		$this->batchQueue = array_values( array_unique( $this->batchQueue ) );

		// Flush if batch size reached or if enough time has passed
		if ( count( $this->batchQueue ) >= self::BATCH_SIZE ||
			 ( microtime( true ) - $this->lastFlushTime ) > 0.5 ) {
			return $this->flushBatch();
		}

		return true;
	}

	/**
	 * Flush the current batch of URLs to Fastly
	 */
	public function flushBatch(): bool {
		if ( !$this->batchQueue ) {
			return true;
		}

		// Process URLs in batches of BATCH_SIZE
		$success = true;
		$chunks = array_chunk( $this->batchQueue, self::BATCH_SIZE );

		foreach ( $chunks as $batch ) {
			try {
				$this->fastlyLogger->debug( 'Purging batch of ' . count( $batch ) . ' URLs from Fastly' );

				if ( !$this->apiClient->purgeUrls( $batch ) ) {
					$this->fastlyLogger->error( 'Failed to purge URLs from Fastly', [
						'url_count' => count( $batch )
					] );
					$success = false;
				}
			} catch ( \Exception $e ) {
				$this->fastlyLogger->error( 'Exception during Fastly purge', [
					'exception' => $e->getMessage(),
					'url_count' => count( $batch )
				] );
				$success = false;
			}
		}

		// Clear the batch queue
		$this->batchQueue = [];
		$this->lastFlushTime = microtime( true );

		return $success;
	}
}
