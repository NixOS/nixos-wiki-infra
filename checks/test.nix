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
          fastly = {
            enable = true;
            originHostname = "origin.nixos-wiki.example.com";
          };
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

    with subtest("rest.php works with AuthManagerOAuth's bundled vendor dir"):
        wiki.succeed("curl -sf 'http://nixos-wiki.example.com/w/rest.php/v1/search/title?q=wiki&limit=1'")

    with subtest("FastlyPurge extension is registered"):
        exts = wiki.succeed("curl -sf 'http://nixos-wiki.example.com/w/api.php?action=query&meta=siteinfo&siprop=extensions&format=json'")
        assert '"FastlyPurge"' in exts, exts

    url = "http://nixos-wiki.example.com/wiki/Wiki_Sync_Test_Page"
    mobile_ua = "Mozilla/5.0 (Linux; Android 14) Mobile Safari/537.36"

    def cache_status(extra: str = "") -> str:
        out = wiki.succeed(f"curl -s -o /dev/null -D - {extra} {url}")
        for line in out.splitlines():
            if line.lower().startswith("x-cache-status:"):
                return line.split(":", 1)[1].strip()
        raise AssertionError(f"no X-Cache-Status in {out}")

    with subtest("mobile UA gets Minerva and never poisons or reads the desktop cache"):
        assert cache_status(f"-A '{mobile_ua}'") == "BYPASS"
        mobile = wiki.succeed(f"curl -s -A '{mobile_ua}' {url}")
        assert "skin-minerva" in mobile, mobile[:2000]
        desktop = wiki.succeed(f"curl -s {url}")
        assert "skin-vector" in desktop, desktop[:2000]
        assert cache_status() == "HIT"
        assert cache_status(f"-A '{mobile_ua}'") == "BYPASS"

    with subtest("anonymous floods of expensive special pages are throttled, sessions are not"):
        rc = "http://nixos-wiki.example.com/w/index.php?title=Special:RecentChanges&from=1"
        codes = wiki.succeed(f"for i in $(seq 40); do curl -s -o /dev/null -w '%{{http_code}} ' '{rc}'; done")
        assert "429" in codes, codes
        codes = wiki.succeed(f"for i in $(seq 40); do curl -s -o /dev/null -w '%{{http_code}} ' -H 'Cookie: mediawiki_session=x' '{rc}'; done")
        assert "429" not in codes, codes

    with subtest("the public hostname is only served to Fastly and loopback"):
        ip = wiki.succeed("ip -4 -o addr show dev eth1 | grep -oP '(?<=inet )[0-9.]+'").strip()
        wiki.fail(f"curl -sf -H 'Host: nixos-wiki.example.com' http://{ip}/wiki/Wiki_Sync_Test_Page")
        wiki.succeed(f"curl -sf -H 'Host: origin.nixos-wiki.example.com' http://{ip}/wiki/Wiki_Sync_Test_Page")

    with subtest("PURGE from MediaWiki invalidates the cached page"):
        assert cache_status() == "HIT"
        # same shape as CdnCacheUpdate::naivePurge()
        wiki.succeed(f"curl -sf -o /dev/null -X PURGE -x 127.0.0.1:80 {url}")
        status = cache_status()
        assert status == "MISS", status
  '';
}
