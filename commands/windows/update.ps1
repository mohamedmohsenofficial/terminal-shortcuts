$E = [char]27
$Red = "$E[1;31m"; $Green = "$E[1;32m"; $Yellow = "$E[1;33m"; $Cyan = "$E[1;36m"; $White = "$E[1;37m"; $Rst = "$E[0m"

Write-Host "$Cyan========================================$Rst`n`n"

Write-Host "  Windows Master Updater & Cleaner`n`n"

Write-Host "$Cyan========================================$Rst`n`n"

# 1. Checking Dependencies
Write-Host "  $Yellow[1/4]$Rst Checking required update modules...`n`n"

If (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Write-Host "  Installing PSWindowsUpdate module (Please wait)...`n`n"
    Install-Module -Name PSWindowsUpdate -Force -SkipPublisherCheck -ErrorAction SilentlyContinue
}

# 2. Scanning for Updates
Write-Host "  $Yellow[2/4]$Rst $Cyan Scanning $Rst for OS and App updates...`n`n"

Write-Host "  Available Windows OS Updates:`n`n"
$WinUpdates = Get-WindowsUpdate -ErrorAction SilentlyContinue
if ($WinUpdates) {
    $WinUpdates | Format-Table KB, Title, Size -AutoSize
} else {
    Write-Host "  [OK] OS is up to date.`n`n"
}

Write-Host "  Available App Updates (Microsoft Store & Others):`n`n"
$AppUpdates = winget upgrade
Write-Host "$AppUpdates`n`n"

# 3. User Confirmation
Write-Host "$Cyan========================================$Rst`n`n"

Write-Host "  1. $Green Approve $Rst & $Green Update $Rst Everything (OS + Apps)`n`n"

Write-Host "  0. $White Skip $Rst / $Red Cancel $Rst Updates`n`n"

$choice = Read-Host "  Choice (0-1)"
Write-Host "`n`n"

if ($choice -eq "1") {
    
    # Executing Updates
    Write-Host "  $Yellow[3/4]$Rst Executing $Green Updates $Rst...`n`n"
    
    Write-Host "  Updating Apps via Winget:`n`n"
    winget upgrade --all --include-unknown
    Write-Host "  [OK] Apps updated successfully!`n`n"
    
    if ($WinUpdates) {
        Write-Host "  Updating Windows OS:`n`n"
        Install-WindowsUpdate -AcceptAll -IgnoreReboot
        Write-Host "  [OK] OS updated successfully! (A manual reboot may be required later).`n`n"
    }

    # 4. Cleaning Junk
    Write-Host "  $Yellow[4/4]$Rst Cleaning Update $Red Garbage $Rst & Leftovers...`n`n"
    
    $junkPaths = @("C:\Windows\SoftwareDistribution\Download\*", "C:\Windows\Temp\*", "$env:TEMP\*")
    foreach ($p in $junkPaths) {
        Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue
    }
    
    Write-Host "  [OK] Cleanup completed. Wasted space recovered!`n`n"

} else {
    Write-Host "  [SKIPPED] $White Pending $Rst updates were skipped.`n`n"
}

Write-Host "$Cyan========================================$Rst`n`n"

Write-Host "  Master Update Completed Successfully!`n`n"

Write-Host "$Cyan========================================$Rst`n`n"
