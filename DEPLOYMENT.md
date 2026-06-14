# Deploying lexlang.org

The Lex front door is a static site **generated from `catalog.lex`**. Edit only
`catalog.lex`; `make gen` regenerates `llms.txt`, `README.md`, and the package
list inside `index.html`. CI (`.github/workflows/ci.yml`) fails if a committed
surface drifts from the catalog, or if a public `lex-*` repo is missing from it.

## Local

```sh
make gen      # regenerate surfaces from catalog.lex
make verify   # fail if anything drifted
```

## Hosting (Firebase, project `alpibru-common`, a second site)

One-time setup (manual — needs the Firebase owner):

1. **Create the hosting site** (id `lexlang`, matching `.firebaserc`):
   ```sh
   firebase hosting:sites:create lexlang --project alpibru-common
   ```
2. **Add the custom domain** `lexlang.org` (and `www.lexlang.org`) to that site in
   the Firebase console → Hosting → Add custom domain. Firebase gives you the A
   records (and a TXT to verify).
3. **Point DNS at Firebase** at the registrar (Webempresa): replace the current
   `lexlang.org` A record (→ `213.158.86.70`, Webempresa) with the A records
   Firebase provides; add the TXT verification record. `lexlang.dev` can 301 to
   `lexlang.org`.
4. **Add the deploy secret** to this repo: `FIREBASE_SERVICE_ACCOUNT_ALPIBRU_COMMON`
   (the same service-account JSON used by the alpibru.com site), under
   Settings → Secrets → Actions.
5. **Enable auto-deploy**: in `.github/workflows/deploy.yml`, change
   `on: workflow_dispatch` to `on: { push: { branches: [main] } }`. Until then,
   deploy manually from the Actions tab (Run workflow) or:
   ```sh
   make gen && firebase deploy --only hosting:lex --project alpibru-common
   ```

## What deploys

`index.html`, `manifesto*.html`, `llms.txt`, `styles.css`, `script.js`, favicons,
`robots.txt`. The sources (`*.lex`, `Makefile`, `scripts/`, `*.md`) are ignored by
`firebase.json`.
