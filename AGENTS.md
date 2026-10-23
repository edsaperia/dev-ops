# Working with the owner

Instructions for any coding agent — Claude, or another model — working on any of the owner's projects. **Read the owner's profile, [`owner/PROFILE.md`](owner/PROFILE.md), first**: who the owner is and how they like to be worked with. It wins where it differs from this file, and a project's own `CLAUDE.md` / `AGENTS.md` adds what is specific to that project and wins over both. The shared protocol for builders, coordinators and pull requests is [`CONVENTIONS.md`](CONVENTIONS.md).

These are the working rules the machinery needs, whoever the owner is.

## Asking the owner

- **The questions page first, then the session.** A coordinator puts every ask on the owner's questions page first ([`claude/QUESTIONS-PAGE.md`](claude/QUESTIONS-PAGE.md)), then mentions it in the session if the owner is present there, never the other way round: a chat message the owner has not answered is a wait they cannot see (2026-09-30). A builder posts a `QUESTION:` (CONVENTIONS.md).
- **One item, one ask on the questions page.** Each item there is about one piece of work and asks the owner for at most one action; a report on several pieces is several items (2026-09-28).
- **A blocking decision is asked on its own, as multiple choice**: one decision at a time, the background in the question itself (what the thing does now, why it is undecided, what each choice costs), options that state their consequence, recommended option first. Then act, and ask the next.
- **Ambiguous instructions: ask, don't guess.** When a note supports more than one reading, present the readings as numbered options and wait.
- **Timestamp status updates** with the wall-clock time from the system clock — never from memory.

## Working style

- **Deploys and merges to `main`**: who decides is in the owner's profile, and how is in CONVENTIONS.md. Say exactly what a deploy carried, checked against the remote, never assumed.
- **Log friction as it happens.** Anything that costs time or quality, such as a wait nobody could see, a re-run, a red, a correction from the owner or a bug they found, goes in one line in the improvement log, [`owner/IMPROVEMENT-LOG.md`](owner/IMPROVEMENT-LOG.md) (or is sent to the dev-ops coordinator), so the daily improvement review ([`claude/IMPROVEMENT.md`](claude/IMPROVEMENT.md)) can act on it. Every change adopted carries a prediction and a date to check it (2026-10-02).
- **Deferred work carries a condition to act**: anything left undone goes in the project's register (item, why deferred, condition, where); dev-ops' own is [`owner/REGISTER.md`](owner/REGISTER.md). The condition must be checkable without judgement — a date, a file existing, a state a command can test, a decision the owner has taken. "Later" is not a condition. At the end of a task, re-read the register: condition met and trivial → do it; met and not trivial → offer it; not met → leave it out.
- **Commit often, push your branch often** — a pushed branch is what survives a crash or a lost session.
- **Keep state out of the conversation.** Sessions compact their context automatically, and a coordinator may be replaced by a fresh session at any time. So record rulings, decisions and deferred work on GitHub (the PR, the issue, the register) as they happen, never only in the chat, so that a compaction or a new session loses nothing. Don't ask the owner to compact.
- **Report outcomes faithfully**: a failed check is reported with its output; a skipped step is said to be skipped.
- **Subagents: delegate freely** — standing permission. Use the model the owner's profile names for every subagent and pass it explicitly, since some agent types otherwise pick their own; a fork runs on the session's own model. Always review delegated work yourself.
- **Project instructions: standing permission** to update a project's `CLAUDE.md` / `AGENTS.md` when appropriate (glossary, rulings that should outlive the session, how the project is run). Changes to these shared dev-ops files go by pull request, merged as CONVENTIONS.md, *Branches and merging*, and the owner's profile say.
- **Keep shell commands readable** — no boilerplate prefixed to the command that matters.

## The owner's machines

Notes for agents running on the owner's own machines, if any, are linked from the owner's profile.
