$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$wildFlyHome = 'C:\wildfy-officiel\wildfly-10.0.0.Final'
$standaloneBat = Join-Path $wildFlyHome 'bin\standalone.bat'
$startScript = Join-Path $PSScriptRoot 'start-spat-wildfly.ps1'
$taskName = 'SPAT WildFly'

if (-not (Test-Path -LiteralPath $standaloneBat)) {
    throw "Installation WildFly introuvable : $wildFlyHome"
}

$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$action = New-ScheduledTaskAction -Execute "$PSHOME\powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$startScript`"" `
    -WorkingDirectory $repoRoot
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $currentUser
$principal = New-ScheduledTaskPrincipal -UserId $currentUser -LogonType Interactive -RunLevel Limited
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries `
    -ExecutionTimeLimit ([TimeSpan]::Zero)

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal `
    -Settings $settings -Description 'Démarre WildFly et SPAT à l’ouverture de session Windows.' -Force | Out-Null

Write-Host "Démarrage automatique de WildFly/SPAT configuré pour $currentUser à chaque ouverture de session."
