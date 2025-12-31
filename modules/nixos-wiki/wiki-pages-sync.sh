#!/usr/bin/env bash
set -euo pipefail

# Arguments: config_json pages_dir jq_bin php_bin mediawiki_path
config="$1"
pages_dir="$2"
jq_bin="$3"
php_bin="$4"
mediawiki_path="$5"

# Process each .wiki file (they're in the pages subdirectory)
for wiki_file in "$pages_dir"/pages/*.wiki; do
  # Skip if no .wiki files found
  [ -e "$wiki_file" ] || continue

  filename=$(basename "$wiki_file")

  # Extract configuration for this file from JSON
  # shellcheck disable=SC2016 # $file is a jq variable, not shell
  title=$("$jq_bin" -r --arg file "$filename" '.[$file].title // empty' <<<"$config")
  # shellcheck disable=SC2016 # $file is a jq variable, not shell
  namespace=$("$jq_bin" -r --arg file "$filename" '.[$file].namespace // ""' <<<"$config")

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

  # Define the comment content
  comment_text="This page is automatically managed through git repository synchronization.
Do not edit this page directly on the wiki - changes will be overwritten.
To edit this page, modify the file: $filename
Source: https://github.com/NixOS/nixos-wiki-infra/blob/main/pages/$filename"

  # Use appropriate comment syntax based on page type
  if [[ $filename == *.css.wiki ]]; then
    content_with_comment="/*
$comment_text
*/

$content"
  else
    content_with_comment="<!--
$comment_text
-->

$content"
  fi

  # Edit the page using maintenance script (no --user means system maintenance user)
  echo "$content_with_comment" | "$php_bin" \
    "$mediawiki_path/share/mediawiki/maintenance/run.php" edit \
    --summary="Updated $filename from git repository" \
    --bot \
    "$full_title"

  echo "Successfully updated: $full_title"
done

echo "Wiki synchronization completed successfully"
