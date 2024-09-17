#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl zstd bash findutils gnused coreutils lychee
# shellcheck shell=bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

workdir="$SCRIPT_DIR/workdir"
mkdir -p "$workdir"
pushd "$workdir" || exit

curl "https://wiki.nixos.org/wikidump.xml.zst" | zstd -d >wikidump.xml

# filter unimportant pages like User:* Talk:*
python ../main.py filter wikidump.xml wikidump-filtered.xml

# generate exclude args from allowlist
python ../main.py badlinks ../allowed.links exclude-args

# exlude sending requests to the wiki
echo "--exclude wiki.nixos.org/wiki" >>exclude-args
extrargs="$extrargs --exclude wiki.nixos.org/wiki"
excludeargs=$(cat exclude-args)

# extract only the text from the filtered xml dump
nix --extra-experimental-features "nix-command flakes" run ..#wikiextractor wikidump-filtered.xml

# lychee requires .md or .html format files to parse
find text -type f | grep -v .html | xargs -I{} mv {} "{}.html"

# default is too high
extrargs="$extrargs --max-concurrency 16"

# github_token from env or fallback to gh (local dev)
if [ -z "${GITHUB_TOKEN}" ]; then
  if command -v gh -v &>/dev/null; then
    echo using gh auth token
    GITHUB_TOKEN=$(gh auth token)
  fi
fi

if [ -n "${GITHUB_TOKEN}" ]; then
  echo using github token
  extrargs="$extrargs --github-token $GITHUB_TOKEN"
fi

# shellcheck disable=SC2086
# fetch links
lychee -E \
  --cache --scheme http --scheme https \
  --include-verbatim $excludeargs $extrargs \
  text |
  tee lychee.log

# shellcheck disable=SC2086
# get all links ignoring the allowlist (allowed.links)
lychee -E \
  --cache --scheme http --scheme https \
  --include-verbatim $extrargs \
  text |
  tee lychee-full.log

# shellcheck disable=SC2086
# save fail_map so we can construct wiki link map to failed urls
lychee -E \
  --cache --scheme http --scheme https \
  --include-verbatim $excludeargs $extrargs \
  --format json \
  text >lychee.json

# get archive suggestions
# --timeout not working with --suggest see https://github.com/lycheeverse/lychee/issues/1501
# TODO remove timeout command later after the issue is fixed
# shellcheck disable=SC2086
timeout 30 lychee -E \
  --cache --scheme http --scheme https \
  --include-verbatim $excludeargs $extrargs \
  --suggest \
  text |
  tee lychee-wayback.log

# csv of status, url, corresponding wiki page link
python ../main.py dumplinkmap lychee.json failed-wiki-links.csv

# sort for consistency
{
  head -n 1 failed-wiki-links.csv
  tail -n +2 failed-wiki-links.csv | sort -t$'\t' -k2,2
} >sorted_filename.tsv
mv sorted_filename.tsv failed-wiki-links.csv

cat failed-wiki-links.csv

dest="../lychee-$(printf '%(%Y-%m-%d)T\n')-report"
mkdir "$dest"
cp ../allowed.links lychee*.log failed-wiki-links.csv "$dest"

popd || exit
#rm -rf "$workdir"
