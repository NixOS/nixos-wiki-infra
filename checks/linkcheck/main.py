import json
import csv
import re
import sys
import xml.etree.ElementTree as ET
from typing import NoReturn


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
def process_dump(dump_file: str, out_file: str) -> None:
    tree = ET.parse(dump_file)
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
                revisions, key=lambda revison: get_revision_timestamp(revison, ns)
            )

            # Remove all revisions except the latest one
            for revision in revisions:
                if revision != latest_revision:
                    page.remove(revision)

    tree.write(out_file, encoding="utf-8", xml_declaration=False)


def badlinks_print(known_file: str, outfile: str) -> None:
    with open(known_file, "r") as infile, open(outfile, "w") as of:
        for line in infile:
            stripped_line = line.strip()
            if stripped_line and not stripped_line.startswith("#"):
                of.write(f"--exclude {stripped_line} ")


def dump_link_map(jsonfile: str, dumpfile: str) -> None:
    with open(jsonfile, "r") as json_file:
        fail_data = json.load(json_file)

    with open(dumpfile, mode="w", newline="", encoding="utf-8") as csv_file:
        csv_writer = csv.writer(csv_file, delimiter="\t", quotechar='"')
        csv_writer.writerow(["STATUS", "URL", "WIKIURL"])

        for xml_file, failed_url_entries in fail_data["fail_map"].items():
            with open(xml_file, "r", encoding="utf-8") as xmlf:
                root = ET.fromstring(f"<root>{xmlf.read()}</root>")

            for doc in root.findall("doc"):
                title = doc.attrib.get("title")
                if title is None:
                    print(
                        f"Title not found in doc: {ET.tostring(doc)}", file=sys.stderr
                    )
                    continue
                title = re.sub(r"\s+", "_", title)
                content = doc.text

                for entry in failed_url_entries:
                    url = entry["url"]
                    status = entry.get("status", {}).get("code", 403)
                    if url in content:
                        csv_writer.writerow(
                            [
                                status,
                                url,
                                f"https://wiki.nixos.org/wiki/{title}",
                            ]
                        )


def print_usage(status: int = 0) -> NoReturn:
    print(
        """
Usage: python main.py [action] <inputfile> <outfile>
  [action]     <inputfile>     <outfile>        what?
  ——————————————————————————————————————————————————————————
  filter       dumpxmlfile     outxmlfile       filter out unncesscary pages from dump
  badlinks     badlinksfile    outfile          parse and print known allowed.links
  dumplinkmap  jsonfile        outfilelinkmap   dumps a map of url and nixos article where it is present
  help                                          prints this help message and exits
"""
    )
    sys.exit(status)


def main() -> None:
    if len(sys.argv) < 2:
        print_usage(1)
    action = sys.argv[1]
    if action in "filter|badlinks|dumplinkmap":
        if len(sys.argv) != 4:
            print_usage(1)
    if action == "filter":
        dump_file = sys.argv[2]
        out_file = sys.argv[3]
        process_dump(dump_file, out_file)
    elif action == "badlinks":
        known_file = sys.argv[2]
        out_file = sys.argv[3]
        badlinks_print(known_file, out_file)
    elif action == "dumplinkmap":
        jsonfile = sys.argv[2]
        dumpfile = sys.argv[3]
        dump_link_map(jsonfile, dumpfile)
    elif action in "--help":
        print_usage(0)
    else:
        print_usage(1)


if __name__ == "__main__":
    main()
