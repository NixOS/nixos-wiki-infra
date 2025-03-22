#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
rm -f .terraform.lock.hcl
nix build .#checks.x86_64-linux.test -L
TF_VAR_passphrase=$(sops -d ../admins/secrets/terraform-passphrase)
export TF_VAR_passphrase
tofu init
tofu "$@"
