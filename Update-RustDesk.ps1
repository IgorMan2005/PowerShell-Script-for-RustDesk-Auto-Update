# PowerShell Script for RustDesk Auto-Update
# Created by IgorMan. 2024
# https://best-itpro.ru


# Specify the path to the current RustDesk installation (if known)
$rustDeskPath = "${env:ProgramFiles}\RustDesk\RustDesk.exe"

# Checking if RustDesk is installed
if (-Not (Test-Path $rustDeskPath)) {
    Write-Host "RustDesk not found. Make sure it is installed." -ForegroundColor Red
    exit 1
}

# current version of RustDesk
$currentVersion = (Get-Item $rustDeskPath).VersionInfo.FileVersion
Write-Host "Current version RustDesk: $currentVersion" -ForegroundColor Green


# Last release of RustDesk
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

try {
    $latestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/rustdesk/rustdesk/releases/latest" -Method Get
    
} catch {
    Write-Host "Can't get info about last release version RustDesk. Check your Internet connection..." -ForegroundColor Red
    exit 1
}
$latestVersion = $latestRelease.tag_name.TrimStart("v")
Write-Host "Last release version RustDesk: $latestVersion" -ForegroundColor Green


# Compare versions
if ($currentVersion -eq $latestVersion) {
    Write-Host "You already have the latest version of RustDesk installed." -ForegroundColor Yellow
    exit 0
}

$downloadUrl = $latestRelease.assets | Where-Object { $_.name -like "*64.exe" } | Select-Object -First 1 -ExpandProperty browser_download_url
$destinationPath = "${env:Temp}\rustdesk-latest.exe"

# Download the latest version of RustDesk
Invoke-WebRequest -Uri $downloadUrl -OutFile $destinationPath

# Check if the installer has been downloaded successfully
if (-Not (Test-Path $destinationPath)) {
    Write-Host "Failed to download installer." -ForegroundColor Red
    exit 1
}

# Installing a new version
Write-Host "Installing a new version of RustDesk..." -ForegroundColor Cyan
Start-Process -FilePath $rustDeskPath -ArgumentList "/S" -Wait

# Remove the installer after completion
Remove-Item $rustDeskPath -Force

Write-Host "RustDesk has been successfully updated to version $latestVersion." -ForegroundColor Green

