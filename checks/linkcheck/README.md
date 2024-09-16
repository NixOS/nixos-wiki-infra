## What

wiki.nixos.org dead links checker gha powered by
[lychee](https://github.com/lycheeverse/lychee)

Runs twice a week, can be adjusted in the github action cron job. Need to
manually edit links in wiki, nothing automated.

Initial run gave ~100 results and were fixed manually, see the entries before 16
Sep
[here](https://wiki.nixos.org/w/index.php?title=Special:Contributions/Phanirithvij&target=Phanirithvij&offset=&limit=100).

## Why

Dead links if detected early have a chance to prevent linkrot.

- Why not use a broken-link-checker github action?
  - wrote this so that it is not tied in to gha (works locally)
  - gha will only call the script and upload artifact

## Instructions

```shell
cd ./checks/linkcheck
direnv allow # or # nix develop ..#linkcheck
./lychee.sh
```

It can be run from anywhere so `/path/to/checks/linkcheck/lychee.sh` works but
the report will be generated at `/path/to/checks/linkcheck`.

As usual, `nix fmt` works inside linkcheck dir.

## TODO/Roadmap

- [ ] archive all links found in lychee scan (see lychee --dump)
  - Since these links are prone to deletion it is our duty to archive them.
  - There was a cli tool for this, forgot what it is, rediscover it
