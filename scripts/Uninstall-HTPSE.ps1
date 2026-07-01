<#
    HTP Secure Endpoint
    Script : Uninstall HTP-SE
    Version: 3.1.0-dev
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host ""
Write-Host "========================================"
Write-Host " HTP Secure Endpoint Uninstaller"
Write-Host " Version 3.1.0-dev"
Write-Host "========================================"
Write-Host ""

$UnregisterScript = Join-Path `
    -Path $PSScriptRoot `
    -ChildPath "Unregister-StartupTask.ps1"

if (-not (Test-Path $UnregisterScript)) {
    throw "Missing deployment script:`n$UnregisterScript"
}

Write-Host "[1/1] Removing startup task..."
Write-Host ""

& $UnregisterScript

Write-Host ""
Write-Host "========================================"
Write-Host " UNINSTALLATION COMPLETE"
Write-Host "========================================"
Write-Host ""

Write-Host "HTP Secure Endpoint startup task has been removed."
Write-Host ""