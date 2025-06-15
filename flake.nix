{
  description = "Dependencies to deploy a nixos-wiki";

  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable-small";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    srvos.url = "github:numtide/srvos";
    srvos.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { self, lib, ... }:
      {
        systems = [
          "aarch64-linux"
          "x86_64-linux"

          "x86_64-darwin"
          "aarch64-darwin"
        ];
        imports = [
          inputs.treefmt-nix.flakeModule
          ./targets/flake-module.nix
          ./modules/flake-module.nix
          ./checks/flake-module.nix
          ./vm/flake-module.nix
          ./formatter.nix
        ];
        perSystem =
          {
            self',
            system,
            pkgs,
            ...
          }:
          {

            checks =
              let
                nixosMachines = lib.mapAttrs' (
                  name: config: lib.nameValuePair "nixos-${name}" config.config.system.build.toplevel
                ) ((lib.filterAttrs (_: config: config.pkgs.system == system)) self.nixosConfigurations);
                packages = lib.mapAttrs' (n: lib.nameValuePair "package-${n}") self'.packages;
                devShells = lib.mapAttrs' (n: lib.nameValuePair "devShell-${n}") self'.devShells;
              in
              nixosMachines // packages // devShells;
          };
      }
    );
}
