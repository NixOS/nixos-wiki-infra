{ config, pkgs, lib, ... }:
{
  options = {
    services.nixos-wiki = {
      hostname = lib.mkOption {
        type = lib.types.str;
        description = "The hostname of the wiki";
      };
      githubClientId = lib.mkOption {
        type = lib.types.str;
        description = "The github client id for the wiki";
      };
    };
  };

  config = {
    sops.secrets."nixos-wiki".owner = config.services.phpfpm.pools.mediawiki.user;
    sops.secrets.nixos-wiki-github-client-secret.owner = config.services.phpfpm.pools.mediawiki.user;
    services.mediawiki = {
      enable = true;
      webserver = "nginx";
      database.type = "postgres";
      nginx.hostName = config.services.nixos-wiki.hostname;
      uploadsDir = "/var/lib/mediawiki-uploads/";
      passwordFile = config.sops.secrets."nixos-wiki".path;

      extensions.SyntaxHighlight_GeSHi = null; # provides <SyntaxHighlight> tags
      extensions.ParserFunctions = null;
      extensions.Cite = null;
      extensions.VisualEditor = null;
      extensions.AuthManagerOAuth = pkgs.fetchzip {
        url = "https://github.com/Mic92/AuthManagerOAuth/releases/download/vendor-bugfix/AuthManagerOAuth.zip";
        hash = "sha256-Xq56QxBYpAG51HQw4TJLnzwHWztv0EhTGXk/i3w2+fs=";
      }; # Github login
      extensions.ConfirmEdit = null; # Combat SPAM with a simple Captcha
      extensions.StopForumSpam = pkgs.fetchzip {
        url = "https://extdist.wmflabs.org/dist/extensions/StopForumSpam-REL1_40-71b57ba.tar.gz";
        hash = "sha256-g8v4zr11c2e4bY0BNipJ48miyAF4WTNvlSMgb/NxPBA=";
      };

      extraConfig = ''
        #$wgDebugLogFile = "/var/log/mediawiki/debug.log";

        # allow local login
        $wgAuthManagerOAuthConfig = [
          'github' => [
            'clientId'                => '${config.services.nixos-wiki.githubClientId}',
            'clientSecret'            => file_get_contents("${config.sops.secrets.nixos-wiki-github-client-secret.path}"),
            'urlAuthorize'            => 'https://github.com/login/oauth/authorize',
            'urlAccessToken'          => 'https://github.com/login/oauth/access_token',
            'urlResourceOwnerDetails' => 'https://api.github.com/user'
          ],
        ];

        # Enable account creation globally
        $wgGroupPermissions['*']['createaccount'] = true;
        $wgGroupPermissions['*']['autocreateaccount'] = true;

        # Disable anonymous editing
        $wgGroupPermissions['*']['edit'] = false;

        # Allow svg upload
        $wgFileExtensions[] = 'svg';
        $wgSVGConverterPath = "${pkgs.imagemagick}/bin";

        # Pretty URLs
        $wgUsePathInfo = true;

        # cache pages with APCu
        $wgMainCacheType = CACHE_ACCEL;

        # TODO: nixos favicon
        #$wgFavicon = "/favicon.ico";
        $wgDefaultSkin = 'vector-2022';
        # configure logos for vector-2022: https://www.mediawiki.org/wiki/Manual:$wgLogos
        $wgLogos = [
          '1x' => '/nixos.png',
          'icon' => '/nixos.png',
        ];

        # Combat SPAM with IP-Blocklists (StopForumSpam extension)
        $wgEnableDnsBlacklist = true;
        $wgDnsBlacklistUrls = array(
          'dnsbl.dronebl.org'
        );

        # required for fancy VisualEditor extension
        $wgGroupPermissions['user']['writeapi'] = true;

        # Enable content security policy
        $wgCSPHeader = true;

        # Disallow framing
        $wgEditPageFrameOptions = "DENY";

        $wgEnableEmail = true;
        $wgAllowHTMLEmail = false;
        $wgEmergencyContact = "nixos-wiki-emergency@thalheim.io";
        $wgPasswordSender   = "nixos-wiki@thalheim.io";           # Default FROM address
        $wgNoReplyAddress   = "nixos-wiki-no-reply@thalheim.io";  # Default Reply-To address

        # To purge all page cache increase this using: date +%Y%m%d%H%M%S
        $wgCacheEpoch = 20231115172319;
      '';
    };

    networking.firewall.allowedTCPPorts = [ 443 80 ];
    security.acme.acceptTerms = true;
    services.nginx.virtualHosts.${config.services.mediawiki.nginx.hostName} = {
      enableACME = lib.mkDefault true;
      forceSSL = true;
      locations."=/nixos.png".alias = ./nixos.png;
    };
  };

}
