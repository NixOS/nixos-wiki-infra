{ config, pkgs, ... }:
let
  wikiDump = "/var/backup/wikidump.xml.gz";

  mediawiki-maintenance = pkgs.runCommand "mediawiki-maintenance"
    {
      nativeBuildInputs = [ pkgs.makeWrapper ];
      preferLocalBuild = true;
    } ''
    mkdir -p $out/bin
    makeWrapper ${config.services.phpfpm.pools.mediawiki.phpPackage}/bin/php $out/bin/mediawiki-maintenance \
      --set MEDIAWIKI_CONFIG ${config.services.phpfpm.pools.mediawiki.phpEnv.MEDIAWIKI_CONFIG} \
      --add-flags ${config.services.mediawiki.finalPackage}/share/mediawiki/maintenance/run.php
  '';

  wiki-backup = pkgs.writeShellApplication
    {
      name = "wiki-backup";
      runtimeInputs = [
        pkgs.postgresql
        pkgs.util-linux
      ];
      text = ''
        tmpdir=$(mktemp -d)
        cleanup() { rm -rf "$tmpdir"; }

        chown postgres:users "$tmpdir"
        mkdir -p /var/lib/mediawiki/backup/
        runuser -u postgres -- pg_dump --format=custom --file "$tmpdir"/db mediawiki 
        cp "$tmpdir"/db /var/lib/mediawiki/backup/db
        trap cleanup EXIT
      '';
    };

  old-wiki-restore = pkgs.writeShellApplication {
    name = "old-wiki-restore";
    runtimeInputs = [
      pkgs.postgresql
      pkgs.coreutils
      pkgs.util-linux
      mediawiki-maintenance
    ];
    text = ''
      tmpdir=$(mktemp -d)
      cleanup() { rm -rf "$tmpdir"; }
      cd "$tmpdir"
      chown mediawiki:nginx "$tmpdir"

      rm -rf /var/lib/mediawiki-uploads
      install -d -m 755 -o mediawiki -g nginx /var/lib/mediawiki-uploads
      systemctl stop phpfpm-mediawiki.service
      runuser -u postgres -- dropdb mediawiki
      systemctl restart postgresql
      runuser -u postgres -- psql -c "ALTER DATABASE mediawiki OWNER TO mediawiki"
      systemctl restart mediawiki-init.service
      cat <<EOF | runuser -u mediawiki -- mediawiki-maintenance deleteBatch.php
      Main_Page
      MediaWiki:About
      EOF
      trap cleanup EXIT
      cp ${wikiDump} "$tmpdir"
      chown mediawiki:nginx "$tmpdir/wikidump.xml.gz"
      chmod 644 "$tmpdir/wikidump.xml.gz"
      runuser -u mediawiki -- mediawiki-maintenance importDump.php --uploads "$tmpdir/wikidump.xml.gz"
      runuser -u mediawiki -- mediawiki-maintenance rebuildrecentchanges.php
      systemctl start phpfpm-mediawiki.service
    '';
  };
in
{
  environment.systemPackages = [ mediawiki-maintenance ];

  systemd.services.old-wiki-backup = {
    startAt = "hourly";

    serviceConfig = {
      ExecStart = [
        "${pkgs.coreutils}/bin/mkdir -p /var/backup"
        "${pkgs.wget}/bin/wget https://nixos.wiki/images/wikidump.xml.gz -O ${wikiDump}.new"
        "${pkgs.coreutils}/bin/mv ${wikiDump}.new ${wikiDump}"
      ];
      Type = "oneshot";
    };
  };

  systemd.services.old-wiki-restore = {
    startAt = "daily";
    path = [ pkgs.postgresql mediawiki-maintenance ];

    serviceConfig = {
      ExecStart = "${old-wiki-restore}/bin/old-wiki-restore";
      Type = "oneshot";
    };
  };

  systemd.services.wiki-backup = {
    startAt = "daily";
    path = [ pkgs.postgresql ];

    unitConfig = {
      Conflicts = [ "phpfpm-mediawiki.service" ];
      OnSuccess = [ "phpfpm-mediawiki.service" ];
      OnFailure = [ "phpfpm-mediawiki.service" ];
    };
    serviceConfig = {
      ExecStart = "${wiki-backup}/bin/wiki-backup";
      Type = "oneshot";
    };
  };


  services.nginx.virtualHosts.${config.services.mediawiki.nginx.hostName} = {
    locations."=/wikidump.xml.gz".alias = wikiDump;
  };


  sops.secrets.storagebox-ssh-key = {
    sopsFile = ../../targets/nixos-wiki.nixos.org/secrets/backup_share_ssh_key;
    format = "binary";
    path = "/var/keys/storagebox-ssh-key";
    mode = "0600";
    owner = "root";
    group = "root";
  };

  sops.secrets.backup-secret = {
    sopsFile = ../../targets/nixos-wiki.nixos.org/secrets/borg_encryption_passphrase;
    format = "binary";
    path = "/var/keys/borg-secret";
    mode = "0600";
    owner = "root";
    group = "root";
  };


  programs.ssh.knownHosts."[u391032.your-storagebox.de]:23".publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA5EB5p/5Hp3hGW1oHok+PIOH9Pbn7cnUiGmUEBrCVjnAw+HrKyN8bYVV0dIGllswYXwkG/+bgiBlE6IVIBAq+JwVWu1Sss3KarHY3OvFJUXZoZyRRg/Gc/+LRCE7lyKpwWQ70dbelGRyyJFH36eNv6ySXoUYtGkwlU5IVaHPApOxe4LHPZa/qhSRbPo2hwoh0orCtgejRebNtW5nlx00DNFgsvn8Svz2cIYLxsPVzKgUxs8Zxsxgn+Q/UvR7uq4AbAhyBMLxv7DjJ1pc7PJocuTno2Rw9uMZi1gkjbnmiOh6TTXIEWbnroyIhwc8555uto9melEUmWNQ+C+PwAK+MPw==";

  systemd.services.borgbackup-job-state = {
    wants = [ "wiki-backup.service" ];
    after = [ "wiki-backup.service" ];
  };

  services.borgbackup.jobs.state = {
    # Create the repo
    doInit = true;

    # Create daily backups, but prune to a reasonable amount
    startAt = "daily";
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };

    paths = [ "/var/lib/mediawiki-uploads" "/var/lib/mediawiki/backup" ];

    # Where to backup it to
    repo = "u391032-sub1@u391032.your-storagebox.de:wiki.nixos.org/repo";
    environment.BORG_RSH = "ssh -p 23 -i /var/keys/storagebox-ssh-key";

    # Authenticated & encrypted, key resides in the repository
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /var/keys/borg-secret";
    };

    # Reduce the backup size
    compression = "auto,zstd";

    # Show summary detailing data usage once completed
    extraCreateArgs = "--stats";
  };




}
