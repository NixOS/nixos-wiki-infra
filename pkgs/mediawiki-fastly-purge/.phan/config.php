<?php

$cfg = require __DIR__ . '/../vendor/mediawiki/mediawiki-phan-config/src/config.php';

// Get MediaWiki path from environment variable
$mediawikiPath = getenv( 'MEDIAWIKI_PATH' );

if ( $mediawikiPath && is_dir( $mediawikiPath ) ) {
	// Add MediaWiki to directory_list for class definitions
	$cfg['directory_list'][] = $mediawikiPath;

	// Exclude MediaWiki from analysis to prevent crashes
	$cfg['exclude_analysis_directory_list'][] = $mediawikiPath;
}

return $cfg;
