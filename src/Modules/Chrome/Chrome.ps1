<#
    HTP Secure Endpoint
    Module : Chrome Monitor
    Version: 3.1.0-dev
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

        return [PSCustomObject]@{
            Running      = $true
            ProcessCount = @($Process).Count
        }
    }

    return [PSCustomObject]@{
        Running      = $false
        ProcessCount = 0
    }
}

function Invoke-HTPChromePolicy {

    [CmdletBinding()]
    param()

    $Status = Get-HTPChromeStatus

    if (-not $Status.Running) {

        Write-Host "Chrome Monitor : Chrome is not running."
        return
    }

    Write-Host "Chrome Monitor : Chrome is running ($($Status.ProcessCount) process(es))."

    $Policy = Get-HTPInternetPolicy `
        -State $Global:HTPState

    if ($Policy.Allowed) {

        Write-Host "Internet Policy : Approved"
        return
    }

    if ($Global:HTPState.Chrome.NotificationSent) {

        Write-Host "Internet Policy : Approval pending."
        return
    }

    Send-HTPNotification `
        -Context $Global:HTPContext `
        -Title "HTP Secure Endpoint" `
        -Message "Chrome is requesting Internet access."

    $Global:HTPState.Chrome.NotificationSent = $true

    Save-HTPState `
        -Context $Global:HTPContext `
        -State $Global:HTPState

    Write-Host "Internet Policy : Approval request sent."
}

function Start-HTPModule {

    [CmdletBinding()]
    param()

    Invoke-HTPChromePolicy
}