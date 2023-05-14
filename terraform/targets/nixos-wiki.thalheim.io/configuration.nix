{self, ...}: {
  imports = [
    self.nixosModules.nixos-wiki
    self.nixosModules.hcloud
  ];
}
