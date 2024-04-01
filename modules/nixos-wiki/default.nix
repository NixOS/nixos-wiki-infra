{ config, pkgs, lib, ... }:
let
  cfg = config.services.nixos-wiki;
in
{
  options = {
    services.nixos-wiki = {
      hostname = lib.mkOption {
        type = lib.types.str;
        description = "The hostname of the wiki";
      };
      adminPasswordFile = lib.mkOption {
        type = lib.types.path;
        description = "The password file for the wiki admin";
      };
      githubClientId = lib.mkOption {
        type = lib.types.str;
        description = "The github client id for the wiki";
      };
      githubClientSecretFile = lib.mkOption {
        type = lib.types.path;
        description = "The github client secret for the wiki";
      };
      emergencyContact = lib.mkOption {
        type = lib.types.str;
        description = "The emergency contact for the wiki";
      };
      passwordSender = lib.mkOption {
        type = lib.types.str;
        description = "default FROM address in emails";
      };
      noReplyAddress = lib.mkOption {
        type = lib.types.str;
        description = "default Reply-To address in emails";
      };
    };
  };

  config = {
    services.mediawiki = {
      name = "NixOS Wiki";
      enable = true;
      webserver = "nginx";
      database.type = "postgres";
      nginx.hostName = config.services.nixos-wiki.hostname;
      uploadsDir = "/var/lib/mediawiki-uploads/";
      passwordFile = cfg.adminPasswordFile;

      extensions.SyntaxHighlight_GeSHi = null; # provides <SyntaxHighlight> tags
      extensions.ParserFunctions = null;
      extensions.Cite = null;
      extensions.VisualEditor = null;
      extensions.AuthManagerOAuth = pkgs.fetchzip {
        url = "https://github.com/mohe2015/AuthManagerOAuth/releases/download/v0.3.2/AuthManagerOAuth.zip";
        hash = "sha256-hr/DLyL6IzQs67eA46RdmuVlfCiAbq+eZCRLfjLxUpc=";
      }; # Github login
      extensions.ConfirmEdit = null; # Combat SPAM with a simple Captcha
      # https://www.mediawiki.org/wiki/Extension:MobileFrontend/
      extensions.MobileFrontend = pkgs.fetchzip {
        url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_41-6dbf6c2.tar.gz/MobileFrontend-REL1_41-6dbf6c2.tar.gz";
        hash = "sha256-LsKPlVId7DzbkS7xc+fSYBiasq4AofCjCfbBaN/eSE8=";
      }; # Responsive skin
      extensions.DarkMode = pkgs.fetchzip {
        url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_41-d647ab5.tar.gz/DarkMode-REL1_41-d647ab5.tar.gz";
        hash = "sha256-ERvWGDKfT6nqFbz7q8iqZFe2uhwoSQ2ePUy4tlPDaOE=";
      };

      #extensions.StopForumSpam = pkgs.fetchzip {
      #  url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/StopForumSpam-REL1_41-73c94fb/StopForumSpam-REL1_41-861c37b.tar.gz";
      #  hash = "sha256-/7gfBiKA9CliEPjXjcHrYKp4JMayXwtixlZFvnA5D2E=";
      #};


      extraConfig = ''
        #$wgDebugLogFile = "/var/log/mediawiki/debug.log";

        # allow local login
        $wgAuthManagerOAuthConfig = [
          'github' => [
            'clientId'                => '${cfg.githubClientId}',
            'clientSecret'            => file_get_contents("${cfg.githubClientSecretFile}"),
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

        # cache pages with db
        $wgMainCacheType = CACHE_DB;

        #$wgFavicon = "/favicon.ico";
        $wgDefaultSkin = 'vector-2022';
        # configure logos for vector-2022: https://www.mediawiki.org/wiki/Manual:$wgLogos
        $wgLogos = [
          '1x' => '/nixos.png',
          'icon' => '/nixos.png',
        ];

        # Combat SPAM with IP-Blocklists (StopForumSpam extension)
        #$wgEnableDnsBlacklist = true;
        #$wgDnsBlacklistUrls = array(
        #  'dnsbl.dronebl.org'
        #);

        # required for fancy VisualEditor extension
        $wgGroupPermissions['user']['writeapi'] = true;

        # Enable content security policy
        $wgCSPHeader = true;

        # Disallow framing
        $wgEditPageFrameOptions = "DENY";

        $wgEnableEmail = true;
        # FIXME: we cannot enable this because of github login
        $wgEmailConfirmToEdit = false;
        $wgAllowHTMLEmail = false;

        $wgEmergencyContact = "${cfg.emergencyContact}";
        $wgPasswordSender   = "${cfg.passwordSender}";
        $wgNoReplyAddress   = "${cfg.noReplyAddress}";

        # To purge all page cache increase this using: date +%Y%m%d%H%M%S
        $wgCacheEpoch = 20231115172319;

        $wgPygmentizePath = "${pkgs.python3Packages.pygments}/bin/pygmentize";
      '';
    };

    services.postgresql.package = pkgs.postgresql_16;

    networking.firewall.allowedTCPPorts = [ 443 80 ];
    security.acme.acceptTerms = true;
    services.nginx.virtualHosts.${config.services.mediawiki.nginx.hostName} = {
      enableACME = lib.mkDefault true;
      forceSSL = lib.mkDefault true;
      locations."=/nixos.png".alias = ./nixos.png;
      locations."=/favicon.ico".alias = ./favicon.ico;
    };
  };
}
