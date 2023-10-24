#!/usr/bin/env bash

mkdir -p var/lib/secrets

umask 0177
sops --extract '["age-key"]' -d "secrets.yaml" > ./var/lib/secrets/age
# restore umask
umask 0022
