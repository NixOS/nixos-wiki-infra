{

  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        settings.global.excludes = [
          "*/nixos-vars.json"
          "*/secrets.yaml"
          "*.lock"
          ".gitignore"
          "modules/nixos-wiki/favicon.ico"
          "modules/nixos-wiki/nixos.png"
          "modules/nixos-wiki/robots.txt"
          "oauth-permissions.png"
          "targets/nixos-wiki.nixos.org/secrets/*"
        ];
        programs.hclfmt.enable = true;
        programs.nixfmt.enable = true;
        programs.nixfmt.package = pkgs.nixfmt-rfc-style;
        programs.deadnix.enable = true;
        programs.ruff.format = true;
        programs.ruff.check = true;
        programs.shfmt.enable = true;
        programs.yamlfmt.enable = true;
        settings.formatter.shfmt.includes = [
          "*.envrc"
          "*.envrc.private-template"
        ];
        programs.shellcheck.enable = true;
        programs.deno.enable = !pkgs.deno.meta.broken;
      };
      packages = {
        default = pkgs.mkShell {
          packages =
            let
              convert2Tofu =
                provider:
                provider.override (prev: {
                  homepage =
                    builtins.replaceStrings
                      [ "registry.terraform.io/providers" ]
                      [
                        "registry.opentofu.org"
                      ]
                      prev.homepage;
                });
            in
            [
              pkgs.bashInteractive
              pkgs.sops
              pkgs.nixos-rebuild-ng
              (pkgs.opentofu.withPlugins (
                p:
                builtins.map convert2Tofu [
                  p.hcloud
                  p.null
                  p.external
                  p.local
                ]
              ))
            ];
        };
      } // (import ./checks/linkcheck/pkgs { inherit pkgs; });
      devShells.linkcheck = pkgs.mkShell {
        packages = [
          pkgs.lychee
          (pkgs.python3.withPackages (pypkgs: [ pypkgs.lxml ]))
        ];
      };
    };
}
