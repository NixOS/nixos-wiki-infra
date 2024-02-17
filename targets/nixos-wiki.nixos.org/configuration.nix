{ self, lib, config, ... }:
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
  security.acme.defaults.email = "joerg.letsencrypt@thalheim.io";

  sops.secrets.nixos-wiki.owner = config.services.phpfpm.pools.mediawiki.user;
  sops.secrets.nixos-wiki-github-client-secret.owner = config.services.phpfpm.pools.mediawiki.user;

  networking = {
    hostName = "wiki";
    domain = "nixos.org";
  };

  services.nixos-wiki = {
    hostname = "wiki.staging.julienmalka.me";
    adminPasswordFile = config.sops.secrets.nixos-wiki.path;
    githubClientId = "Iv1.95ed182c83df1d22";
    githubClientSecretFile = config.sops.secrets.nixos-wiki-github-client-secret.path;
    emergencyContact = "nixos-wiki@thalheim.io";
    passwordSender = "nixos-wiki@thalheim.io";
    noReplyAddress = "nixos-wiki-no-reply@thalheim.io";
  };

  sops.defaultSopsFile = ./secrets/secrets.yaml;
  boot.loader.grub.devices = lib.mkForce [ "/dev/sda" ];
}
