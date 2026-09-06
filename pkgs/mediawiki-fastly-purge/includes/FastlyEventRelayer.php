<?php
declare( strict_types=1 );

namespace MediaWiki\Extension\FastlyPurge;

use MediaWiki\Deferred\DeferredUpdates;
use MediaWiki\Logger\LoggerFactory;
use MediaWiki\MediaWikiServices;
use Wikimedia\EventRelayer\EventRelayer;

class FastlyEventRelayer extends EventRelayer {

	public static function onRegistration(): void {
		global $wgEventRelayerConfig, $wgFastlyApiToken;

		if ( (string)$wgFastlyApiToken === '' ) {
			LoggerFactory::getInstance( 'FastlyPurge' )
				->warning( '$wgFastlyApiToken is not set, Fastly purging is disabled' );
			return;
		}
		$wgEventRelayerConfig['cdn-url-purges'] = [ 'class' => self::class ];
	}

	/**
	 * @param string $channel
	 * @param array<int, array<string, mixed>> $events
	 */
	protected function doNotify( $channel, array $events ): bool {
		$urls = [];
		foreach ( $events as $event ) {
			if ( isset( $event['url'] ) && is_string( $event['url'] ) ) {
				$urls[] = $event['url'];
			}
		}
		if ( $urls ) {
			// CdnCacheUpdate calls relayers *before* it PURGEs $wgCdnServers. Deferring to
			// POSTSEND makes Fastly revalidate against an already purged origin cache and
			// keeps the API round-trip out of the edit response.
			DeferredUpdates::addCallableUpdate( static function () use ( $urls ) {
				self::purge( $urls );
			}, DeferredUpdates::POSTSEND );
		}
		return true;
	}

	/**
	 * @param string[] $urls
	 */
	public static function purge( array $urls ): void {
		$services = MediaWikiServices::getInstance();
		$token = (string)$services->getMainConfig()->get( 'FastlyApiToken' );
		$urlUtils = $services->getUrlUtils();

		$reqs = [];
		foreach ( $urls as $url ) {
			$url = (string)$urlUtils->expand( $url, PROTO_CANONICAL );
			$reqs[] = [
				'method' => 'POST',
				'url' => 'https://api.fastly.com/purge/' . preg_replace( '#^[a-z]+://#i', '', $url ),
				'headers' => [
					'Fastly-Key' => $token,
					'Fastly-Soft-Purge' => '1',
				],
			];
		}

		$reqs = $services->getHttpRequestFactory()
			->createMultiClient( [ 'reqTimeout' => 10, 'maxConnsPerHost' => 8 ] )
			->runMulti( $reqs );

		$logger = LoggerFactory::getInstance( 'FastlyPurge' );
		foreach ( $reqs as $req ) {
			if ( $req['response']['code'] !== 200 ) {
				$logger->error( 'Fastly purge of {url} failed: {code} {error}', [
					'url' => $req['url'],
					'code' => $req['response']['code'],
					'error' => $req['response']['error'] ?: $req['response']['body'],
				] );
			}
		}
	}
}
