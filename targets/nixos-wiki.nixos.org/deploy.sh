#!/usr/bin/env bash

nixos-rebuild switch --flake .#nixos-wiki-nixos-org --target-host root@wiki.nixos.org
