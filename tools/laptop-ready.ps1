<#
laptop-ready.ps1 — is the owner's Windows laptop free for an unattended run (a headless browser proof, a CPU job)?

Read-only and quick (typically 2–5 s; the first run in a session compiles a small idle-time reader): it never opens, attaches to, closes or reads another program, and starts nothing.
Prints one JSON line and one verdict line; exit 0 = READY, 1 = NOT READY, 2 = the check itself failed.

  powershell -NoProfile -ExecutionPolicy Bypass -File tools\laptop-ready.ps1
  powershell -NoProfile -ExecutionPolicy Bypass -File tools\laptop-ready.ps1 -MinIdleMinutes 10 -CpuMax 60
  powershell -NoProfile -ExecutionPolicy Bypass -File tools\laptop-ready.ps1 -SelfTest

READY needs the owner idle for at least -MinIdleMinutes (last keyboard/mouse input; default 2). Open browsers and CPU
are reported, and block only when asked (-BlockOnBrowser, -CpuMax): Ed, 2026-11-01, relaxed the gates after strict
ones stopped runs he wasn't disturbing.
Run it in the owner's own desktop session: idle time read from a service or another session is meaningless.
#>
param(
  [double]$MinIdleMinutes = 2,
  [switch]$BlockOnBrowser,
  [int]$CpuMax = 100,
  [string[]]$Browsers = @('chrome', 'msedge', 'firefox', 'brave', 'opera', 'vivaldi'),
  [switch]$SelfTest
)
$ErrorActionPreference = 'Stop'
$started = [Diagnostics.Stopwatch]::StartNew()

function Get-LaptopVerdict([double]$IdleMs, [int]$BrowserCount, [int]$VisibleBrowsers, [double]$CpuPercent, [double]$MinIdleMinutes, [int]$CpuMax, [bool]$BlockBrowsers = $true) {
  $reasons = @()
  if ($IdleMs -lt 0) { $reasons += 'idle time unavailable (not the owner''s desktop session?)' }
  elseif ($IdleMs -lt $MinIdleMinutes * 60000) { $reasons += ('owner active {0:N1} min ago (needs {1})' -f ($IdleMs / 60000), $MinIdleMinutes) }
  if ($BlockBrowsers -and $BrowserCount -gt 0) { $reasons += ('{0} browser process(es) open, {1} with a window' -f $BrowserCount, $VisibleBrowsers) }
  if ($CpuPercent -gt $CpuMax) { $reasons += ('CPU {0:N0}% (max {1})' -f $CpuPercent, $CpuMax) }
  [pscustomobject]@{ ready = ($reasons.Count -eq 0); reasons = $reasons }
}

if ($SelfTest) {
  $cases = @(
    @{ args = @(600000, 0, 0, 10, 5, 70); ready = $true },
    @{ args = @(60000, 0, 0, 10, 5, 70); ready = $false },
    @{ args = @(600000, 22, 1, 10, 5, 70); ready = $false },
    @{ args = @(600000, 0, 0, 95, 5, 70); ready = $false },
    @{ args = @(-1, 0, 0, 10, 5, 70); ready = $false },
    @{ args = @(400000, 0, 0, 10, 10, 70); ready = $false },
    @{ args = @(600000, 22, 1, 10, 5, 70, $false); ready = $true }
  )
  $failed = 0
  foreach ($c in $cases) {
    $a = $c.args; $v = Get-LaptopVerdict @a
    if ($v.ready -ne $c.ready) { $failed++; Write-Output ("FAIL {0} -> {1}" -f ($c.args -join ','), $v.ready) }
  }
  Write-Output ("self-test: {0} of {1} passed" -f ($cases.Count - $failed), $cases.Count)
  exit ([int]($failed -gt 0))
}

try {
  if (-not ('LaptopReadyIdle' -as [type])) {
    Add-Type -TypeDefinition @'
using System; using System.Runtime.InteropServices;
public static class LaptopReadyIdle {
  [StructLayout(LayoutKind.Sequential)] struct LASTINPUTINFO { public uint cbSize; public uint dwTime; }
  [DllImport("user32.dll")] static extern bool GetLastInputInfo(ref LASTINPUTINFO info);
  public static long IdleMs() {
    var info = new LASTINPUTINFO(); info.cbSize = (uint)Marshal.SizeOf(info);
    if (!GetLastInputInfo(ref info)) return -1;
    return (long)unchecked((uint)Environment.TickCount - info.dwTime);
  }
}
'@
  }
  $idleMs = [LaptopReadyIdle]::IdleMs()

  $open = @(Get-Process -Name $Browsers -ErrorAction SilentlyContinue)
  $visible = @($open | Where-Object { $_.MainWindowHandle -ne [IntPtr]::Zero }).Count

  # CPU over one second: total from the processor counter (locale-independent CIM), top processes from their CPU-time deltas.
  $before = @{}; foreach ($p in Get-Process) { try { $before[$p.Id] = $p.TotalProcessorTime.TotalMilliseconds } catch {} }
  $t0 = [DateTime]::UtcNow
  Start-Sleep -Milliseconds 1000
  $cpu = [double](Get-CimInstance -ClassName Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
  $elapsed = ([DateTime]::UtcNow - $t0).TotalMilliseconds * [Environment]::ProcessorCount
  $top = @(foreach ($p in Get-Process) {
      try { if ($before.ContainsKey($p.Id)) { [pscustomobject]@{ name = $p.ProcessName; pct = [math]::Round(100 * ($p.TotalProcessorTime.TotalMilliseconds - $before[$p.Id]) / $elapsed, 1) } } } catch {}
    }) | Where-Object { $_.pct -gt 0 } | Sort-Object pct -Descending | Select-Object -First 3

  $v = Get-LaptopVerdict $idleMs $open.Count $visible $cpu $MinIdleMinutes $CpuMax ([bool]$BlockOnBrowser)
  $report = [ordered]@{
    at = [DateTime]::UtcNow.ToString('o'); host = $env:COMPUTERNAME
    idleMs = $idleMs; browsers = $open.Count; visibleBrowsers = $visible; cpuPercent = $cpu; topCpu = @($top)
    minIdleMinutes = $MinIdleMinutes; cpuMax = $CpuMax; ready = $v.ready; reasons = @($v.reasons); elapsedMs = $started.ElapsedMilliseconds
  }
  Write-Output ($report | ConvertTo-Json -Compress -Depth 4)
  if ($v.ready) { Write-Output 'READY' } else { Write-Output ('NOT READY: ' + ($v.reasons -join '; ')) }
  exit ([int](-not $v.ready))
} catch {
  Write-Output ('CHECK FAILED: ' + $_.Exception.Message)
  exit 2
}
