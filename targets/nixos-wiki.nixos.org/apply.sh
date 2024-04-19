#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
rm -f .terraform.lock.hcl
nix build .#checks.x86_64-linux.test -L
tofu init -backend-config="password=$GITLAB_TOKEN" -backend-config="username=$GITLAB_USER"
tofu apply "$@"
