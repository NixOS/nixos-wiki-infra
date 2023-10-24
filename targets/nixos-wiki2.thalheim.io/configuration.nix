{ self, lib, ... }:
let
  nixosVars = builtins.fromJSON (builtins.readFile ./nixos-vars.json);
in
{
  imports = [
    self.nixosModules.nixos-wiki
    self.nixosModules.nixos-wiki-backup
    self.nixosModules.hcloud
  ];
  users.users.root.openssh.authorizedKeys.keys = nixosVars.ssh_keys;
  system.stateVersion = "23.11";
  services.nixos-wiki.hostname = "nixos-wiki2.thalheim.io";
  security.acme.defaults.email = "joerg.letsencrypt@thalheim.io";
  services.nixos-wiki.githubClientId = "Iv1.95ed182c83df1d22";
  sops.defaultSopsFile = ./secrets.yaml;
  boot.loader.grub.devices = lib.mkForce [ "/dev/sda" ];
}
