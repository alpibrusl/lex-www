# Deploying lexlang.org (GitHub Pages)

The Lex front door is a static site **generated from `catalog.lex`**. Edit only
`catalog.lex`; `make gen` regenerates `llms.txt`, `README.md`, and the package
list inside `index.html`. CI (`.github/workflows/ci.yml`) fails if a committed
surface drifts from the catalog, or if the catalog drifts from GitHub reality.

## Local

```sh
make gen                 # regenerate surfaces from catalog.lex
make verify              # fail if anything drifted
bash scripts/build_site.sh   # assemble _site/ (what Pages serves)
```

## Hosting — GitHub Pages

`.github/workflows/pages.yml` builds `_site/` (a clean copy: `index.html`,
`/manifesto/`, `llms.txt`, `styles.css`, favicons, `robots.txt`, `CNAME`) and
deploys it on every push to `main`. No server, no secrets. The repo must be
public (Pages Free tier) — it is.

### One-time: point the domain
1. In **Settings → Pages**, confirm Source = **GitHub Actions** and the custom
   domain shows `lexlang.org` (set by the `CNAME` file in the artifact).
2. At the registrar (**Webempresa**), replace the current `lexlang.org` A record
   (→ `213.158.86.70`) with the four GitHub Pages apex A records:
   ```
   185.199.108.153
   185.199.109.153
   185.199.110.153
   185.199.111.153
   ```
   (and the AAAA records `2606:50c0:8000::153` … `8003::153` if you want IPv6).
   Optionally add `www.lexlang.org` as a CNAME → `alpibrusl.github.io`.
3. GitHub provisions TLS automatically once DNS resolves; then tick **Enforce
   HTTPS** in Settings → Pages.

Until DNS is pointed, the site is live at `https://alpibrusl.github.io/lex-www/`
(absolute asset paths assume the custom domain, so use the domain for the real
check).

`lexlang.dev` can 301-redirect to `lexlang.org` at the registrar.
