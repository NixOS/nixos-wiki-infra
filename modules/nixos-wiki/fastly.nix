{
  config,
  lib,
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
  };

  config = lib.mkIf cfg.enable {
    services.mediawiki.extraConfig = ''
      # nginx already rewrites REMOTE_ADDR from Fastly-Client-IP, this only
      # covers X-Forwarded-For handling inside MediaWiki (blocks, rate limits).
      $wgCdnServersNoPurge = [ ${lib.concatMapStringsSep ", " (r: "'${r}'") fastlyRanges} ];
    '';

    services.nginx.commonHttpConfig = ''
      ${lib.concatMapStrings (r: "set_real_ip_from ${r};\n") fastlyRanges}
      # Set by Fastly on the edge; the VCL must overwrite any client supplied value.
      real_ip_header Fastly-Client-IP;
    '';

    # Fastly needs an origin name that does not point back at itself and a
    # certificate matching it (ssl_cert_hostname in nixos-infra terraform).
    services.nginx.virtualHosts.${config.services.mediawiki.nginx.hostName}.serverAliases = [
      cfg.originHostname
    ];
  };
}
