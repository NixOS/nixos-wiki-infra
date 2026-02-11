<?php
declare( strict_types=1 );

namespace MediaWiki\Extension\FastlyPurge;

use MediaWiki\Logger\LoggerFactory;
use MediaWiki\MediaWikiServices;

class Hooks {
	/**
	 * Hook: Setup event relayer configuration
	 * This is called very early in the initialization process
	 */
	public static function onSetupAfterCache(): void {
		global $wgEventRelayerConfig;

		$services = MediaWikiServices::getInstance();

		// Check if extension is properly configured
		try {
			$config = new FastlyConfig( $services->getMainConfig() );

			if ( !$config->isValid() ) {
				$logger = LoggerFactory::getInstance( 'FastlyPurge' );
				foreach ( $config->getValidationErrors() as $error ) {
					$logger->warning( $error );
				}
				return;
			}

			// Configure the EventRelayer to use our custom class
			$wgEventRelayerConfig['cdn-url-purges'] = [
				'class' => FastlyEventRelayer::class,
			];

		} catch ( \Exception $e ) {
			LoggerFactory::getInstance( 'FastlyPurge' )->error(
				'Failed to initialize FastlyPurge extension',
				[ 'exception' => $e->getMessage() ]
			);
		}
	}

}
