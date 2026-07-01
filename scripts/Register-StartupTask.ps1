<#
    HTP Secure Endpoint
    Script : Register Startup Task
    Version: 3.1.0-dev
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

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

    $ProjectRoot = Split-Path -Parent $PSScriptRoot

    $AgentScript = Join-Path `
        -Path $ProjectRoot `
        -ChildPath "src\Agent\Start-HTPAgent.ps1"

    if (-not (Test-Path $AgentScript)) {
        throw "Agent bootstrap not found:`n$AgentScript"
    }

    Write-Host ""
    Write-Host "========================================"
    Write-Host " Register Startup Task"
    Write-Host "========================================"
    Write-Host ""

    Write-Host "Task Name    : $TaskName"
    Write-Host "Agent Script : $AgentScript"
    Write-Host ""

    $ExistingTask = Get-ScheduledTask `
        -TaskName $TaskName `
        -ErrorAction SilentlyContinue

    if ($ExistingTask) {

        Write-Host "Existing scheduled task found."

        Unregister-ScheduledTask `
            -TaskName $TaskName `
            -Confirm:$false

        Write-Host "Existing scheduled task removed."
        Write-Host ""
    }

    $Action = New-ScheduledTaskAction `
        -Execute "powershell.exe" `
        -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$AgentScript`""

    $Trigger = New-ScheduledTaskTrigger -AtLogOn

    Register-ScheduledTask `
        -TaskName $TaskName `
        -Action $Action `
        -Trigger $Trigger `
        -Description "Starts Habims Tech Pulse Secure Endpoint at user logon." `
        | Out-Null

    $Task = Get-ScheduledTask -TaskName $TaskName

    Write-Host ""
    Write-Host "========================================"
    Write-Host " Registration Successful"
    Write-Host "========================================"
    Write-Host ""

    Write-Host "Task Name : $($Task.TaskName)"
    Write-Host "State     : $($Task.State)"
}
catch {

    Write-Host ""
    Write-Host "========================================"
    Write-Host " REGISTRATION FAILED"
    Write-Host "========================================"
    Write-Host ""

    Write-Host $_.Exception.Message -ForegroundColor Red
}
finally {

    Write-Host ""
}