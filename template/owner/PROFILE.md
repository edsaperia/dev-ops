# The owner: <name>

Who the owner is and how they like to be worked with. `AGENTS.md` sends every agent here first; where this file and the kit differ, this file wins (a project's own `CLAUDE.md` / `AGENTS.md` still wins over both for what is specific to it). Date each ruling: *(<name>, YYYY-MM-DD)*.

<One or two lines: who they are, how they work, what they care about. Their GitHub account, which every agent posts as.>

Each heading below lists the kinds of preference worth recording. The suggestions in *italics* are the defaults the kit was first written for; keep, change or delete each.

## Communication

- How to open a response. *Restate the request in your own words, so a misunderstanding shows early.*
- How much to say while work runs. *Honest commentary on the instruction, then teach: the project, the technology, how they are developing it. Verbosity welcome.*
- Code in messages. *Reasoning over code: ideas, tradeoffs, the rejected alternative; refer to changes by `file:line`, never paste diffs unless asked.*
- Narrating edits. *One or two lines per edit, in feature terms, as you go.*
- Numbering. *Number everything they might answer, in one sequence across the message, so they can reply "do 3 and 7".*
- Blocking decisions. *One at a time, as multiple choice, recommended option first; then act and ask the next.*
- Open questions. *Repeat them in full in the next report while they wait.*
- Ambiguity. *Present the readings as numbered options and say what seems inconsistent.*
- Vocabulary. *Plain terms: what a user sees and does, not internal labels.*
- Timestamps. *`[20:36]`, from the system clock.*
- Naming. *Literal, stable, descriptive names for the parts of a feature, kept in the project's glossary.*

## What is theirs to decide

- Deploys. *The owner's call: ask before anything deploys unless they have just asked to ship.*
- Merges to `main`. *The owner's decision, on their questions page; the coordinator does the merge.*
- Changes to the shared dev-ops files. *By pull request: the coordinator merges a change the owner chose on their page; the owner merges any they have not seen.*

## Working style

- Restarts and nudges they must do by hand. *One tap: a button that copies the message and opens where it goes; a link they must open is a large button.*
- Token budget. *Don't be precious, don't waste: quiet output for long watches, a measurement over a screenshot.*
- Subagent model. *Name one model for every subagent, pass it explicitly, and review the choice when a new model is released.*
- Projects off the page. *Any project whose coordinator they work with directly, in its session; say which in `projects.md`.*

## Local machines

<Their laptop's operating system, and a `local/<os>.md` of its traps if agents run there.>
