{
  # Allow Mic92's prometheus server to access telegraf
  networking.firewall.extraCommands = ''
    ip6tables -A nixos-fw -p tcp --source 2a03:4000:62:fdb::/128 --dport 9273 -j nixos-fw-accept
  '';
  networking.firewall.extraStopCommands = ''
    ip6tables -D nixos-fw -p tcp --source 2a03:4000:62:fdb::/128 --dport 9273 -j nixos-fw-accept || true
  '';
}
