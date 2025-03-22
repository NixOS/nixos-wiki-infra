#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
rm -f .terraform.lock.hcl
TF_VAR_passphrase=$(sops -d ./secrets/terraform-passphrase)
export TF_VAR_passphrase
tofu init
tofu "$@"
