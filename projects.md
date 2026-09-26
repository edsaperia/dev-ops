# Projects using dev-ops

| Project | Actions builder | Cloud environment | Notes |
|---|---|---|---|
| [edsaperia/dev-ops](https://github.com/edsaperia/dev-ops) | wiring 2026-09-26 (the test bed) | — | no build; the builder only edits markdown here |
| [edsaperia/draft](https://github.com/edsaperia/draft) (docs.vote) | wiring 2026-09-26 | network Custom + `cdn.playwright.dev`; setup script `npx -y playwright@1.62.1 install chromium` | **a push to `main` deploys docs.vote**; the Playwright version in the setup script must follow `package.json`; the project's CLAUDE.md is long and authoritative |
| [edsaperia/mergetournament](https://github.com/edsaperia/mergetournament) (mergetournament.org) | wired and tested 2026-09-26 (Node 24, `npm ci`) | — | **merging to `main` does not deploy**: production is updated by `deploy/update.sh` on the droplet (`docs/DEPLOY.md`); tests use embedded PGlite, so no database service is needed; builders have no browser, so UI changes need a click-through before deploy |
