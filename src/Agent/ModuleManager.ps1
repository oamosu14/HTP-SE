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

    $ModuleFiles = @()

    foreach ($Folder in Get-ChildItem -Path $ModulesRoot -Directory) {

        $MainModule = Join-Path `
            -Path $Folder.FullName `
            -ChildPath "$($Folder.Name).ps1"

        if (Test-Path $MainModule) {
            $ModuleFiles += Get-Item $MainModule
        }
    }

    if ($ModuleFiles.Count -eq 0) {

        Write-Host "No endpoint modules installed."

        Write-HTPLog `
            -Context $Context `
            -Module "ModuleManager" `
            -Message "No endpoint modules found."

        Write-HTPJsonLog `
            -Context $Context `
            -Module "ModuleManager" `
            -Message "No endpoint modules found."

        return
    }

    foreach ($Module in $ModuleFiles) {

        Write-Host "Loading $($Module.BaseName)"

        Remove-Item `
            -Path Function:\Start-HTPModule `
            -ErrorAction SilentlyContinue

        . $Module.FullName

        if (Get-Command Start-HTPModule -ErrorAction SilentlyContinue) {

            Start-HTPModule

            Write-HTPLog `
                -Context $Context `
                -Module "ModuleManager" `
                -Message "$($Module.BaseName) started."

            Write-HTPJsonLog `
                -Context $Context `
                -Module "ModuleManager" `
                -Message "$($Module.BaseName) started."
        }
        else {

            Write-HTPLog `
                -Context $Context `
                -Module "ModuleManager" `
                -Level "WARN" `
                -Message "$($Module.BaseName) does not expose Start-HTPModule."

            Write-HTPJsonLog `
                -Context $Context `
                -Module "ModuleManager" `
                -Level "WARN" `
                -Message "$($Module.BaseName) does not expose Start-HTPModule."
        }
    }

    Write-HTPLog `
        -Context $Context `
        -Module "ModuleManager" `
        -Message "$($ModuleFiles.Count) module(s) loaded."

    Write-HTPJsonLog `
        -Context $Context `
        -Module "ModuleManager" `
        -Message "$($ModuleFiles.Count) module(s) loaded."
}