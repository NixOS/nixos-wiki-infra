{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.nixos-wiki.fastly;
  # https://api.fastly.com/public-ip-list, refresh with ./update-fastly-ips.sh
  fastlyIps = lib.importJSON ./fastly-ips.json;
  fastlyRanges = fastlyIps.addresses ++ fastlyIps.ipv6_addresses;
in
{
  options.services.nixos-wiki.fastly = {
    enable = lib.mkEnableOption "serving the wiki through Fastly";
    originHostname = lib.mkOption {
      type = lib.types.str;
      description = ''
        Hostname Fastly connects to and validates the origin certificate
        against. Must resolve directly to this machine, not to Fastly.
      '';
    };
    apiTokenFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = ''
        File containing a Fastly API token with purge permission on the wiki
        service. Without it the FastlyPurge extension is loaded but inert.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.mediawiki.extensions.FastlyPurge =
      pkgs.callPackage ../../pkgs/mediawiki-fastly-purge/package.nix
        { };

    services.mediawiki.extraConfig = ''
      ${lib.optionalString (cfg.apiTokenFile != null) ''
        $wgFastlyApiToken = trim( file_get_contents( '${cfg.apiTokenFile}' ) );
      ''}
      # nginx already rewrites REMOTE_ADDR from Fastly-Client-IP, this only
      # covers X-Forwarded-For handling inside MediaWiki (blocks, rate limits).
      $wgCdnServersNoPurge = [ ${lib.concatMapStringsSep ", " (r: "'${r}'") fastlyRanges} ];
    '';

    services.nginx.commonHttpConfig = ''
      ${lib.concatMapStrings (r: "set_real_ip_from ${r};\n") fastlyRanges}
      # Set by Fastly on the edge; the VCL must overwrite any client supplied value.
      real_ip_header Fastly-Client-IP;

      # $realip_remote_addr is the connecting peer, $remote_addr the client
      geo $realip_remote_addr $via {
        default direct;
        127.0.0.0/8 local;
        ::1 local;
        ${lib.concatMapStrings (r: "${r} fastly;\n") fastlyRanges}
      }
      log_format wiki '$remote_addr $via $upstream_cache_status [$time_local] '
        '"$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" $request_time';
    '';

    # Fastly needs an origin name that does not point back at itself and a
    # certificate matching it (ssl_cert_hostname in nixos-infra terraform).
    services.nginx.virtualHosts.${config.services.mediawiki.nginx.hostName} = {
      serverAliases = [ cfg.originHostname ];
      extraConfig = ''
        access_log syslog:server=unix:/dev/log,nohostname wiki;
        # ${cfg.originHostname} and loopback (MediaWiki PURGE) stay reachable
        set $via_host "$via:$host";
        if ($via_host = "direct:${config.services.mediawiki.nginx.hostName}") {
          return 421;
        }
      '';
    };
  };
}
