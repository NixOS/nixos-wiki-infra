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
        system.stateVersion = config.system.nixos.release;
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
          pages = {
            pageConfig = {
              "wiki-sync-test-page.wiki" = {
                title = "Wiki Sync Test Page";
                namespace = "";
              };
            };
          };
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

    wiki.wait_for_unit("phpfpm-mediawiki.service")
    wiki.wait_for_unit("nginx.service")
    wiki.wait_for_unit("mediawiki-init.service")

    page = wiki.succeed("curl -vL http://nixos-wiki.example.com/")
    assert "MediaWiki has been installed" in page

    # Test wiki pages sync functionality
    print("Testing wiki pages sync...")

    # Check that the test page was created on the wiki
    print("Checking if test page was created...")
    test_page = wiki.succeed("curl -s http://nixos-wiki.example.com/wiki/Wiki_Sync_Test_Page")

    # Check for title in HTML
    assert "Automatic synchronization from git repository" in test_page, f"Expected title not found in test page: {test_page}"
  '';
}
