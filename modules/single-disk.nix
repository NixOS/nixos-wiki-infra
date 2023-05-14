{ self, ... }:
let
  partitions = [
    {
      name = "grub";
      end = "1M";
      part-type = "primary";
      flags = [ "bios_grub" ];
    }
    {
      name = "ESP";
      start = "1MiB";
      end = "500MiB";
      bootable = true;
      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
      };
    }
    {
      name = "root";
      start = "100MiB";
      end = "100%";
      part-type = "primary";
      bootable = true;
      content = {
        type = "filesystem";
        # We use xfs because it has support for compression and has a quite good performance for databases
        format = "xfs";
        mountpoint = "/";
      };
    }
  ];
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
        type = "table";
        format = "gpt";
        inherit partitions;
      };
    };
  };
}
