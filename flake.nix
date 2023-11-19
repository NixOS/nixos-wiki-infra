{
  description = "Dependencies to deploy a nixos-wiki";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    srvos.url = "github:numtide/srvos";
    # Use the version of nixpkgs that has been tested to work with SrvOS
    srvos.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs-stable.follows = "";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ lib, ... }: {
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "riscv64-linux"

        "x86_64-darwin"
        "aarch64-darwin"
      ];
      imports = [
        inputs.treefmt-nix.flakeModule
        ./targets/flake-module.nix
        ./modules/flake-module.nix
      ];
      perSystem = { config, pkgs, ... }: {
        treefmt = {
          projectRootFile = "flake.nix";
          programs.hclfmt.enable = true;
          programs.nixpkgs-fmt.enable = true;
        };
        packages.default =
          let
            terraformHalal = pkgs.terraform.overrideAttrs (_old: { meta = _old.meta // { license = lib.licenses.free; }; });
          in
          pkgs.mkShell {
            packages = [
              pkgs.bashInteractive
              pkgs.sops
              (terraformHalal.withPlugins (p: [
                p.netlify
                p.hcloud
                p.null
                p.external
                p.local
              ]))
            ];
          };
      };
    });
}
