{ lib, self, ... }:
let
  entries = builtins.attrNames (builtins.readDir ./.);
  configs = builtins.filter (dir: builtins.pathExists (./. + "/${dir}/configuration.nix")) entries;
in
{
  flake.nixosConfigurations = lib.listToAttrs
    (builtins.map
      (name:
        lib.nameValuePair
          (builtins.replaceStrings [ "." ] [ "-" ] name)
          (lib.nixosSystem {
            system = "x86_64-linux";
            # Make flake available in modules
            specialArgs = {
              self = {
                inputs = self.inputs;
                nixosModules = self.nixosModules;
              };
            };

            modules = [ (./. + "/${name}/configuration.nix") ];
          }))
      configs);
}
