Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  🚀 Windows Intelligent System Cleaner" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 5. Strict Protection (Diplomatic Immunity)
$PROTECTED_REGEX = "(?i)(Microsoft|Windows|System|Code|vscode|codium|docker|containers|podman|wsl|ubuntu|kali|debian|intel|amd|nvidia|google)"

# 1. OS Roots & Deep Cache
Write-Host "`n[1/3] Scanning Temp & OS Cache...`n" -ForegroundColor Yellow

$CACHE_TARGETS = @("$env:TEMP\*", "C:\Windows\Temp\*", "C:\Windows\SoftwareDistribution\Download\*")

while ($CACHE_TARGETS.Count -gt 0) {
    $sizeBytes = 0
    Write-Host "🔍 Found disposable cache directories:`n"
    foreach ($p in $CACHE_TARGETS) {
        $parentPath = Split-Path $p
        $leafPath = Split-Path $p -Leaf
        if (Test-Path $parentPath) {
            $items = Get-ChildItem -Path $parentPath -Filter $leafPath -Recurse -Force -ErrorAction SilentlyContinue
            if ($items) { 
                $sum = ($items | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum 
                $sizeBytes += $sum
                $folderMB = [math]::Round($sum / 1MB, 2)
                Write-Host " -> $parentPath ($folderMB MB)`n"
            }
        }
    }

    $sizeMB = [math]::Round($sizeBytes / 1MB, 2)
    if ($sizeMB -eq 0) { 
        Write-Host "[OK] Cache is clean.`n" -ForegroundColor Green
        break 
    }

    Write-Host "Total Cache Size: $sizeMB MB`n" -ForegroundColor Green
    
    Write-Host "  1. ✅ " -NoNewline; Write-Host "Approve" -ForegroundColor Green -NoNewline; Write-Host " & " -NoNewline; Write-Host "Delete" -ForegroundColor Red -NoNewline; Write-Host " All`n"
    
    Write-Host "  2. ➕ Add " -NoNewline; Write-Host "Exception" -ForegroundColor Yellow -NoNewline; Write-Host " (Skip a specific folder/keyword)`n"
    
    Write-Host "  0. ❌ " -NoNewline; Write-Host "Skip" -ForegroundColor Gray -NoNewline; Write-Host " / " -NoNewline; Write-Host "Cancel" -ForegroundColor Red -NoNewline; Write-Host " Caches Cleanup`n"
    
    $choice = Read-Host "👉 Choice (0-2)"
    Write-Host ""

    if ($choice -eq "1") {
        foreach ($p in $CACHE_TARGETS) { Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue }
        Write-Host "[OK] Caches cleared.`n" -ForegroundColor Green
        break
    } elseif ($choice -eq "2") {
        $excText = Read-Host "✏️ Enter text to exclude"
        Write-Host ""
        $newTargets = @()
        foreach ($t in $CACHE_TARGETS) { if ($t -notmatch $excText) { $newTargets += $t } }
        $CACHE_TARGETS = $newTargets
        Write-Host "✅ Exception applied!`n" -ForegroundColor Green
    } elseif ($choice -eq "0") { 
        Write-Host "[SKIPPED]`n" -ForegroundColor Gray
        break 
    } else {
        Write-Host "Invalid choice.`n" -ForegroundColor Red
    }
}

# 4. Orphaned Folders Radar (AppData vs Program Files)
Write-Host "[2/3] Scanning for Orphaned Config Folders (AppData)...`n" -ForegroundColor Yellow

$ORPHANS = @()
$appDataPaths = @($env:APPDATA, $env:LOCALAPPDATA)

foreach ($baseDir in $appDataPaths) {
    $folders = Get-ChildItem -Path $baseDir -Directory -ErrorAction SilentlyContinue
    foreach ($folder in $folders) {
        if ($folder.Name -match $PROTECTED_REGEX) { continue }
        
        # Check if corresponding app exists in Program Files
        $progPath1 = Join-Path "C:\Program Files" $folder.Name
        $progPath2 = Join-Path "C:\Program Files (x86)" $folder.Name
        if (-not (Test-Path $progPath1) -and -not (Test-Path $progPath2)) {
            $ORPHANS += $folder.FullName
        }
    }
}

while ($ORPHANS.Count -gt 0) {
    $sizeBytes = 0
    Write-Host "🔍 Found potentially orphaned folders:`n"
    foreach ($p in $ORPHANS) {
        $sum = (Get-ChildItem -Path $p -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
        $sizeBytes += $sum
        $folderMB = [math]::Round($sum / 1MB, 2)
        Write-Host " -> $p ($folderMB MB)`n"
    }

    $sizeMB = [math]::Round($sizeBytes / 1MB, 2)
    if ($sizeMB -eq 0) { break }

    Write-Host "Total Orphan Size: $sizeMB MB`n" -ForegroundColor Red
    
    Write-Host "  1. ✅ " -NoNewline; Write-Host "Approve" -ForegroundColor Green -NoNewline; Write-Host " & " -NoNewline; Write-Host "Delete" -ForegroundColor Red -NoNewline; Write-Host " All`n"
    
    Write-Host "  2. ➕ Add " -NoNewline; Write-Host "Exception" -ForegroundColor Yellow -NoNewline; Write-Host " (Skip a specific folder/keyword)`n"
    
    Write-Host "  0. ❌ " -NoNewline; Write-Host "Skip" -ForegroundColor Gray -NoNewline; Write-Host " / " -NoNewline; Write-Host "Cancel" -ForegroundColor Red -NoNewline; Write-Host " Orphans Cleanup`n"
    
    $choice = Read-Host "👉 Choice (0-2)"
    Write-Host ""

    if ($choice -eq "1") {
        foreach ($p in $ORPHANS) { Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue }
        Write-Host "[OK] Orphaned folders deleted.`n" -ForegroundColor Green
        break
    } elseif ($choice -eq "2") {
        $excText = Read-Host "✏️ Enter text to exclude"
        Write-Host ""
        $newOrphans = @()
        foreach ($t in $ORPHANS) { if ($t -notmatch $excText) { $newOrphans += $t } }
        $ORPHANS = $newOrphans
        Write-Host "✅ Exception applied!`n" -ForegroundColor Green
    } elseif ($choice -eq "0") { 
        Write-Host "[SKIPPED]`n" -ForegroundColor Gray
        break 
    } else {
        Write-Host "Invalid choice.`n" -ForegroundColor Red
    }
}

# 2. Containers Cleanup
Write-Host "[3/3] Cleaning Docker Remnants...`n" -ForegroundColor Yellow

If (Get-Command docker -ErrorAction SilentlyContinue) {
    docker builder prune -a
    docker image prune
    Write-Host "`n"
} else { 
    Write-Host "[SKIPPED] Docker not found.`n" -ForegroundColor Gray 
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ✨ Cleanup Completed Successfully!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
