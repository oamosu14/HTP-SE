<#
    HTP Secure Endpoint
    Module : Initialization Engine
    Version: 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Start-HTPInitialization {

    [CmdletBinding()]
    param()

    Write-Host ""
    Write-Host "========================================"
    Write-Host " HTP Secure Endpoint"
    Write-Host " Version 3.0.0-alpha2"
    Write-Host "========================================"
    Write-Host ""

    $config = Get-HTPConfiguration

    Write-Host "Product :" $config.ProductName
    Write-Host "Version :" $config.Version
    Write-Host "Company :" $config.Company

    return $config
}