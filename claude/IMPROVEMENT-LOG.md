# Improvement log

The record kept by the daily improvement review ([`IMPROVEMENT.md`](IMPROVEMENT.md)): the numbers, the friction, and every change with its prediction. Newest rows at the bottom of each table. Times are UTC.

**The Routine's prompt** (re-create it with this if the dev-ops coordinator's session is replaced): *Daily improvement review: follow claude/IMPROVEMENT.md in edsaperia/dev-ops (read it from main): check predictions due, write today's numbers, read the friction since the last review, act on at most two improvements, and report on Ed's questions page.*

## Numbers

| Day (24 h to) | Project | Merged | Open → merged, median / worst | Merge-main commits | Deploy wait on main | Reds on main | Ed's answers, median / over 90 min | Asked of Ed (q / u / t) | Mis-shaped | Overdue | Bugs Ed found |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 2026-10-02 17:15 (baseline) | draft | 10 | 4.7 h / 8.7 h | ~12 | 21 min (1 sample, #166) | 0 | 11 min / 8 (to 16:00) | 15 / 25 / 7 (all projects, to 16:00) | 3 (no status) | 1 | not yet counted |

## Friction

| Date | What happened | Cost | Cause | Led to |
|---|---|---|---|---|
| 2026-10-01 | Draft items of kind *final* and *decision* the page couldn't show | Ed couldn't answer them until repaired | No check on writes | C2 |
| 2026-10-02 | Three draft items with no status, invisible on the page | Ed saw no merges to do while the coordinator waited on him | No check on writes | Page v13, C2 |
| 2026-10-02 | 51 draft answers never stamped handled | Wakes re-read old answers | Rule not followed | Poke; C2 reminds hourly |
| 2026-10-02 | Merge tasks sent Ed to GitHub, where he was signed out | Two merges hidden from him | Ed did the merging | C1 |
| 2026-10-02 | The page guard didn't load in cloud sessions | One probe round; Ed set an environment variable | Cloud workspaces are untrusted | env var (SETUP step 6) |
| 2026-10-02 | A subagent ran on Sonnet against the Opus rule | Rule broken; probe repeated | Model not passed explicitly | Pass `model: "opus"` every time |
| 2026-10-02 | Dev-ops lost its watch on draft #175 in a restart | Merge waited for an overdue in-flight item and Ed's nudge | Subscriptions die with the session | C4 |
| 2026-10-02 | PRs merged one at a time; each merge put the rest into conflict | ~12 re-runs of ~40 min; small PRs waited 3–5 h | Queue order kept by habit; every PR edits the same ledgers | C3 |
| 2026-10-02 | #160's Merge question waited 1h45 on Ed | The line stood still behind it | One question at a time | C3 |
| 2026-10-02 | Main's deploy job waited 21 min for a machine | Every merge waits behind branch test runs | Account's limit on jobs at once; nothing puts the deploy first | C6, then C7 |
| 2026-10-02 | Three auto-mode safety refusals in dev-ops (a trigger delete, a hash read, a force-push) | Ed had to type a go-ahead once; two reroutes | Classifier caution on outward actions | Watch: if it repeats, find the pattern |
| 2026-10-02 | Good: #163's new check caught the rail triangle hanging under the dev switch | 1h40 to fix before deploy, not after | Draft's one-check-per-fix rule | Keep the rule |
| 2026-10-02 | Draft (sent): four new builder PRs (#170 #171 #172 #174) unseen ~1.5 h | Review started late | Coordinator not subscribed to new PRs | Draft now subscribes on open and lists PRs at each wake |
| 2026-10-02 | Draft (sent): #174 turned CLAUDE.md's line endings CRLF→LF, breaking a gotcha's literal CR | One extra fix round | Builder rewrote the file in text mode | Candidate: a line-ending check in spec-check, so the push catches it |
| 2026-10-02 | Draft (sent): the coordinator can't read docs.vote/healthz or edit .claude/settings.json (auto-mode refusals) | Deploys verified only by CI's own step | Classifier treats production and self-editing as risky | A page task owed by draft for Ed's one-line approval |
| 2026-10-02 | Draft (sent): builder Charlie reported Ed's Q5 as open 80 min after it was answered and relayed | 80 min | Builder missed the COORDINATOR comment | C5 should cover it |
| 2026-10-02 | Draft (sent), good: the builder measured the real cause of #163's toc-travel red after the coordinator misdiagnosed it | Wrong fix avoided | Builder pushback with measurements | Keep: builders may dispute a diagnosis with numbers |
| 2026-10-02 | Draft (sent), good: copy-check's walk caught four 📧 text moves needing a golden re-freeze before merge | Caught before deploy | Sprint tier | Keep |
| 2026-10-02 | Draft (sent): Ed judges UI from screenshots, so some issues show only after deploy | Fix rounds after deploy | No way to try a PR before it deploys | Candidate: a preview deploy per PR, linked from each Merge question |
| 2026-10-02 | A task's "Claude Code environments" link opened a blank tab (Ed) | A detour for Ed | The link pointed at claude.ai/code, not the settings page; it was never tried | Settings tasks give exact steps, not untried links |
| 2026-10-02 | Admit (sent): its coordinator's GitHub tool reaches only nwspk/admit, so it can't read the rules from dev-ops as CONVENTIONS says | A workaround found by the coordinator | A session's GitHub scope is its own repository's owner | CONVENTIONS names the public clone as the fallback |
| 2026-10-02 | Dev-ops told Ed that Claude couldn't push to Topic, trusting the attach tool's "push refused"; a real push and PR then worked | A wrong task on Ed's page, then a correction | Took a tool's prediction as a measurement | Test with a harmless real action before reporting a block |
| 2026-10-02 | Dev-ops wrote page times rounded ahead of the clock (18:46, 18:47 at 18:44); the page guard refused the second | One refused write, one item 2 min early | Guessed the time instead of reading it | The guard works; read `date -u` before every stamp |
| 2026-10-02 | Topic's repository has no Claude app, so GitHub events wake no session there | Topic's PRs must be checked by hand | Repository on another person's account | Issue #363 asks the owner |
| 2026-10-02 | Admit (sent): a "read and sign off the spec" task got Done 25 s after posting, with no note | One extra question to find out what Done meant | A judgement step posted as a task | C8 |
| 2026-10-02 | Topic (sent): a subagent builder started with worktree isolation had every command refused in the cloud session | One wasted builder start, ~1 min | Isolation context lost in cloud sessions | CONVENTIONS, "Briefing a builder": make the worktree by hand |
| 2026-10-02 | Topic (sent): the page guard refused a page write with an `asked` time from memory, in the future | One refused write | Second coordinator today to guess the time (dev-ops was the first) | The guard catches it; a repeat on a third coordinator makes it a rule to read the clock |
| 2026-10-02 | Topic (sent): every project's answers wake every watching coordinator (4 wakes in Topic's first 5 min; dozens for dev-ops today) | A turn per wake per coordinator, now 4 coordinators | One watch covers the whole page | Register item; the review weighs it now that 4 coordinators pay it |
| 2026-10-02 | Admit (sent): a builder subscribed to its PR never woke for the coordinator's review comments (nwspk/web#53) | 22 min idle until a nudge | All agents post as Ed's account, so a COORDINATOR: comment looks like the builder's own echo | CONVENTIONS: the nudge after every COORDINATOR: comment stays; C5 refined |
| 2026-10-02 | ae: the Claude app reaches it; PR events arrived at once (subscription and merge) | — | — | — |

## Changes

| # | Change | Made | Prediction | Check on | Result |
|---|---|---|---|---|---|
| C1 | Merge is a question on the page; the coordinator merges (dev-ops PR #23) | 2026-10-02 13:00 | No merge tasks to Ed; merged within 10 min of his Merge | 2026-10-04 | |
| C2 | The page guard: writes to the page checked before they run (dev-ops; draft PR #175) | 2026-10-02 13:23 / 15:37 | No mis-shaped items on the page; no answer unstamped over an hour | 2026-10-04 | |
| C3 | Faster merges: every ready PR asked at once, docs-only merges by the coordinator, ledgers written on main, no re-run for being behind by docs (dev-ops PR #26) | 2026-10-02 16:27 | Draft's small PRs merged within 2 h of opening (median); at most 3 merge-main commits a day; docs PRs merged without a question | 2026-10-03, again 2026-10-05 | First sign: #166 merged without a question at 16:34 |
| C4 | A restarted coordinator re-subscribes to its PRs (dev-ops PR #26) | 2026-10-02 16:27 | No overdue in-flight item caused by a missed PR event | 2026-10-09 | |
| C5 | Builders watch their own PRs; the coordinator is the backstop (dev-ops PR #27) | 2026-10-02 17:07 | A PR put into conflict by a merge is pushed up to date within 30 min, unprompted | 2026-10-04 | First sign, 2026-10-02: review comments don't wake a subscribed builder (same-account echo); the nudge rule restored for COORDINATOR: comments |
| C6 | Watching main's deploy wait for an hour; a proposal if it recurs | 2026-10-02 17:00 | (measurement) | 2026-10-02 18:00 | Recurred: 2 of 9 merges waited (#166 21 min, #170 4 min), the rest 3–4 s; 19 jobs per merge, stale PR runs uncancelled. Led to C7 |
| C7 | The deploy never queues behind PR checks: stale PR runs cancelled, one slow suite per branch, deploy job first on main (CONVENTIONS) | 2026-10-02 18:14 (rule); draft's workflows by its Merge question | No deploy job on main waits over 2 min for a machine; PR verdicts at most ~5 min slower | 2026-10-05 | |
| C8 | A step that needs Ed's judgement is a question with named outcomes, never a task (QUESTIONS-PAGE.md) | 2026-10-02 18:56 | No judgement step is posted as a task, and no Done needs a follow-up question to read | 2026-10-09 | |
