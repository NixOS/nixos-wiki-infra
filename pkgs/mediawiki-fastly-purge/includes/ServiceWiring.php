<?php
declare( strict_types=1 );

namespace MediaWiki\Extension\FastlyPurge;

use MediaWiki\Logger\LoggerFactory;
use MediaWiki\MediaWikiServices;

return [
	'FastlyConfig' => static function ( MediaWikiServices $services ): FastlyConfig {
		return new FastlyConfig( $services->getMainConfig() );
	},

	'FastlyApiClient' => static function ( MediaWikiServices $services ): FastlyApiClient {
		$config = $services->get( 'FastlyConfig' );
		return new FastlyApiClient(
			$config->getApiKey(),
			$config->getServiceId(),
			$services->getHttpRequestFactory(),
			LoggerFactory::getInstance( 'FastlyPurge' )
		);
	},

	'FastlyEventRelayer' => static function ( MediaWikiServices $services ): FastlyEventRelayer {
		return new FastlyEventRelayer(
			[],
			$services->get( 'FastlyApiClient' ),
			LoggerFactory::getInstance( 'FastlyPurge' )
		);
	}
];
