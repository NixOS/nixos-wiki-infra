{
  # Allow Mic92's prometheus server to access telegraf
  networking.firewall.extraCommands = ''
    ip6tables -A nixos-fw -p tcp --source 2a01:4f8:1c1a:37b2::1/128 --dport 9273 -j nixos-fw-accept
  '';
  networking.firewall.extraStopCommands = ''
    ip6tables -D nixos-fw -p tcp --source 2a01:4f8:1c1a:37b2::1/128 --dport 9273 -j nixos-fw-accept || true
  '';
}
