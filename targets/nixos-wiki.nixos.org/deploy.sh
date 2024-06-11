#!/usr/bin/env bash

nix build .#checks.x86_64-linux.test -L
nixos-rebuild switch --flake .#nixos-wiki-nixos-org --target-host root@wiki.nixos.org
