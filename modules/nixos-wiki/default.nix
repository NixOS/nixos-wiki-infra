{
  config,
  pkgs,
  lib,
  ...
}:
let
  mediawiki-maintenance = pkgs.callPackage ./mediawiki-maintenance.nix { inherit config; };
  sitemap_dir = "/var/lib/mediawiki-sitemap/";
  cfg = config.services.nixos-wiki;
in
{
  imports = [
    ./pages.nix
  ];
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
      testMode = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable test mode, which disables github login and uses a fixed admin password";
      };
    };
  };

  config = {
    environment.systemPackages = [
      (pkgs.python3.pkgs.callPackage ../../pkgs/wiki-user-search { })
    ];

    services.memcached = {
      enable = true;
      listen = "127.0.0.1";
      port = 11211;
      maxMemory = 512;
      maxConnections = 2048; # 256 connections per core for 8 cores
    };

    services.mediawiki = {
      name = "NixOS Wiki";
      enable = true;
      webserver = "nginx";
      database.type = "postgres";
      nginx.hostName = config.services.nixos-wiki.hostname;
      uploadsDir = "/var/lib/mediawiki-uploads/";
      passwordFile = if cfg.testMode then pkgs.writeText "pass" "nixos-wiki00" else cfg.adminPasswordFile;

      # PHP-FPM pool configuration optimized for 8-core machine
      poolConfig = {
        "pm" = "dynamic";
        "pm.max_children" = 64; # 8 workers per core
        "pm.start_servers" = 16; # 2 per core
        "pm.min_spare_servers" = 8; # 1 per core
        "pm.max_spare_servers" = 32; # 4 per core
        "pm.max_requests" = 1000; # Increased for better performance
      };

      extensions = {
        SyntaxHighlight_GeSHi = null; # provides <SyntaxHighlight> tags
        ParserFunctions = null;
        Cite = null;
        VisualEditor = null;
        ConfirmEdit = null; # Combat SPAM with a simple Captcha
        DiscussionTools = null; # Adds a new discussion tool to the talk pages
        Thanks = null; # Adds a "thank" button
        Linter = null; # Dependency of DiscussionTools
        Echo = null; # Dependency of DiscussionTools
        TemplateData = null;
        Description2 = pkgs.fetchzip {
          url = "https://extdist.wmflabs.org/dist/extensions/Description2-REL1_43-50e2aef.tar.gz";
          hash = "sha256-ciUEUcg4tsgpvohuLYztFaGNBowR7p1dIKnNp4ooKtA=";
        };
        # Adds meta description tag
        Mermaid = pkgs.fetchzip {
          url = "https://github.com/SemanticMediaWiki/Mermaid/archive/refs/tags/3.1.0.zip";
          hash = "sha256-tLOdAsXsaP/URvKcl5QWQiyhMy70qn8Fi8g3+ecNOWQ=";
        }; # Adds diagram generation
      }
      // pkgs.callPackages ./extensions.nix { };
      extraConfig = ''
        # docs https://www.mediawiki.org/wiki/Extension:QuestyCaptcha
        $wgCaptchaQuestions = [
          "What is the output of this command: nix-instantiate --eval --expr 'builtins.hashString \"sha256\" \"NixOS wiki\"' ?" => "\"62e65110a5a6fa4f08256f7d9ee3461412babb37dc0955531b79dcf9732c9c91\""
        ];
        wfLoadExtensions([ 'ConfirmEdit/QuestyCaptcha' ]);

        wfLoadExtension( 'Mermaid' );

        # Enable automatic meta description tags on all pages
        wfLoadExtension( 'Description2' );
        $wgEnableMetaDescriptionFunctions = true;

        #$wgDebugLogFile = "/var/log/mediawiki/debug.log";
        #$wgShowExceptionDetails = true;

        # allow local login
        ${lib.optionalString (!cfg.testMode) ''
          $wgAuthManagerOAuthConfig = [
            'github' => [
              'clientId'                => '${cfg.githubClientId}',
              'clientSecret'            => file_get_contents("${cfg.githubClientSecretFile}"),
              'urlAuthorize'            => 'https://github.com/login/oauth/authorize',
              'urlAccessToken'          => 'https://github.com/login/oauth/access_token',
              'urlResourceOwnerDetails' => 'https://api.github.com/user'
            ],
          ];
        ''}

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

        # Configure Memcached for caching
        $wgMainCacheType = CACHE_MEMCACHED;
        $wgMemCachedServers = [ '127.0.0.1:11211' ];

        wfLoadSkin( 'MinervaNeue' );
        $wgDefaultMobileSkin = 'minerva';

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

        ${lib.optionalString (!cfg.testMode) ''
          $wgEmergencyContact = "${cfg.emergencyContact}";
          $wgPasswordSender   = "${cfg.passwordSender}";
          $wgNoReplyAddress   = "${cfg.noReplyAddress}";
        ''}

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
        $wgSpamRegex = ["/seo (software|tools)|adult toys|pornstars|casino|gambling|viagra/i"];

        # Allow user-defined CSS for experimentation
        $wgAllowUserCss = true;
        # Visual Editor Settings
        $wgVisualEditorAvailableNamespaces = [
          'Help' => true,
          'Project' => true,
        ];

        # Enable String Parser functions
        $wgEnableStringFunctions = true;

        # Enable CDN/reverse proxy support for cache invalidation
        $wgUseCdn = true;

        # Configure CDN servers (nginx on localhost)
        $wgCdnServers = [ '127.0.0.1' ];

        # Use PURGE method for cache invalidation
        $wgCdnReboundPurgeDelay = 0;

        # Set cache control headers
        $wgUseCacheControl = true;

        # Cache anonymous page views
        $wgCachePages = true;

        # Send cache headers for anonymous users
        $wgCdnMaxAge = 18000; # 5 hours cache for anonymous users (MediaWiki default)
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

    # Enable Nginx VTS module for monitoring and cache-purge module
    services.nginx = {
      additionalModules = [
        pkgs.nginxModules.vts
        pkgs.nginxModules.cache-purge
      ];

      appendHttpConfig = ''
        # FastCGI cache configuration
        fastcgi_cache_path /var/cache/nginx/mediawiki
          levels=1:2
          keys_zone=mediawiki:100m
          inactive=5h
          max_size=20g
          use_temp_path=off;

        # Cache key to use - includes host, request URI, and query string
        fastcgi_cache_key "$scheme$request_method$host$request_uri";

        # Define cache purge method
        map $request_method $purge_method {
          PURGE 1;
          default 0;
        }

        # Per-IP rate limiting
        limit_req_zone $binary_remote_addr zone=ip_second:20m rate=10r/s;

        # Aggressive rate limiting for Chinese cloud providers
        geo $is_chinese_network {
          default 0;

          # Alibaba Cloud (comprehensive list)
          8.128.0.0/10 1;      # 8.128.0.0 - 8.191.255.255 (main bot source)
          8.212.128.0/18 1;    # 8.212.128.0 - 8.212.191.255
          47.52.0.0/16 1;      # 47.52.0.0 - 47.52.255.255
          47.56.0.0/15 1;      # 47.56.0.0 - 47.57.255.255
          47.86.0.0/16 1;      # 47.86.0.0 - 47.86.255.255
          47.88.0.0/14 1;      # 47.88.0.0 - 47.91.255.255
          47.238.0.0/15 1;     # 47.238.0.0 - 47.239.255.255
          47.242.0.0/16 1;     # 47.242.0.0 - 47.242.255.255
          47.243.0.0/16 1;     # 47.243.0.0 - 47.243.255.255
          47.250.0.0/17 1;     # 47.250.0.0 - 47.250.127.255
          47.254.192.0/18 1;   # 47.254.192.0 - 47.254.255.255
          72.254.0.0/16 1;     # 72.254.0.0 - 72.254.255.255
          139.95.0.0/16 1;     # 139.95.0.0 - 139.95.255.255
          147.139.0.0/16 1;    # 147.139.0.0 - 147.139.255.255
          155.102.0.0/16 1;    # 155.102.0.0 - 155.102.255.255
          163.181.0.0/16 1;    # 163.181.0.0 - 163.181.255.255

          # Tencent Cloud (comprehensive list)
          1.12.0.0/14 1;       # 1.12.0.0 - 1.15.255.255
          1.116.0.0/15 1;      # 1.116.0.0 - 1.117.255.255
          42.192.0.0/15 1;     # 42.192.0.0 - 42.193.255.255
          43.138.0.0/15 1;     # 43.138.0.0 - 43.139.255.255
          43.140.0.0/15 1;     # 43.140.0.0 - 43.141.255.255
          43.144.0.0/13 1;     # 43.144.0.0 - 43.151.255.255
          43.176.0.0/12 1;     # 43.176.0.0 - 43.191.255.255
          49.232.0.0/14 1;     # 49.232.0.0 - 49.235.255.255
          81.68.0.0/14 1;      # 81.68.0.0 - 81.71.255.255
          82.156.0.0/15 1;     # 82.156.0.0 - 82.157.255.255
          101.34.0.0/15 1;     # 101.34.0.0 - 101.35.255.255
          106.52.0.0/14 1;     # 106.52.0.0 - 106.55.255.255
          119.28.0.0/14 1;     # 119.28.0.0 - 119.31.255.255
          124.220.0.0/14 1;    # 124.220.0.0 - 124.223.255.255
          129.204.0.0/14 1;    # 129.204.0.0 - 129.207.255.255
        }

        # Extract /24 subnet for Chinese networks
        map $remote_addr $addr_subnet24 {
          "~^(\d+\.\d+\.\d+)\." $1;
          default "";
        }

        # Very aggressive rate limiting for Chinese networks
        # Per IP: 1 req/s
        map "$is_chinese_network:$binary_remote_addr" $chinese_limit_key {
          "~^0:" "";  # Not a Chinese network
          default $binary_remote_addr;
        }
        limit_req_zone $chinese_limit_key zone=chinese_ip_second:10m rate=1r/s;

        # Per /24 subnet: 3 req/s
        map "$is_chinese_network:$addr_subnet24" $chinese_subnet {
          "~^0:" "";  # Not a Chinese network
          default $addr_subnet24;
        }
        limit_req_zone $chinese_subnet zone=chinese_subnet_second:10m rate=3r/s;

        limit_req_status 429;

        # Enable VTS module
        vhost_traffic_status_zone;
        vhost_traffic_status_filter_by_host on;
      '';
    };

    services.nginx.virtualHosts.${config.services.mediawiki.nginx.hostName} = {
      enableACME = lib.mkDefault (!cfg.testMode);
      forceSSL = lib.mkDefault (!cfg.testMode);
      extraConfig = ''
        # Apply rate limits to all requests
        limit_req zone=ip_second burst=20 nodelay;

        # Apply aggressive limits for Chinese cloud providers
        limit_req zone=chinese_ip_second burst=2 nodelay;
        limit_req zone=chinese_subnet_second burst=5 nodelay;

        # Add cache status header for debugging
        add_header X-Cache-Status $upstream_cache_status always;
      '';

      locations = {
        # Extend the PHP endpoints with caching
        "~ ^/w/(index|load|api|thumb|opensearch_desc|rest|img_auth)\\.php$".extraConfig = lib.mkAfter ''
          # Cache configuration
          fastcgi_cache mediawiki;

          # Respect MediaWiki's cache headers
          fastcgi_cache_valid 200 301 302 5h;
          fastcgi_cache_valid 404 10m;

          # Use stale cache when updating or on errors
          fastcgi_cache_use_stale error timeout updating invalid_header http_500 http_503;
          fastcgi_cache_background_update on;
          fastcgi_cache_lock on;
          fastcgi_cache_lock_timeout 5s;

          # Handle cache purging - MediaWiki sends PURGE requests directly to URLs
          fastcgi_cache_purge $purge_method;
        '';

        # Extend wiki pages with caching
        "/wiki/".extraConfig = lib.mkAfter ''
          # Cache configuration for wiki pages
          fastcgi_cache mediawiki;

          # Respect MediaWiki's cache headers
          fastcgi_cache_valid 200 301 302 5h;
          fastcgi_cache_valid 404 10m;

          # Use stale cache when updating or on errors
          fastcgi_cache_use_stale error timeout updating invalid_header http_500 http_503;
          fastcgi_cache_background_update on;
          fastcgi_cache_lock on;

          # Handle cache purging - MediaWiki sends PURGE requests directly to URLs
          fastcgi_cache_purge $purge_method;
        '';

        # Static files
        "=/nixos.png".alias = ./nixos.png;
        "=/favicon.ico".alias = ./favicon.ico;
        "=/robots.txt".alias = ./robots.txt;
        "/sitemap/".alias = sitemap_dir;
        "= /sitemap.xml".alias = "${sitemap_dir}sitemap-index-mediawiki.xml";
        "= /google2855366826b5ab3a.html".alias = ./google2855366826b5ab3a.html;

        # VTS status endpoint - restricted to localhost only
        "/nginx_status" = {
          extraConfig = ''
            vhost_traffic_status_display;
            vhost_traffic_status_display_format html;
            allow 127.0.0.1;
            allow ::1;
            deny all;
          '';
        };
      };
    };

    systemd.tmpfiles.rules = [
      "d '${sitemap_dir}' 0750 mediawiki ${config.services.nginx.group} - -"
      "d '/var/cache/nginx/mediawiki' 0750 ${config.services.nginx.user} ${config.services.nginx.group} - -"
    ];

    systemd.services.wiki-sitemap = {
      startAt = "daily";
      serviceConfig = {
        ExecStart = "${mediawiki-maintenance}/bin/mediawiki-maintenance generateSitemap.php --fspath ${sitemap_dir} --server https://${config.services.nixos-wiki.hostname} --urlpath sitemap/";
        User = "mediawiki";
        Type = "oneshot";
      };
    };
  };
}
