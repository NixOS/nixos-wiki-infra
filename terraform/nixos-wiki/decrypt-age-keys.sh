#!/usr/bin/env bash

set -euo pipefail -x

mkdir -p var/lib/secrets

umask 0177
sops --extract '["age-key"]' -d "$SOPS_FILE" >./var/lib/secrets/age
# restore umask
umask 0022
