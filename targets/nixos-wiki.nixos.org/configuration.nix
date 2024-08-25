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
    hostname = "wiki.nixos.org";
    adminPasswordFile = config.sops.secrets.nixos-wiki.path;
    githubClientId = "Iv1.fcbe65bcecdda275";
    githubClientSecretFile = config.sops.secrets.nixos-wiki-github-client-secret.path;
    emergencyContact = "wiki@nixos.org";
    passwordSender = "wiki@wiki.nixos.org";
    noReplyAddress = "wiki-no-reply@wiki.nixos.org";
  };

  services.cloud-init.enable = lib.mkForce false;

  systemd.network.networks."10-wan" = {
    # match the interface by name
    matchConfig.MACAddress = "96:00:03:02:b6:04";
    address = [
      # configure addresses including subnet mask
      "65.21.240.250/32"
      # TODO: drop this ip and only keep ::1
      "2a01:4f9:c012:8178::/64"
      "2a01:4f9:c012:8178::1/64"
    ];
    routes = [
      # create default routes for both IPv6 and IPv4
      { Gateway = "fe80::1"; }
      # or when the gateway is not on the same network
      {
        Gateway = "172.31.1.1";
        GatewayOnLink = true;
      }
    ];
    # make the routes on this interface a dependency for network-online.target
    linkConfig.RequiredForOnline = "routable";
  };

  sops.defaultSopsFile = ./secrets/secrets.yaml;
}
