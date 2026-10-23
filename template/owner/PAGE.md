# <name>'s questions page and environment

The facts of this owner's setup that the kit's files refer to by path: `claude/QUESTIONS-PAGE.md` (the page), `claude/SETUP.md` (the environment), `claude/IMPROVEMENT.md` (the daily review).

## The page

- **Link:** <https://claude.ai/artifact/…> — published from `claude/questions-page.html` with `OWNER` set to their name.
- **Artifact id:** <the uuid page-comment notifications carry>
- **Access:** private to the owner.
- **Published:** <date>; republished: <date: what changed>.

## Environment variables (the cloud environment's settings)

- `QUESTIONS_PAGE_IDS=<link id>,<artifact uuid>` — which page the page-contract mod guards; unset, it does nothing.
- `QUESTIONS_RULES_REPO=<github owner>/dev-ops` — the dev-ops whose `main` the mod watches; unset, that check is off.
- `CLAUDE_CODE_PLUGIN_DIRS=/home/user/dev-ops/.claude/skills/page-contract:/home/user/<project>/.claude/skills/page-contract` — dev-ops' copy first, then each project's.

## GitHub

- The owner's account, and where their copy of dev-ops lives.

## The daily improvement review

- The scheduled Routine's id and time, and the session it is bound to; its prompt is in the header of `IMPROVEMENT-LOG.md`.
