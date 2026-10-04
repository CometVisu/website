import os
import re
import sys
from pathlib import Path


HREF_RE = re.compile(r'(\bhref=)(["\'])(.*?)\2')
CLASS_RE = re.compile(r'\bclass=(["\'])(.*?)\1')
ANCHOR_RE = re.compile(r'<a\b[^>]*>', re.IGNORECASE)
NAV_RE = re.compile(
    r'(<nav\b(?=[^>]*\bclass=(["\'])[^"\']*\bcv-website-navbar\b[^"\']*\2)[^>]*>)'
    r'(.*?)'
    r'(</nav\s*>)',
    re.IGNORECASE | re.DOTALL,
)
LANGUAGE_LINK_RE = re.compile(r'^(.*?)(?:\.\./)(en|de)/$')


def fix_anchor(anchor: str, homepage_href: str) -> str:
    class_match = CLASS_RE.search(anchor)
    href_match = HREF_RE.search(anchor)
    if href_match is None:
        return anchor

    classes = class_match.group(2).split() if class_match is not None else []
    href = href_match.group(3)

    if "cv-nav-logo" in classes:
        fixed_href = f"{href}/../../"
    elif "cv-nav-news" in classes:
        fixed_href = f"{homepage_href}news/"
    elif "cv-lang-switch" in classes:
        match = LANGUAGE_LINK_RE.fullmatch(href)
        if match is None:
            return anchor
        prefix, language = match.groups()
        fixed_href = f"{prefix}../../../{language}/latest/manual/"
    elif "#" in href:
        fixed_href = f"{homepage_href}#{href.partition('#')[2]}"
    else:
        return anchor

    start, end = href_match.span(3)
    return f"{anchor[:start]}{fixed_href}{anchor[end:]}"


def fix_documentation_tree(root: Path) -> None:
    for html_file in root.rglob("*.html"):
        original = html_file.read_text(encoding="utf-8")

        relative_path = html_file.relative_to(root)
        language = relative_path.parts[0]
        relative_site_root = Path(
            os.path.relpath(root.parent, html_file.parent)
        ).as_posix()
        homepage_href = f"{relative_site_root}/"
        if language == "de":
            homepage_href = f"{homepage_href}de/"

        def fix_navigation(match: re.Match[str]) -> str:
            nav_content = ANCHOR_RE.sub(
                lambda anchor: fix_anchor(anchor.group(), homepage_href),
                match.group(3),
            )
            return f"{match.group(1)}{nav_content}{match.group(4)}"

        fixed = NAV_RE.sub(fix_navigation, original)
        if fixed != original:
            html_file.write_text(fixed, encoding="utf-8")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        raise SystemExit("Usage: fix_docs_navigation.py <documentation-directory>")
    fix_documentation_tree(Path(sys.argv[1]))
