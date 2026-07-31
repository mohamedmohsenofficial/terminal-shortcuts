# 5. Strict Protection (Diplomatic Immunity)
$PROTECTED_REGEX = "(?i)(Microsoft|Windows|System|Code|vscode|codium|docker|containers|podman|wsl|ubuntu|kali|debian|intel|amd|nvidia|google)"

# Main Application Loop
while ($true) {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Windows Intelligent System Cleaner" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan

    # 1. OS Roots & Deep Cache
    Write-Host "`n[1/3] Scanning Temp & OS Cache...`n" -ForegroundColor Yellow

    $CACHE_TARGETS = @("$env:TEMP\*", "C:\Windows\Temp\*", "C:\Windows\SoftwareDistribution\Download\*")

    while ($CACHE_TARGETS.Count -gt 0) {
        $sizeBytes = 0
        Write-Host "  Found disposable cache directories:`n"
        foreach ($p in $CACHE_TARGETS) {
            $parentPath = Split-Path $p
            $leafPath = Split-Path $p -Leaf
            if (Test-Path $parentPath) {
                $items = Get-ChildItem -Path $parentPath -Filter $leafPath -Recurse -Force -ErrorAction SilentlyContinue
                if ($items) { 
                    $sum = ($items | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum 
                    $sizeBytes += $sum
                    $folderMB = [math]::Round($sum / 1MB, 2)
                    Write-Host "    - " -NoNewline; Write-Host "$folderMB MB" -ForegroundColor Cyan -NoNewline; Write-Host " : $parentPath"
                }
            }
        }

        $sizeMB = [math]::Round($sizeBytes / 1MB, 2)
        if ($sizeMB -eq 0) { 
            Write-Host "`n  [OK] Cache is clean.`n" -ForegroundColor Green
            break 
        }

        Write-Host "`n  Total Cache Size: " -NoNewline; Write-Host "$sizeMB MB`n" -ForegroundColor Green
        
        Write-Host "  1. " -NoNewline; Write-Host "Approve" -ForegroundColor Green -NoNewline; Write-Host " & " -NoNewline; Write-Host "Delete" -ForegroundColor Red -NoNewline; Write-Host " All"
        Write-Host "  2. Add " -NoNewline; Write-Host "Exception" -ForegroundColor Yellow -NoNewline; Write-Host " (Skip a specific folder/keyword)"
        Write-Host "  0. " -NoNewline; Write-Host "Skip" -ForegroundColor White -NoNewline; Write-Host " / " -NoNewline; Write-Host "Cancel" -ForegroundColor Red -NoNewline; Write-Host " Caches Cleanup (Move to next step)`n"
        
        $choice = Read-Host "  Choice (0-2)"
        Write-Host ""

        if ($choice -eq "1") {
            foreach ($p in $CACHE_TARGETS) { Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue }
            Write-Host "  [OK] Caches cleared.`n" -ForegroundColor Green
            break
        } elseif ($choice -eq "2") {
            $excText = Read-Host "  Enter text to exclude"
            Write-Host ""
            $newTargets = @()
            foreach ($t in $CACHE_TARGETS) { if ($t -notmatch $excText) { $newTargets += $t } }
            $CACHE_TARGETS = $newTargets
            Write-Host "  Exception applied!`n" -ForegroundColor Green
        } elseif ($choice -eq "0") { 
            Write-Host "  [SKIPPED] Moving to next step...`n" -ForegroundColor White
            break 
        } else {
            Write-Host "  Invalid choice.`n" -ForegroundColor Red
        }
    }

    # 4. Orphaned Folders Radar (Uninstalled Apps Only)
    Write-Host "[2/3] Scanning for Orphaned Config Folders (Uninstalled Apps Only)...`n" -ForegroundColor Yellow

    $ORPHANS = @()
    $appDataPaths = @($env:APPDATA, $env:LOCALAPPDATA)

    foreach ($baseDir in $appDataPaths) {
        $folders = Get-ChildItem -Path $baseDir -Directory -ErrorAction SilentlyContinue
        foreach ($folder in $folders) {
            if ($folder.Name -match $PROTECTED_REGEX) { continue }
            
            $isInstalled = $false
            
            # 1. Check Program Files
            $progPath1 = Join-Path "C:\Program Files" $folder.Name
            $progPath2 = Join-Path "C:\Program Files (x86)" $folder.Name
            if ((Test-Path $progPath1) -or (Test-Path $progPath2)) { $isInstalled = $true }
            
            # 2. Check Start Menu Shortcuts
            if (-not $isInstalled) {
                $startMenu1 = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs"
                $startMenu2 = Join-Path $env:ProgramData "Microsoft\Windows\Start Menu\Programs"
                $shortcut = Get-ChildItem -Path $startMenu1, $startMenu2 -Filter "*$($folder.Name)*" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
                if ($shortcut) { $isInstalled = $true }
            }
            
            # 3. Check for internal local executables (User-level installations like Discord, VSCode)
            if (-not $isInstalled) {
                $exe = Get-ChildItem -Path $folder.FullName -Filter "*.exe" -Recurse -Depth 2 -ErrorAction SilentlyContinue | Select-Object -First 1
                if ($exe) { $isInstalled = $true }
            }

            if (-not $isInstalled) {
                $ORPHANS += $folder.FullName
            }
        }
    }

    if ($ORPHANS.Count -eq 0) {
        Write-Host "  No orphaned folders found. Your system is clean!`n" -ForegroundColor Green
    }

    while ($ORPHANS.Count -gt 0) {
        $sizeBytes = 0
        Write-Host "  Found potentially orphaned folders (from deleted apps):`n"
        foreach ($p in $ORPHANS) {
            $sum = (Get-ChildItem -Path $p -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
            $sizeBytes += $sum
            $folderMB = [math]::Round($sum / 1MB, 2)
            Write-Host "    - " -NoNewline; Write-Host "$folderMB MB" -ForegroundColor Red -NoNewline; Write-Host " : $p"
        }

        $sizeMB = [math]::Round($sizeBytes / 1MB, 2)

        Write-Host "`n  Total Orphan Size: " -NoNewline; Write-Host "$sizeMB MB`n" -ForegroundColor Red
        
        Write-Host "  1. " -NoNewline; Write-Host "Approve" -ForegroundColor Green -NoNewline; Write-Host " & " -NoNewline; Write-Host "Delete" -ForegroundColor Red -NoNewline; Write-Host " All"
        Write-Host "  2. Add " -NoNewline; Write-Host "Exception" -ForegroundColor Yellow -NoNewline; Write-Host " (Skip a specific folder/keyword)"
        Write-Host "  0. " -NoNewline; Write-Host "Skip" -ForegroundColor White -NoNewline; Write-Host " / " -NoNewline; Write-Host "Cancel" -ForegroundColor Red -NoNewline; Write-Host " Orphans Cleanup (Move to next step)`n"
        
        $choice = Read-Host "  Choice (0-2)"
        Write-Host ""

        if ($choice -eq "1") {
            foreach ($p in $ORPHANS) { Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue }
            Write-Host "  [OK] Orphaned folders deleted.`n" -ForegroundColor Green
            break
        } elseif ($choice -eq "2") {
            $excText = Read-Host "  Enter text to exclude"
            Write-Host ""
            $newOrphans = @()
            foreach ($t in $ORPHANS) { if ($t -notmatch $excText) { $newOrphans += $t } }
            $ORPHANS = $newOrphans
            Write-Host "  Exception applied!`n" -ForegroundColor Green
        } elseif ($choice -eq "0") { 
            Write-Host "  [SKIPPED] Moving to next step...`n" -ForegroundColor White
            break 
        } else {
            Write-Host "  Invalid choice.`n" -ForegroundColor Red
        }
    }

    # 2. Containers Cleanup
    Write-Host "[3/3] Cleaning Docker Remnants...`n" -ForegroundColor Yellow

    If (Get-Command docker -ErrorAction SilentlyContinue) {
        docker builder prune -a -f
        docker image prune -f
        Write-Host "  [OK] Docker remnants cleared.`n" -ForegroundColor Green
    } else { 
        Write-Host "  [SKIPPED] Docker not found.`n" -ForegroundColor White 
    }

    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Cleanup Completed Successfully!" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""

    # Loop Prompt
    Write-Host "What would you like to do next?"
    Write-Host "  1. " -NoNewline; Write-Host "Run Cleanup Again" -ForegroundColor Green
    Write-Host "  0. " -NoNewline; Write-Host "Exit Cleaner`n" -ForegroundColor Red
    
    $loop_choice = Read-Host "  Choice (0-1)"
    Write-Host ""

    if ($loop_choice -eq "0") {
        Write-Host "  Goodbye!`n" -ForegroundColor Green
        break
    }
}
