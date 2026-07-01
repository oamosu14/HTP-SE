<#
    HTP Secure Endpoint
    Module : Runtime Context
    Version: 3.1.0-dev
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

        Environment = $Configuration.Environment

        Configuration = $Configuration

        SessionId = $SessionId

        LogDirectory = $Configuration.Paths.LogDirectory

        StateDirectory = $Configuration.Paths.StateDirectory

        StartTime = Get-Date
    }

    return $Context
}
