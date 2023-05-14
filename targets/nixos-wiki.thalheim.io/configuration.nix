{ self, ... }: let
  nixosVars = builtins.fromJSON (builtins.readFile ./nixos-vars.json);
in {
  imports = [
    self.nixosModules.nixos-wiki
    self.nixosModules.hcloud
  ];
  users.users.root.openssh.authorizedKeys.keys = nixosVars.ssh_keys;
  system.stateVersion = "23.05";
}
