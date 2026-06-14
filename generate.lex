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

import "std.list" as list

import "./catalog" as cat

fn layer_rank(l :: cat.Layer) -> Int {
  match l {
    Substrate => 0,
    Library => 1,
    Agents => 2,
    Finance => 3,
    Energy => 4,
    Robotics => 5,
  }
}

fn layer_title(l :: cat.Layer) -> Str {
  match l {
    Substrate => "Substrate — the language, runtime, and registry",
    Library => "Libraries — horizontal building blocks",
    Agents => "Agents & orchestration",
    Finance => "Finance",
    Energy => "Energy & EV",
    Robotics => "Robotics",
  }
}

fn status_label(s :: cat.Status) -> Str {
  match s {
    Runnable => "runnable",
    Beta => "beta",
    Alpha => "alpha",
    Idea => "idea",
  }
}

fn layers() -> List[cat.Layer] {
  [Substrate, Library, Agents, Finance, Energy, Robotics]
}

# Only public packages reach the public surfaces (so no broken links to private
# repos); the catalog still tracks private ones for internal completeness.
fn in_layer(target :: cat.Layer) -> (cat.Pkg) -> Bool {
  fn (p :: cat.Pkg) -> Bool {
    if p.public { layer_rank(p.layer) == layer_rank(target) } else { false }
  }
}

fn repo_url(p :: cat.Pkg) -> Str {
  str.join(["https://github.com/", cat.org(), "/", p.name], "")
}

# "- [lex-os](url) — summary  _(runnable)_"  (private packages get a marker)
fn pkg_md(p :: cat.Pkg) -> Str {
  let vis := if p.public { "" } else { " · _private_" }
  str.join(["- [", p.name, "](", repo_url(p), ") — ", p.summary, "  _(", status_label(p.status), vis, ")_"], "")
}

fn section_md(l :: cat.Layer) -> Str {
  let rows := list.map(list.filter(cat.packages(), in_layer(l)), pkg_md)
  if list.is_empty(rows) {
    ""
  } else {
    str.join(["## ", layer_title(l), "\n\n", str.join(rows, "\n")], "")
  }
}

fn all_sections() -> Str {
  let secs := list.filter(list.map(layers(), section_md), fn (s :: Str) -> Bool { str.is_empty(s) == false })
  str.join(secs, "\n\n")
}

fn tagline() -> Str {
  "Lex is the substrate for software you don't fully trust: effects are part of the type, so what code is allowed to do is checked before it runs and re-checked at runtime — from sandboxing a function an LLM just wrote up to bounding what a learned policy may do to a robot."
}

fn solo_note() -> Str {
  "Alpibru is one founder and agentic AI. The breadth below — a language, a runtime, a registry, and production stacks across finance, energy, and robotics — is the demonstration: it is possible because trust here is mechanical (typed effects, tests, tamper-evident attestation), not headcount."
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
    all_sections(), "\n"
  ], ""))
}

fn readme() -> [io] Unit {
  io.print(str.join([
    "# Lex\n\n",
    tagline(), "\n\n",
    "**", solo_note(), "**\n\n",
    "New here? Read the [manifesto](", cat.canonical(), ") · install [lex-lang](https://github.com/", cat.org(), "/lex-lang/releases).\n\n",
    all_sections(), "\n\n",
    "_This file is generated from `catalog.lex` by `generate.lex` — do not edit by hand._\n"
  ], ""))
}
