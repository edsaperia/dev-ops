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
| 2026-10-02 | Main's deploy job waited 21 min for a machine | Every merge waits behind branch test runs | Account's limit on jobs at once; nothing puts the deploy first | C6 (watching) |
| 2026-10-02 | Three auto-mode safety refusals in dev-ops (a trigger delete, a hash read, a force-push) | Ed had to type a go-ahead once; two reroutes | Classifier caution on outward actions | Watch: if it repeats, find the pattern |
| 2026-10-02 | Good: #163's new check caught the rail triangle hanging under the dev switch | 1h40 to fix before deploy, not after | Draft's one-check-per-fix rule | Keep the rule |

## Changes

| # | Change | Made | Prediction | Check on | Result |
|---|---|---|---|---|---|
| C1 | Merge is a question on the page; the coordinator merges (dev-ops PR #23) | 2026-10-02 13:00 | No merge tasks to Ed; merged within 10 min of his Merge | 2026-10-04 | |
| C2 | The page guard: writes to the page checked before they run (dev-ops; draft PR #175) | 2026-10-02 13:23 / 15:37 | No mis-shaped items on the page; no answer unstamped over an hour | 2026-10-04 | |
| C3 | Faster merges: every ready PR asked at once, docs-only merges by the coordinator, ledgers written on main, no re-run for being behind by docs (dev-ops PR #26) | 2026-10-02 16:27 | Draft's small PRs merged within 2 h of opening (median); at most 3 merge-main commits a day; docs PRs merged without a question | 2026-10-03, again 2026-10-05 | First sign: #166 merged without a question at 16:34 |
| C4 | A restarted coordinator re-subscribes to its PRs (dev-ops PR #26) | 2026-10-02 16:27 | No overdue in-flight item caused by a missed PR event | 2026-10-09 | |
| C5 | Builders watch their own PRs; the coordinator is the backstop (dev-ops PR #27) | 2026-10-02 17:07 | A PR put into conflict by a merge is pushed up to date within 30 min, unprompted | 2026-10-04 | |
| C6 | Watching main's deploy wait for an hour; a proposal if it recurs | 2026-10-02 17:00 | (measurement) | 2026-10-02 18:00 | |
