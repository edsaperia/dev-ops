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
| `FINAL:` | builder | the finished work: commits, checks and their results, what changed for a user, what was deferred, and every call Ed has not ruled on, numbered, each with context and options |

All agents may post as Ed's GitHub account; the prefix says who is speaking.

## Branches and merging

- A builder pushes **only its own branch** — never `main`, never someone else's branch — and commits and pushes after every piece of work.
- A builder that starts from another builder's branch **pushes at least one commit of its own before opening its PR**. Opened on the other branch's tip, the PR is marked *merged* the moment that branch lands on `main`, and a closed PR runs no CI and holds no conversation (draft #104, 2026-09-26).
- **Merging to `main` is Ed's tap**, on GitHub (desktop or phone), or a coordinator acting on Ed's explicit word in that moment. In a repo where `main` deploys, the merge is the deploy decision. **In a repo where `main` deploys nothing** (dev-ops), the coordinator merges a PR itself once it carries a change Ed chose on his questions page, and posts an OK-only *update* there naming the PR and what it carried; a merge task is not raised (Ed, 2026-10-01: "Why can't you merge this yourself?"). A merge that deploys stays Ed's tap.
- A builder never writes the project's changelog or release notes unless its brief says so; the coordinator does, at the merge.

## Waking a builder

- **`@claude` in an issue or PR comment** (by someone with write access) starts a Claude builder on a GitHub Actions runner in any repo wired up per [`claude/SETUP.md`](claude/SETUP.md). It reads the project's `CLAUDE.md`, this file and `AGENTS.md`, pushes a `claude/…` branch, and comments a link to open the PR.
- A cloud session (claude.ai/code) is woken by a message; a coordinator posts the instruction as a `COORDINATOR:` comment first, then sends the one-line nudge *read the latest COORDINATOR comment on your PR and act on it*.
- **Every cloud session runs in Auto mode**, coordinator or builder, chosen in the session's mode menu at the start (or switched while it runs). A session in the default mode asks Ed for one-off approvals that the repo's settings file cannot all suppress (`claude/SETUP.md` B5; Ed, 2026-09-30). A session that is asking for permission is a session that was opened in the wrong mode.

## Waking a coordinator: Ed's questions page

A coordinator sleeps between messages, and nothing on GitHub wakes it (2026-09-26/28: a cloud coordinator went quiet seven times, for up to ten hours). So the loop runs through Ed's questions page ([`claude/QUESTIONS-PAGE.md`](claude/QUESTIONS-PAGE.md)):

- **When anything finishes** — a `FINAL:` reviewed, a deploy verified, a check gone red — the coordinator puts an *update* on the page saying what finished and what it will start next. It does not start the next thing on its own.
- **A builder that finishes says so on the page too**: with its `FINAL:` (or a blocking `QUESTION:`), a cloud-session builder puts an update on the page, *PR #n: finished — OK to have the coordinator review it*; Ed's OK wakes the coordinator to review. Without it a builder's `FINAL:` sits unread until something else wakes the coordinator.
- **The coordinator stamps `lastActive`** on the page after every turn that did work, so Ed sees a stall as a stale time.
- **Whatever the coordinator is waiting on is on the page as an in-flight item** (`inflight/<project>-<slug>`): what is happening, what will land on the page when it finishes, and by when. The page shows these when nothing waits on Ed, and turns one red once its time has passed with nothing landed. Start one when the wait starts, move its time (with the reason) before it passes, close it when the promised update is posted.
- **Ed's OK starts it**: every answer, OK and Done on the page wakes the coordinator watching it. The coordinator asks Ed to paste the page's link at the start of each session, which is what arms its watch.
- **One item, one ask**: each item on the page is about one piece of work and asks Ed for at most one action; a report on several pieces is several items (Ed, 2026-09-28).
- **A coordinator schedules no check-ins of its own** (no *next check-in 12:35*, no Routine of its own) and asks nothing through tool approval prompts that can expire unseen: everything that waits on Ed waits on the page, and Ed's answers are what wake it.
- **Idle is never silent.** A coordinator with nothing in flight and nothing open on the page is not idle, it is waiting on Ed, and that is an item: a *question* on the page, *what next*, with its recommended next step first and what each option costs. "Next: stage 8 on Ed's word" in a chat or in the coordinator's own notes is a wait Ed cannot see (2026-09-29 and 2026-09-30: the draft coordinator finished a stage, wrote that in its record, and the project went silent on Ed's phone twice).
- **The page first, then chat.** When a coordinator needs Ed's word, the item goes on the page first; it mentions it in the session only if Ed is present there. Never the other way round: a chat message Ed has not answered is a wait he cannot see, and it dies with the chat when he leaves.
- **The contract changes while coordinators run, so every wake re-reads it**: at the start of every turn that does coordinator work, read this file and `claude/QUESTIONS-PAGE.md` from `edsaperia/dev-ops` `main` (the GitHub tool, not the container's checkout, which is from session start) and follow what they say now. Whoever merges a change to either file pokes every running coordinator listed in the page's `coordinators` collection: a message into its session (a one-shot Routine bound to that session with the change as its prompt, fired, then deleted) naming the section that changed. (Ed, 2026-09-28: the draft coordinator, started two days earlier, never saw the in-flight contract.)
- **A safety-check refusal is cleared only in the session's chat.** A cloud session in Auto mode may refuse an action on its own judgement, however the standing permissions read (2026-09-30: an edit to a repo's `.claude/settings.json`, an edit to an agent-instructions file, a fetch of a live site's health check). An answer on the page does not clear it, because the page's answers reach the session as data; only Ed's words typed in that session's chat do. So the coordinator puts a *task* on the page with a `copy` button that carries the line (*go ahead with both*) and opens the session, one tap, and never works round the refusal by another route, tool or session (Ed, 2026-09-30).

## Precedence

An explicit instruction in a brief or `COORDINATOR:` comment overrides these defaults (for example *push nothing* in a smoke test, or a named prefix for the reply). Otherwise this file holds.

## Decisions

A builder that must choose something Ed has not ruled makes the call, keeps going, and lists it in `FINAL:`. Ed rules those afterwards, one at a time. Questions that block the work are `QUESTION:` comments and wait.

**A decision taken on Ed's behalf is shown to him.** When a coordinator answers a builder's `QUESTION:` itself, or accepts a call listed in a `FINAL:`, because an existing ruling settles it, it also posts an OK-only *update* on Ed's questions page: what it decided, for which builder and PR, and which ruling settles it (see `claude/QUESTIONS-PAGE.md`, *Decisions taken on Ed's behalf*). Ed's OK costs one tap; his note is a veto, and the coordinator acts on it. A decision no ruling settles is not the coordinator's to take: it goes to the page as a question. (Ed, 2026-09-29: he was rarely asked anything through the page, and could not see what had been decided without him.)
