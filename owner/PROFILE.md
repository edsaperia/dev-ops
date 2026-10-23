# The owner: Ed Saperia

Who the owner is and how he likes to be worked with. [`AGENTS.md`](../AGENTS.md) sends every agent here first; where this file and the kit differ, this file wins (a project's own `CLAUDE.md` / `AGENTS.md` still wins over both for what is specific to it). Dated attributions are Ed's rulings.

Ed is a slow, methodical product manager who wants things right first time. His GitHub account is `edsaperia`, and every agent posts as it. His questions page, environment values and daily review are in [`PAGE.md`](PAGE.md); his projects in [`projects.md`](projects.md).

## Communication

- **Rephrase the ask.** Open a response by restating the request in your own words — it is how he catches misunderstandings early.
- **Reflect, then teach while he waits.** After the rephrase, give honest commentary on the instruction: does it make sense, what tensions or risks it carries, how it fits the project's architecture and direction. Ed is usually waiting while work runs, so use that time to explain the project, the technology, or observations on how he is developing it. Verbosity is welcome here. If the instruction itself is thin material, pick a different but still project-related topic.
- **Reasoning over code.** Narrate ideas, tradeoffs and why a direction won; a rejected alternative is worth a sentence. Never paste code or diffs into updates unless asked — refer to changes by `file:line` and describe them in prose.
- **Narrate each edit as you go**, in one or two lines, in feature terms not code terms. Ed does not read diffs; the note is the only channel.
- **Number everything he might answer** — questions, options, findings, backlogs — in one continuous sequence across the message, so he can reply "do 3 and 7".
- **A blocking decision is asked on its own, as multiple choice** (the shape is in `AGENTS.md`): one decision at a time, then act, and ask the next. The session's question tool is for a builder with Ed in a live session.
- **Repeat open questions in full** in the next report while they wait for an answer — numbers alone make him dig.
- **Ambiguous instructions**: when presenting the readings, say what seems inconsistent or surprising about the note — helping him clarify his own model is part of the value.
- **Plain terms.** Describe things by what a user sees and does, not by internal labels he may not know.
- **Timestamps** on status updates look like `[20:36]`, the wall-clock time from the system clock.
- **Name the parts.** Give the pieces of a feature literal, stable, descriptive names (never whimsical codenames) and keep them in the project's glossary.

## What is Ed's to decide

- **Deploys are Ed's call.** Ask before anything deploys unless he has just asked to ship. Watch for repos where merging or pushing to main deploys. Say exactly what a deploy carried, checked against the remote, never assumed.
- **Merging to main is Ed's decision**, on his questions page; the coordinator does the merge, and a merge that deploys nothing is the coordinator's own — see [`CONVENTIONS.md`](../CONVENTIONS.md).
- **Changes to the shared dev-ops files** go by pull request: the coordinator merges a change Ed has chosen on his questions page, and Ed merges any he has not seen (Ed, 2026-10-03).

## Working style

- **A manual restart is one tap.** When Ed has to restart or nudge something himself (a stalled coordinator, a builder waiting on a message), give him a button that does the whole thing — copies the message, opens the place it goes — never a paragraph of steps to follow (Ed, 2026-09-28). The same for a link he must open to press a button there: it is a large button, not a small one (Ed, 2026-09-30).
- **Token economy.** Ed's plan has high limits, so don't be precious about tokens, but don't waste them: several coordinators and builders now draw on the same subscription, so waste on one project slows the others. Quiet output for long watches (e.g. discard a watch's rolling output and view the result once); prefer a measurement over a screenshot where either answers the question.
- **Subagents** run on **Opus 5.5**, every one (builders, design, reviews, plans, reports, searches): it is the best balance of quality and cost, and the choice is reviewed whenever a new model is released (Ed, 2026-10-03; the review is in [`REGISTER.md`](REGISTER.md)). Pass the model explicitly (`model: "opus"`), since some agent types otherwise pick their own; never Haiku; a fork runs on the session's own model.
- **Off the page**: some projects put nothing on his questions page and Ed works with their coordinator directly in its session; [`projects.md`](projects.md) says which.

## Local machines

Ed's laptop is Windows. Agents running there should read [`local/windows.md`](local/windows.md).
