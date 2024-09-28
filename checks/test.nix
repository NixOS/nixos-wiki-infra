(import ./lib.nix) {
  name = "nixos-wiki";
  nodes = {
    # `self` here is set by using specialArgs in `lib.nix`
    wiki =
      {
        self,
        pkgs,
        config,
        ...
      }:
      {
        imports = [
          self.nixosModules.nixos-wiki
        ];
        networking.extraHosts = ''
          127.0.0.1 nixos-wiki.example.com
        '';
        security.acme.defaults.email = "admin@example.com";
        services.nixos-wiki = {
          hostname = "nixos-wiki.example.com";
          adminPasswordFile = pkgs.writeText "adminPasswordFile" "Creation-Fabric-Untrimmed3";
          githubClientId = "Iv1.95ed182c83df1d22";
          githubClientSecretFile = pkgs.writeText "githubClientSecretFile" "secret";
          emergencyContact = "nixos-wiki@thalheim.io";
          passwordSender = "nixos-wiki@thalheim.io";
          noReplyAddress = "nixos-wiki-no-reply@thalheim.io";
        };
        services.nginx.virtualHosts.${config.services.mediawiki.nginx.hostName} = {
          enableACME = false;
          forceSSL = false;
        };
      };
  };
  # This is the test code that will check if our service is running correctly:
  testScript = ''
    start_all()

    machine.wait_for_unit("phpfpm-mediawiki.service")
    machine.wait_for_unit("nginx.service")
    machine.wait_for_unit("mediawiki-init.service")

    page = machine.succeed("curl -vL http://nixos-wiki.example.com/")
    assert "MediaWiki has been installed" in page
  '';
}
