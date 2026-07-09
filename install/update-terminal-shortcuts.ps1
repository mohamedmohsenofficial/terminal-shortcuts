$VersionFile="$env:USERPROFILE\.terminal-shortcuts\version"

try {
    $RemoteVersion=(Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/version").Content.Trim()
} catch {
    exit
}

if(Test-Path $VersionFile){
    $LocalVersion=(Get-Content $VersionFile).Trim()
}else{
    $LocalVersion="0.0.0"
}

if($LocalVersion -ne $RemoteVersion){

    Write-Host ""
    Write-Host "Running some updates for your system safety 😚"
    Write-Host ""

    irm https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/install/install-windows.ps1 | iex

}
