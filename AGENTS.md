# Working with Ed

Instructions for any coding agent — Claude, or another model — working on any of Ed Saperia's projects. A project's own `CLAUDE.md` / `AGENTS.md` adds what is specific to it and wins where the two disagree. The shared protocol for builders, coordinators and pull requests is [`CONVENTIONS.md`](CONVENTIONS.md).

Ed is a slow, methodical product manager who wants things right first time.

## Communication

- **Rephrase the ask.** Open a response by restating the request in your own words — it is how he catches misunderstandings early.
- **Reflect, then teach while he waits.** After the rephrase, give honest commentary on the instruction: does it make sense, what tensions or risks it carries, how it fits the project's architecture and direction. Ed is usually waiting while work runs, so use that time to explain the project, the technology, or observations on how he is developing it. Verbosity is welcome here.
- **Reasoning over code.** Narrate ideas, tradeoffs and why a direction won; a rejected alternative is worth a sentence. Never paste code or diffs into updates unless asked — refer to changes by `file:line` and describe them in prose.
- **Narrate each edit as you go**, in one or two lines, in feature terms not code terms. Ed does not read diffs; the note is the only channel.
- **Number everything he might answer** — questions, options, findings, backlogs — in one continuous sequence across the message, so he can reply "do 3 and 7".
- **A blocking decision is asked on its own, as multiple choice**: one decision at a time, the background in the question itself (what the thing does now, why it is undecided, what each choice costs), options that state their consequence, recommended option first. Then act, and ask the next.
- **Repeat open questions in full** in the next report while they wait for an answer — numbers alone make him dig.
- **Ambiguous instructions: ask, don't guess.** When a note supports more than one reading, present the readings as numbered options and wait. Say what seems inconsistent or surprising about the note — helping him clarify his own model is part of the value.
- **Plain terms.** Describe things by what a user sees and does, not by internal labels he may not know.
- **Timestamp status updates** with the wall-clock time from the system clock (e.g. `[20:36]`) — never from memory.
- **Name the parts.** Give the pieces of a feature literal, stable, descriptive names (never whimsical codenames) and keep them in the project's glossary.

## Working style

- **Deploys are Ed's call.** Ask before anything deploys unless he has just asked to ship. Watch for repos where merging or pushing to main deploys. Say exactly what a deploy carried, checked against the remote, never assumed.
- **Merging to main is Ed's tap** — see CONVENTIONS.md.
- **Deferred work carries a condition to act**: anything left undone goes in the project's register (item, why deferred, condition, where). The condition must be checkable without judgement — a date, a file existing, a state a command can test, a decision Ed has taken. "Later" is not a condition. At the end of a task, re-read the register: condition met and trivial → do it; met and not trivial → offer it; not met → leave it out.
- **Commit often, push your branch often** — a pushed branch is what survives a crash or a lost session.
- **Report outcomes faithfully**: a failed check is reported with its output; a skipped step is said to be skipped.
- **Don't waste effort for nothing**: quiet output for long watches; prefer a measurement over a screenshot where either answers the question.
- **Keep shell commands readable** — no boilerplate prefixed to the command that matters.

## Local machines

Ed's laptop is Windows. Agents running there should read [`local/windows.md`](local/windows.md).
