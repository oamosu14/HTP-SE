<#
    HTP Secure Endpoint
    Module : Initialization Engine
    Version: 3.1.0-dev
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Start-HTPInitialization {

    [CmdletBinding()]
    param()

    $Config = Get-HTPConfiguration

    Write-Host ""
    Write-Host "========================================"
    Write-Host " HTP Secure Endpoint"
    Write-Host " Version $($Config.Version)"
    Write-Host "========================================"
    Write-Host ""

    Write-Host "Product     : $($Config.ProductName)"
    Write-Host "Version     : $($Config.Version)"
    Write-Host "Company     : $($Config.Company)"
    Write-Host "Environment : $($Config.Environment)"

    return $Config
}