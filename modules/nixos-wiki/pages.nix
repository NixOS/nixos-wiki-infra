{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.services.nixos-wiki.pages;

  # Path to pages directory
  pagesDir = lib.fileset.toSource {
    root = ../../.;
    fileset = lib.fileset.fileFilter (file: file.hasExt "wiki") ../../pages;
  };

  syncScript = pkgs.runCommand "wiki-pages-sync" { nativeBuildInputs = [ pkgs.shellcheck ]; } ''
    shellcheck ${./wiki-pages-sync.sh}
    cp ${./wiki-pages-sync.sh} $out
  '';

  pageType = types.submodule {
    options = {
      title = mkOption {
        type = types.str;
        description = "Wiki page title";
      };
      namespace = mkOption {
        type = types.str;
        default = "";
        description = "Wiki namespace (empty for main namespace)";
      };
    };
  };
in
{
  options.services.nixos-wiki.pages = {

    pageConfig = mkOption {
      type = types.attrsOf pageType;
      default = { };
      description = "Configuration for wiki pages, keyed by filename";
      example = {
        "main-page.wiki" = {
          title = "Main Page";
          namespace = "";
        };
        "help-editing.wiki" = {
          title = "Editing";
          namespace = "Help";
        };
      };
    };
  };

  config = mkIf (cfg.pageConfig != { }) {

    systemd.services.wiki-pages-sync = {
      description = "Synchronize wiki pages from git repository";
      after = [ "mediawiki-init.service" ];
      requiredBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        User = "mediawiki";
        Group = "nginx";
      };
      environment = config.services.phpfpm.pools.mediawiki.phpEnv;
      script = ''
        ${pkgs.bash}/bin/bash ${syncScript} \
          ${lib.escapeShellArg (builtins.toJSON cfg.pageConfig)} \
          ${pagesDir} \
          ${pkgs.jq}/bin/jq \
          ${config.services.phpfpm.pools.mediawiki.phpPackage}/bin/php \
          ${config.services.mediawiki.finalPackage}
      '';
    };
  };
}
