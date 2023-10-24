{ self, ... }:
let
  partitions = {
    boot = {
      size = "1M";
      type = "EF02"; # for grub MBR
    };
    esp = {
      size = "500M";
      type = "EF00"; # for grub MBR
      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
      };
    };
    root = {
      size = "100%";
      content = {
        type = "filesystem";
        format = "ext4";
        mountpoint = "/";
      };
    };
  };
in
{
  imports = [
    self.inputs.disko.nixosModules.disko
  ];
  disko.devices = {
    disk.sda = {
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "gpt";
        inherit partitions;
      };
    };
  };
}
