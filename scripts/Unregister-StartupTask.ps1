<#
    HTP Secure Endpoint
    Script : Unregister Startup Task
    Version: 3.1.0-dev
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

#
# Self-Elevation
#
$CurrentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$Principal = New-Object Security.Principal.WindowsPrincipal($CurrentUser)

if (-not $Principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Host ""
    Write-Host "Administrator privileges are required."
    Write-Host "Requesting elevation..."
    Write-Host ""

    $Process = Start-Process `
        -FilePath "powershell.exe" `
        -Verb RunAs `
        -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" `
        -PassThru

    $Process.WaitForExit()

    return
}

try {

    $TaskName = "HTP Secure Endpoint"

    Write-Host ""
    Write-Host "========================================"
    Write-Host " Unregister Startup Task"
    Write-Host "========================================"
    Write-Host ""

    $Task = Get-ScheduledTask `
        -TaskName $TaskName `
        -ErrorAction SilentlyContinue

    if (-not $Task) {

        Write-Host "No scheduled task found."
        Write-Host ""
        Write-Host "Nothing to remove."

        return
    }

    Write-Host "Existing scheduled task found."

    Unregister-ScheduledTask `
        -TaskName $TaskName `
        -Confirm:$false

    $Task = Get-ScheduledTask `
        -TaskName $TaskName `
        -ErrorAction SilentlyContinue

    if ($Task) {

        throw "Scheduled task still exists after removal."
    }

    Write-Host ""
    Write-Host "========================================"
    Write-Host " Unregistration Successful"
    Write-Host "========================================"
    Write-Host ""

    Write-Host "Scheduled Task removed successfully."

}
catch {

    Write-Host ""
    Write-Host "========================================"
    Write-Host " UNREGISTRATION FAILED"
    Write-Host "========================================"
    Write-Host ""

    Write-Host $_.Exception.Message -ForegroundColor Red

    throw
}