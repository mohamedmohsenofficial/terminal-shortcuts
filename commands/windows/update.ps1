# --------------------------------------------------
# Update Terminal Shortcuts
# --------------------------------------------------

Write-Host "Running some updates to keep Terminal Shortcuts healthy... 😚`n"

try {
    if (Get-Command update-terminal-shortcuts -ErrorAction SilentlyContinue) {
        update-terminal-shortcuts *> $null
    }
}
catch {
}

# Main Application Loop
while ($true) {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Windows Master Updater & Cleaner"
    Write-Host "========================================`n" -ForegroundColor Cyan

    # 1. Checking Dependencies
    Write-Host "  " -NoNewline; Write-Host "[1/4]" -ForegroundColor Yellow -NoNewline; Write-Host " Checking required update modules...`n"

    If (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
        Write-Host "    - Installing PSWindowsUpdate module (Please wait)...`n" -ForegroundColor Cyan
        Install-Module -Name PSWindowsUpdate -Force -SkipPublisherCheck -ErrorAction SilentlyContinue
    } else {
        Write-Host "    - " -NoNewline; Write-Host "[OK]" -ForegroundColor Green -NoNewline; Write-Host " Update modules are ready.`n"
    }

    # 2. Scanning for Updates
    Write-Host "  " -NoNewline; Write-Host "[2/4]" -ForegroundColor Yellow -NoNewline; Write-Host " Scanning for OS and App updates...`n" -ForegroundColor Cyan

    Write-Host "  Checking Windows OS Updates:`n"
    $WinUpdates = Get-WindowsUpdate -ErrorAction SilentlyContinue
    if ($WinUpdates) {
        foreach ($update in $WinUpdates) {
            Write-Host "    - $($update.KB) | $($update.Title)" -ForegroundColor Cyan
        }
        Write-Host ""
    } else {
        Write-Host "    - " -NoNewline; Write-Host "[OK]" -ForegroundColor Green -NoNewline; Write-Host " Windows OS is up to date.`n`n"
    }

    Write-Host "  Checking App Updates (Microsoft Store & Others):`n"
    $AppUpdates = winget upgrade
    if ($AppUpdates -match "No installed package found matching input criteria" -or $AppUpdates -match "No applicable update found" -or $AppUpdates -match "No available upgrades") {
        Write-Host "    - " -NoNewline; Write-Host "[OK]" -ForegroundColor Green -NoNewline; Write-Host " All apps are up to date.`n`n"
    } else {
        # Formatting Winget output neatly
        $AppUpdates | ForEach-Object {
            if ($_.Trim() -ne "" -and $_ -notmatch "----|Name|Id") {
                Write-Host "    - $($_)" -ForegroundColor Cyan
            }
        }
        Write-Host ""
    }

    # 3. User Confirmation Phase (Updates)
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  1. " -NoNewline; Write-Host "Approve" -ForegroundColor Green -NoNewline; Write-Host " & " -NoNewline; Write-Host "Update" -ForegroundColor Green -NoNewline; Write-Host " Everything (OS + Apps)"
    Write-Host "  0. " -NoNewline; Write-Host "Skip" -ForegroundColor White -NoNewline; Write-Host " / " -NoNewline; Write-Host "Cancel" -ForegroundColor Red -NoNewline; Write-Host " Updates (Move to Cleanup)`n"

    $choice_update = Read-Host "  Choice (0-1)"
    Write-Host "`n"

    if ($choice_update -eq "1") {
        # Executing Updates
        Write-Host "  " -NoNewline; Write-Host "[3/4]" -ForegroundColor Yellow -NoNewline; Write-Host " Executing " -NoNewline; Write-Host "Updates" -ForegroundColor Green -NoNewline; Write-Host "...`n"
        
        Write-Host "  Updating Apps via Winget...`n"
        winget upgrade --all --include-unknown
        Write-Host "`n  " -NoNewline; Write-Host "[OK]" -ForegroundColor Green -NoNewline; Write-Host " Apps updated successfully!`n`n"
        
        if ($WinUpdates) {
            Write-Host "  Updating Windows OS...`n"
            Install-WindowsUpdate -AcceptAll -IgnoreReboot
            Write-Host "`n  " -NoNewline; Write-Host "[OK]" -ForegroundColor Green -NoNewline; Write-Host " OS updated successfully! (A manual reboot may be required later).`n`n"
        }
    } elseif ($choice_update -eq "0") {
        Write-Host "  " -NoNewline; Write-Host "[SKIPPED]" -ForegroundColor White -NoNewline; Write-Host " Pending updates were skipped. Moving to next step...`n`n"
    } else {
        Write-Host "  " -NoNewline; Write-Host "[ERROR]" -ForegroundColor Red -NoNewline; Write-Host " Invalid choice. Moving to next step...`n`n"
    }

    # 4. Cleanup Phase
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  " -NoNewline; Write-Host "[4/4]" -ForegroundColor Yellow -NoNewline; Write-Host " System Cleanup & Cache Rebuild"
    Write-Host "  1. " -NoNewline; Write-Host "Approve" -ForegroundColor Green -NoNewline; Write-Host " & " -NoNewline; Write-Host "Clean" -ForegroundColor Red -NoNewline; Write-Host " Update Garbage & Leftovers"
    Write-Host "  0. " -NoNewline; Write-Host "Skip" -ForegroundColor White -NoNewline; Write-Host " / " -NoNewline; Write-Host "Cancel" -ForegroundColor Red -NoNewline; Write-Host " Cleanup (Move to Report)`n"

    $choice_clean = Read-Host "  Choice (0-1)"
    Write-Host "`n"

    if ($choice_clean -eq "1") {
        Write-Host "  Cleaning Update " -NoNewline; Write-Host "Garbage" -ForegroundColor Red -NoNewline; Write-Host " & Leftovers...`n"
        
        $junkPaths = @("C:\Windows\SoftwareDistribution\Download\*", "C:\Windows\Temp\*", "$env:TEMP\*")
        foreach ($p in $junkPaths) {
            Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue
        }
        
        Write-Host "  " -NoNewline; Write-Host "[OK]" -ForegroundColor Green -NoNewline; Write-Host " Cleanup completed. Wasted space recovered!`n`n"
    } else {
        Write-Host "  " -NoNewline; Write-Host "[SKIPPED]" -ForegroundColor White -NoNewline; Write-Host " Cleanup was skipped. Moving to report...`n`n"
    }

    # 5. Final Report & Loop Prompt
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  " -NoNewline; Write-Host "[OK]" -ForegroundColor Green -NoNewline; Write-Host " Master Operation Cycle Complete!"
    Write-Host "========================================`n" -ForegroundColor Cyan

    Write-Host "What would you like to do next?"
    Write-Host "  1. " -NoNewline; Write-Host "Run Updater & Cleaner Again" -ForegroundColor Green
    Write-Host "  0. " -NoNewline; Write-Host "Exit`n" -ForegroundColor Red
    
    $loop_choice = Read-Host "  Choice (0-1)"
    Write-Host "`n"

    if ($loop_choice -eq "0") {
        Write-Host "  Goodbye!`n" -ForegroundColor Green
        break
    }
}
