# CI efficiency: review crossings, remove repeated work

Ed, 2026-11-01: review CI the first time it goes above 10, 20, 30 minutes,
and each further ten-minute threshold. A threshold resets after a review finds
and fixes a cause and a comparable completed run finishes below it. Ed also
asked that Witch's speedups be written up here. His direction was to improve
use of the existing infrastructure before looking for more capacity.

## Trigger and reset

The project coordinator owns the review. Measure elapsed time from the push
to completion of all required gates, including queueing. If the exact push time
is unavailable, record workflow creation time as a proxy. Keep queue time,
execution time, publication time and aggregate worker-minutes separately.
Optional checks must not silently become required gates.

Keep durable state for each comparable workload and each threshold: armed or
under review, the triggering run and source, review owner, cause, correction,
verification run and reset time. Workloads must distinguish materially different
coverage, such as documents-only reuse and a render-changing full art check.

1. The first observation above an armed threshold opens a review. An ongoing
   run already above it counts; do not wait for a slow or hung run to finish.
2. One review can cover several crossed thresholds. Repeated observations of
   the same unresolved crossing do not create duplicate reviewers or alerts.
3. Rearm each crossed threshold only when the review identifies a cause, its
   correction is implemented, and a comparable completed run finishes below
   that threshold. Store the evidence. A review alone, proposed change,
   cancelled run or unrelated fast workload does not reset it.
4. A later crossing of a rearmed threshold starts another review. Higher armed
   thresholds still trigger if the existing review has not resolved the delay.

Example: a 27-minute run triggers 10 and 20. A correction followed by an
18-minute comparable run rearms 20, but leaves 10 under review. A subsequent
21-minute run triggers 20 again. Exactly 20 is neither above nor below 20.
When adopting this policy during an existing review, attach historical
crossings to that review without inventing crossing timestamps or replaying
separate reviews for every band.

## What a review records

Use existing run metadata, logs and artifacts first; do not launch a full suite
merely to discover which existing step is slow. Record the source SHA, workflow,
runner class, OS, exact runtime/browser versions, workload, cache state and
required coverage. Identify the critical path rather than adding parallel job
durations together. Compare equivalent runs; label cold caches and partial or
cancelled measurements. A failed or incomplete run is never a budget pass.

For each finding, name the owner, correction, predicted saving, verification
condition and date to check it. Track both elapsed time and worker-minutes:
parallelism can shorten the wait while increasing total work, queueing or memory.
Preserve required correctness and security checks. Buying capacity comes after
evidence that the remaining bottleneck is capacity rather than repeated work.

## Reusable findings from Witch

These are patterns to investigate, not instructions to change every repository.
Project-specific scope and release rules continue to apply.

| Pattern | What to change | Evidence and limits |
|---|---|---|
| Build once per tested source | Pass one immutable build artifact to smoke, benchmarks, previews and publication instead of rebuilding in each job. Preserve source/version identity and fork publication restrictions. | Witch's shared build is described in [PR 1496](https://github.com/edsaperia/witch/pull/1496). Further publication reuse is part of [PR 1582](https://github.com/edsaperia/witch/pull/1582); its total saving requires completed CI evidence. |
| Stop generating the same expensive fixtures twice | Keep cheap unit contracts near the code; perform production art assertions against art already generated in the mandatory art job. Inventory every original assertion before moving it. | [PR 1570's timing report](https://github.com/edsaperia/witch/blob/c67d3da7729581fb0a8a4b0a5dba115b69235a87/docs/reports/sleeping-legend-test-cost.md): two unit files previously took 28,636 ms; the replacement fixture tests took 7 ms. Production art assertions remain required elsewhere. This is not a measured whole-CI saving. |
| Select related tests conservatively | Use dependency-aware selection for eligible small PRs, with a full-suite fallback for missing history, shared/config/dependency changes and uncertainty. Keep release coverage explicit. | [PR 1496](https://github.com/edsaperia/witch/pull/1496) introduced the relevant Witch path. [PR 1582](https://github.com/edsaperia/witch/pull/1582) extends CI orchestration; do not confuse narrower local checks with all required CI passing. |
| Reuse proven results for unchanged inputs | Key reuse by the relevant input tree, tool/config fingerprints, environment and coverage. Require successful, complete proof; a branch name or a green check on an older head is insufficient. | [PR 1583](https://github.com/edsaperia/witch/pull/1583) preserves art-tree and per-task proof reuse. Invalid, missing, stale or cancelled evidence must fail closed. |
| Balance independent expensive tasks | Use observed durations to distribute tasks; require a final gate to reconcile every shard's exact coverage and identity. | The reference art job took 42m34s; sprites 1,621.5s, sleeping art 384.8s and auxiliary work 882.8s are balancing inputs, not additive wall-time savings. Four art shards in [PR 1583](https://github.com/edsaperia/witch/pull/1583) were awaiting complete after measurements at this writeup. |
| Pin the environment shared by distributed proof | Pin plan, workers and final validation consistently; retain strict mismatch rejection and useful diagnostics. | [PR 1583's first failure](https://github.com/edsaperia/witch/pull/1583#issuecomment-6552235957) was Node 22.23.4 versus 22.23.3 before art assertions ran. The correction pins the runtime; weakening identity checks would hide the defect. A single successful shard is not a successful workflow. |
| Bound setup and cache the right browser | Version cache keys, retain required native dependencies, bound installation/retries and report setup time separately. | [The CI review](https://github.com/edsaperia/witch/pull/1476#issuecomment-6551886017) identified a roughly 20-minute Playwright installation wait and 52–54-minute art runs. A cancelled install is a diagnosis, not evidence the replacement smoke check passed. |
| Avoid obsolete work and needless reruns | Cancel superseded PR runs, protect publication capacity, batch a coherent source change, and avoid merging upstream solely for documents when project rules permit. | These extend the existing [branch and merging conventions](CONVENTIONS.md#branches-and-merging). Preserve required checks on the actual combined release; never cancel required production work to make a dashboard look faster. |
| Remove shared-file conflict hotspots | Use per-change fragments and coordinator-owned shared ledgers; generate inventories before pushing so cheap metadata failures do not consume another long CI cycle. | Existing conventions record a day of reruns caused by shared QUESTIONS/CHANGELOG edits. Witch uses separate changelog fragments and generated note/tool indexes. This saves avoidable cycles; no new numerical saving is claimed. |
| Run the right verification once | Builders run nearby tests and type checks; the release coordinator owns combined full-suite/smoke work where project rules allow. Prepare deterministic cloud proofs separately from hardware-specific performance proof. | [Witch's builder rules](https://github.com/edsaperia/witch/blob/claude/prototype/CLAUDE.md#builders-and-the-coordinator-ed-2026-10-29) assign this ownership. Moving a test does not remove it; software rendering cannot establish a laptop GPU budget. |

The reference art run was [job 124690329035](https://github.com/edsaperia/witch/actions/runs/41253034424/job/124690329035).
Its 42m34s elapsed time and the 28,636ms/7ms unit measurements have different
coverage and execution conditions. Do not subtract them or publish an aggregate
speedup. Successful per-species after timings were not retained in that run;
record that gap instead of reconstructing numbers. Update the project evidence
when complete comparable after runs finish, including cache behavior and total
worker cost.

## CI waits must not become coding holds

For every waiting builder, identify the exact blocked action, dependency owner,
wake condition and independent authorized work that remains. Code review,
diagnostic preparation and isolated fixes can often continue while a release,
browser allocation or long check waits. Preserve actual file ownership and
product fences; this is not permission to start unassigned work or launch another
heavy process. A finished builder is available, not obliged to invent more work.

Witch's November 1 audit of 13 owner chats found code review and source work
waiting unnecessarily. Resumed review produced a healing-priority regression
fix ([PR 1540](https://github.com/edsaperia/witch/pull/1540)), a blocked-store
backpressure fix ([PR 1559](https://github.com/edsaperia/witch/pull/1559)), a
readback lifecycle fix ([PR 1586](https://github.com/edsaperia/witch/pull/1586))
and a guard against incomplete proof ([PR 1587](https://github.com/edsaperia/witch/pull/1587)).
These are source findings, not claims of deployment or completed hardware proof.
The [audit report](https://github.com/edsaperia/witch/pull/1476#issuecomment-6552192040)
records the dispositions.

Keep the routing record outside chat memory. Verify actual pickup through a
PLAN, REPORT or concrete work evidence: accepted delivery is not receipt. Read
the latest full instruction before waking an owner, preserve comment versions,
and avoid repeatedly sending an unchanged accepted message. Quiet central
monitoring can replace perpetual idle builder polls when the project's owner has
chosen it; meaningful changes must still wake the exact owner.

## Adoption and follow-through

The threshold/reset rule is Ed's chosen policy; this guide and its shared-rule
link remain a pull request until merged. Witch's existing coordinator monitor
and durable project state are updated separately. This document does not install
monitoring into other projects or reroute their builders automatically.

Prediction: the next observed armed threshold crossing will get a named review
without an owner reminder, and every reset will cite a correction and a comparable
completed below-threshold run. Check on 2026-11-08 against project review records;
report no qualifying observation if none occurred. Also compare critical-path
elapsed time, queue time, worker-minutes and required coverage before and after
each optimization. An unmeasured change remains unverified.

Suggested friction-log entry for the dev-ops coordinator: 2026-11-01, Witch CI
reached 40–54 minutes and source work waited behind measurement/release gates;
Ed prompted the efficiency and all-builders review. Exact aggregate lost time
is unknown. Record this guide, its prediction and check date in the shared change
ledger when adopted; builders do not edit that coordinator-owned ledger here.
