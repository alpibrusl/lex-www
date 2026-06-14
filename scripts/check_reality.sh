#!/usr/bin/env bash
# Anti-drift reality check: catalog.lex must match GitHub reality.
#  - every PUBLIC lex-* repo in the org must appear in catalog.lex (no orphans)
#  - every catalog entry marked public:true must be an actually-public repo
# Needs gh auth (GITHUB_TOKEN in CI). Exits non-zero on any mismatch.
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"; cd "$ROOT"

python3 - <<'PY'
import json, re, subprocess, sys

cat = open("catalog.lex").read()
# entries look like: { name: "lex-x", ... public: true|false, ... }
cat_names = set(re.findall(r'name:\s*"([^"]+)"', cat))
cat_flag = {}  # name -> bool(public)
for m in re.finditer(r'\{[^{}]*?name:\s*"([^"]+)"[^{}]*?public:\s*(true|false)[^{}]*?\}', cat, re.S):
    cat_flag[m.group(1)] = (m.group(2) == "true")
cat_public = {n for n, p in cat_flag.items() if p}

# Meta repos that are not catalogued packages (this site repo itself, etc.).
EXCLUDE = {"lex-www"}

repos = json.loads(subprocess.check_output(
    ["gh","repo","list","alpibrusl","--limit","300","--json","name,visibility"]))
gh_public = {r["name"] for r in repos
             if r["name"].startswith("lex") and r["visibility"]=="PUBLIC" and r["name"] not in EXCLUDE}

fail = 0
orphans = sorted(gh_public - cat_names)
if orphans:
    fail = 1
    print("ORPHANS: public lex-* repos missing from catalog.lex:")
    for r in orphans: print("  -", r)

mislabeled = sorted(cat_public - gh_public)
if mislabeled:
    fail = 1
    print("MISLABELED: catalog says public:true but repo is not public (or missing):")
    for r in mislabeled: print("  -", r)

# Public on GitHub but hidden (public:false) in the catalog -> won't render on the
# site though it's live. Catch it so a visibility flip can't be silently forgotten.
hidden = sorted(r for r in gh_public if cat_flag.get(r) is False)
if hidden:
    fail = 1
    print("HIDDEN: repos are public on GitHub but marked public:false in catalog.lex:")
    for r in hidden: print("  -", r)

if not fail:
    print(f"reality OK: {len(gh_public)} public lex-* repos all catalogued and shown; "
          f"{len(cat_public)} public entries all real.")
sys.exit(fail)
PY
