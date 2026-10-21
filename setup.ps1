# ====================================================================
#               KIRFI TECH SYSTEM UTILITY (KTUTIL)
#                One-Line Bootstrap Web Launcher
# ====================================================================

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$MainScriptUrl = "https://raw.githubusercontent.com/kirfi02/ktutil/main/ktutil.ps1"

try {
    Write-Host "[+] Fetching Kirfi Tech Utility (KTUTIL) from GitHub..." -ForegroundColor Cyan
    $script = Invoke-RestMethod -Uri $MainScriptUrl -UseBasicParsing
    Invoke-Expression $script
}
catch {
    Write-Error "[-] Failed to fetch KTUTIL engine. Verify network connection or repository URL."
}
