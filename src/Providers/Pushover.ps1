<#
    HTP Secure Endpoint
    Provider : Pushover
    Version  : 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Send-HTPPushoverNotification {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [pscustomobject]$Context,

        [Parameter(Mandatory)]
        [string]$Title,

        [Parameter(Mandatory)]
        [string]$Message
    )

    $Token = $Context.Configuration.Notifications.ApiToken
    $User  = $Context.Configuration.Notifications.UserKey

    $Body = @{
        token   = $Token
        user    = $User
        title   = $Title
        message = $Message
    }

    Invoke-RestMethod `
        -Uri "https://api.pushover.net/1/messages.json" `
        -Method Post `
        -Body $Body | Out-Null

    Write-HTPLog `
        -Context $Context `
        -Module "Notification" `
        -Message "Pushover notification sent."

    Write-HTPJsonLog `
        -Context $Context `
        -Module "Notification" `
        -Message "Pushover notification sent."
}