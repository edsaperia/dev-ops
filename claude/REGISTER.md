# Dev-ops register: work left undone, and when to do it

Each entry: the item, why it waits, the condition to act (checkable without judgement), and where. Re-read at the end of every task: condition met and trivial, do it; met and not trivial, offer it to Ed; not met, leave it.

| Item | Why it waits | Condition to act | Where |
|---|---|---|---|
| Copy the page-contract mod into mergetournament | Its coordinator sleeps by Ed's choice (2026-10-02 09:30) and nothing runs there | `inflight/mergetournament-asleep` on the page is `done` or deleted (Ed has woken it) | `mergetournament/.claude/skills/page-contract/`, by a Merge question |
| A wake meant for another project still costs a turn in every coordinator watching the page | A mod can only see the notification by calling ReadNotifications itself, which takes it from the model; a missed real wake costs more than the ~40 cheap "not for me" turns a day it would save (decided 2026-10-02) | The engine offers a way to read a pending notification without consuming it, or the page gains per-project watches | `.claude/skills/page-contract/hooks/register.ts` |
| A pane or status line of open items in Claude Code | Ed works from the page on his phone; a desktop view adds nothing he uses (decided 2026-10-02) | Ed asks for one | a new mod |
| Apply "The deploy never queues behind PR checks" to mergetournament's workflows | Its coordinator sleeps by Ed's choice; nothing runs there now, so nothing queues | `inflight/mergetournament-asleep` on the page is `done` or deleted (Ed has woken it) | `mergetournament/.github/workflows/`, by a Merge question |
| Review the subagent model (AGENTS.md: Opus 5.5) and put the choice to Ed | Ed keeps Opus 5.5 by name as the best balance of quality and cost; a newer Opus may not be (Ed, 2026-10-03). Note `model: "opus"` follows the newest Opus, so a release changes what helpers run on until this is reviewed | A Claude model newer than Opus 5.5 is listed by the Models API or offered in Claude Code | `AGENTS.md`, *Subagents*, by a question on Ed's page |
