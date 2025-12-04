# Script to install browser extensions for Zen (Firefox-based)
# Assumes Zen is installed; runs after install-software.ps1

Write-Host "Installing browser extensions..." -ForegroundColor Yellow

# Find Zen profile path (default)
$zenProfilesPath = "$env:APPDATA\Zen\profiles.ini"
if (Test-Path $zenProfilesPath) {
    # Parse default profile
    $profileIni = Get-Content $zenProfilesPath
    $defaultProfile = ($profileIni | Select-String "Default=").Line -replace "Default=", ""
    $extensionsPath = "$env:APPDATA\Zen\$defaultProfile\extensions"

    # Create extensions dir if needed
    if (-not (Test-Path $extensionsPath)) { New-Item -Path $extensionsPath -ItemType Directory }

    # uBlock Origin (download XPI)
    $ublockUrl = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
    $ublockPath = "$extensionsPath\uBlock0@raymondhill.net.xpi"
    Invoke-WebRequest -Uri $ublockUrl -OutFile $ublockPath
    Write-Host "Installed uBlock Origin"

    # AD Download Manager Firefox extension (placeholder; replace with actual)
    $adExtUrl = "https://example.com/ad-dm-firefox.xpi"  # TODO: Find real URL (e.g., for FDM extension)
    $adExtPath = "$extensionsPath\ad-dm@extension.id.xpi"  # Replace ID
    Invoke-WebRequest -Uri $adExtUrl -OutFile $adExtPath
    Write-Host "Installed AD Download Manager extension"
} else {
    Write-Host "Zen Browser profile not found. Install Zen first." -ForegroundColor Red
}

Write-Host "Extensions installed. Restart Zen Browser to activate." -ForegroundColor Green