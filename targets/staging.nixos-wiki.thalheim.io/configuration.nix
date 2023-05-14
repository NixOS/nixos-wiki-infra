{ self, ... }: let
  nixosVars = builtins.fromJSON (builtins.readFile ./nixos-vars.json);
in {
  imports = [
    self.nixosModules.nixos-wiki
    self.nixosModules.hcloud
  ];
  config.users.users.root.openssh.authorizedKeys.keys = nixosVars.ssh_keys;
}
