Windows 11 LTSC – Ultimate Privacy & Productivity Setup

One-click (or one-script) post-install setup for Windows 11 IoT Enterprise LTSC

This repository contains fully automated PowerShell scripts that turn a fresh Windows 11 LTSC install into a telemetry-free, activated, and ready-to-use daily driver with all my favorite tools.
What this does

    Completely disables Microsoft telemetry, diagnostics, and data collection
    Activates Windows 11 LTSC using the open-source Massgrave (MAS) HWID method
    Installs & configures Winget (if missing)
    Installs the following software (silently where possible):
        Zen Browser (privacy-focused Firefox fork)
        uBlock Origin (automatically installed into Zen)
        FilePilot
        AD Download Manager + its Firefox/Zen extension
        PowerToys
        Discord
        Windhawk
        Sublime Text 4
        Windows Terminal
    All scripts are modular, well-commented, and safe to re-run

Important Warnings

    These scripts disable telemetry aggressively. Some Windows features (e.g., certain Store apps, Windows Update diagnostics) may stop working.
    The activation method uses Microsoft Activation Scripts (MAS) from https://massgrave.dev – open-source and widely used, but you are responsible for using it only on legitimately licensed systems.
    Run everything as Administrator.
    Test on a virtual machine first if you’re unsure.
    I am not responsible for any issues caused by these modifications.

Repository Structure
text

windows-11-ltsc-setup/
├── main.ps1                    ← Run this one (orchestrates everything)
├── disable-telemetry.ps1       ← Blocks telemetry at service, task, registry & hosts level
├── activate-windows.ps1        ← Downloads & runs latest MAS (HWID activation)
├── install-software.ps1        ← Winget + direct installers for everything
├── extensions/
│   └── install-extensions.ps1  ← Installs uBlock Origin + AD Download Manager extension into Zen
└── README.md                   ← You’re reading it

How to Use

    Download or clone this repository
    PowerShell

git clone https://github.com/yourusername/windows-11-ltsc-setup.git

Open PowerShell as Administrator
Navigate to the folder
PowerShell

cd path\to\windows-11-ltsc-setup

Unblock the scripts (required on fresh systems)
PowerShell

Get-ChildItem -Recurse *.ps1 | Unblock-File

Run the main script
PowerShell

    .\main.ps1

    Or right-click → “Run with PowerShell” (as Admin) on main.ps1
    Grab a coffee – everything installs silently. Reboot when it finishes.

Optional: Run only specific parts
PowerShell

.\disable-telemetry.ps1     # Just disable telemetry
.\activate-windows.ps1      # Just activate
.\install-software.ps1      # Just install apps

Credits & Sources

    Telemetry blocking methods: Community knowledge + Chris Titus Tech / BlackViper
    Activation: https://massgrave.dev (Microsoft Activation Scripts)
    Zen Browser: https://zen-browser.app
    Windhawk: https://windhawk.net
    All other software from their official sources

License

MIT License – feel free to fork, improve, and share.

Enjoy your clean, fast, and private Windows 11 LTSC setup!