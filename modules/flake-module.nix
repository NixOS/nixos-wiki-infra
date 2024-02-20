{ inputs, ... }: {
  flake.nixosModules = {
    hcloud.imports = [
      inputs.srvos.nixosModules.server
      inputs.srvos.nixosModules.mixins-nginx
      inputs.sops-nix.nixosModules.sops
      inputs.srvos.nixosModules.hardware-hetzner-cloud
      inputs.srvos.nixosModules.mixins-telegraf
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
