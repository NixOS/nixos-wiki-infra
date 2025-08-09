{ pkgs, config, ... }:
(pkgs.runCommand "mediawiki-maintenance"
  {
    nativeBuildInputs = [ pkgs.makeWrapper ];
    preferLocalBuild = true;
  }
  ''
    mkdir -p $out/bin
    makeWrapper ${config.services.phpfpm.pools.mediawiki.phpPackage}/bin/php $out/bin/mediawiki-maintenance \
      --set MEDIAWIKI_CONFIG ${config.services.phpfpm.pools.mediawiki.phpEnv.MEDIAWIKI_CONFIG} \
      --add-flags ${config.services.mediawiki.finalPackage}/share/mediawiki/maintenance/run.php
  ''
)
