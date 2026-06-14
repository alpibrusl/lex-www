#!/usr/bin/env bash
# Assemble the deployable static site into _site/ from the committed files.
# (The committed surfaces are kept in sync with catalog.lex by `make verify`/CI.)
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"; cd "$ROOT"
rm -rf _site && mkdir -p _site/manifesto
cp index.html llms.txt styles.css robots.txt \
   favicon.ico favicon-32x32.png favicon-192x192.png apple-touch-icon.png _site/ 2>/dev/null || true
# manifesto at a clean URL (/manifesto/); make its relative asset refs absolute
sed -E 's#(href|src)="(styles\.css|favicon\.ico|favicon-32x32\.png|favicon-192x192\.png|apple-touch-icon\.png)"#\1="/\2"#g' \
  manifesto.html > _site/manifesto/index.html
echo "lexlang.org" > _site/CNAME
echo "built _site/ ($(find _site -type f | wc -l | tr -d ' ') files)"
