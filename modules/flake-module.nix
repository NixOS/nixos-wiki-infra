{ inputs, ... }: {
  flake.nixosModules = {
    hcloud.imports = [
      inputs.srvos.nixosModules.server
      inputs.srvos.nixosModules.hardware-hetzner-cloud
      ./single-disk.nix
    ];

    nixos-wiki.imports = [
      ./nixos-wiki.nix
    ];
  };
}
