#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"
rm -f .terraform.lock.hcl
tofu init -backend-config="password=$GITLAB_TOKEN" -backend-config="username=$GITLAB_USER"
tofu apply

