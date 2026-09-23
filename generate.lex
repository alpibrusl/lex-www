# generate.lex — render the public surfaces from catalog.lex (the source of truth).
#
# Dogfood: lexlang.org's own front matter is produced by a Lex program. Each
# entry fn prints one surface to stdout; the Makefile writes it to a file and CI
# fails if the committed file drifts from what this regenerates.
#
#   lex run --allow-effects io generate.lex llms   > llms.txt
#   lex run --allow-effects io generate.lex readme > ORG_README.md

import "std.io" as io

import "std.str" as str

import "./catalog" as cat

fn tagline() -> Str {
  "Lex is the substrate for software you don't fully trust: effects are part of the type, so what code is allowed to do is checked before it runs and re-checked at runtime — from sandboxing a function an LLM just wrote up to bounding what a learned policy may do to a robot."
}

fn solo_note() -> Str {
  "Alpibru is one founder and agentic AI. The breadth here — a language, a runtime, a registry, and production stacks across finance, energy, and robotics — is the demonstration: it is possible because trust here is mechanical (typed effects, tests, tamper-evident attestation), not headcount."
}

# The package list is two live links, not a maintained list: GitHub's own org
# search always reflects what's actually public, and the hub shows what's
# actually installable. Either one goes stale the moment code ships elsewhere
# without this repo being edited — so nothing here restates them.
fn packages_md() -> Str {
  str.join([
    "- [Browse lex-* repos on GitHub](", cat.github_packages_url(), ") — every public package, always current\n",
    "- [Browse the lex-official registry](", cat.hub_url(), ") — what's actually published and installable"
  ], "")
}

# ── Surfaces ─────────────────────────────────────────────────────────────────
fn llms() -> [io] Unit {
  io.print(str.join([
    "# Lex\n\n",
    "> ", tagline(), "\n\n",
    solo_note(), "\n\n",
    "Manifesto: ", cat.canonical(), "/manifesto\n",
    "Install the toolchain: https://github.com/", cat.org(), "/lex-lang/releases\n\n",
    "## Packages\n\n",
    packages_md(), "\n"
  ], ""))
}

# ── HTML fragment (injected into index.html between markers) ─────────────────
fn packages_html() -> [io] Unit {
  io.print(str.join([
    "  <div class=\"pillars\">\n",
    "    <a class=\"pillar\" style=\"text-decoration:none;display:block\" href=\"", cat.github_packages_url(), "\">\n",
    "      <h3>lex-* on GitHub &rarr;</h3><p>Every public package in the org, straight from GitHub's own search — always current, nothing to keep in sync.</p></a>\n",
    "    <a class=\"pillar\" style=\"text-decoration:none;display:block\" href=\"", cat.hub_url(), "\">\n",
    "      <h3>lex-official registry &rarr;</h3><p>What's actually published and installable: browse source, versions, and functions on the hub.</p></a>\n",
    "  </div>"
  ], ""))
}

fn readme() -> [io] Unit {
  io.print(str.join([
    "# Lex\n\n",
    tagline(), "\n\n",
    "**", solo_note(), "**\n\n",
    "New here? Read the [manifesto](", cat.canonical(), ") · install [lex-lang](https://github.com/", cat.org(), "/lex-lang/releases).\n\n",
    "## Packages\n\n",
    packages_md(), "\n\n",
    "_This file is generated from `catalog.lex` by `generate.lex` — do not edit by hand._\n"
  ], ""))
}
