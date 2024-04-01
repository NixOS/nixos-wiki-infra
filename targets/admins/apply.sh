#!/usr/bin/env bash
set -euo pipefail

rm -f .terraform.lock.hcl
tofu init -backend-config="password=$GITLAB_TOKEN" -backend-config="username=$GITLAB_USER"
tofu apply

