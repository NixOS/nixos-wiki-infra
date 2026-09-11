{
  config,
  lib,
  ...
}:
let
  cfg = config.services.nixos-wiki.fastly;
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
    # Fastly needs an origin name that does not point back at itself and a
    # certificate matching it (ssl_cert_hostname in nixos-infra terraform).
    services.nginx.virtualHosts.${config.services.mediawiki.nginx.hostName}.serverAliases = [
      cfg.originHostname
    ];
  };
}
