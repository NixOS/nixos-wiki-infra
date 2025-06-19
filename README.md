# nixos-wiki-infra

This project contains the setup of
[the official NixOS Wiki (wiki.nixos.org)](https://wiki.nixos.org).

Additionally,
[this project's GitHub Issues](https://github.com/NixOS/nixos-wiki-infra/issues)
host a space for coordination and discussion of wiki activities, in tandem with
[the Matrix channel `#wiki:nixos.org`](https://matrix.to/#/#wiki:nixos.org).

## Examples

Checkout [./targets/nixos-wiki.nixos.org]() for an example terraform deployment
on hetzner cloud.

## Downloading a dump of the wiki

This is useful if you want to run your own instance. Every day an XML dump is
updated here:

https://wiki.nixos.org/wikidump.xml.zst

## Restoring from a backup (wiki admins only)

```
$ systemctl stop phpfpm-mediawiki.service
$ borg-job-wiki list
$ borg-job-wiki mount u391032-sub1@u391032.your-storagebox.de:wiki.nixos.org/repo::wiki-wiki-2024-04-01T12:40:37 /tmp/restore
$ ls -la /tmp/restore/var/lib/mediawiki/backup/
$ sudo dropdb db
$ sudo -u postgres dropdb mediawiki
$ systemctl restart postgresql.service
$ sudo -u postgres pg_restore -d mediawiki < /tmp/restore/var/lib/mediawiki/backup/db
$ systemctl start phpfpm-mediawiki.service
$ ls -la /tmp/restore/var/lib/mediawiki-uploads/
$ umount /tmp/restore/
```

## Searching for wiki users (wiki admins only)

The `wiki-user-search` tool allows administrators to search for MediaWiki users
by username, email, or real name. Since it connects to PostgreSQL, it must be
run as the `postgres` user:

```bash
# Search by username
$ sudo -u postgres wiki-user-search "admin"

# Search by email domain
$ sudo -u postgres wiki-user-search "@example.com"

# Search by real name
$ sudo -u postgres wiki-user-search "John Smith"

# Limit results (default is 10)
$ sudo -u postgres wiki-user-search "test" -l 20
```

The tool displays results in a table format showing Username, Email, and Real
Name. It uses fuzzy matching with case-insensitive search and prioritizes exact
matches over partial matches.

## Applying terraform

Updating hetzner ssh keys:

```
$ ./targets/admins/tf.sh apply
```

Deploying hetzner machine:

```
$ ./targets/nixos-wiki.nixos.org/tf.sh apply
```

## Updating NixOS server

```
$ ./targets/nixos-wiki.nixos.org/deploy.sh
```

## Testing

Run NixOS VM integration tests to verify configuration:

```
$ nix build .#checks.x86_64-linux.test --log-format bar-with-logs
```

Format code:

```
$ nix fmt
```

Run link health checks:

```
$ nix develop .#linkcheck
$ ./checks/linkcheck/lychee.sh
```

## interactive VM

You can also run the wiki in an interactive vm by running

```nix
nix run .#interactive-vm
```

you can then access the wiki at localhost:4360 follow the output of the script
for more details (like passwords)

## FAQ:

### When logging in with "GitHub auth", the app shows "Act on your behalf" as a permission.

We created the Oauth app with read-only access and minimal permissions:

![](./oauth-permissions.png)

Unfortunately, GitHub misrepresents this information. Read more about this issue
here: https://github.com/orgs/community/discussions/37117

## Roles

Various roles are present on the wiki:

- Bureaucrats can assign roles to others.
  ([members](https://wiki.nixos.org/w/index.php?title=Special:ListUsers&group=bureaucrat),
  [permissions](https://wiki.nixos.org/wiki/Special:ListGroupRights#bureaucrat))
- Administrators can perform almost all restricted actions.
  ([members](https://wiki.nixos.org/w/index.php?title=Special:ListUsers&group=sysop),
  [permissions](https://wiki.nixos.org/wiki/Special:ListGroupRights#sysop))
- Moderators can perform a limited subset of restricted actions.
  ([members](https://wiki.nixos.org/w/index.php?title=Special:ListUsers&group=moderator),
  [permissions](https://wiki.nixos.org/wiki/Special:ListGroupRights#moderator))
- Trusted users can perform page deletions.
  ([members](https://wiki.nixos.org/w/index.php?title=Special:ListUsers&group=trusted),
  [permissions](https://wiki.nixos.org/wiki/Special:ListGroupRights#trusted))
