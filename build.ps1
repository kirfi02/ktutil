# ====================================================================
#          KIRFI TECH UTILITY (KTUTIL) - EXECUTABLE BUILDER
#     Maintainer: Ukasha M. I. Kirfi | IoT & AI Systems Developer
# ====================================================================

[CmdletBinding()]
param()

Clear-Host
Write-Host "==========================================================================" -ForegroundColor Cyan
Write-Host "            KIRFI TECH UTILITY (KTUTIL) - COMPILER ENGINE                 " -ForegroundColor Green
Write-Host "==========================================================================" -ForegroundColor Cyan

# 1. Check & Install ps2exe Module if missing
if (-not (Get-Module -ListAvailable -Name "ps2exe")) {
    Write-Host "[+] Installing 'ps2exe' compiler module from PowerShell Gallery..." -ForegroundColor Yellow
    Install-Module -Name "ps2exe" -Scope CurrentUser -Force -Confirm:$false
}

Import-Module ps2exe

# 2. Define Paths
$ScriptRoot = $PSScriptRoot
$InputScript = Join-Path $ScriptRoot "ktutil.ps1"
$OutputExe = Join-Path $ScriptRoot "KTUTIL.exe"

if (-not (Test-Path $InputScript)) {
    Write-Error "[-] Critical Error: 'ktutil.ps1' not found in project root!"
    exit 1
}

Write-Host "[+] Compiling 'ktutil.ps1' into standalone portable executable..." -ForegroundColor Cyan

# 3. Compile Script to .exe using Invoke-PS2EXE
# Note: -noConsole keeps it clean for the WPF GUI, but preserves background logging where applicable.
Invoke-PS2EXE `
    -InputFile $InputScript `
    -OutputFile $OutputExe `
    -Title "Kirfi Tech System Utility" `
    -Description "Windows Debloat, CTT Parity, Local AI & IoT Engine" `
    -Company "Kirfi Tech" `
    -Product "KTUTIL" `
    -Copyright "Copyright © 2026 Ukasha M. I. Kirfi" `
    -Version "1.1.0.0" `
    -RequireAdmin `
    -NoConsole `
    -Verbose

if (Test-Path $OutputExe) {
    Write-Host "[SUCCESS] KTUTIL.exe successfully compiled at: $OutputExe" -ForegroundColor Green
} else {
    Write-Error "[-] Compilation failed."
}
