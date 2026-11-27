#!/usr/bin/env python3
"""Validate canonical documentation sections, links, PII, Mermaid and synthetic MRZ."""
from __future__ import annotations

import posixpath
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ERRORS: list[str] = []
CANONICAL = {"specs", "architecture", "as-built", "verification", "data-model"}
MD_FILES = sorted(
    p for p in ROOT.rglob("*.md")
    if p.relative_to(ROOT).parts[0] in CANONICAL or p.name in {"README.md", "_sidebar.md"}
)

def error(path: Path, message: str) -> None:
    ERRORS.append(f"{path.relative_to(ROOT).as_posix()}: {message}")

def check_digit(value: str) -> str:
    weights = (7, 3, 1)
    def char_value(ch: str) -> int:
        if ch == "<":
            return 0
        if ch.isdigit():
            return int(ch)
        return ord(ch) - ord("A") + 10
    return str(sum(char_value(ch) * weights[i % 3] for i, ch in enumerate(value)) % 10)

def apply_docsify_alias(path: str) -> str:
    aliases = (
        ("materials/descriptor/evidence/", "verification/"),
        ("materials/descriptor/", "specs/"),
        ("materials/deshifrator/docs/data-exchange-and-mrz.md", "architecture/data-exchange-and-mrz.md"),
        ("materials/deshifrator/index.md", "as-built/README.md"),
        ("materials/deshifrator/docs/", "as-built/docs/"),
        ("materials/deshifrator/sources/", "as-built/sources/"),
        ("materials/deshifrator/", "as-built/"),
        ("materials/architecture/README.md", "architecture/diagrams.md"),
        ("materials/architecture/", "architecture/"),
    )
    for old, new in aliases:
        if path == old.rstrip("/") or path.startswith(old):
            return new + path[len(old):]
    return path

def resolve_link(source: Path, raw: str) -> bool:
    target = raw.split("#", 1)[0].split("?", 1)[0].strip()
    if not target or target.startswith(("http://", "https://", "mailto:", "data:")):
        return True
    candidate = target.lstrip("/") if target.startswith("/") else (source.parent / target).as_posix()
    candidate = posixpath.normpath(candidate)
    # Static HTML entrypoints are served as files and are not rewritten by Docsify aliases.
    if not candidate.endswith((".html", ".css", ".js", ".svg", ".drawio", ".png", ".jpg", ".jpeg")):
        candidate = apply_docsify_alias(candidate)
    path = ROOT / candidate
    if path.is_file():
        return True
    if path.suffix == "":
        return any((path / name).is_file() for name in ("README.md", "index.md"))
    return False

# Markdown structure, basic PII patterns and canonical-section links.
for path in MD_FILES:
    text = path.read_text(encoding="utf-8", errors="replace")
    fences = len(re.findall(r"^ {0,3}```", text, flags=re.M))
    if fences % 2:
        error(path, f"unbalanced code fences ({fences})")
    if "/media/" in text or "/home/" in text:
        error(path, "contains a local filesystem path")
    if "contextDiagram" in text or "containerDiagram" in text:
        error(path, "uses legacy Mermaid syntax")
    if re.search(r"\b\d{3}-\d{3}-\d{4}\b", text):
        error(path, "contains phone-like PII")
    if re.search(r"\b[\w.-]+@[\w.-]+\.\w{2,4}\b", text):
        error(path, "contains an email address")
    if r"\n" in text:
        error(path, "contains a literal backslash-n sequence")

    prose = re.sub(r"^ {0,3}```[\s\S]*?^ {0,3}```", "", text, flags=re.M)
    for match in re.finditer(r"!?\[[^\]]*\]\(([^)]+)\)", prose):
        raw = match.group(1).strip().split()[0].strip("<>")
        if not resolve_link(path, raw):
            error(path, f"broken relative link: {raw}")

    for block in re.findall(r"```mermaid\s*\n([\s\S]*?)```", text):
        for line in block.splitlines():
            if re.search(r"\|[^\"]*[А-Яа-яЁё][^\"]*\|", line):
                error(path, f"unquoted Cyrillic Mermaid edge label: {line.strip()}")
            if "erDiagram" in block and re.search(r":\s*(?!\")[^\n]*[А-Яа-яЁё]", line):
                error(path, f"unquoted Cyrillic Mermaid ER relationship: {line.strip()}")

# The reconstructed PostgreSQL ERD contains 24 application entities only.
erd_path = ROOT / "data-model/reconstructed-erd.md"
if erd_path.exists():
    erd_text = erd_path.read_text(encoding="utf-8")
    entities = re.findall(r"^\s{4}([a-z][a-z0-9_]*)\s*\{\s*$", erd_text, flags=re.M)
    if len(entities) != 24:
        error(erd_path, f"expected 24 ERD entities, found {len(entities)}")
    if "flyway_schema_history" in entities:
        error(erd_path, "Flyway metadata table must not be in the 24 application entities")

# Validate synthetic ICAO TD3 MRZ fixtures.
sql_path = ROOT / "data-model/db/tests/integration_test_umms.sql"
if sql_path.exists():
    sql_text = sql_path.read_text(encoding="utf-8")
    mrz_lines = re.findall(r"'([A-Z0-9<]{44})'", sql_text)
    for i in range(0, len(mrz_lines), 2):
        if i + 1 >= len(mrz_lines):
            error(sql_path, "unpaired MRZ line")
            break
        line1, line2 = mrz_lines[i], mrz_lines[i + 1]
        if not line1.startswith("P<") or "RUS" not in line1[:5]:
            error(sql_path, f"unexpected MRZ line 1: {line1}")
        checks = (
            (line2[9], line2[:9], "passport number"),
            (line2[19], line2[13:19], "birth date"),
            (line2[27], line2[21:27], "expiry date"),
            (line2[42], line2[28:42], "optional data"),
        )
        for actual, source, label in checks:
            if actual != check_digit(source):
                error(sql_path, f"MRZ {label} check digit mismatch")
        composite = line2[:10] + line2[13:20] + line2[21:43]
        if line2[43] != check_digit(composite):
            error(sql_path, "MRZ composite check digit mismatch")
    if re.search(r"\b\d{4}\s\d{6}\b", sql_text.replace("9999 123456", "")):
        error(sql_path, "contains a non-synthetic passport series/number")
    inn_values = re.findall(r"'(\d{12})'", sql_text)
    if any(value != "000000000000" for value in inn_values):
        error(sql_path, "contains a non-synthetic 12-digit INN")
    if re.search(r"\b(?:10|172|192)\.\d{1,3}\.\d{1,3}\.\d{1,3}\b", sql_text):
        error(sql_path, "contains a private network IP address")
    all_markdown = "\n".join(p.read_text(encoding="utf-8", errors="replace") for p in MD_FILES)
    if re.search(r"\]\([^)]*pg_test_run_20261125_012743\.log", all_markdown):
        error(sql_path, "missing historical log must not be linked as a file")

if ERRORS:
    print("\n".join(ERRORS), file=sys.stderr)
    print(f"FAILED: {len(ERRORS)} validation issue(s)", file=sys.stderr)
    sys.exit(1)

print(f"PASS: {len(MD_FILES)} Markdown files checked; relative links, PII patterns, Mermaid labels, 24-table ERD and synthetic MRZ validated.")
