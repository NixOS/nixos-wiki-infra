{
  description = "Dependencies to deploy a nixos-wiki";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ lib, ... }: {
      systems = lib.systems.flakeExposed;
      imports = [
        inputs.treefmt-nix.flakeModule
        ./terraform/targets/flake-module.nix
      ];
      perSystem = { config, pkgs, ... }: {
        treefmt = {
          projectRootFile = "flake.nix";
          programs.terraform.enable = true;
          programs.nixpkgs-fmt.enable = true;
        };
        packages.default = pkgs.mkShell {
          packages = [
            pkgs.bashInteractive
            (pkgs.terraform.withPlugins (p: [
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
