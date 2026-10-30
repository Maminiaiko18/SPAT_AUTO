param(
    [switch]$Background
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$apiRoot = Join-Path $repoRoot 'automation-api'
$jarPath = Join-Path $apiRoot 'target\facture-automation-api-0.1.0-SNAPSHOT.jar'
$credentialPath = Join-Path $apiRoot 'local\spat-ro-connection.xml'

if (-not (Test-Path -LiteralPath $jarPath)) {
    throw "JAR introuvable : $jarPath. Construisez l'API avec Maven avant de la démarrer."
}
if (-not (Test-Path -LiteralPath $credentialPath)) {
    throw "Configuration Oracle absente. Exécutez une fois scripts\setup-automation-api-autostart.ps1."
}

try {
    $runningApi = Invoke-RestMethod -Uri 'http://localhost:8088/api/v1/health' -TimeoutSec 2
    if ($runningApi.service -eq 'facture-automation-api') {
        Write-Host "L'API est déjà démarrée sur http://localhost:8088."
        exit 0
    }
}
catch {
    # Aucun service API ne répond encore sur le port local.
}

function Test-Java21([string]$candidatePath) {
    if (-not $candidatePath -or -not (Test-Path -LiteralPath $candidatePath)) { return $false }
    $candidateHome = Split-Path -Parent (Split-Path -Parent $candidatePath)
    $candidateRelease = Join-Path $candidateHome 'release'
    return (Test-Path -LiteralPath $candidateRelease) -and
        ((Get-Content -LiteralPath $candidateRelease -Raw) -match 'JAVA_VERSION="21\.')
}

# JAVA_HOME/PATH may point to Java 17 because WildFly and older project tools use it.
# Search all known JDK 21 installs first, then report a useful error if none exists.
$javaCandidates = @()
if ($env:JAVA_HOME) { $javaCandidates += Join-Path $env:JAVA_HOME 'bin\java.exe' }
$javaCandidates += 'C:\Program Files\Java\jdk-21\bin\java.exe'
if (Test-Path -LiteralPath 'C:\Program Files\Java') {
    $javaCandidates += Get-ChildItem -LiteralPath 'C:\Program Files\Java' -Directory -Filter 'jdk-21*' -ErrorAction SilentlyContinue |
        ForEach-Object { Join-Path $_.FullName 'bin\java.exe' }
}
$javaCandidates += (Get-Command java.exe -ErrorAction SilentlyContinue).Source
$javaPath = $javaCandidates | Where-Object { Test-Java21 $_ } | Select-Object -First 1
if (-not $javaPath) {
    $javaOnPath = (Get-Command java.exe -ErrorAction SilentlyContinue).Source
    $runtime = if ($javaOnPath) { Split-Path -Parent (Split-Path -Parent $javaOnPath) } else { 'aucun runtime trouvé' }
    throw "Java 21 est requis pour l'API. Java sur PATH : $runtime. Installez un JDK 21 ou définissez JAVA_HOME vers son dossier."
}
$javaHome = Split-Path -Parent (Split-Path -Parent $javaPath)
Write-Host "Runtime API sélectionné : $javaHome"

$settings = Import-Clixml -LiteralPath $credentialPath
if (-not $settings.JdbcUrl -or $settings.Credential.UserName -ne 'SPAT_RO') {
    throw 'La configuration locale doit contenir une URL JDBC et le compte SPAT_RO.'
}

$env:SPAT_RO_JDBC_URL = $settings.JdbcUrl
$env:SPAT_RO_DB_USER = 'SPAT_RO'
$env:SPAT_RO_DB_ENABLED = 'true'
$env:SPAT_RO_DB_PASSWORD = $settings.Credential.GetNetworkCredential().Password

try {
    if ($Background) {
        $stdoutPath = Join-Path $apiRoot 'target\automation-api-startup.log'
        Write-Host "API lancée en arrière-plan. Journaux : $stdoutPath"
        & $javaPath -jar $jarPath >> $stdoutPath 2>&1
        if ($LASTEXITCODE -ne 0) { throw "L'API s'est arrêtée avec le code $LASTEXITCODE. Consultez $stdoutPath." }
    }
    else {
        Write-Host "Démarrage de l'API sur http://localhost:8088. Arrêtez avec Ctrl+C."
        & $javaPath -jar $jarPath
        if ($LASTEXITCODE -ne 0) { throw "L'API s'est arrêtée avec le code $LASTEXITCODE." }
    }
}
finally {
    Remove-Item Env:SPAT_RO_DB_PASSWORD -ErrorAction SilentlyContinue
    Remove-Item Env:SPAT_RO_JDBC_URL -ErrorAction SilentlyContinue
    Remove-Item Env:SPAT_RO_DB_USER -ErrorAction SilentlyContinue
    Remove-Item Env:SPAT_RO_DB_ENABLED -ErrorAction SilentlyContinue
}
