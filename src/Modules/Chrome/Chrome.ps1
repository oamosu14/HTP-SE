<#
    HTP Secure Endpoint
    Module : Chrome Monitor
    Version: 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-HTPChromeStatus {

    [CmdletBinding()]
    param()

    $Process = Get-Process `
        -Name chrome `
        -ErrorAction SilentlyContinue

    if ($Process) {

        return [pscustomobject]@{
            Running = $true
            ProcessCount = @($Process).Count
        }
    }

    return [pscustomobject]@{
        Running = $false
        ProcessCount = 0
    }
}

function Start-HTPModule {

    [CmdletBinding()]
    param()

    $Status = Get-HTPChromeStatus

    if ($Status.Running) {

        Write-Host "Chrome Monitor : Chrome is running ($($Status.ProcessCount) process(es))."
    }
    else {

        Write-Host "Chrome Monitor : Chrome is not running."
    }
}