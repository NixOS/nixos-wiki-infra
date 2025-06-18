#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p nixfmt-rfc-style python3 python3Packages.requests python3Packages.beautifulsoup4 gh
import json
import os
import shlex
import subprocess
import sys
import time
import urllib.parse
from dataclasses import dataclass
from pathlib import Path
from tempfile import TemporaryDirectory
from typing import Dict, Any, List, Optional

import requests
from bs4 import BeautifulSoup


def get_latest_url(
    extension_name: str, mediawiki_version: str
) -> urllib.parse.ParseResult:
    # <dl><dd><a rel="nofollow" class="external free" href="https://extdist.wmflabs.org/dist/extensions/QuickInstantCommons-REL1_41-2a29b3e.tar.gz">https://extdist.wmflabs.org/dist/extensions/QuickInstantCommons-REL1_41-2a29b3e.tar.gz</a></dd></dl>
    extension_url = f"https://www.mediawiki.org/wiki/Special:ExtensionDistributor?extdistname={extension_name}&extdistversion=REL{mediawiki_version}"
    body = requests.get(extension_url)
    soup = BeautifulSoup(body.text, "html.parser")
    url = soup.find_all("a", class_="external free")[0].get("href")
    return urllib.parse.urlparse(url)


def run(
    cmd: list[str],
    check: bool = True,
    stdout: int | None = None,
    stdin: int | None = subprocess.DEVNULL,
) -> subprocess.CompletedProcess[str]:
    print("$ " + shlex.join(cmd))
    return subprocess.run(cmd, check=check, stdout=stdout, stdin=stdin, text=True)


@dataclass
class Extension:
    name: str
    hash: str
    url: str


def download_file(url: str, local_filename: str) -> str:
    with requests.get(url, stream=True) as r:
        r.raise_for_status()
        with open(local_filename, "wb") as f:
            for chunk in r.iter_content(chunk_size=8192):
                # If you have chunk encoded response uncomment if
                # and set chunk_size parameter to None.
                # if chunk:
                f.write(chunk)
    return local_filename


def get_github_headers() -> Dict[str, str]:
    """Get headers for GitHub API requests, including auth if GITHUB_TOKEN is set"""
    headers = {"Accept": "application/vnd.github.v3+json"}
    github_token = os.environ.get("GITHUB_TOKEN")
    if github_token:
        headers["Authorization"] = f"token {github_token}"
    return headers


def get_latest_github_release_url(repo: str, extension_type: str) -> str:
    """Get latest release or tag from GitHub API"""
    headers = get_github_headers()

    if extension_type == "release":
        api_url = f"https://api.github.com/repos/{repo}/releases/latest"
        response = requests.get(api_url, headers=headers)
        response.raise_for_status()
        data = response.json()

        # Look for release assets first
        assets = data.get("assets", [])
        # Try to find a .zip asset (prefer release assets over source archives)
        for asset in assets:
            if asset["name"].endswith(".zip"):
                return asset["browser_download_url"]

        # Fallback to source archive if no release assets found
        tag_name = data["tag_name"]
        return f"https://github.com/{repo}/archive/refs/tags/{tag_name}.zip"
    elif extension_type == "tag":
        api_url = f"https://api.github.com/repos/{repo}/tags"
        response = requests.get(api_url, headers=headers)
        response.raise_for_status()
        data = response.json()
        if not data:
            raise Exception(f"No tags found for {repo}")
        latest_tag = data[0]["name"]
        return f"https://github.com/{repo}/archive/refs/tags/{latest_tag}.zip"
    else:
        raise Exception(f"Unknown extension type: {extension_type}")


def mirror_custom_extension(
    extension_name: str, github_repo: str, extension_type: str
) -> Extension:
    """Handle custom GitHub extensions"""
    download_url = get_latest_github_release_url(github_repo, extension_type)
    print(f"{extension_name}: {download_url}")

    # Use nix-prefetch-url directly for custom extensions
    for i in range(30):
        try:
            data = run(
                ["nix", "store", "prefetch-file", "--unpack", download_url, "--json"],
                stdout=subprocess.PIPE,
            ).stdout.strip()
            hash = json.loads(data)["hash"]
        except subprocess.CalledProcessError:
            print("nix-prefetch-url failed, retrying")
            time.sleep(i * 5)
            continue
        else:
            return Extension(name=extension_name, hash=hash, url=download_url)
    raise Exception("Failed to fetch extension, see above")


def mirror_extension(extension_name: str, mediawiki_version: str) -> Extension:
    download_url = get_latest_url(extension_name, mediawiki_version)
    base_name = Path(download_url.path).name
    print(f"{base_name}: {download_url.geturl()}")

    if run(["gh", "release", "view", base_name], check=False).returncode != 0:
        run(["gh", "release", "create", "--title", base_name, base_name])
    mirror_url = f"https://github.com/NixOS/nixos-wiki-infra/releases/download/{base_name}/{base_name}"
    if requests.head(mirror_url).status_code == 404:
        with TemporaryDirectory() as tmpdir:
            download_file(download_url.geturl(), f"{tmpdir}/{base_name}")
            run(["gh", "release", "upload", base_name, f"{tmpdir}/{base_name}"])
    for i in range(30):
        try:
            data = run(
                ["nix", "store", "prefetch-file", "--unpack", mirror_url, "--json"],
                stdout=subprocess.PIPE,
            ).stdout.strip()
            hash = json.loads(data)["hash"]
        except subprocess.CalledProcessError:
            # sometimes github takes a while to make releases available
            print("nix-prefetch-url failed, retrying")
            time.sleep(i * 5)
            continue
        else:
            return Extension(name=extension_name, hash=hash, url=mirror_url)
    raise Exception("Failed to fetch extension, see above")


def extension_nix_expression(mirrored_extensions: List[Extension]) -> str:
    expression = "{ fetchzip }: {\n"
    for extension in mirrored_extensions:
        expression += f'  "{extension.name}" = fetchzip {{ url = "{extension.url}"; hash = "{extension.hash}"; }};\n'
    expression += "}\n"
    return expression


def get_mediawiki_version(mediawiki_version: Optional[str] = None) -> str:
    if mediawiki_version is None:
        mediawiki_version = run(
            [
                "nix",
                "eval",
                "--inputs-from",
                ".#",
                "--raw",
                "nixpkgs#mediawiki.version",
            ],
            stdout=subprocess.PIPE,
        ).stdout.strip()
    mediawiki_version = mediawiki_version.replace(".", "_")
    version_parts = mediawiki_version.split("_")
    return version_parts[0] + "_" + version_parts[1]


def main() -> None:
    if len(sys.argv) < 2:
        print("Usage: update-extensions.py extensions.json [mediawiki_version]")
        sys.exit(1)

    extensions: Dict[str, Any] = json.loads(Path(sys.argv[1]).read_text())
    mediawiki_version = get_mediawiki_version(
        sys.argv[2] if len(sys.argv) > 2 else None
    )

    # so that gh picks up the correct repository
    os.chdir(Path(__file__).parent)

    mirrored_extensions: List[Extension] = []
    for name, config in extensions.items():
        if config.get("type") == "github":
            # Handle GitHub extensions
            github_repo: str = config["github_repo"]
            github_type: str = config["github_type"]
            extension = mirror_custom_extension(name, github_repo, github_type)
        else:
            # Handle standard MediaWiki extensions
            extension = mirror_extension(name, mediawiki_version)
        mirrored_extensions.append(extension)

    nix_extensions = Path("extensions.nix")
    nix_extensions.write_text(extension_nix_expression(mirrored_extensions))
    run(["nixfmt", str(nix_extensions)])


if __name__ == "__main__":
    main()
