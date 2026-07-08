$ErrorActionPreference = "Stop"

$InstallDir = "$env:USERPROFILE\.terminal-shortcuts"
$BinDir = "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps"

Write-Host ""
Write-Host "============================================="
Write-Host " Removing Terminal Shortcuts"
Write-Host "============================================="
Write-Host ""

# --------------------------------------------------
# Check installation
# --------------------------------------------------

if (-not (Test-Path $InstallDir)) {

    Write-Host "Terminal Shortcuts is not installed."
    exit 0

}

# --------------------------------------------------
# Remove installed commands
# --------------------------------------------------

$Commands = Join-Path $InstallDir "commands\windows"

if (Test-Path $Commands) {

    Get-ChildItem $Commands -File | ForEach-Object {

        $Wrapper = Join-Path $BinDir ($_.BaseName + ".cmd")

        if (Test-Path $Wrapper) {

            Remove-Item $Wrapper -Force

        }

    }

}

# --------------------------------------------------
# Remove installation directory
# --------------------------------------------------

Remove-Item $InstallDir -Recurse -Force

# --------------------------------------------------
# Finish
# --------------------------------------------------

Write-Host ""
Write-Host "============================================="
Write-Host ""
Write-Host "Terminal Shortcuts has been removed successfully."
Write-Host ""
Write-Host "Removed:"
Write-Host ""
Write-Host " • Installed commands"
Write-Host " • Installation directory"
Write-Host ""
Write-Host "Installation directory:"
Write-Host " $InstallDir"
Write-Host ""
Write-Host "============================================="
