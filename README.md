# dev-ops

A kit for running AI coding agents across one person's projects — any model, any repo, with or without the owner's laptop running. Each project has a **coordinator** (a long-lived session that briefs, reviews and merges) and **builders** (one per piece of work, each on its own branch and draft pull request). The owner answers everything from one **questions page**, a private claude.ai page their coordinators write to and are woken by. A daily **improvement review** measures the work and changes the method.

The kit is written for any owner. Everything about one particular owner — who they are, their page, their projects — lives in the [`owner/`](owner/) folder, and the kit refers to it by path; [`owner/README.md`](owner/README.md) says whose this copy's is.

## The kit

- [`AGENTS.md`](AGENTS.md) — how any agent works with the owner. Read first; it sends you to the owner's profile.
- [`CONVENTIONS.md`](CONVENTIONS.md) — the protocol between the owner, coordinators and builders: draft pull requests as the conversation, the comment prefixes, who merges.
- [`claude/QUESTIONS-PAGE.md`](claude/QUESTIONS-PAGE.md) — the questions page's data contract: how coordinators ask, read answers, show what is in flight, and wake.
- [`claude/questions-page.html`](claude/questions-page.html) — the page itself, published as each owner's own claude.ai artifact.
- [`.claude/skills/page-contract/`](.claude/skills/page-contract/) — a Claude Code mod that holds every write to the page to its contract and stamps coordinators' activity.
- [`claude/IMPROVEMENT.md`](claude/IMPROVEMENT.md) — the daily improvement review.
- [`claude/SETUP.md`](claude/SETUP.md) — wiring a project for Claude builders on GitHub Actions (`@claude`) and in cloud sessions, and taking on a project.
- [`.github/workflows/claude-builder.yml`](.github/workflows/claude-builder.yml) — the shared builder workflow each project calls, from a copy of [`claude/project-stub.yml`](claude/project-stub.yml).
- [`.claude/settings.json`](.claude/settings.json) — the standing permissions every project copies.
- [`template/owner/`](template/owner/) — a blank `owner/` folder for a new owner.

## The owner's folder

- [`owner/README.md`](owner/README.md) — whose it is.
- [`owner/PROFILE.md`](owner/PROFILE.md) — who the owner is and how they like to be worked with; wins over the kit where they differ.
- [`owner/PAGE.md`](owner/PAGE.md) — their questions page's link, the environment's values, the daily review's schedule.
- [`owner/projects.md`](owner/projects.md) — which projects use dev-ops.
- [`owner/REGISTER.md`](owner/REGISTER.md) — dev-ops work left undone, with conditions to act.
- [`owner/IMPROVEMENT-LOG.md`](owner/IMPROVEMENT-LOG.md) — the improvement review's numbers, friction and changes.

`projects.md`, `claude/REGISTER.md`, `claude/IMPROVEMENT-LOG.md`, `local/windows.md` and `q/index.html` are stubs left where those files used to be (2026-10-23).

## Setting up for yourself

Instructions for an agent setting this copy of dev-ops up for a new owner, in their own fork or copy of the repository. Do them in order, and ask the new owner for anything only they know.

1. **Delete `owner/` entirely**, and the stubs at the old paths: `projects.md`, `claude/REGISTER.md`, `claude/IMPROVEMENT-LOG.md`, `local/windows.md` and `q/index.html` (or re-point `q/index.html` at the new owner's page if they want a forwarding link). Nothing of the previous owner's should remain.
2. **Copy [`template/owner/`](template/owner/) to `owner/`** and fill it in with the new owner: their name and how they like to work in `PROFILE.md` (go through its suggestions with them), and an empty `projects.md`, `REGISTER.md` and `IMPROVEMENT-LOG.md` ready for rows.
3. **Publish their own questions page** from [`claude/questions-page.html`](claude/questions-page.html): set `OWNER` (their name) and `RULES_REPO` (their copy of dev-ops) at the top of its script, publish it with the Artifact tool and the capabilities [`claude/QUESTIONS-PAGE.md`](claude/QUESTIONS-PAGE.md) gives, then set `PAGE_URL` to the link it got, republish, and record the link and the artifact's id in `owner/PAGE.md`.
4. **Set the environment variables** in each cloud environment the owner's sessions use, and record them in `owner/PAGE.md`: `QUESTIONS_PAGE_IDS` (`<the page link's id>,<the artifact's uuid>`; without it the page-contract mod does nothing), `QUESTIONS_RULES_REPO` (`<their account>/dev-ops`), and `CLAUDE_CODE_PLUGIN_DIRS` (dev-ops' copy of the mod first, then each project's; [`claude/SETUP.md`](claude/SETUP.md) B6).
5. **Point the workflows at their copy of dev-ops**: each line marked `# owner:` in [`.github/workflows/claude-builder.yml`](.github/workflows/claude-builder.yml) (the `readers` allow-list default `edsaperia,…` and `repository: edsaperia/dev-ops`), [`.github/workflows/claude.yml`](.github/workflows/claude.yml) and [`claude/project-stub.yml`](claude/project-stub.yml) (`uses: edsaperia/dev-ops/…`) names the previous owner's GitHub account; change it to theirs.
6. **Follow [`claude/SETUP.md`](claude/SETUP.md) for each project** they bring in, which also adds it to `owner/projects.md`.
