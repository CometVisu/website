import re
import sys
from pathlib import Path


HREF_RE = re.compile(r'(\bhref=)(["\'])(.*?)\2')
CLASS_RE = re.compile(r'\bclass=(["\'])(.*?)\1')
ANCHOR_RE = re.compile(r'<a\b[^>]*>', re.IGNORECASE)
LANGUAGE_LINK_RE = re.compile(r'^(.*?)(?:\.\./)(en|de)/$')
HOMEPAGE_SECTION_LINK_RE = re.compile(
    r'^(.*?)(?:\.\./){2}(de/)?#(features|customization)$'
)


def fix_anchor(anchor: str) -> str:
    class_match = CLASS_RE.search(anchor)
    href_match = HREF_RE.search(anchor)
    if class_match is None or href_match is None:
        return anchor

    classes = class_match.group(2).split()
    href = href_match.group(3)

    if "cv-nav-logo" in classes:
        fixed_href = f"{href}/../../"
    elif "cv-lang-switch" in classes:
        match = LANGUAGE_LINK_RE.fullmatch(href)
        if match is None:
            return anchor
        prefix, language = match.groups()
        fixed_href = f"{prefix}../../../{language}/latest/manual/"
    else:
        match = HOMEPAGE_SECTION_LINK_RE.fullmatch(href)
        if match is None:
            return anchor
        prefix, language_path, section = match.groups()
        fixed_href = f"{prefix}../../../../{language_path or ''}#{section}"

    start, end = href_match.span(3)
    return f"{anchor[:start]}{fixed_href}{anchor[end:]}"


def fix_documentation_tree(root: Path) -> None:
    for html_file in root.rglob("*.html"):
        original = html_file.read_text(encoding="utf-8")
        fixed = ANCHOR_RE.sub(lambda match: fix_anchor(match.group()), original)
        if fixed != original:
            html_file.write_text(fixed, encoding="utf-8")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        raise SystemExit("Usage: fix_docs_navigation.py <documentation-directory>")
    fix_documentation_tree(Path(sys.argv[1]))
