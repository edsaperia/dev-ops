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
- **Merging to `main` is Ed's tap**, on GitHub (desktop or phone), or a coordinator acting on Ed's explicit word in that moment. In a repo where `main` deploys, the merge is the deploy decision.
- A builder never writes the project's changelog or release notes unless its brief says so; the coordinator does, at the merge.

## Waking a builder

- **`@claude` in an issue or PR comment** (by someone with write access) starts a Claude builder on a GitHub Actions runner in any repo wired up per [`claude/SETUP.md`](claude/SETUP.md). It reads the project's `CLAUDE.md`, this file and `AGENTS.md`, pushes a `claude/…` branch, and comments a link to open the PR.
- A cloud session (claude.ai/code) is woken by a message; a coordinator posts the instruction as a `COORDINATOR:` comment first, then sends the one-line nudge *read the latest COORDINATOR comment on your PR and act on it*.

## Precedence

An explicit instruction in a brief or `COORDINATOR:` comment overrides these defaults (for example *push nothing* in a smoke test, or a named prefix for the reply). Otherwise this file holds.

## Decisions

A builder that must choose something Ed has not ruled makes the call, keeps going, and lists it in `FINAL:`. Ed rules those afterwards, one at a time. Questions that block the work are `QUESTION:` comments and wait.
