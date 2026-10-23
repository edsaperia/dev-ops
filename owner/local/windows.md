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
