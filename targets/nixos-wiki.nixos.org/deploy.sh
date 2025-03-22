#!/usr/bin/env bash

set -euxo pipefail

nixBuild() {
  if command -v nom -v &>/dev/null; then
    nom build "$@"
  else
    nix build "$@"
  fi
}
nixBuild .#checks.x86_64-linux.test .#nixosConfigurations.nixos-wiki-nixos-org.config.system.build.toplevel -L
if ! nixos-rebuild-ng switch --flake .#nixos-wiki-nixos-org --target-host root@wiki.nixos.org; then
  nixos-rebuild-ng switch --flake .#nixos-wiki-nixos-org --target-host root@wiki.nixos.org
fi
