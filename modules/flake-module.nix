{ inputs, ... }: {
  flake.nixosModules = {
    hcloud.imports = [
      inputs.srvos.nixosModules.server
      inputs.srvos.nixosModules.hardware-hetzner-cloud
    ];

    nixos-wiki.imports = [
      ./nixos-wiki.nix
    ];
  };
}
