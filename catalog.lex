# catalog.lex — org-level constants for the generated public surfaces.
#
# This file used to hand-curate a Layer/Status entry per package. That list
# went stale the moment a repo was added, renamed, or its CI status changed,
# and needed its own reality-check script (scripts/check_reality.sh, removed)
# to catch drift. The package list itself is now two live links instead:
# GitHub's own org search (always current, no maintenance) and the hub's
# lex-official registry (what's actually installable). Nothing here can go
# stale because nothing here restates what GitHub or the hub already know.

import "std.str" as str

fn canonical() -> Str { "https://lexlang.org" }

fn org() -> Str { "alpibrusl" }

# GitHub's own search over the org, filtered to the "lex-" prefix — always
# reflects exactly what's public right now, with no separate list to update.
fn github_packages_url() -> Str {
  str.join(["https://github.com/orgs/", org(), "/repositories?q=lex-&type=public"], "")
}

# The hub's public registry browser for the lex-official tenant: what's
# actually published and installable, with source, versions, and functions.
fn hub_url() -> Str { "https://console.lexlang.org/#/lex-official" }
