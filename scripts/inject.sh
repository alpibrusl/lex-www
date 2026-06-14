#!/usr/bin/env bash
# Replace the content between the packages markers in an HTML file with a fragment.
# Usage: scripts/inject.sh <html-file> <fragment-file>
set -euo pipefail
html="$1"; frag="$2"
awk -v f="$frag" '
  /<!-- packages:start -->/ { print; while ((getline l < f) > 0) print l; skip=1; next }
  /<!-- packages:end -->/   { skip=0; print; next }
  skip != 1 { print }
' "$html" > "$html.tmp" && mv "$html.tmp" "$html"
