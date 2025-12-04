# Main script to orchestrate Windows 11 LTSC setup
# Run as Administrator

# Error handling: Stop on errors
$ErrorActionPreference = "Stop"

try {
    Write-Host "Starting Windows 11 LTSC setup..." -ForegroundColor Green

    # Step 1: Disable Telemetry
    Write-Host "Disabling telemetry..."
    .\disable-telemetry.ps1

    # Step 2: Activate Windows using Massgrave (MAS)
    Write-Host "Activating Windows..."
    .\activate-windows.ps1

    # Step 3: Install software and setup
    Write-Host "Setting up Winget and installing software..."
    .\install-software.ps1

    # Step 4: Install browser extensions
    Write-Host "Installing browser extensions..."
    .\extensions\install-extensions.ps1

    Write-Host "Setup complete! Reboot recommended." -ForegroundColor Green
} catch {
    Write-Host "Error occurred: $_" -ForegroundColor Red
}