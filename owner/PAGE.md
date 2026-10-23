# Ed's questions page and environment

The facts of Ed's own setup that the kit's files refer to by path. The kit says what each is for: [`claude/QUESTIONS-PAGE.md`](../claude/QUESTIONS-PAGE.md) (the page), [`claude/SETUP.md`](../claude/SETUP.md) (the environment), [`claude/IMPROVEMENT.md`](../claude/IMPROVEMENT.md) (the daily review).

## The page

- **Link:** https://claude.ai/artifact/FoSoRQxMVh8cZocFpMP6KW — the link a coordinator asks Ed to paste, and the `url` of every `ArtifactData` call.
- **Artifact id:** `77dc0e00-9f35-45ee-af49-0632428ebbf5` (the id page-comment notifications carry).
- **Title:** *Questions for Ed* (the `OWNER` constant in `claude/questions-page.html` is `'Ed'`). A session's consent prompt names it: *edit the data in "Questions for Ed"*.
- **Forwarding page:** https://edsaperia.github.io/dev-ops/q/, served from `q/index.html` at the repository root, which stays for that link; its copy here, [`q/index.html`](q/index.html), is served at https://edsaperia.github.io/dev-ops/owner/q/.
- **Access:** private to Ed; a coordinator reaches it only through `ArtifactData` acting as Ed, in a session Ed runs.
- **Published:** 2026-09-26; contract 0.2.61, capabilities `db` (rules as `claude/QUESTIONS-PAGE.md` gives them), `user` and `comments`. The `comments` capability makes the page organization-internal: it can no longer be shared by public link. Republished:
  - 2026-09-28: the wake.
  - 2026-09-28: the in-flight list.
  - 2026-09-30 (commit c85e824, version 10): a task's first link as a large button.
  - 2026-09-30 (v11): *Probably stuck* above open items, each coordinator's last-active line always shown, a coordinator's `restart` only once late, lists after a line of text, `https://` links only.
  - 2026-10-01 (v12): mis-shaped items report themselves to the dev-ops coordinator.
  - 2026-10-02 (v13): an item written without `status` shows, as mis-shaped, instead of staying invisible; so do options without keys.
  - 2026-10-02 (v14): a `copy` or `restart` with a `url` shows as two big buttons, *1 · copy* then *2 · open*, instead of one button that copies and opens at once (Ed: *split this into two big buttons*). A `label` written *Copy X, open Y* names the two buttons *Copy X* and *Open Y*.
  - 2026-10-03 (v18): one row of project chips at the top replaces the line per coordinator and the filter row: a dot for the coordinator's state, a badge for items waiting, a tap to filter.
  - 2026-10-03 (v17): filter chips, one per project, when items from more than one project wait; answer buttons sit in their own card.
  - 2026-10-03 (v16): every waiting item fully open at once, each answerable in place, instead of one open and the rest as lines (Ed: *every item fully open please*).
  - 2026-10-03 (v15): *Waiting* lists every open item, the one being answered opened in place, instead of one at a time behind *Later* (Ed: *I'd like to see all outstanding items in the list*). A coordinator with an item open on the page is waiting on Ed, so it is no longer shown as quiet or given a nudge (Ed: *what do we do about tasks to awaken coordinators that have no outstanding jobs?*).

## Environment variables (the cloud environment's settings)

**Add the first two before page-contract 0.3.0 reaches `main`** (2026-10-23): until then the page's guard ran on ids written into its code; from 0.3.0 it reads them from here, and with them unset it checks and stamps nothing.

- `QUESTIONS_PAGE_IDS=FoSoRQxMVh8cZocFpMP6KW,77dc0e00-9f35-45ee-af49-0632428ebbf5` — which page the page-contract mod guards (from page-contract 0.3.0; unset, the mod does nothing).
- `QUESTIONS_RULES_REPO=edsaperia/dev-ops` — the dev-ops whose `main` the mod watches, telling other coordinators when the rules move.
- `CLAUDE_CODE_PLUGIN_DIRS=/home/user/dev-ops/.claude/skills/page-contract:/home/user/draft/.claude/skills/page-contract:/home/user/mergetournament/.claude/skills/page-contract:/home/user/admit/.claude/skills/page-contract:/home/user/timetable/.claude/skills/page-contract:/home/user/ae/.claude/skills/page-contract:/home/user/witch/.claude/skills/page-contract:/home/user/campaign-hub/.claude/skills/page-contract` — dev-ops' copy first, then each project's; a folder a session has not cloned is skipped.

## GitHub

- Ed's account `edsaperia`; this kit lives at [edsaperia/dev-ops](https://github.com/edsaperia/dev-ops) (public, so a session limited to another organisation can clone it).
- The workflow lines a new owner would change are marked `# owner:` in `.github/workflows/claude-builder.yml`, `.github/workflows/claude.yml` and `claude/project-stub.yml`.

## The daily improvement review

- A scheduled Routine, `trig_01UksMf3HSzyjeqkmzKd7JY2`, daily at **07:57 London time**, so the report is waiting when Ed starts. Ed asked for it (Ed, 2026-10-02).
- It is bound to the dev-ops coordinator's session; its prompt is in the header of [`IMPROVEMENT-LOG.md`](IMPROVEMENT-LOG.md).
- Its daily numbers come, for draft, from GitHub plus the page, and the coordinator's two gaps are measured on draft; projects off the page (see [`projects.md`](projects.md)) are counted as merges only.
