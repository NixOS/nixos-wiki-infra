{ lib, self, ... }:
let
  collectNixosHosts = { directory }:
    lib.mapAttrs'
      (name: _:
      lib.nameValuePair
        name
        (lib.nixosSystem {
          system = "x86_64-linux";
          # Make flake available in modules
          specialArgs = {
            self = {
              inputs = self.inputs;
              nixosModules = self.nixosModules;
            };
          };

          modules = [ (directory + "/${name}/configuration.nix") ];
        }))
      (builtins.readDir directory);
in
{ 
  flake.nixosConfigurations = collectNixosHosts {
    directory = ".";
  };
}
