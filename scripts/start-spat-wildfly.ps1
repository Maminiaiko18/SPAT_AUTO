$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$wildFlyHome = 'C:\wildfy-officiel\wildfly-10.0.0.Final'
$javaHome = 'C:\Program Files\Eclipse Adoptium\jdk-8.0.372.7-hotspot'
$standaloneBat = Join-Path $wildFlyHome 'bin\standalone.bat'
$logPath = Join-Path $repoRoot 'automation-api\target\wildfly-autostart.log'
$credentialPath = Join-Path $repoRoot 'automation-api\local\spat-wildfly-api-credentials.xml'

if (-not (Test-Path -LiteralPath $standaloneBat)) {
    throw "Script de démarrage WildFly introuvable : $standaloneBat"
}
if (-not (Test-Path -LiteralPath (Join-Path $javaHome 'bin\java.exe'))) {
    throw "Java 8 requis par ce WildFly introuvable : $javaHome"
}

try {
    $response = Invoke-WebRequest -Uri 'http://localhost:8080/spat/' -TimeoutSec 3
    if ($response.StatusCode -eq 200) {
        Write-Host 'WildFly/SPAT est déjà démarré sur le port 8080.'
        exit 0
    }
}
catch {
    # SPAT ne répond pas encore; démarrer WildFly ci-dessous.
}

$env:JAVA_HOME = $javaHome
$env:JBOSS_HOME = $wildFlyHome
$env:PATH = "$javaHome\bin;$env:PATH"
$env:SPAT_N8N_VALIDATION_WEBHOOK_URL = 'http://127.0.0.1:5678/webhook/spat/factures-fournisseurs/validation'
Remove-Item Env:JAVA_OPTS -ErrorAction SilentlyContinue

if (Test-Path -LiteralPath $credentialPath) {
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
    "$(Get-Date -Format s) Identités API WildFly chargées depuis la configuration DPAPI locale." | Out-File -LiteralPath $logPath -Append -Encoding utf8
} else {
    "$(Get-Date -Format s) Configuration API WildFly absente; les routes protégées répondront 503." | Out-File -LiteralPath $logPath -Append -Encoding utf8
}

"$(Get-Date -Format s) Démarrage de WildFly/SPAT." | Out-File -LiteralPath $logPath -Append -Encoding utf8
Push-Location (Join-Path $wildFlyHome 'bin')
try {
    & $env:ComSpec /d /c "`"$standaloneBat`"" 2>&1 | Out-File -LiteralPath $logPath -Append -Encoding utf8
    if ($LASTEXITCODE -ne 0) {
        throw "WildFly s'est arrêté avec le code $LASTEXITCODE. Consultez $logPath."
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
