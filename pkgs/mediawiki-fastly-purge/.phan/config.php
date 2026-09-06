<?php

$cfg = require __DIR__ . '/../vendor/mediawiki/mediawiki-phan-config/src/config.php';

$mediawikiPath = getenv( 'MEDIAWIKI_PATH' );

if ( $mediawikiPath && is_dir( $mediawikiPath ) ) {
	$cfg['directory_list'][] = $mediawikiPath;

	$cfg['exclude_analysis_directory_list'][] = $mediawikiPath;
}

return $cfg;
