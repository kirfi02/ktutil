# ====================================================================
#               KIRFI TECH SYSTEM UTILITY (KTUTIL)
#                One-Line Bootstrap Web Launcher
# ====================================================================

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

$MainScriptUrl = "https://raw.githubusercontent.com/kirfi02/ktutil/main/ktutil.ps1"

try {
    Write-Host "[+] Fetching Kirfi Tech Utility (KTUTIL) from GitHub..." -ForegroundColor Cyan
    
    # Download main script and supporting config files into TEMP directory so PSScriptRoot and relative paths resolve correctly
    $TempDir = "$env:TEMP\ktutil"
    if (-not (Test-Path $TempDir)) { New-Item -ItemType Directory -Path $TempDir -Force | Out-Null }
    if (-not (Test-Path "$TempDir\config")) { New-Item -ItemType Directory -Path "$TempDir\config" -Force | Out-Null }

    # Download ktutil.ps1
    $ScriptPath = "$TempDir\ktutil.ps1"
    (New-Object Net.WebClient).DownloadFile($MainScriptUrl, $ScriptPath)

    # Download profiles.json and tweaks.json
    $ProfilesUrl = "https://raw.githubusercontent.com/kirfi02/ktutil/main/config/profiles.json"
    $TweaksUrl = "https://raw.githubusercontent.com/kirfi02/ktutil/main/config/tweaks.json"
    $AppsUrl = "https://raw.githubusercontent.com/kirfi02/ktutil/main/config/apps.json"

    (New-Object Net.WebClient).DownloadFile($ProfilesUrl, "$TempDir\config\profiles.json")
    (New-Object Net.WebClient).DownloadFile($TweaksUrl, "$TempDir\config\tweaks.json")
    (New-Object Net.WebClient).DownloadFile($AppsUrl, "$TempDir\config\apps.json")

    Write-Host "[+] Launching KTUTIL Engine..." -ForegroundColor Green
    Set-Location $TempDir
    & $ScriptPath
}
catch {
    Write-Error "[-] Failed to fetch or initialize KTUTIL engine: $_"
}
