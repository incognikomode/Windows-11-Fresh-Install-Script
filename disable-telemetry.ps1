# Script to disable telemetry in Windows 11 LTSC
# WARNING: This may break some features like Windows Update diagnostics. Use at your own risk.

# Requires Admin
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Run as Administrator!" -ForegroundColor Red
    exit
}

Write-Host "Disabling telemetry services and tasks..." -ForegroundColor Yellow

# Stop and disable telemetry services
$services = @("DiagTrack", "dmwappushservice", "WMPNetworkSvc")
foreach ($service in $services) {
    if (Get-Service -Name $service -ErrorAction SilentlyContinue) {
        Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
        Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
        Write-Host "Disabled $service"
    }
}

# Disable scheduled tasks
$tasks = @("Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
           "Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
           "Microsoft\Windows\Autochk\Proxy")
foreach ($task in $tasks) {
    Disable-ScheduledTask -TaskName $task -ErrorAction SilentlyContinue
    Write-Host "Disabled task: $task"
}

# Registry edits to block telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f

# Block telemetry hosts (add to hosts file)
$hostsPath = "$env:windir\System32\drivers\etc\hosts"
$telemetryHosts = @("vortex.data.microsoft.com", "telemetry.microsoft.com", "oca.telemetry.microsoft.com")
foreach ($hostEntry in $telemetryHosts) {
    if (-not (Get-Content $hostsPath | Select-String $hostEntry)) {
        Add-Content -Path $hostsPath -Value "0.0.0.0 $hostEntry"
    }
}

Write-Host "Telemetry disabled. Some changes require reboot." -ForegroundColor Green