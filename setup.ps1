# ====================================================================
#               KIRFI TECH SYSTEM UTILITY (KTUTIL)
#                One-Line Bootstrap Web Launcher
# ====================================================================

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

$MainScriptUrl = "https://raw.githubusercontent.com/kirfi02/ktutil/main/ktutil.ps1"

try {
    Write-Host "[+] Fetching Kirfi Tech Utility (KTUTIL) from GitHub..." -ForegroundColor Cyan
    $script = Invoke-RestMethod -Uri $MainScriptUrl -UseBasicParsing
    
    # Save locally to ensure PSScriptRoot and relative configs exist
    $TempDir = "$env:TEMP\ktutil"
    if (-not (Test-Path $TempDir)) { New-Item -ItemType Directory -Path $TempDir -Force | Out-Null }
    $LocalScript = "$TempDir\ktutil.ps1"
    $script | Out-File -FilePath $LocalScript -Encoding utf8

    # Also clone/fetch config files if needed or execute locally
    Write-Host "[+] Launching KTUTIL engine..." -ForegroundColor Green
    & $LocalScript
}
catch {
    Write-Error "[-] Failed to fetch KTUTIL engine: $_"
}
