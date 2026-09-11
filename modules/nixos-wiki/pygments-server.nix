{ config, pkgs, ... }:
let
  package = pkgs.callPackage ../../pkgs/pygments-server { };
in
{
  # SyntaxHighlight forks pygmentize per <syntaxhighlight> block on every
  # parse; ~180ms each, almost all of it interpreter start-up.
  services.mediawiki.extraConfig = ''
    $wgPygmentizePath = "${package}/bin/pygmentize";
  '';

  systemd.sockets.pygments-server = {
    wantedBy = [ "sockets.target" ];
    socketConfig = {
      ListenStream = package.socketPath;
      SocketUser = "mediawiki";
      SocketGroup = config.services.nginx.group;
      SocketMode = "0660";
    };
  };

  systemd.services.pygments-server = {
    serviceConfig = {
      ExecStart = "${package}/bin/pygments-server";
      DynamicUser = true;
      Restart = "always";
      MemoryMax = "512M";
      CapabilityBoundingSet = "";
      NoNewPrivileges = true;
      PrivateDevices = true;
      PrivateNetwork = true;
      ProtectHome = true;
      ProtectSystem = "strict";
      ProtectProc = "invisible";
      RestrictAddressFamilies = "AF_UNIX";
      RestrictNamespaces = true;
      SystemCallFilter = [
        "@system-service"
        "~@privileged @resources"
      ];
    };
  };
}
