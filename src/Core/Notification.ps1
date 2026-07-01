<#
    HTP Secure Endpoint
    Module : Notification Engine
    Version: 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Send-HTPNotification {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [pscustomobject]$Context,

        [Parameter(Mandatory)]
        [string]$Title,

        [Parameter(Mandatory)]
        [string]$Message
    )

    $Provider = $Context.Configuration.Notifications.Provider

    switch ($Provider) {

        "Pushover" {

            Send-HTPPushoverNotification `
                -Context $Context `
                -Title $Title `
                -Message $Message

            break
        }

        default {

            throw "Unsupported notification provider: $Provider"
        }
    }
}