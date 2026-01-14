import json
import csv
import re
import sys
import argparse
import bisect
import xml.etree.ElementTree as ET
from pathlib import Path


def get_revision_timestamp(revision: ET.Element, ns: dict[str, str]) -> str:
    timestamp = revision.find("mw:timestamp", ns)
    if timestamp is None:
        print(
            f"Timestamp tag not found in revision: {ET.tostring(revision)}",
            file=sys.stderr,
        )
        return ""
    if timestamp.text is None:
        print(
            f"Timestamp text doesn't exist in revision: {ET.tostring(revision)}",
            file=sys.stderr,
        )
        return ""
    return timestamp.text


# filter out unimportant pages like Talk:, User:, and old revisions of posts
def process_dump(args: argparse.Namespace) -> None:
    tree = ET.parse(str(args.dump_file))
    root = tree.getroot()

    ns = {"mw": "http://www.mediawiki.org/xml/export-0.11/"}
    ET.register_namespace("", ns["mw"])

    for page in root.findall("mw:page", ns):
        title_tag = page.find("mw:title", ns)
        if title_tag is None:
            print(f"Title tag not found in page: {ET.tostring(page)}", file=sys.stderr)
            continue
        title = title_tag.text
        if title is None:
            print(
                f"Title text doesn't exist in page: {ET.tostring(page)}",
                file=sys.stderr,
            )
            continue

        if title.startswith("User:") or title.startswith("Talk:"):
            root.remove(page)
            continue

        revisions = page.findall("mw:revision", ns)

        if len(revisions) > 1:
            latest_revision = max(
                revisions, key=lambda revision: get_revision_timestamp(revision, ns)
            )

            # Remove all revisions except the latest one
            for revision in revisions:
                if revision != latest_revision:
                    page.remove(revision)

    tree.write(str(args.out_file), encoding="utf-8", xml_declaration=False)


def badlinks_print(args: argparse.Namespace) -> None:
    with args.known_file.open() as infile, args.out_file.open("w") as of:
        for line in infile:
            stripped_line = line.strip()
            if stripped_line and not stripped_line.startswith("#"):
                of.write(f"--exclude {stripped_line} ")


def read_lychee_file(lychee_file: Path) -> list[list[str]]:
    fail_data = json.loads(lychee_file.read_text())
    failed_urls = []
    for xml_file, failed_url_entries in fail_data["fail_map"].items():
        with open(xml_file, "r", encoding="utf-8") as xmlf:
            root = ET.fromstring(f"<root>{xmlf.read()}</root>")
        for doc in root.findall("doc"):
            title = doc.attrib.get("title")
            if title is None:
                print(f"Title not found in doc: {ET.tostring(doc)}", file=sys.stderr)
                continue
            title = re.sub(r"\s+", "_", title)
            content = doc.text
            for entry in failed_url_entries:
                url = entry["url"]
                status = entry.get("status", {}).get("code", 403)
                if url in content:
                    bisect.insort(
                        failed_urls,
                        [
                            status,
                            url,
                            f"https://wiki.nixos.org/wiki/{title}",
                        ],
                    )
    return failed_urls


def dump_link_map(args: argparse.Namespace) -> None:
    failed_urls = read_lychee_file(args.json_file)

    with args.dump_file.open(mode="w", newline="", encoding="utf-8") as csv_file:
        csv_writer = csv.writer(csv_file, delimiter="\t", quotechar='"')
        csv_writer.writerow(["STATUS", "URL", "WIKIURL"])

        for item in failed_urls:
            csv_writer.writerow(item)


def main() -> None:
    parser = argparse.ArgumentParser(description="Process wiki dump files")
    subparsers = parser.add_subparsers()
    parser_filter = subparsers.add_parser("filter", help="Filter out unimportant pages")

    parser_filter.add_argument("dump_file", type=Path)
    parser_filter.add_argument("out_file", type=Path)
    parser_filter.set_defaults(func=process_dump)

    parser_badlinks = subparsers.add_parser(
        "badlinks", help="Parse and print known allowed links"
    )
    parser_badlinks.add_argument("known_file", type=Path)
    parser_badlinks.add_argument("out_file", type=Path)
    parser_badlinks.set_defaults(func=badlinks_print)

    parser_dumplinkmap = subparsers.add_parser(
        "dumplinkmap", help="Dump a map of url and nixos article where it is present"
    )
    parser_dumplinkmap.add_argument("json_file", type=Path)
    parser_dumplinkmap.add_argument("dump_file", type=Path)
    parser_dumplinkmap.set_defaults(func=dump_link_map)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
