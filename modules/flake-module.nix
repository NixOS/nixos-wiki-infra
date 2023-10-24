{ inputs, ... }: {
  flake.nixosModules = {
    hcloud.imports = [
      inputs.srvos.nixosModules.server
      inputs.sops-nix.nixosModules.sops
      inputs.srvos.nixosModules.hardware-hetzner-cloud
      ./single-disk.nix
      {
        sops.age.keyFile = "/var/lib/secrets/age";
      }
    ];

    nixos-wiki.imports = [
      ./nixos-wiki
    ];
    nixos-wiki-backup.imports = [
      ./nixos-wiki/backup.nix
    ];
  };
}
