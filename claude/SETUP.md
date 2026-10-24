# Wiring a project for Claude builders

> **Setting dev-ops up for a new owner?** Do [README.md, *Setting up for yourself*](../README.md#setting-up-for-yourself) first; this file is then followed once per project.

Two engines, both runnable with the owner's laptop closed. Pick per task; both follow [`../CONVENTIONS.md`](../CONVENTIONS.md).

| | GitHub Actions builder | Cloud session (claude.ai/code) |
|---|---|---|
| Started by | `@claude` in an issue or PR comment — from the GitHub app on a phone too | the owner opening a session (web or phone app) |
| Runs on | a GitHub runner (Linux, 4 cores, 16 GB; free for public repos) | an Anthropic VM (Ubuntu, 4 cores, 16 GB, no compute charge) |
| Billed to | the owner's Claude subscription, via the repo's `CLAUDE_CODE_OAUTH_TOKEN` | the owner's Claude subscription |
| Lasts | up to 6 h per run (`timeout-minutes`) | until idle; the conversation survives, running processes do not |
| Opens PRs | no — pushes a `claude/…` branch and comments a link | yes |
| Talks via | the issue or PR it was mentioned on | its draft PR; a coordinator nudges it with `claude -p "…" --cloud <session>` |

## A. The GitHub Actions builder — once per project

1. **Install the Claude GitHub App** on the repo: https://github.com/apps/claude → *Configure* → add the repository.
2. **Make a subscription token** (once; it lasts a year and can be reused for every project): run `claude setup-token` in a terminal, sign in, copy the token it prints once.
3. **Store it as the repo's secret**: `gh secret set CLAUDE_CODE_OAUTH_TOKEN -R <owner>/<project>` and paste the token (or GitHub → repo → Settings → Secrets and variables → Actions → New repository secret).
4. **Add the stub**: copy [`project-stub.yml`](project-stub.yml) to `<project>/.github/workflows/claude.yml`, fill in `node-version` and `setup` for what the project needs, and commit it to `main` (issue and comment triggers only run from the default branch).
5. **Try it**: open an issue titled *`@claude` say hello* — a builder should reply on the issue within a few minutes.
6. Add the project to the projects list, [`owner/projects.md`](../owner/projects.md).

Safety, by design of `anthropics/claude-code-action`: only people with write access can trigger it; it reads only the comments of `readers` (the owner and itself by default, set in `.github/workflows/claude-builder.yml`); it never pushes to `main`, merges, or edits workflow files.

## B. Cloud sessions — once per project

1. At claude.ai/code, open the environment settings used for the repo.
2. **Network**: *Limited* (*Custom* in an older app) — keep the default trusted list, add whatever the project downloads outside it under **Allowed domains** (e.g. `cdn.playwright.dev` for Playwright browsers), and leave **Allow package managers** ticked (in an older app, *Also include default list of common package managers*): unticked, npm and pip installs fail with 403 "Host not in allowlist" (issue #10).
3. **Setup script**: runs *before the repo is cloned*, so install only repo-independent things (e.g. `npx -y playwright@<exact version> install chromium`); the builder runs the project's own install itself. **Keep any version pinned here in step with the project.**
4. To use one: open a session on the repo with the message *You are a builder. Wait for your brief, which will arrive as the next message.* and give the link to the coordinator.
5. **Permission mode: Auto, for every session**, coordinator or builder. Pick it in the session's mode menu when you open the session, or change it while the session runs; a resumed session keeps its mode. Auto is the only thing that stops the one-off approval prompts (2026-09-30): the repo's `.claude/settings.json` (the standing permissions, dev-ops PR #11) is honoured only by a session on a single repository in the default mode, a session on two repositories reads no permission rules from it at all, and the *edit the data in "Questions for ‹owner›"* consent is not covered by allow rules in either mode. `.claude/settings.json` also carries `defaultMode: "auto"`, and it works: a new session on a repo whose settings file has that line opens in Auto without anyone choosing it (2026-09-30, on dev-ops). So this step is automatic on every repo whose settings file carries the line; choose the mode by hand only in a session opened before the line was merged, or on a repo without it.
6. **The page-contract mod**: copy `.claude/skills/page-contract/` from dev-ops into the repo (in a repo where `main` deploys, by a Merge question like any other change), and make sure the environment's variables carry `CLAUDE_CODE_PLUGIN_DIRS` with that repo's path, as `claude/QUESTIONS-PAGE.md`, *The page-contract mod*, gives it, and `QUESTIONS_PAGE_IDS` and `QUESTIONS_RULES_REPO`, once per environment. The owner's values for all three are in [`owner/PAGE.md`](../owner/PAGE.md). Without `CLAUDE_CODE_PLUGIN_DIRS` a cloud session does not load the mod; without `QUESTIONS_PAGE_IDS` it loads and does nothing.

## What a cloud session cannot do on GitHub

A cloud session works through a GitHub proxy that lets it push only branches and open, comment on and merge pull requests in the repositories attached to it. These need the owner, on GitHub, so a coordinator asks for them as a task on the questions page (a large button to the page) and never promises them as its own step:

- **delete a branch** (the API and `git push --delete` are both refused; 2026-10-22);
- **push a tag** (refused; record versions in a file, or ask the owner to tag; 2026-10-23);
- **invite a collaborator or change anyone's access** (2026-10-23);
- **reach a repository the Claude GitHub app has not been given**, including one just created in an organisation that grants it selected repositories only (2026-10-23).

Creating a repository through the GitHub connector has worked (2026-10-23) and may be tried first (C, step 1).

## C. Taking on a project: its coordinator, start to finish

The order the dev-ops coordinator follows when the owner brings a project in, new or existing (2026-10-02). Each step names who does it; the owner's steps go on their questions page as tasks with a one-tap button.

1. **Reach the repository** (dev-ops). For a new project with no repository yet, dev-ops first tries the GitHub connector's `create_repository` (it worked on 2026-10-23, once the owner had chosen the name and visibility); if that is refused, as it was on 2026-10-03, the owner creates the empty repository from a task on their page with a large button to `https://github.com/new?owner=<owner>&name=<project>&visibility=private`. A repository new to an organisation whose Claude app reaches only selected repositories also needs the owner to add it there (2026-10-23), then the coordinator is opened on it. For an existing one, attach it with `add_repo`. If it can't be reached, the Claude GitHub app needs access to it, which only the owner can give. Put a task on the owner's page with a large button to https://github.com/apps/claude/installations/select_target, since nothing else can proceed.
2. **Read it** (dev-ops, a subagent on Opus allowed). Find out:
   - what it is and who uses it;
   - whether a push to `main` deploys, and how;
   - how it is tested;
   - what is half-done: open PRs, open issues, a plan file.

   Summarise this for the owner as an update on their page.
3. **Add the shared files** (dev-ops, by PR; a Merge question if `main` deploys):
   - `.claude/settings.json` with the standing permissions and `defaultMode: "auto"` (copy dev-ops's);
   - `.claude/skills/page-contract/` (B6);
   - a `CLAUDE.md`, if the project has none: what it is, how to test, whether `main` deploys, and a glossary heading.
4. **Wire builders** (the owner, optional): A1–A5 above for `@claude` builders. This is the only step with a secret in it.
5. **The cloud environment** (the owner; dev-ops gives the exact values in the task):
   - network allowances (B2) and a setup script (B3), if the project needs them;
   - the repository's path appended to `CLAUDE_CODE_PLUGIN_DIRS`, and `QUESTIONS_PAGE_IDS` and `QUESTIONS_RULES_REPO` if the environment lacks them (B6).
6. **Open the coordinator** (the owner, one tap). The task's button copies the first message and opens a new session on the repository in Auto mode. The message: *You are the coordinator for `<project>`. Read AGENTS.md and CONVENTIONS.md from ‹owner›/dev-ops main, then claude/QUESTIONS-PAGE.md; then ask me to paste my questions page's link.* The owner then pastes the page link into it.
7. **The coordinator joins the page** (the new coordinator):
   - arms its watch;
   - `set`s `coordinators/<project>` with its session link;
   - subscribes to the project's open PRs;
   - asks the owner *what next*, recommending from step 2's reading.
8. **Bookkeeping** (dev-ops):
   - a row in the projects list, [`owner/projects.md`](../owner/projects.md);
   - the project added to the improvement review's daily numbers;
   - the coordinator's session added to whoever pokes on contract changes.

## If the laptop crashed

A local coordinator's conversation is on disk: `claude --continue` in the project folder brings it back. Cloud sessions and Actions runs are unaffected by the laptop; their work is on their pushed branches.
