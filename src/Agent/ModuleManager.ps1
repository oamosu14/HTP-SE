<#
    HTP Secure Endpoint
    Module : Module Manager
    Version: 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Start-HTPModules {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [pscustomobject]$Context
    )

    Write-HTPLog `
        -Context $Context `
        -Module "ModuleManager" `
        -Message "Module Manager started."

    Write-HTPJsonLog `
        -Context $Context `
        -Module "ModuleManager" `
        -Message "Module Manager started."

    Write-Host ""
    Write-Host "Loading endpoint modules..."
    Write-Host ""

    $ModulesRoot = Join-Path `
        -Path $PSScriptRoot `
        -ChildPath "..\Modules"

    $ModulesRoot = (Resolve-Path $ModulesRoot).Path

    $Modules = @(Get-ChildItem `
        -Path $ModulesRoot `
        -Filter *.ps1 `
        -File `
        -ErrorAction SilentlyContinue)

    if ($Modules.Count -eq 0) {

        Write-Host "No endpoint modules installed."

        Write-HTPLog `
            -Context $Context `
            -Module "ModuleManager" `
            -Message "No endpoint modules found."

        return
    }

    foreach ($Module in $Modules) {

        Write-Host "Loading $($Module.Name)"

        . $Module.FullName
    }

    Write-HTPLog `
        -Context $Context `
        -Module "ModuleManager" `
        -Message "$($Modules.Count) module(s) loaded."
}