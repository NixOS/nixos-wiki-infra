<?php
declare( strict_types=1 );

namespace MediaWiki\Extension\FastlyPurge;

use MediaWiki\Http\HttpRequestFactory;
use Psr\Log\LoggerInterface;

class FastlyApiClient {

	private const API_BASE_URL = 'https://api.fastly.com';

	public function __construct(
		private readonly string $apiKey,
		private readonly string $serviceId,
		private readonly HttpRequestFactory $httpFactory,
		private readonly LoggerInterface $logger
	) {
	}

	/**
	 * Purge multiple URLs from Fastly cache using soft purge
	 * @param string[] $urls
	 */
	public function purgeUrls( array $urls ): bool {
		if ( !$urls ) {
			return true;
		}

		// Fastly batch purge endpoint
		$endpoint = self::API_BASE_URL . '/service/' . $this->serviceId . '/purge';

		// Prepare request data
		$data = [
			'urls' => $urls
		];

		$json = json_encode( $data );
		if ( $json === false ) {
			$this->logger->error( 'Failed to encode purge request data' );
			return false;
		}

		$this->logger->debug( 'Sending purge request to Fastly', [
			'endpoint' => $endpoint,
			'url_count' => count( $urls ),
			// Log first 5 URLs for debugging
			'urls' => array_slice( $urls, 0, 5 )
		] );

		try {
			$req = $this->createRequest( $endpoint, [
				'method' => 'POST',
				'timeout' => 10,
				'postData' => $json,
				'headers' => [
					'Content-Type' => 'application/json',
					// Always use soft purge to protect origin
					'Fastly-Soft-Purge' => '1'
				]
			] );
			$status = $req->execute();

			if ( !$status->isOK() ) {
				$this->logger->error( 'Fastly purge request failed', [
					'status' => $req->getStatus(),
					'response' => substr( $req->getContent(), 0, 500 )
				] );
				return false;
			}

			$responseData = json_decode( $req->getContent(), true );

			$this->logger->debug( 'Fastly purge response', [
				'response' => $responseData
			] );

			// Check if all URLs were successfully queued
			if ( isset( $responseData['status'] ) && $responseData['status'] === 'ok' ) {
				$this->logger->info( 'Successfully purged ' . count( $urls ) . ' URLs from Fastly' );
				return true;
			}

			// Log error for unexpected response
			$this->logger->error( 'Unexpected response from Fastly purge', [
				'response' => $responseData
			] );
			return false;

		} catch ( \Exception $e ) {
			$this->logger->error( 'Exception during Fastly API call', [
				'exception' => $e->getMessage()
			] );
			return false;
		}
	}

	/**
	 * Purge all content from Fastly cache
	 */
	public function purgeAll(): bool {
		$endpoint = self::API_BASE_URL . '/service/' . $this->serviceId . '/purge_all';

		$this->logger->debug( 'Sending purge_all request to Fastly' );

		try {
			$req = $this->createRequest( $endpoint, [
				'method' => 'POST',
				'timeout' => 10,
				'headers' => [
					'Fastly-Soft-Purge' => '1'
				]
			] );
			$status = $req->execute();

			if ( !$status->isOK() ) {
				$this->logger->error( 'Fastly purge_all request failed', [
					'status' => $req->getStatus(),
					'response' => substr( $req->getContent(), 0, 500 )
				] );
				return false;
			}

			$responseData = json_decode( $req->getContent(), true );

			if ( isset( $responseData['status'] ) && $responseData['status'] === 'ok' ) {
				$this->logger->info( 'Successfully purged all content from Fastly' );
				return true;
			}

			$this->logger->error( 'Unexpected response from Fastly purge_all', [
				'response' => $responseData
			] );
			return false;

		} catch ( \Exception $e ) {
			$this->logger->error( 'Exception during Fastly purge_all', [
				'exception' => $e->getMessage()
			] );
			return false;
		}
	}

	/**
	 * Create HTTP request with standard Fastly headers
	 * @param string $endpoint API endpoint URL
	 * @param array<string, mixed> $options Request options
	 */
	private function createRequest( string $endpoint, array $options ): \MWHttpRequest {
		// Ensure Fastly headers are set
		$options['headers'] ??= [];
		$options['headers']['Fastly-Key'] = $this->apiKey;
		$options['headers']['Accept'] = 'application/json';

		return $this->httpFactory->create( $endpoint, $options, __METHOD__ );
	}
}
