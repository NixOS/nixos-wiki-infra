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
    srvos.inputs.nixos-stable.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs-stable.follows = "";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ self, lib, ... }: {
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
        ./checks/flake-module.nix
      ];
      perSystem = { config, self', system, pkgs, ... }: {
        treefmt = {
          projectRootFile = "flake.nix";
          programs.hclfmt.enable = true;
          programs.nixpkgs-fmt.enable = true;
        };
        packages.default =
          pkgs.mkShell {
            packages =
              let
                halalify = drv: drv.overrideAttrs (_old: { meta = _old.meta // { license = lib.licenses.free; }; });
              in
              [
                pkgs.bashInteractive
                pkgs.sops
                (halalify (pkgs.terraform.withPlugins (p: [
                  p.hcloud
                  p.null
                  p.external
                  p.local
                ])))
              ];
          };

        checks =
          let
            nixosMachines = lib.mapAttrs' (name: config: lib.nameValuePair "nixos-${name}" config.config.system.build.toplevel) ((lib.filterAttrs (_: config: config.pkgs.system == system)) self.nixosConfigurations);
            packages = lib.mapAttrs' (n: lib.nameValuePair "package-${n}") self'.packages;
            devShells = lib.mapAttrs' (n: lib.nameValuePair "devShell-${n}") self'.devShells;
          in
          nixosMachines // packages // devShells;
      };
    });
}
