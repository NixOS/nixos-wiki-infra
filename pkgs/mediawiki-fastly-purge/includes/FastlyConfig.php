<?php
declare( strict_types=1 );

namespace MediaWiki\Extension\FastlyPurge;

use MediaWiki\Config\Config;

class FastlyConfig {
	private readonly string $apiKey;
	private readonly string $serviceId;

	public function __construct( Config $config ) {
		$this->apiKey = (string)$config->get( 'FastlyApiKey' );
		$this->serviceId = (string)$config->get( 'FastlyServiceId' );
	}

	/**
	 * Get the Fastly API key
	 */
	public function getApiKey(): string {
		return $this->apiKey;
	}

	/**
	 * Get the Fastly service ID
	 */
	public function getServiceId(): string {
		return $this->serviceId;
	}

	/**
	 * Check if the configuration is valid
	 */
	public function isValid(): bool {
		return $this->apiKey !== '' && $this->serviceId !== '';
	}

	/**
	 * Get validation errors
	 * @return string[]
	 */
	public function getValidationErrors(): array {
		$errors = [];

		if ( $this->apiKey === '' ) {
			$errors[] = 'FastlyApiKey is not configured';
		}

		if ( $this->serviceId === '' ) {
			$errors[] = 'FastlyServiceId is not configured';
		}

		return $errors;
	}
}
