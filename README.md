# nixos-wiki-infra

This project contains everything to setup yourself a mirror of https://nixos.wiki/

## Demo

I have one instance deployed [here](https://nixos-wiki.thalheim.io/wiki/Main_Page)

## Examples

Checkout [./targets/nixos-wiki2.thalheim.io]() for an example terraform deployment on hetzner cloud.

## Restoring from an backup

After installing run:

```
systemctl start wiki-backup.service && systemctl start wiki-restore
```

Note that `nixos-wiki-backup` will do this restore every night.

## Outstanding patches

I have encountered some regressions in mediawiki's latest release.
Patches are included in this repository.
The patches have been sent to upstream here: https://gerrit.wikimedia.org/r/c/mediawiki/core/+/971581
