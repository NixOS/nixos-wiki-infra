#!/usr/bin/env bash

nix build .#checks.x86_64-linux.test .#nixosConfigurations.nixos-wiki-nixos-org.config.system.build.toplevel -L
if ! nixos-rebuild switch --flake .#nixos-wiki-nixos-org --target-host root@wiki.nixos.org; then
  nixos-rebuild switch --flake .#nixos-wiki-nixos-org --target-host root@wiki.nixos.org
fi
