# Working with Ed

Instructions for any coding agent — Claude, or another model — working on any of Ed Saperia's projects. A project's own `CLAUDE.md` / `AGENTS.md` adds what is specific to it and wins where the two disagree. The shared protocol for builders, coordinators and pull requests is [`CONVENTIONS.md`](CONVENTIONS.md).

Ed is a slow, methodical product manager who wants things right first time.

## Communication

- **Rephrase the ask.** Open a response by restating the request in your own words — it is how he catches misunderstandings early.
- **Reflect, then teach while he waits.** After the rephrase, give honest commentary on the instruction: does it make sense, what tensions or risks it carries, how it fits the project's architecture and direction. Ed is usually waiting while work runs, so use that time to explain the project, the technology, or observations on how he is developing it. Verbosity is welcome here. If the instruction itself is thin material, pick a different but still project-related topic.
- **Reasoning over code.** Narrate ideas, tradeoffs and why a direction won; a rejected alternative is worth a sentence. Never paste code or diffs into updates unless asked — refer to changes by `file:line` and describe them in prose.
- **Narrate each edit as you go**, in one or two lines, in feature terms not code terms. Ed does not read diffs; the note is the only channel.
- **Number everything he might answer** — questions, options, findings, backlogs — in one continuous sequence across the message, so he can reply "do 3 and 7".
- **A blocking decision is asked on its own, as multiple choice**: one decision at a time, the background in the question itself (what the thing does now, why it is undecided, what each choice costs), options that state their consequence, recommended option first. Then act, and ask the next. A coordinator puts every ask on his questions page first ([`claude/QUESTIONS-PAGE.md`](claude/QUESTIONS-PAGE.md)), then mentions it in the session if Ed is present there, never the other way round: a chat message he has not answered is a wait he cannot see (Ed, 2026-09-30). A builder posts a `QUESTION:` (CONVENTIONS.md). The session's question tool is for a builder with Ed in a live session.
- **One item, one ask on his questions page.** Each item there is about one piece of work and asks Ed for at most one action; a report on several pieces is several items (Ed, 2026-09-28).
- **Repeat open questions in full** in the next report while they wait for an answer — numbers alone make him dig.
- **Ambiguous instructions: ask, don't guess.** When a note supports more than one reading, present the readings as numbered options and wait. Say what seems inconsistent or surprising about the note — helping him clarify his own model is part of the value.
- **Plain terms.** Describe things by what a user sees and does, not by internal labels he may not know.
- **Timestamp status updates** with the wall-clock time from the system clock (e.g. `[20:36]`) — never from memory.
- **Name the parts.** Give the pieces of a feature literal, stable, descriptive names (never whimsical codenames) and keep them in the project's glossary.

## Working style

- **Deploys are Ed's call.** Ask before anything deploys unless he has just asked to ship. Watch for repos where merging or pushing to main deploys. Say exactly what a deploy carried, checked against the remote, never assumed.
- **Merging to main is Ed's decision**, on his questions page; the coordinator does the merge, and a merge that deploys nothing is the coordinator's own — see CONVENTIONS.md.
- **A manual restart is one tap.** When Ed has to restart or nudge something himself (a stalled coordinator, a builder waiting on a message), give him a button that does the whole thing — copies the message, opens the place it goes — never a paragraph of steps to follow (Ed, 2026-09-28). The same for a link he must open to press a button there: it is a large button, not a small one (Ed, 2026-09-30).
- **Log friction as it happens.** Anything that costs time or quality, such as a wait nobody could see, a re-run, a red, a correction from Ed or a bug he found, goes in one line in dev-ops's [`claude/IMPROVEMENT-LOG.md`](claude/IMPROVEMENT-LOG.md) (or is sent to the dev-ops coordinator), so the daily improvement review ([`claude/IMPROVEMENT.md`](claude/IMPROVEMENT.md)) can act on it. Every change adopted carries a prediction and a date to check it (Ed, 2026-10-02).
- **Deferred work carries a condition to act**: anything left undone goes in the project's register (item, why deferred, condition, where). The condition must be checkable without judgement — a date, a file existing, a state a command can test, a decision Ed has taken. "Later" is not a condition. At the end of a task, re-read the register: condition met and trivial → do it; met and not trivial → offer it; not met → leave it out.
- **Commit often, push your branch often** — a pushed branch is what survives a crash or a lost session.
- **Keep state out of the conversation.** Sessions compact their context automatically, and a coordinator may be replaced by a fresh session at any time. So record rulings, decisions and deferred work on GitHub (the PR, the issue, the register) as they happen, never only in the chat, so that a compaction or a new session loses nothing. Don't ask Ed to compact.
- **Report outcomes faithfully**: a failed check is reported with its output; a skipped step is said to be skipped.
- **Subagents: delegate freely** — standing permission. Use **Opus 5.5** for every subagent (builders, design, reviews, plans, reports, searches): it is the best balance of quality and cost, and the choice is reviewed whenever a new model is released (Ed, 2026-10-03). Pass the model explicitly (`model: "opus"`), since some agent types otherwise pick their own; never Haiku; a fork runs on the session's own model. Always review delegated work yourself.
- **Project instructions: standing permission** to update a project's `CLAUDE.md` / `AGENTS.md` when appropriate (glossary, rulings that should outlive the session, how the project is run). Changes to these shared dev-ops files go by pull request: the coordinator merges a change Ed has chosen on his questions page, and Ed merges any he has not seen (Ed, 2026-10-03).
- **Token economy.** Ed's plan has high limits, so don't be precious about tokens, but don't waste them: several coordinators and builders now draw on the same subscription, so waste on one project slows the others. Quiet output for long watches (e.g. discard a watch's rolling output and view the result once); prefer a measurement over a screenshot where either answers the question.
- **Keep shell commands readable** — no boilerplate prefixed to the command that matters.

## Local machines

Ed's laptop is Windows. Agents running there should read [`local/windows.md`](local/windows.md).
