$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$wildFlyHome = 'C:\wildfy-officiel\wildfly-10.0.0.Final'
$javaHome = 'C:\Program Files\Eclipse Adoptium\jdk-8.0.372.7-hotspot'
$standaloneBat = Join-Path $wildFlyHome 'bin\standalone.bat'
$credentialPath = Join-Path $repoRoot 'automation-api\local\spat-wildfly-api-credentials.xml'

if (-not (Test-Path -LiteralPath $standaloneBat)) {
    throw "Installation WildFly introuvable : $wildFlyHome"
}
if (-not (Test-Path -LiteralPath (Join-Path $javaHome 'bin\java.exe'))) {
    throw "Java 8 requis par WildFly introuvable : $javaHome"
}
if (-not (Test-Path -LiteralPath $credentialPath)) {
    throw 'Configuration API absente. Lancez en premier la tâche VS Code de configuration des identités API WildFly.'
}

$listener = Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue |
    Select-Object -First 1
if ($listener) {
    $process = Get-Process -Id $listener.OwningProcess -ErrorAction SilentlyContinue
    throw "Le port 8080 est déjà utilisé par $($process.ProcessName) (PID $($listener.OwningProcess)). Arrêtez WildFly avant ce démarrage. Ce script ne le stoppe pas automatiquement."
}

$configuration = Import-Clixml -LiteralPath $credentialPath
if (
    $configuration.Refuser -notmatch '^[0-9]{1,10}$' -or
    $configuration.Tiers.UserName -ne 'SPATERP_API_TOKEN' -or
    $configuration.Utilisateurs.UserName -ne 'SPATERP_USER_API_TOKEN' -or
    $configuration.Bed.UserName -ne 'SPATERP_BED_API_TOKEN'
) {
    throw 'Le fichier local ne contient pas les identifiants API attendus.'
}

$env:SPATERP_API_USER = $configuration.Refuser
$env:SPATERP_API_TOKEN = $configuration.Tiers.GetNetworkCredential().Password
$env:SPATERP_USER_API_REFUSER = $configuration.Refuser
$env:SPATERP_USER_API_TOKEN = $configuration.Utilisateurs.GetNetworkCredential().Password
$env:SPATERP_BED_API_REFUSER = $configuration.Refuser
$env:SPATERP_BED_API_TOKEN = $configuration.Bed.GetNetworkCredential().Password
$env:SPAT_N8N_VALIDATION_WEBHOOK_URL = 'http://127.0.0.1:5678/webhook/spat/factures-fournisseurs/validation'
$env:JAVA_HOME = $javaHome
$env:JBOSS_HOME = $wildFlyHome
$env:PATH = "$javaHome\bin;$env:PATH"
Remove-Item Env:JAVA_OPTS -ErrorAction SilentlyContinue

Push-Location (Join-Path $wildFlyHome 'bin')
try {
    Write-Host 'Démarrage WildFly avec les identités API chargées uniquement dans ce processus.'
    Write-Host 'Les journaux restent visibles ici. Arrêtez le serveur avec Ctrl+C.'
    & $standaloneBat -c standalone.xml
    if ($LASTEXITCODE -ne 0) {
        throw "WildFly s'est arrêté avec le code $LASTEXITCODE."
    }
}
finally {
    foreach ($name in @('SPATERP_API_USER', 'SPATERP_API_TOKEN', 'SPATERP_USER_API_REFUSER',
            'SPATERP_USER_API_TOKEN', 'SPATERP_BED_API_REFUSER', 'SPATERP_BED_API_TOKEN',
            'SPAT_N8N_VALIDATION_WEBHOOK_URL')) {
        Remove-Item "Env:$name" -ErrorAction SilentlyContinue
    }
    $configuration = $null
    Pop-Location
}
