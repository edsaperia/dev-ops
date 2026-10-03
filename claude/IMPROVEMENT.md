# The daily improvement review

How the dev-ops coordinator keeps looking for ways to make the work faster and better, across every project (Ed, 2026-10-02: *regularly think about how you can improve efficiency and quality based on the work we are doing*). The record is [`IMPROVEMENT-LOG.md`](IMPROVEMENT-LOG.md).

Three parts, each needed: the same **numbers** every day, so a trend shows; a **friction log** written the moment something goes wrong, so nothing waits on memory; and every adopted change carrying a **prediction and a date to check it**, so each change is either confirmed or undone, never just left in place.

## 1. The friction log: write it as it happens

Whenever something costs time or quality, the dev-ops coordinator appends one line to the log's *Friction* table that same turn. Examples: a wait nobody could see, a re-run, a red on `main`, a mis-shaped item, a refusal, Ed correcting us, or a bug Ed found that a check should have caught. Each line gives the date, what happened, the cost (minutes, or what Ed had to do) and the cause if it is known. Good surprises go in too, such as a check that caught a real bug, so the review sees what is worth keeping. Another coordinator's friction goes in when dev-ops learns of it.

## 2. The daily numbers

Measured for the 24 hours to the review, per project with work that day (draft: GitHub plus the page), and written as one row of the log's *Numbers* table:

| Number | How | Why |
|---|---|---|
| PRs merged | merged PRs in the window | throughput |
| Open → merged, median and worst | PR `created_at` → `merged_at` | lead time; small PRs should be well under 2 h |
| …split in three | open → its Merge question `asked`, `asked` → `answer.at`, `answer.at` → `merged_at` (medians) | which stage holds the hours: building and review, Ed, or the merge (2026-10-03: 4.3 h / 10 min / 4 min) |
| Merge-main commits | commits titled *Merge main …* / *Merge remote-tracking branch 'origin/main' …* on PR branches | re-run waste |
| Deploy wait on `main` | for each push run on `main`: the `ci` job's `started_at` − the run's `created_at` | machine queue |
| Reds on `main` | push runs on `main` (CI and Sprint) not `success` | escaped defects |
| Ed's answers, median and over 90 min | page items: `answer.at` − `asked` | Ed's waits; slow ones are a cause, not a fault |
| Items asked of Ed, by kind | page items asked in the window | how much of Ed's attention the work takes |
| Mis-shaped or refused writes | items without status, unknown kind, guard refusals | page quality |
| In-flight items gone overdue | `inflight` past `expectBy` without an update | silent waits |
| Bugs Ed found | issues or notes from Ed reporting something broken | quality as Ed sees it |

A subagent (Opus) may gather the numbers; the coordinator checks them before they are written.

## 3. The review, daily

1. **Check predictions due.** Each row of the *Changes* table whose check date has come: compare the numbers with the prediction and write the result. *Holds*: keep it. *Missed*: find out why and either fix it or propose undoing it. A change is never left unexamined.
2. **Write today's numbers** and compare them with the last few rows. Close or re-promise any of dev-ops's own in-flight items whose work has moved on.
3. **Read the friction log since the last review.** Group it by cause; a cause seen twice is a candidate.
4. **Choose at most two improvements.** Rank by time or quality saved, against what each costs and risks. Prefer removing a step over adding one, and a measurement over a guess. Never take a check away unless a number shows it costs more than it catches.
5. **Act.**
   - A change within dev-ops's own rules, or one Ed has already chosen, is made straight away.
   - Anything else goes to Ed as a question on his page, one change per question, with its prediction and check date in the context.
   - Every change, adopted or proposed, gets a row in *Changes*.
6. **Sweep finished builders.** Archive any builder session whose PRs are all merged or closed and that has been idle a day (CONVENTIONS.md, *A finished builder is archived*), and count them in the report.
7. **Report** with one OK-only update on Ed's page: the headline numbers, what changed, what was checked, and the questions raised. When nothing is worth his attention, the update says so in one line.

**Monday's review also looks back a week**: it reads the trend across the week's rows and the week's friction as a whole, and trims anything in the method that has not earned its keep.

## Cost

The review runs once a day as a scheduled Routine that wakes the dev-ops coordinator, at 07:57 London time so the report is waiting when Ed starts. Ed asked for it, which makes it the one exception to *a coordinator schedules no check-ins of its own*. Expect one turn of the coordinator and one subagent a day; quiet days cost less. The Routine is bound to the dev-ops coordinator's session: a replacement session re-creates it (`create_trigger`, the prompt in the log's header) and deletes the old one.
