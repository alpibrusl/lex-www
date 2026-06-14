#!/usr/bin/env bash
# Evidence-based status audit for the public lex-* packages. Prints the status
# each repo EARNS from the rubric, so catalog.lex can be set from evidence rather
# than opinion. Needs gh auth. Re-run after fixing a repo's CI to see promotions.
#
# Rubric:
#   runnable = latest push CI is green  AND  the repo has an examples/ dir
#   beta     = latest push CI is green  AND  has a tests/ dir (but no examples)
#   alpha    = code exists but CI is red or absent (unverified)
#   idea     = essentially empty
set -uo pipefail
gh repo list alpibrusl --limit 300 --json name,visibility -q \
  '.[] | select(.name|startswith("lex")) | select(.visibility=="PUBLIC") | .name' \
  | grep -v '^lex-www$' | sort | while read -r n; do
  ci=$(gh run list --repo "alpibrusl/$n" --event push -L 1 --json conclusion -q '.[0].conclusion' 2>/dev/null)
  [ -z "$ci" ] && { gh api "repos/alpibrusl/$n/contents/.github/workflows" >/dev/null 2>&1 && ci=noRun || ci=noCI; }
  top=$(gh api "repos/alpibrusl/$n/contents" --jq '.[].name' 2>/dev/null)
  ex=$(echo "$top" | grep -qx examples && echo 1 || echo 0)
  ts=$(echo "$top" | grep -qiE '^tests?$' && echo 1 || echo 0)
  if   [ "$ci" = success ] && [ "$ex" = 1 ]; then s=Runnable
  elif [ "$ci" = success ] && [ "$ts" = 1 ]; then s=Beta
  else s=Alpha; fi
  printf "%-16s ci=%-8s ex=%s ts=%s -> %s\n" "$n" "$ci" "$ex" "$ts" "$s"
done
