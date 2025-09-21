{
  perSystem =
    { pkgs, ... }:
    {
      packages.fastly-purge = pkgs.callPackage ./package.nix { };

      checks.fastly-purge-lint = pkgs.callPackage ./lint.nix { };

      devShells.fastly-purge = pkgs.mkShell {
        packages = [
          pkgs.php83
          pkgs.php83.packages.composer
        ];
        MEDIAWIKI_PATH = "${pkgs.mediawiki}/share/mediawiki";
        shellHook = ''
          [ -d vendor ] || composer install --no-interaction
        '';
      };
    };
}
