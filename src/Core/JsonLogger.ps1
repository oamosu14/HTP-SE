<#
    HTP Secure Endpoint
    Module : JSON Logging Engine
    Version: 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-HTPJsonLog {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [pscustomobject]$Context,

        [Parameter(Mandatory)]
        [string]$Module,

        [Parameter(Mandatory)]
        [string]$Message,

        [ValidateSet('INFO','WARN','ERROR','DEBUG')]
        [string]$Level = 'INFO'
    )

    if (-not (Test-Path -Path $Context.LogDirectory)) {

        New-Item `
            -ItemType Directory `
            -Path $Context.LogDirectory `
            -Force | Out-Null
    }

    $LogFile = Join-Path `
        -Path $Context.LogDirectory `
        -ChildPath ("HTP-" + (Get-Date -Format "yyyy-MM-dd") + ".json")

    $Event = [PSCustomObject]@{

        Timestamp = (Get-Date).ToString("o")

        SessionId = $Context.SessionId

        Product = $Context.ProductName

        Version = $Context.Version

        Module = $Module

        Level = $Level

        Message = $Message
    }

    $Event |
        ConvertTo-Json -Depth 5 -Compress |
        Add-Content -Path $LogFile
}