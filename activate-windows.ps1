# Script to run Massgrave (Microsoft Activation Scripts) for Windows activation
# Source: https://massgrave.dev (open-source, use only for legitimate activations)

# Requires Admin and internet
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Run as Administrator!" -ForegroundColor Red
    exit
}

Write-Host "Downloading and running MAS..." -ForegroundColor Yellow

# Download MAS script (latest version)
$masUrl = "https://massgrave.dev/get"
$masPath = "$env:TEMP\MAS.cmd"
Invoke-WebRequest -Uri $masUrl -OutFile $masPath

# Run MAS with HWID activation (common for LTSC)
& $masPath /HWID  # Change to /KMS or other if needed

# Clean up
Remove-Item $masPath -Force

Write-Host "Activation complete (check with slmgr /xpr)." -ForegroundColor Green