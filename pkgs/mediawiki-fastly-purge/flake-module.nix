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
          pkgs.mediawiki
        ];

        MEDIAWIKI_PATH = "${pkgs.mediawiki}/share/mediawiki";

        shellHook = ''
          echo "FastlyPurge Extension Development Shell"
          echo "========================================"
          echo ""
          echo "Available commands:"
          echo "  composer lint"
          echo "  composer fix"
          echo ""
          echo "PHP version: $(php --version | head -n1)"
          echo "MediaWiki path: $MEDIAWIKI_PATH"
          echo ""

          # Create vendor directory if it doesn't exist
          if [ ! -d "vendor" ]; then
            echo "Installing composer dependencies..."
            composer install --no-interaction
          fi
        '';
      };
    };
}
