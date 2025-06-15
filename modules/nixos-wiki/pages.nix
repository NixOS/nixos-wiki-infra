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
                # Read the JSON config
                config='${builtins.toJSON cfg.pageConfig}'

                # Process each .wiki file (they're in the pages subdirectory)
                for wiki_file in "${pagesDir}"/pages/*.wiki; do
                    # Skip if no .wiki files found
                    [ -e "$wiki_file" ] || continue

                    filename=$(basename "$wiki_file")

                    # Extract configuration for this file from JSON
                    title=$(echo "$config" | ${pkgs.jq}/bin/jq -r --arg file "$filename" '.[$file].title // empty')
                    namespace=$(echo "$config" | ${pkgs.jq}/bin/jq -r --arg file "$filename" '.[$file].namespace // ""')

                    # Skip if no config found for this file
                    if [ -z "$title" ]; then
                        echo "Warning: No configuration found for $filename, skipping"
                        continue
                    fi

                    # Construct full page title
                    if [ -n "$namespace" ]; then
                        full_title="$namespace:$title"
                    else
                        full_title="$title"
                    fi

                    echo "Processing: $filename -> $full_title"

                    # Read page content and add management comment
                    content=$(cat "$wiki_file")
                    content_with_comment="<!--
        This page is automatically managed through git repository synchronization.
        Do not edit this page directly on the wiki - changes will be overwritten.
        To edit this page, modify the file: $filename
        Source: https://github.com/NixOS/nixos-wiki-infra/blob/main/pages/$filename
        -->

        $content"

                    # Edit the page using maintenance script (no --user means system maintenance user)
                    echo "$content_with_comment" | ${config.services.phpfpm.pools.mediawiki.phpPackage}/bin/php \
                      ${config.services.mediawiki.finalPackage}/share/mediawiki/maintenance/run.php edit \
                      --summary="Updated $filename from git repository" \
                      --bot \
                      "$full_title"

                    echo "Successfully updated: $full_title"
                done

                echo "Wiki synchronization completed successfully"
      '';
    };
  };
}
