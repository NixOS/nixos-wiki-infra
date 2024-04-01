{ config, pkgs, ... }:

let
  domain = "wiki.nixos.org";
in
{
  services.opendkim.enable = true;
  services.opendkim.domains = domain;
  services.opendkim.selector = "mail";
  services.opendkim.user = config.services.postfix.user;
  services.opendkim.group = config.services.postfix.group;
  sops.secrets.opendkim-private-key.owner = config.services.postfix.user;

  services.opendkim.keyPath = "/run/opendkim-keys";
  systemd.services.opendkim.serviceConfig = {
    ExecStartPre = [
      (
        "+${pkgs.writeShellScript "opendkim-keys" ''
          install -o ${config.services.postfix.user} -g ${config.services.postfix.group} -D -m0700 ${config.sops.secrets.opendkim-private-key.path} /run/opendkim-keys/${config.services.opendkim.selector}.private
        ''}"
      )
    ];
  };

  # postfix configuration for sending emails only
  services.postfix = {
    enable = true;
    hostname = domain;
    inherit domain;

    config = {
      smtp_tls_note_starttls_offer = "yes";

      smtp_tls_security_level = "dane";

      tls_medium_cipherlist = "AES128+EECDH:AES128+EDH";

      smtpd_relay_restrictions = "permit_mynetworks permit_sasl_authenticated defer_unauth_destination";
      mydestination = "localhost.$mydomain, localhost, $myhostname";
      myorigin = "$mydomain";

      milter_default_action = "accept";
      milter_protocol = "6";
      smtpd_milters = "unix:/run/opendkim/opendkim.sock";
      non_smtpd_milters = "unix:/run/opendkim/opendkim.sock";

      inet_interfaces = "loopback-only";
      inet_protocols = "all";
    };
  };
}
