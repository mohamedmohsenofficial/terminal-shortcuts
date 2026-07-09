$ErrorActionPreference = "Stop"

$Repo = "https://github.com/mohamedmohsenofficial/terminal-shortcuts.git"

$InstallDir = "$env:USERPROFILE\.terminal-shortcuts"

$BinDir = "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps"

Write-Host ""
Write-Host "============================================="
Write-Host " Installing Terminal Shortcuts"
Write-Host "============================================="
Write-Host ""

# --------------------------------------------------
# Check Git
# --------------------------------------------------

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {

    Write-Host "Git is not installed."
    Write-Host "Install Git first:"
    Write-Host "https://git-scm.com/download/win"

    exit 1

}

# --------------------------------------------------
# Remove previous installation
# --------------------------------------------------

if (Test-Path $InstallDir) {

    Remove-Item $InstallDir -Recurse -Force

}

# --------------------------------------------------
# Clone Repository
# --------------------------------------------------

git clone $Repo $InstallDir

# --------------------------------------------------
# Install Commands
# --------------------------------------------------

$Commands = Join-Path $InstallDir "commands\windows"

Get-ChildItem $Commands -File | ForEach-Object {

    $Name = $_.BaseName

    @"
@echo off
powershell -ExecutionPolicy Bypass -File "$($_.FullName)" %*
"@ | Set-Content "$BinDir\$Name.cmd"

}

@"
@echo off
powershell -ExecutionPolicy Bypass -File "$InstallDir\install\update-terminal-shortcuts.ps1" %*
"@ | Set-Content "$BinDir\update-terminal-shortcuts.cmd"

Copy-Item `
"$InstallDir\install\update-terminal-shortcuts.ps1" `
"$BinDir\update-terminal-shortcuts.ps1" `
-Force

# --------------------------------------------------
# Finish
# --------------------------------------------------

Write-Host ""
Write-Host "============================================="
Write-Host ""
Write-Host "Terminal Shortcuts installed successfully."
Write-Host ""
Write-Host "Installed Commands:"
Write-Host ""

Get-ChildItem $Commands | ForEach-Object {

    Write-Host " - $($_.BaseName)"

}

Write-Host ""
Write-Host "Location:"
Write-Host "$InstallDir"
Write-Host ""
Write-Host "You can now use commands directly from Command Prompt or PowerShell."
Write-Host ""
Write-Host "============================================="
