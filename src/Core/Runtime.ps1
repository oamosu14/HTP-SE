<#
    HTP Secure Endpoint
    Module : Runtime Context
    Version: 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function New-HTPRuntimeContext {

    [CmdletBinding()]
    param()

    $Configuration = Get-HTPConfiguration

    $SessionId = "HTP-{0}" -f (Get-Date -Format "yyyyMMdd-HHmmss")

    $Context = [PSCustomObject]@{

        ProductName = $Configuration.ProductName

        Version = $Configuration.Version

        Company = $Configuration.Company

        Configuration = $Configuration

        SessionId = $SessionId

        LogDirectory = $Configuration.Logging.LogDirectory

        StateDirectory = $Configuration.State.Directory

        StartTime = Get-Date

    }

    return $Context
}