{ self, lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages = lib.optionalAttrs pkgs.stdenv.isLinux {
        interactive-vm = pkgs.writeShellApplication {
          name = "interactive-vm";
          runtimeInputs = [
          ];
          text =
            let
              debugVm =
                { modulesPath, ... }:
                {
                  imports = [
                    # The qemu-vm NixOS module gives us the `vm` attribute that we will later
                    # use, and other VM-related settings
                    "${modulesPath}/virtualisation/qemu-vm.nix"
                  ];

                  # Forward the hosts's port 2222 to the guest's SSH port.
                  # Also, forward the other ports 1:1 from host to guest.
                  virtualisation.forwardPorts = [
                    {
                      from = "host";
                      host.port = 2222;
                      guest.port = 22;
                    }
                    {
                      from = "host";
                      host.port = 4360;
                      guest.port = 4360;
                    }
                  ];
                  virtualisation.memorySize = 2048;

                  # Root user without password and enabled SSH for playing around
                  networking.firewall.enable = false;
                  services.openssh.enable = true;
                  services.openssh.permitRootLogin = "yes";
                  users.extraUsers.root.password = "nixos-wiki00"; # same as the admin user on the test wiki
                  environment.systemPackages = with pkgs; [
                    iptables
                  ];
                  services.nginx.defaultListen = [
                    {
                      addr = "0.0.0.0";
                      port = 4360;
                    }
                  ];
                  networking.firewall.allowedTCPPorts = [ 4360 ];
                };
              vmConfig = pkgs.nixos [
                debugVm
                self.nixosModules.nixos-wiki
                {
                  security.acme.defaults.email = "example@example.com";
                  security.acme.defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
                  services.nixos-wiki = {
                    hostname = "localhost:4360";
                    testMode = true;
                  };
                }
              ];
            in
            ''
              echo 'access the wiki after startup at http://localhost:4360'
              echo 'user: admin, password: nixos-wiki00'
              echo 'you can also SSH into the VM with: ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost -p 2222'
              echo 'password: nixos-wiki00'
              ${vmConfig.config.system.build.vm}/bin/run-nixos-vm &>/dev/null
              # TODO maybe clean up the qcow image?
            '';
        };
      };
    };
}
