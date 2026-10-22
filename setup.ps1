# ====================================================================
#               KIRFI TECH SYSTEM UTILITY (KTUTIL)
#                One-Line Bootstrap Web Launcher
# ====================================================================

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

$MainScriptUrl = "https://raw.githubusercontent.com/kirfi02/ktutil/main/ktutil.ps1"

try {
    Write-Host "[+] Fetching Kirfi Tech Utility (KTUTIL) from GitHub..." -ForegroundColor Cyan
    $script = (New-Object Net.WebClient).DownloadString($MainScriptUrl)
    Invoke-Expression $script
}
catch {
    Write-Error "[-] Failed to fetch KTUTIL engine: $_"
}
