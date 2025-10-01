{
  php83,
  mediawiki,
}:

let
  phpEnv = php83.buildEnv {
    extensions = ({ enabled, all }: enabled ++ [ all.ast ]);
  };
in
phpEnv.buildComposerProject2 {
  pname = "fastly-purge-lint";
  version = "0.0.1";
  src = ./.;

  vendorHash = "sha256-xySf8KVwZn8yrnMtXF2XE75Ep5xGTukJnbj8+6F2Whs=";
  composerNoDev = false;

  doCheck = true;
  checkPhase = ''
    runHook preCheck

    export MEDIAWIKI_PATH=${mediawiki}/share/mediawiki

    # Ensure vendor directory is available
    cp -a --reflink=auto $composerVendor/vendor vendor
    chmod -R u+w vendor

    patchShebangs vendor/bin/*

    # Run lint checks with proper phpcs configuration
    ./vendor/bin/phan -d . --long-progress-bar
    ./vendor/bin/parallel-lint . --exclude vendor --exclude node_modules
    ./vendor/bin/phpcs --runtime-set installed_paths vendor/phpcsstandards/phpcsextra,vendor/mediawiki/mediawiki-codesniffer -p -s

    rm -rf vendor

    runHook postCheck
  '';
}
