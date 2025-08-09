{ config, pkgs, ... }:
let
  wikiDump = "/var/lib/mediawiki/backup/wikidump.xml.zst";

  mediawiki-maintenance = pkgs.callPackage ./mediawiki-maintenance.nix {};

  wiki-backup = pkgs.writeShellApplication {
    name = "wiki-backup";
    runtimeInputs = [
      config.services.postgresql.package
      pkgs.util-linux
    ];
    text = ''
      mkdir -p /var/lib/mediawiki/backup/
      runuser -u postgres -- pg_dump --compress=zstd --format=custom mediawiki > /var/lib/mediawiki/backup/db.tmp
      mv /var/lib/mediawiki/backup/{db.tmp,db}
    '';
  };

  # to restore:
  # $ runuser -u postgres -- pg_restore --format=custom -d mediawiki < /tmp/db

  wiki-dump = pkgs.writeShellApplication {
    name = "wiki-dump";
    runtimeInputs = [
      pkgs.util-linux
      pkgs.coreutils
    ];
    text = ''
      mkdir -p /var/lib/mediawiki/backup/
      runuser -u mediawiki -- ${mediawiki-maintenance}/bin/mediawiki-maintenance dumpBackup.php \
        --full --include-files --uploads --quiet | \
        ${pkgs.zstd}/bin/zstd > ${wikiDump}.tmp
      mv ${wikiDump}{.tmp,}
    '';
  };
in
{
  environment.systemPackages = [ mediawiki-maintenance ];

  systemd.services.wiki-backup = {
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

  systemd.services.wiki-dump = {
    startAt = "daily";

    unitConfig = {
      Conflicts = [ "phpfpm-mediawiki.service" ];
      OnSuccess = [ "phpfpm-mediawiki.service" ];
      OnFailure = [ "phpfpm-mediawiki.service" ];
    };
    serviceConfig = {
      ExecStart = "${wiki-dump}/bin/wiki-dump";
      Type = "oneshot";
    };
  };

  services.nginx.virtualHosts.${config.services.mediawiki.nginx.hostName}.locations."=/wikidump.xml.zst".alias =
    wikiDump;

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

  programs.ssh.knownHosts."[u391032.your-storagebox.de]:23".publicKey =
    "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA5EB5p/5Hp3hGW1oHok+PIOH9Pbn7cnUiGmUEBrCVjnAw+HrKyN8bYVV0dIGllswYXwkG/+bgiBlE6IVIBAq+JwVWu1Sss3KarHY3OvFJUXZoZyRRg/Gc/+LRCE7lyKpwWQ70dbelGRyyJFH36eNv6ySXoUYtGkwlU5IVaHPApOxe4LHPZa/qhSRbPo2hwoh0orCtgejRebNtW5nlx00DNFgsvn8Svz2cIYLxsPVzKgUxs8Zxsxgn+Q/UvR7uq4AbAhyBMLxv7DjJ1pc7PJocuTno2Rw9uMZi1gkjbnmiOh6TTXIEWbnroyIhwc8555uto9melEUmWNQ+C+PwAK+MPw==";

  systemd.services.borgbackup-job-state = {
    wants = [ "wiki-backup.service" ];
    after = [ "wiki-backup.service" ];
  };

  services.borgbackup.jobs.${config.networking.hostName} = {
    # Create the repo
    doInit = true;

    # Create daily backups, but prune to a reasonable amount
    startAt = "daily";
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };

    paths = [
      "/var/lib/mediawiki-uploads"
      "/var/lib/mediawiki/backup"
    ];

    # Where to backup it to
    repo = "u391032-sub1@u391032.your-storagebox.de:wiki.nixos.org/repo";
    environment.BORG_RSH = "ssh -p 23 -i /var/keys/storagebox-ssh-key";

    preHook = ''
      set -x
      ${config.systemd.package}/bin/systemctl start --wait wiki-dump wiki-backup
      set +x
    '';
    postHook = ''
      cat > /var/log/telegraf/borgbackup-job-${config.networking.hostName}.service <<EOF
      task,frequency=daily last_run=$(date +%s)i,state="$([[ $exitStatus == 0 ]] && echo ok || echo fail)"
      EOF
    '';

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

  systemd.services."borgbackup-job-${config.networking.hostName}".serviceConfig.ReadWritePaths = [
    "/var/log/telegraf"
  ];
}
