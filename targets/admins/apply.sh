#!/usr/bin/env bash
set -euo pipefail

rm -f .terraform.lock.hcl
terraform init -backend-config="password=$GITLAB_TOKEN" -backend-config="username=$GITLAB_USER"
terraform apply

