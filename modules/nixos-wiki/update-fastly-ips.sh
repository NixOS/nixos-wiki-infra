#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
curl -sf https://api.fastly.com/public-ip-list | jq . >fastly-ips.json
