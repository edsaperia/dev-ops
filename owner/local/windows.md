# Ed's Windows laptop — traps

For agents running on Ed's own machine (Windows 11, PowerShell 5.1, Git Bash). Cloud sessions and CI runners are Linux and can ignore this file.

- **Never rewrite source files with `Get-Content`/`Set-Content`**: UTF-8 read as ANSI turns non-ASCII into mojibake, and `-Encoding utf8` adds a BOM. Use an edit tool.
- **`sed -i` and `perl -pi` in Git Bash strip CRs from the whole file.** In a CRLF repo a one-line substitution rewrites every line. Use an edit tool; `git diff --ignore-cr-at-eol --stat` against plain `--stat` tells a real change from line-ending churn.
- **Multi-line commit messages via PowerShell here-strings get mangled** (lines starting `--` parse as options) — use `git commit -F <file>` or Git Bash.
- **`gh` with quoted or multi-line arguments**: use Git Bash, not PowerShell.
- **Long briefs and nudges go in a file, never on the command line**: Windows caps a command line at 32,767 characters, which `claude -p "…"` hits (plan-queue, 2026-08-25: ENAMETOOLONG).
- **Auto mode refuses `cd <dir> && …` compounds** whatever the allowlist says: pass the path to the command, or set the working directory, instead.
- **Kill dev servers that earlier sessions left on ports before running walks**, or the walk tests a stale build.
- **A process started detached with `Start-Process` dies with its terminal.**
- **A scheduled task that runs `cmd.exe` under an interactive logon flashes a console window every time it fires**; the task's *hidden* setting does not hide it (plan-queue's `serve` task, every 5 minutes until 2026-10-02).
- **Memory is 16 GB and runs short** under several headless browsers at once: run one browser-heavy process at a time, and prefer a cloud session or CI for browser walks.
- **Before any unattended run on the laptop** (a headless browser proof, a long CPU job), run `powershell -NoProfile -ExecutionPolicy Bypass -File <dev-ops>\tools\laptop-ready.ps1` from Ed's own desktop session, and start only on `READY` (exit 0): Ed idle at least 2 minutes. Open browsers and CPU load are reported, not blocking, and Ed's own windows are never closed, attached to or inspected; use a private temporary profile. **During a run, input or load does not stop it**: record `input at <s>` or `cpu busy` beside the result and label any timing figure *measured under load*. Don't start the next run while Ed is actively using the laptop (Ed, 2026-11-01: strict gates stopped proofs he wasn't disturbing). Coordinators can ask any laptop agent for a quick check by posting `READY CHECK`; it runs the script once and posts the verdict line, `elapsedMs` and the reasons.
- **A stopped or failed laptop run always names which guard tripped**, in its report, every time: one word from *input*, *CPU*, *browser*, *memory*, *timeout*, *crash* or *other* (with a short phrase for *other*). The category is run status, posted publicly; process names, values and window details stay local. A report that says only "safety guard" or "insufficient" is incomplete (Ed, 2026-11-01).
