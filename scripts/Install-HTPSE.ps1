<#
    HTP Secure Endpoint
    Script : Install HTP-SE
    Version: 3.1.0-dev
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host ""
Write-Host "========================================"
Write-Host " HTP Secure Endpoint Installer"
Write-Host " Version 3.1.0-dev"
Write-Host "========================================"
Write-Host ""

$ProjectRoot = Split-Path -Parent $PSScriptRoot

$RegisterScript = Join-Path `
    -Path $PSScriptRoot `
    -ChildPath "Register-StartupTask.ps1"

$TestScript = Join-Path `
    -Path $PSScriptRoot `
    -ChildPath "Test-Installation.ps1"

if (-not (Test-Path $RegisterScript)) {
    throw "Missing deployment script:`n$RegisterScript"
}

Write-Host "[1/2] Registering startup task..."
Write-Host ""

& $RegisterScript

if (-not (Test-Path $TestScript)) {

    Write-Host ""
    Write-Host "Installation completed."
    Write-Host "Installation test script not found."

    return
}

Write-Host ""
Write-Host "[2/2] Verifying installation..."
Write-Host ""

& $TestScript

Write-Host ""
Write-Host "========================================"
Write-Host " INSTALLATION COMPLETE"
Write-Host "========================================"
Write-Host ""

Write-Host "HTP Secure Endpoint has been installed successfully."
Write-Host ""