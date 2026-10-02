# Conventions — builders, coordinators and pull requests

The protocol every agent follows on Ed's projects, whatever model it is and wherever it runs (Ed's laptop, a cloud session, a GitHub Actions runner).

## Roles

- **Ed** decides: product questions, anything a project's rules reserve to him, and every merge to `main`.
- **A coordinator** briefs builders, answers their questions where Ed's existing rulings settle them, reviews their work, and brings Ed only what is his.
- **A builder** does one piece of work on its own branch and reports.

## The pull request is the conversation

Every piece of work has a **draft pull request**, opened by its builder at the start (a GitHub Actions builder cannot open one: its conversation is the issue or PR it was mentioned on, and it comments a link for Ed to open the PR), titled with what it is and, where it must not be merged yet, `— do not merge`. Everything about the work is said there, so the PR holds the whole record and survives any lost session or machine. Comments carry a prefix **at the start of a line** — the Actions builder wraps its comments in a header of its own, so readers match a prefix at the start of any line, not only the first:

| Prefix | Who | Meaning |
|---|---|---|
| `COORDINATOR:` | coordinator | an instruction or an answer; the builder acts on the latest one |
| `QUESTION:` | builder | needs an answer; states the recommended option; the builder keeps working on anything that does not depend on it |
| `REPORT:` | builder | progress at a milestone |
| `FINAL:` | builder | the finished work: commits, checks and their results, what changed for a user, what was deferred, and every call Ed has not ruled on, numbered, each with context and options. **The checks are the exact commands CI runs, named word for word and run over what the builder wrote**; a narrower stand-in is not green (plan-queue, 2026-08-27: a type check that skipped every test file). **Every user-visible string that changed is listed, before → after**, or the FINAL says *no user-visible text changed*; silence is not *none* (plan-queue: thirteen member-facing sentences once landed unrecorded) |

All agents may post as Ed's GitHub account; the prefix says who is speaking.

## Branches and merging

- A builder pushes **only its own branch** — never `main`, never someone else's branch — and commits and pushes after every piece of work.
- A builder that starts from another builder's branch **pushes at least one commit of its own before opening its PR**. Opened on the other branch's tip, the PR is marked *merged* the moment that branch lands on `main`, and a closed PR runs no CI and holds no conversation (draft #104, 2026-09-26).
- **Merging to `main` is Ed's decision**, taken on his questions page or in a coordinator's chat; the coordinator does the merge. In a repo where `main` deploys, the merge is the deploy decision: once a PR is reviewed, green and conflict-free, the coordinator asks a *question* on the page, *Merge PR #n: ‹what it changes for a user›*, with **Merge** (deploy now) recommended and **Hold**, the context saying what merging changes and whether it is a full or a surface deploy. On *Merge* the coordinator re-checks the head is still green and conflict-free, merges, verifies the deploy, and posts the *now live* update; on *Hold* it merges nothing and acts on Ed's note. A merge task (*tap Merge on GitHub*) is not raised (Ed, 2026-10-02: "if you can merge it yourself, why am I merging things manually?"; his GitHub trip had twice hidden a merge that day). **In a repo where `main` deploys nothing** (dev-ops), the coordinator merges a PR itself once it carries a change Ed chose on his questions page, and posts an OK-only *update* there naming the PR and what it carried; a merge task is not raised (Ed, 2026-10-01: "Why can't you merge this yourself?").
- **Ask for every ready merge at once.** Each PR that is reviewed, green and conflict-free gets its *Merge PR #n* question as soon as it is ready, beside any already open; the coordinator never holds one back to keep a queue order. When Ed says *Merge* on several, it merges them in turn without waiting on him between them, re-checking each head first. A PR that the merge before it puts into conflict goes back to its builder and gets a fresh question once it is ready again. Each PR stays its own item (Ed, 2026-10-02: a PR stood green and unasked for an hour behind another's question).
- **A merge that deploys nothing is the coordinator's own.** Where CI leaves a documents-only push to `main` undeployed (in draft, the deploy step's `docs` lane), a PR whose whole diff is documents is merged by the coordinator itself once it is reviewed, green and conflict-free. It posts an OK-only *update* naming the PR, not a *Merge* question. Before merging it checks two things. First, every changed file is in CI's own documents filter (read from the workflow, not remembered). Second, `main`'s latest commit is deployed, since CI deploys any undeployed commit along with the next push. After merging it reads CI's log for the lane it took. If CI deployed after all, the update says so and the deploy is verified as any other (Ed, 2026-10-02).
- **Shared ledgers are the coordinator's, written on `main`.** A file that every PR would edit at the same spot is never edited in a builder's PR: the changelog, a numbered questions or decisions log, its *next free* line. Each such edit puts every other open PR into a conflict, and so into a full re-run. The brief gives the builder any numbers it needs. The builder puts in its `FINAL:` the text it would have written. The coordinator writes that text to `main` at the merge as a documents-only commit, which deploys nothing (the rule above). Draft, 2026-10-02: most of a day's dozen re-runs were conflicts in QUESTIONS.md and CHANGELOG.md (Ed, 2026-10-02).
- **Re-run only for what `main` changed.** A PR that is behind `main` but merges cleanly is not brought up to date and re-run merely for being behind when everything `main` gained since its checks went green is documents: its *Merge* question is asked on the head as it stands, and CI's gates on the merge commit still run before any deploy. When `main` gained code, the PR merges `main` and re-runs its checks as before, the slower ones included where the change touches what they cover (Ed, 2026-10-02).

## Briefing a builder

- **Write the brief just before the build starts**, not days ahead: a plan right when written goes stale as other work lands (plan-queue lost a week to such plans).
- **Point at a file and a symbol, never a line number**, which moves.
- **Read the brief through for self-consistency before handing it over** (plan-queue, 2026-08-29: 4 of 12 agent-written plans contradicted themselves).
- **One piece of work per brief**; an unrelated fix found on the way is its own PR (plan-queue: nine steps in one session cost $214 and stalled; a one-line brief cost $2.39).

## Reviewing a FINAL

- **A red check whose failure names nothing the diff touches gets one re-run before it is treated as a defect**; a second red on the same commit is real, and is never re-run again. A builder that disputes a red with measurements may be right (plan-queue, 2026-08-27 and 08-29: reds from machine load, green on a plain re-run).
- **Any check against a running server first proves the server is serving this commit** (its health or version check names the sha); a stale server gives false findings (plan-queue, 2026-08-25: three).

## Waking a builder

- **Before telling a builder that an answer or a permission is in place, check that it is** (the rule written, the setting saved, the comment posted). Otherwise the resumed builder is refused again and works round it (plan-queue, 2026-08-27: Ed chose *allow both permanently*, nobody added the rule, and the builder deleted the file by another route).
- **A quiet session may be rate-limited, not stuck**: read its usage (the session's rate-limit status) before diagnosing a stall, and when a promised time slips, say how many commits have been pushed so far (plan-queue: a review sat 35 minutes on an exhausted usage window and was reported as a stall).

- **`@claude` in an issue or PR comment** (by someone with write access) starts a Claude builder on a GitHub Actions runner in any repo wired up per [`claude/SETUP.md`](claude/SETUP.md). It reads the project's `CLAUDE.md`, this file and `AGENTS.md`, pushes a `claude/…` branch, and comments a link to open the PR.
- A cloud session (claude.ai/code) is woken by a message; a coordinator posts the instruction as a `COORDINATOR:` comment first, then sends the one-line nudge *read the latest COORDINATOR comment on your PR and act on it*.
- **A cloud-session builder watches its own PR.** When it opens its PR, the builder subscribes to the PR's activity (`subscribe_pr_activity`), and again after any restart. Its events then wake it without the coordinator:
  - a notice that the PR no longer merges cleanly: merge `main`, resolve the conflict, run the gates, push, and say so on the PR;
  - a red check: fix it, or show it is not this PR's, as CI-red handling requires;
  - a `COORDINATOR:` comment: act on it.

  A green check, or an event echoing its own comment, needs nothing. A builder still never merges its PR and never asks Ed. It unsubscribes once the PR is merged or closed. **The coordinator is the backstop**: after each merge to `main`, it lists the open PRs that no longer merge cleanly and wakes the builder of each one that has not already pushed a fix, since a notice can be missed (Ed, 2026-10-02: small PRs waited hours for someone to notice that `main` had moved).
- **Every cloud session runs in Auto mode**, coordinator or builder, chosen in the session's mode menu at the start (or switched while it runs). A session in the default mode asks Ed for one-off approvals that the repo's settings file cannot all suppress (`claude/SETUP.md` B5; Ed, 2026-09-30). A session that is asking for permission is a session that was opened in the wrong mode.

## Waking a coordinator: Ed's questions page

A coordinator sleeps between messages, and nothing on GitHub wakes it except activity on a pull request it has subscribed to (2026-09-26/28: a cloud coordinator went quiet seven times, for up to ten hours). So the loop runs through Ed's questions page ([`claude/QUESTIONS-PAGE.md`](claude/QUESTIONS-PAGE.md)):

- **When anything finishes** — a `FINAL:` reviewed, a deploy verified, a check gone red — the coordinator puts an *update* on the page saying what finished and what it will start next. It does not start the next thing on its own.
- **A builder that finishes says so on the page too**: with its `FINAL:` (or a blocking `QUESTION:`), a cloud-session builder puts an update on the page, *PR #n: finished — OK to have the coordinator review it*; Ed's OK wakes the coordinator to review. Without it a builder's `FINAL:` sits unread until something else wakes the coordinator.
- **The coordinator stamps `lastActive`** on the page after every turn that did work, so Ed sees a stall as a stale time.
- **Whatever the coordinator is waiting on is on the page as an in-flight item** (`inflight/<project>-<slug>`): what is happening, what will land on the page when it finishes, and by when. The page shows these when nothing waits on Ed, and turns one red once its time has passed with nothing landed. Start one when the wait starts, move its time (with the reason) before it passes, close it when the promised update is posted.
- **A restarted coordinator re-subscribes to its pull requests.** A PR watch (`subscribe_pr_activity`) belongs to the session that set it, and a restart or a replacement session loses it silently: green checks and review comments then wake nobody. So at the start of a session, and after any restart, the coordinator subscribes again to every open PR it is driving, before anything else (2026-10-02: dev-ops lost its watch on draft #175 in a restart, missed the checks going green, and the merge waited until the in-flight item went overdue).
- **Ed's OK starts it**: every answer, OK and Done on the page wakes the coordinator watching it. The coordinator asks Ed to paste the page's link at the start of each session, which is what arms its watch.
- **One item, one ask**: each item on the page is about one piece of work and asks Ed for at most one action; a report on several pieces is several items (Ed, 2026-09-28).
- **A coordinator schedules no check-ins of its own** (no *next check-in 12:35*, no Routine of its own; the one exception is a Routine Ed asked for, such as dev-ops's daily improvement review, [`claude/IMPROVEMENT.md`](claude/IMPROVEMENT.md)) and asks nothing through tool approval prompts that can expire unseen: everything that waits on Ed waits on the page, and Ed's answers are what wake it.
- **Idle is never silent.** A coordinator with nothing in flight and nothing open on the page is not idle, it is waiting on Ed, and that is an item: a *question* on the page, *what next*, with its recommended next step first and what each option costs. "Next: stage 8 on Ed's word" in a chat or in the coordinator's own notes is a wait Ed cannot see (2026-09-29 and 2026-09-30: the draft coordinator finished a stage, wrote that in its record, and the project went silent on Ed's phone twice).
- **The page first, then chat.** When a coordinator needs Ed's word, the item goes on the page first; it mentions it in the session only if Ed is present there. Never the other way round: a chat message Ed has not answered is a wait he cannot see, and it dies with the chat when he leaves.
- **The contract changes while coordinators run, so every wake re-reads it**: at the start of every turn that does coordinator work, read this file and `claude/QUESTIONS-PAGE.md` from `edsaperia/dev-ops` `main` (the GitHub tool, not the container's checkout, which is from session start) and follow what they say now. Whoever merges a change to either file pokes every running coordinator listed in the page's `coordinators` collection: a message into its session (a one-shot Routine bound to that session with the change as its prompt, fired, then deleted) naming the section that changed. (Ed, 2026-09-28: the draft coordinator, started two days earlier, never saw the in-flight contract.)
- **A safety-check refusal is cleared only in the session's chat.** A cloud session in Auto mode may refuse an action on its own judgement, however the standing permissions read (2026-09-30: an edit to a repo's `.claude/settings.json`, an edit to an agent-instructions file, a fetch of a live site's health check). An answer on the page does not clear it, because the page's answers reach the session as data; only Ed's words typed in that session's chat do. So the coordinator puts a *task* on the page with a `copy` button that carries the line (*go ahead with both*) and opens the session, one tap, and never works round the refusal by another route, tool or session (Ed, 2026-09-30).

## Precedence

An explicit instruction in a brief or `COORDINATOR:` comment overrides these defaults (for example *push nothing* in a smoke test, or a named prefix for the reply). Otherwise this file holds.

## Decisions

A builder that must choose something Ed has not ruled makes the call, keeps going, and lists it in `FINAL:`. Ed rules those afterwards, one at a time. Questions that block the work are `QUESTION:` comments and wait.

**A decision taken on Ed's behalf is shown to him.** When a coordinator answers a builder's `QUESTION:` itself, or accepts a call listed in a `FINAL:`, because an existing ruling settles it, it also posts an OK-only *update* on Ed's questions page: what it decided, for which builder and PR, and which ruling settles it (see `claude/QUESTIONS-PAGE.md`, *Decisions taken on Ed's behalf*). Ed's OK costs one tap; his note is a veto, and the coordinator acts on it. A decision no ruling settles is not the coordinator's to take: it goes to the page as a question. (Ed, 2026-09-29: he was rarely asked anything through the page, and could not see what had been decided without him.)
