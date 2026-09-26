# Projects using dev-ops

| Project | Actions builder | Cloud environment | Notes |
|---|---|---|---|
| [edsaperia/draft](https://github.com/edsaperia/draft) (docs.vote) | wiring 2026-09-26 | network Custom + `cdn.playwright.dev`; setup script `npx -y playwright@1.62.1 install chromium` | **a push to `main` deploys docs.vote**; the Playwright version in the setup script must follow `package.json`; the project's CLAUDE.md is long and authoritative |
