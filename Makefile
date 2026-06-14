# Lex front door — generated from catalog.lex (the single source of truth).
# Edit catalog.lex only; `make gen` regenerates every public surface; CI runs
# `make verify` and fails if a committed surface drifted from the catalog.

LEX_EFF = io
RUN = lex run --allow-effects $(LEX_EFF) generate.lex
# `lex run` echoes the entry fn's Unit result as a trailing "null" line — drop it.
STRIP = awk 'NR>1{print p} {p=$$0} END{if(p!="null")print p}'
.PHONY: help check gen verify

help: ## Show targets
	@grep -hE '^[a-z-]+:.*##' $(MAKEFILE_LIST) | sed -E 's/:.*## /\t/'

check: ## Type-check the catalog + generator
	@lex check catalog.lex && lex check generate.lex

gen: check ## Regenerate llms.txt, README.md, and the index.html package list
	@$(RUN) llms          | $(STRIP) > llms.txt
	@$(RUN) readme        | $(STRIP) > README.md
	@$(RUN) packages_html | $(STRIP) > /tmp/lex-pkgs.html
	@bash scripts/inject.sh index.html /tmp/lex-pkgs.html
	@echo "regenerated: llms.txt, README.md, index.html"

verify: check ## Fail if any committed surface drifted from catalog.lex
	@$(RUN) llms          | $(STRIP) > /tmp/lex-llms.gen
	@$(RUN) readme        | $(STRIP) > /tmp/lex-readme.gen
	@$(RUN) packages_html | $(STRIP) > /tmp/lex-pkgs.html
	@cp index.html /tmp/lex-index.gen && bash scripts/inject.sh /tmp/lex-index.gen /tmp/lex-pkgs.html
	@diff -u llms.txt /tmp/lex-llms.gen >/dev/null && \
	 diff -u README.md /tmp/lex-readme.gen >/dev/null && \
	 diff -u index.html /tmp/lex-index.gen >/dev/null && \
	 echo "surfaces in sync with catalog.lex" || \
	 { echo "DRIFT: a committed surface differs from catalog.lex — run 'make gen'"; exit 1; }
