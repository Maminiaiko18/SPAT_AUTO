$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$apiRoot = Join-Path $repoRoot 'automation-api'
$jarPath = Join-Path $apiRoot 'target\facture-automation-api-0.1.0-SNAPSHOT.jar'
$localConfigRoot = Join-Path $apiRoot 'local'
$credentialPath = Join-Path $localConfigRoot 'spat-ro-connection.xml'
$startScript = Join-Path $PSScriptRoot 'start-automation-api.ps1'
$taskName = 'SPAT Facture Automation API'

if (-not (Test-Path -LiteralPath $jarPath)) {
    throw "JAR introuvable : $jarPath. Construisez d'abord l'API avec Maven."
}

$replaceConfiguration = $true
if (Test-Path -LiteralPath $credentialPath) {
    $replace = Read-Host 'Une configuration Oracle existe déjà. La remplacer ? [o/N]'
    if ($replace -notin @('o', 'O', 'oui', 'Oui', 'y', 'Y', 'yes', 'Yes')) {
        $replaceConfiguration = $false
        Write-Host 'Configuration Oracle conservée; le démarrage automatique sera (re)configuré.'
    }
}

if ($replaceConfiguration) {
    $jdbcUrl = (Read-Host 'URL JDBC Oracle (jdbc:oracle:thin:@//hote:1521/service)').Trim()
    if ($jdbcUrl -notmatch '^jdbc:oracle:thin:@') {
        throw 'URL JDBC Oracle invalide : elle doit commencer par jdbc:oracle:thin:@.'
    }

    $securePassword = Read-Host 'Mot de passe du compte Oracle SPAT_RO (saisie masquée)' -AsSecureString
    if ($securePassword.Length -eq 0) { throw 'Mot de passe Oracle manquant.' }

    if (-not (Test-Path -LiteralPath $localConfigRoot)) {
        New-Item -ItemType Directory -Path $localConfigRoot -Force | Out-Null
    }

    $savedConfiguration = [pscustomobject]@{
        JdbcUrl = $jdbcUrl
        Credential = [pscredential]::new('SPAT_RO', $securePassword)
    }
    $savedConfiguration | Export-Clixml -LiteralPath $credentialPath -Force
}

$savedConfiguration = Import-Clixml -LiteralPath $credentialPath
if (-not $savedConfiguration.JdbcUrl -or $savedConfiguration.Credential.UserName -ne 'SPAT_RO') {
    throw 'Le fichier local doit contenir une URL JDBC et le compte SPAT_RO.'
}

$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$action = New-ScheduledTaskAction -Execute "$PSHOME\powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$startScript`" -Background" `
    -WorkingDirectory $repoRoot
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $currentUser
$principal = New-ScheduledTaskPrincipal -UserId $currentUser -LogonType Interactive -RunLevel Limited
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries `
    -ExecutionTimeLimit ([TimeSpan]::Zero)

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal `
    -Settings $settings -Description 'Démarre l’API de validation SPAT avec le compte Oracle local SPAT_RO.' -Force | Out-Null

Write-Host "Configuration locale DPAPI chargée : $credentialPath"
Write-Host "Démarrage automatique configuré à l’ouverture de session pour $currentUser."
Write-Host "Pour démarrer l’API maintenant, exécutez scripts\start-automation-api.ps1."
