# ====================================================================
#               KIRFI TECH SYSTEM UTILITY (KTUTIL)
#                One-Line Bootstrap Web Launcher
# ====================================================================

# Force TLS 1.2 & 1.3
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

# Raw script target with cache-busting timestamp query parameter
$CacheBuster = Get-Date -UFormat "%s"
$MainScriptUrl = "https://raw.githubusercontent.com/kirfi02/ktutil/main/ktutil.ps1?cb=$CacheBuster"

try {
    Write-Host "[+] Fetching Kirfi Tech Utility (KTUTIL) from GitHub..." -ForegroundColor Cyan
    $script = (New-Object System.Net.WebClient).DownloadString($MainScriptUrl)
    Invoke-Expression $script
}
catch {
    Write-Host "[!] WebClient fallback engaging..." -ForegroundColor Yellow
    try {
        $script = Invoke-RestMethod -Uri $MainScriptUrl -UseBasicParsing
        Invoke-Expression $script
    }
    catch {
        Write-Error "[-] Failed to fetch KTUTIL engine. Verify network connection or repository URL."
    }
}
