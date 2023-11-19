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
