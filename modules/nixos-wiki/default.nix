{
  config,
  pkgs,
  lib,
  ...
}:
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

      extensions = {
        SyntaxHighlight_GeSHi = null; # provides <SyntaxHighlight> tags
        ParserFunctions = null;
        Cite = null;
        VisualEditor = null;
        AuthManagerOAuth = pkgs.fetchzip {
          url = "https://github.com/mohe2015/AuthManagerOAuth/releases/download/v0.3.2/AuthManagerOAuth.zip";
          hash = "sha256-hr/DLyL6IzQs67eA46RdmuVlfCiAbq+eZCRLfjLxUpc=";
        }; # Github login
        ConfirmEdit = null; # Combat SPAM with a simple Captcha
        DiscussionTools = null; # Adds a new discussion tool to the talk pages
        Thanks = null; # Adds a "thank" button
        Linter = null; # Dependency of DiscussionTools
        Echo = null; # Dependency of DiscussionTools
      } // pkgs.callPackages ./extensions.nix { };
      extraConfig = ''
        # docs https://www.mediawiki.org/wiki/Extension:QuestyCaptcha
        $wgCaptchaQuestions = [
          "What Linux distribution is this wiki about?" => [ 'nixos', 'NixOS', 'NIXOS', 'Nixos' ],
          "What is the package manager of NixOS called?" => [ 'Nix', 'nix', 'NIX' ],
        ];
        wfLoadExtensions([ 'ConfirmEdit/QuestyCaptcha' ]);

        #$wgDebugLogFile = "/var/log/mediawiki/debug.log";
        #$wgShowExceptionDetails = true;

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

        # Combat SPAM with IP-Blocklists
        # https://www.mediawiki.org/wiki/Manual:Combating_spam#Honeypots,_DNS_BLs_and_HTTP_BLs
        $wgEnableDnsBlacklist = true;
        $wgDnsBlacklistUrls = array(
          # Spamhouse blocks users from Austrialian ISPs, maybe because of residential IPs?
          # 'xbl.spamhaus.org',
          'opm.tornevall.org'
        );

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

        # Enable Translate extension for all users
        $wgGroupPermissions['user']["translate"] = true;
        $wgGroupPermissions['user']["pagetranslation"] = true;

        # add extra groups
        ## add trusted group
        $wgGroupPermissions['trusted'] = $wgGroupPermissions['user'];
        $wgGroupPermissions['trusted']['delete'] = true;
        # allow trusted users to manage translations
        $wgGroupPermissions['trusted']['translate-manage'] = true;

        ## add moderator group
        $wgGroupPermissions['moderator'] = $wgGroupPermissions['user'];
        $wgGroupPermissions['moderator']['delete'] = true;
        $wgGroupPermissions['moderator']['blockusers'] = true;
        $wgGroupPermissions['moderator']['rollback'] = true;
        $wgGroupPermissions['moderator']['viewdeleted'] = true;
        $wgGroupPermissions['moderator']['oversight'] = true;
        $wgGroupPermissions['moderator']['protect'] = true;

        ## remove restrictions on display titles
        $wgRestrictDisplayTitle = false;

        # Notify users via email on changes
        $wgEnotifWatchlist = true;
        $wgEnotifUserTalk = true;

        # Block spam by regex
        $wgSpamRegex = ["/seo (software|tools)|pornstars|casino|gambling|viagra/i"];
      '';
    };

    # https://www.mediawiki.org/wiki/Help:Extension:Translate/Installation
    services.phpfpm.pools.mediawiki.phpOptions =
      let
        phpVersion = builtins.replaceStrings [ "." ] [ "" ] (
          lib.versions.majorMinor config.services.phpfpm.pools.mediawiki.phpPackage.version
        );
        extensions = pkgs."php${phpVersion}Extensions";
      in
      ''
        extension=${extensions.yaml}/lib/php/extensions/yaml.so
      '';

    services.postgresql.package = pkgs.postgresql_16;

    # Postgresql doesn't have column size index limits unlike MySQL,
    # which breaks inserting translation tasks into the database jobqueue.
    # As far as I can see nothing tries to query the job_cmd column with a LIKE query,
    # so we don't actually need the index on that column.
    systemd.services.mediawiki-init.script = lib.mkAfter ''
      if [ ! -f /var/lib/mediwiki/.mediawiki-job-index-fix ]; then
        ${config.services.postgresql.package}/bin/psql -d ${lib.escapeShellArg config.services.mediawiki.database.name} <<'EOF'
      DROP INDEX IF EXISTS job_cmd;
      -- the original index looks like this, we leave job_params out because it gets too long
      -- CREATE INDEX job_cmd ON job (job_cmd, job_namespace, job_title, job_params);
      -- source: https://github.com/wikimedia/mediawiki/blob/17079782a776849ec51d5c3d3712edc217cce65b/maintenance/postgres/tables-generated.sql#L480
      CREATE INDEX job_cmd ON job (job_cmd, job_namespace, job_title);
      EOF
        touch /var/lib/mediawiki/.mediawiki-job-index-fix
      fi
    '';
    systemd.services.mediawiki-init.serviceConfig.RemainAfterExit = true;

    networking.firewall.allowedTCPPorts = [
      443
      80
    ];
    security.acme.acceptTerms = true;
    services.nginx.virtualHosts.${config.services.mediawiki.nginx.hostName} = {
      enableACME = lib.mkDefault true;
      forceSSL = lib.mkDefault true;
      locations."=/nixos.png".alias = ./nixos.png;
      locations."=/favicon.ico".alias = ./favicon.ico;
      locations."=/robots.txt".alias = ./robots.txt;
    };
  };
}
