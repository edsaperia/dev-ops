# Ed's Windows laptop — traps

For agents running on Ed's own machine (Windows 11, PowerShell 5.1, Git Bash). Cloud sessions and CI runners are Linux and can ignore this file.

- **Never rewrite source files with `Get-Content`/`Set-Content`**: UTF-8 read as ANSI turns non-ASCII into mojibake, and `-Encoding utf8` adds a BOM. Use an edit tool.
- **`sed -i` and `perl -pi` in Git Bash strip CRs from the whole file.** In a CRLF repo a one-line substitution rewrites every line. Use an edit tool; `git diff --ignore-cr-at-eol --stat` against plain `--stat` tells a real change from line-ending churn.
- **Multi-line commit messages via PowerShell here-strings get mangled** (lines starting `--` parse as options) — use `git commit -F <file>` or Git Bash.
- **`gh` with quoted or multi-line arguments**: use Git Bash, not PowerShell.
- **Memory is 16 GB and runs short** under several headless browsers at once: run one browser-heavy process at a time, and prefer a cloud session or CI for browser walks.
