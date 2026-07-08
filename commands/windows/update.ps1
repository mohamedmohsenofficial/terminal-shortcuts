Set-ExecutionPolicy Bypass -Scope Process -Force
$E = [char]27
$Red = "$E[1;31m"; $Green = "$E[1;32m"; $Yellow = "$E[1;33m"; $Cyan = "$E[1;36m"; $White = "$E[1;37m"; $Rst = "$E[0m"

$PROTECTED_REGEX = "(?i)(Microsoft|Windows|System|Code|vscode|codium|docker|containers|podman|wsl|ubuntu|kali|debian|intel|amd|nvidia|google)"

Write-Host "$Cyan========================================$Rst`n`n"

Write-Host "  🚀 Windows Master Updater & Cleaner`n`n"

Write-Host "$Cyan========================================$Rst`n`n"

Write-Host "  $Yellow[1/3]$Rst 🔵 $Cyan Scanning $Rst for OS and App updates...`n`n"

If (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Install-Module -Name PSWindowsUpdate -Force -SkipPublisherCheck -ErrorAction SilentlyContinue
}

$WinUpdates = Get-WindowsUpdate -ErrorAction SilentlyContinue
if ($WinUpdates) { $WinUpdates | Format-Table KB, Title, Size -AutoSize } else { Write-Host "  ✅ OS is up to date.`n`n" }

$AppUpdates = winget upgrade
Write-Host "$AppUpdates`n`n"

Write-Host "$Cyan========================================$Rst`n`n"

Write-Host "  1. ✅ 🟢 $Green Approve $Rst & 🟢 $Green Update $Rst Everything`n`n"

Write-Host "  0. ❌ ⚪ $White Skip $Rst / $Red Cancel $Rst Updates`n`n"

$choice = Read-Host "👉 Choice (0-1)"
Write-Host "`n`n"

if ($choice -eq "1") {
    Write-Host "  ⏳ Executing 🟢 $Green Updates $Rst...`n`n"
    winget upgrade --all --include-unknown
    if ($WinUpdates) { Install-WindowsUpdate -AcceptAll -IgnoreReboot }
    Write-Host "`n`n  ✅ Updates completed!`n`n"
} else {
    Write-Host "  ⏭️ ⚪ $White Pending $Rst updates skipped.`n`n"
}

Write-Host "  $Yellow[2/3]$Rst 🔵 $Cyan Scanning $Rst 🔴 $Red Garbage $Rst & Orphans...`n`n"

$TARGETS = @("$env:TEMP\*", "C:\Windows\Temp\*", "C:\Windows\SoftwareDistribution\Download\*")

$appDataPaths = @($env:APPDATA, $env:LOCALAPPDATA)
foreach ($baseDir in $appDataPaths) {
    $folders = Get-ChildItem -Path $baseDir -Directory -ErrorAction SilentlyContinue
    foreach ($folder in $folders) {
        if ($folder.Name -match $PROTECTED_REGEX) { continue }
        $progPath1 = Join-Path "C:\Program Files" $folder.Name
        $progPath2 = Join-Path "C:\Program Files (x86)" $folder.Name
        if (-not (Test-Path $progPath1) -and -not (Test-Path $progPath2)) {
            $TARGETS += $folder.FullName
        }
    }
}

while ($TARGETS.Count -gt 0) {
    $sizeBytes = 0
    Write-Host "🔍 Found disposable caches and orphans:`n`n"
    foreach ($p in $TARGETS) {
        $parentPath = Split-Path $p
        $leafPath = Split-Path $p -Leaf
        if (Test-Path $parentPath) {
            $items = Get-ChildItem -Path $parentPath -Filter $leafPath -Recurse -Force -ErrorAction SilentlyContinue
            if ($items) { 
                $sum = ($items | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum 
                $sizeBytes += $sum
                $folderMB = [math]::Round($sum / 1MB, 2)
                Write-Host " -> $parentPath ($folderMB MB)`n`n"
            }
        }
    }

    $sizeMB = [math]::Round($sizeBytes / 1MB, 2)
    if ($sizeMB -eq 0) { Write-Host "  ✅ [OK] Clean.`n`n" -ForegroundColor Green; break }

    Write-Host "Total Wasted Space: $sizeMB MB`n`n" -ForegroundColor Red
    
    Write-Host "  1. ✅ 🟢 $Green Approve $Rst & 🔴 $Red Delete $Rst All`n`n"
    
    Write-Host "  2. ➕ Add 🟡 $Yellow Exception $Rst (Skip a folder)`n`n"
    
    Write-Host "  0. ❌ ⚪ $White Skip $Rst Cleanup`n`n"
    
    $choice2 = Read-Host "👉 Choice (0-2)"
    Write-Host "`n`n"

    if ($choice2 -eq "1") {
        foreach ($p in $TARGETS) { Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue }
        Write-Host "  ✅ [OK] 🔴 $Red Garbage $Rst cleared.`n`n"
        break
    } elseif ($choice2 -eq "2") {
        $excText = Read-Host "✏️ Enter text to exclude"
        Write-Host "`n`n"
        $newTargets = @()
        foreach ($t in $TARGETS) { if ($t -notmatch $excText) { $newTargets += $t } }
        $TARGETS = $newTargets
        Write-Host "  ✅ 🟡 $Yellow Exception $Rst applied!`n`n"
    } elseif ($choice2 -eq "0") { 
        Write-Host "  ⏭️ [SKIPPED]`n`n"
        break 
    }
}

Write-Host "  $Yellow[3/3]$Rst ⚙️ Executing System Optimizations...`n`n"
If (Get-Command docker -ErrorAction SilentlyContinue) {
    docker builder prune -a -f | Out-Null
    docker image prune -f | Out-Null
}
Write-Host "  ✅ System optimizations applied!`n`n"

Write-Host "$Cyan========================================$Rst`n`n"
