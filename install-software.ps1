# Script to setup Winget and install specified software
# Requires Admin for some installs

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Run as Administrator!" -ForegroundColor Red
    exit
}

Write-Host "Setting up Winget..." -ForegroundColor Yellow

# Check if Winget is installed; install if not (via Microsoft Store dependencies)
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Winget..."
    $appInstallerUrl = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    $vclibsUrl = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
    Invoke-WebRequest -Uri $vclibsUrl -OutFile "$env:TEMP\VCLibs.appx"
    Invoke-WebRequest -Uri $appInstallerUrl -OutFile "$env:TEMP\AppInstaller.msixbundle"
    Add-AppxPackage "$env:TEMP\VCLibs.appx"
    Add-AppxPackage "$env:TEMP\AppInstaller.msixbundle"
    Remove-Item "$env:TEMP\VCLibs.appx", "$env:TEMP\AppInstaller.msixbundle" -Force
    # Refresh PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# Update Winget sources
winget source update

# Install software via Winget where possible
$wingetApps = @{
    "PowerToys" = "Microsoft.PowerToys"
    "Discord" = "Discord.Discord"
    "Windhawk" = "ramensoftware.windhawk"  # Assuming this is the ID; verify
    "SublimeText" = "SublimeHQ.SublimeText"
    "WindowsTerminal" = "Microsoft.WindowsTerminal"
}

foreach ($app in $wingetApps.Keys) {
    Write-Host "Installing $app..."
    winget install --id $wingetApps[$app] --silent --accept-package-agreements --accept-source-agreements
}

# Direct downloads for non-Winget apps
# Zen Browser (Firefox-based, download from GitHub)
Write-Host "Installing Zen Browser..."
$zenUrl = "https://github.com/zen-browser/desktop/releases/latest/download/zen.installer.exe"  # Adjust for latest
$zenPath = "$env:TEMP\zen-installer.exe"
Invoke-WebRequest -Uri $zenUrl -OutFile $zenPath
Start-Process $zenPath -ArgumentList "/S" -Wait  # Silent install
Remove-Item $zenPath -Force

# FilePilot (assuming it's a tool; placeholder – replace with actual URL if known)
Write-Host "Installing FilePilot..."
$filePilotUrl = "https://example.com/filepilot-setup.exe"  # TODO: Replace with real URL
$filePilotPath = "$env:TEMP\filepilot.exe"
Invoke-WebRequest -Uri $filePilotUrl -OutFile $filePilotPath
Start-Process $filePilotPath -ArgumentList "/S" -Wait
Remove-Item $filePilotPath -Force

# AD Download Manager (assuming Aria2 or similar; placeholder – e.g., Free Download Manager)
Write-Host "Installing AD Download Manager..."
$adDmUrl = "https://example.com/ad-dm-setup.exe"  # TODO: Replace (e.g., FDM: https://www.freedownloadmanager.org/download.htm)
$adDmPath = "$env:TEMP\ad-dm.exe"
Invoke-WebRequest -Uri $adDmUrl -OutFile $adDmPath
Start-Process $adDmPath -ArgumentList "/S" -Wait
Remove-Item $adDmPath -Force

Write-Host "Software installation complete." -ForegroundColor Green