# Wiring a project for Claude builders

Two engines, both runnable with Ed's laptop closed. Pick per task; both follow [`../CONVENTIONS.md`](../CONVENTIONS.md).

| | GitHub Actions builder | Cloud session (claude.ai/code) |
|---|---|---|
| Started by | `@claude` in an issue or PR comment — from the GitHub app on a phone too | Ed opening a session (web or phone app) |
| Runs on | a GitHub runner (Linux, 4 cores, 16 GB; free for public repos) | an Anthropic VM (Ubuntu, 4 cores, 16 GB, no compute charge) |
| Billed to | Ed's Claude subscription, via the repo's `CLAUDE_CODE_OAUTH_TOKEN` | Ed's Claude subscription |
| Lasts | up to 6 h per run (`timeout-minutes`) | until idle; the conversation survives, running processes do not |
| Opens PRs | no — pushes a `claude/…` branch and comments a link | yes |
| Talks via | the issue or PR it was mentioned on | its draft PR; a coordinator nudges it with `claude -p "…" --cloud <session>` |

## A. The GitHub Actions builder — once per project

1. **Install the Claude GitHub App** on the repo: https://github.com/apps/claude → *Configure* → add the repository.
2. **Make a subscription token** (once; it lasts a year and can be reused for every project): run `claude setup-token` in a terminal, sign in, copy the token it prints once.
3. **Store it as the repo's secret**: `gh secret set CLAUDE_CODE_OAUTH_TOKEN -R edsaperia/<project>` and paste the token (or GitHub → repo → Settings → Secrets and variables → Actions → New repository secret).
4. **Add the stub**: copy [`project-stub.yml`](project-stub.yml) to `<project>/.github/workflows/claude.yml`, fill in `node-version` and `setup` for what the project needs, and commit it to `main` (issue and comment triggers only run from the default branch).
5. **Try it**: open an issue titled *`@claude` say hello* — a builder should reply on the issue within a few minutes.
6. Add the project to [`../projects.md`](../projects.md).

Safety, by design of `anthropics/claude-code-action`: only people with write access can trigger it; it reads only the comments of `readers` (Ed and itself by default); it never pushes to `main`, merges, or edits workflow files.

## B. Cloud sessions — once per project

1. At claude.ai/code, open the environment settings used for the repo.
2. **Network**: *Custom* — keep the default trusted list, add whatever the project downloads outside it (e.g. `cdn.playwright.dev` for Playwright browsers).
3. **Setup script**: runs *before the repo is cloned*, so install only repo-independent things (e.g. `npx -y playwright@<exact version> install chromium`); the builder runs the project's own install itself. **Keep any version pinned here in step with the project.**
4. To use one: open a session on the repo with the message *You are a builder. Wait for your brief, which will arrive as the next message.* and give the link to the coordinator.
5. **Permission mode: Auto, for every session**, coordinator or builder. Pick it in the session's mode menu when you open the session, or change it while the session runs; a resumed session keeps its mode. Auto is the only thing that stops the one-off approval prompts (Ed, 2026-09-30): the repo's `.claude/settings.json` (the standing permissions, dev-ops PR #11) is honoured only by a session on a single repository in the default mode, a session on two repositories reads no permission rules from it at all, and the *edit the data in "Questions for Ed"* consent is not covered by allow rules in either mode. `.claude/settings.json` also carries `defaultMode: "auto"`, and it works: a new session on a repo whose settings file has that line opens in Auto without anyone choosing it (Ed, 2026-09-30, on dev-ops). So this step is automatic on every repo whose settings file carries the line; choose the mode by hand only in a session opened before the line was merged, or on a repo without it.
6. **The page-contract mod**: copy `.claude/skills/page-contract/` from dev-ops into the repo (in a repo where `main` deploys, by a Merge question like any other change), and make sure the environment's variables carry `CLAUDE_CODE_PLUGIN_DIRS` with that repo's path, as `claude/QUESTIONS-PAGE.md`, *The page-contract mod*, gives it. Without the variable a cloud session does not load the mod.

## C. Taking on a project: its coordinator, start to finish

The order the dev-ops coordinator follows when Ed brings a project in, new or existing (2026-10-02, admissions). Each step names who does it; Ed's steps go on his questions page as tasks with a one-tap button.

1. **Reach the repository** (dev-ops). For a new project with no repository yet, Ed creates the empty repository: a task on his page with a large button to `https://github.com/new?owner=edsaperia&name=<project>&visibility=private` (a cloud session cannot create one: the safety check and GitHub's proxy both refuse it, Witch 2026-10-03), then the coordinator is opened on it. For an existing one, attach it with `add_repo`. If it can't be reached, the Claude GitHub app needs access to it, which only the owner can give. Put a task on Ed's page with a large button to https://github.com/apps/claude/installations/select_target, since nothing else can proceed.
2. **Read it** (dev-ops, a subagent on Opus allowed). Find out:
   - what it is and who uses it;
   - whether a push to `main` deploys, and how;
   - how it is tested;
   - what is half-done: open PRs, open issues, a plan file.

   Summarise this for Ed as an update on his page.
3. **Add the shared files** (dev-ops, by PR; a Merge question if `main` deploys):
   - `.claude/settings.json` with the standing permissions and `defaultMode: "auto"` (copy dev-ops's);
   - `.claude/skills/page-contract/` (B6);
   - a `CLAUDE.md`, if the project has none: what it is, how to test, whether `main` deploys, and a glossary heading.
4. **Wire builders** (Ed, optional): A1–A5 above for `@claude` builders. This is the only step with a secret in it.
5. **The cloud environment** (Ed; dev-ops gives the exact values in the task):
   - network allowances (B2) and a setup script (B3), if the project needs them;
   - the repository's path appended to `CLAUDE_CODE_PLUGIN_DIRS` (B6).
6. **Open the coordinator** (Ed, one tap). The task's button copies the first message and opens a new session on the repository in Auto mode. The message: *You are the coordinator for `<project>`. Read AGENTS.md and CONVENTIONS.md from edsaperia/dev-ops main, then claude/QUESTIONS-PAGE.md; then ask me to paste my questions page's link.* Ed then pastes the page link into it.
7. **The coordinator joins the page** (the new coordinator):
   - arms its watch;
   - `set`s `coordinators/<project>` with its session link;
   - subscribes to the project's open PRs;
   - asks Ed *what next*, recommending from step 2's reading.
8. **Bookkeeping** (dev-ops):
   - a row in [`../projects.md`](../projects.md);
   - the project added to the improvement review's daily numbers;
   - the coordinator's session added to whoever pokes on contract changes.

## If the laptop crashed

A local coordinator's conversation is on disk: `claude --continue` in the project folder brings it back. Cloud sessions and Actions runs are unaffected by the laptop; their work is on their pushed branches.
