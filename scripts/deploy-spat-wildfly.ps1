param(
    [string]$WildFlyHome = 'C:\wildfy-officiel\wildfly-10.0.0.Final',
    [string]$WarPath = (Join-Path $PSScriptRoot '..\gallois-war\dist\gallois-war.war')
)

$ErrorActionPreference = 'Stop'
$WildFlyHome = (Resolve-Path -LiteralPath $WildFlyHome).Path
$deployRoot = (Resolve-Path -LiteralPath (Join-Path $WildFlyHome 'standalone\deployments')).Path
$expectedDeployRoot = Join-Path $WildFlyHome 'standalone\deployments'
if ($deployRoot.TrimEnd('\') -ne $expectedDeployRoot.TrimEnd('\')) {
    throw "Unexpected WildFly deployment directory: $deployRoot"
}

$WarPath = (Resolve-Path -LiteralPath $WarPath).Path
if ([IO.Path]::GetExtension($WarPath) -ne '.war') {
    throw "Expected a WAR file: $WarPath"
}

$deployment = Join-Path $deployRoot 'spat.war'
$deployedMarker = Join-Path $deployRoot 'spat.war.deployed'
$failedMarker = Join-Path $deployRoot 'spat.war.failed'
$deployMarker = Join-Path $deployRoot 'spat.war.dodeploy'
$backupRoot = Join-Path (Join-Path $WildFlyHome 'standalone') 'codex-deploy-backups'
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$backup = Join-Path $backupRoot "spat.war-$stamp"

if (-not (Test-Path -LiteralPath $deployment -PathType Container) -and
    -not (Test-Path -LiteralPath $deployment -PathType Leaf)) {
    throw "Expected the current SPAT deployment archive or directory at: $deployment"
}
if (Test-Path -LiteralPath $backup) {
    throw "Backup destination already exists: $backup"
}

New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
if (Test-Path -LiteralPath $failedMarker) {
    Move-Item -LiteralPath $failedMarker -Destination (Join-Path $backupRoot "previous-spat.war.failed-$stamp")
}
if (Test-Path -LiteralPath $deployedMarker) {
    Remove-Item -LiteralPath $deployedMarker
}
Move-Item -LiteralPath $deployment -Destination $backup

try {
    Copy-Item -LiteralPath $WarPath -Destination $deployment
    New-Item -ItemType File -Path $deployMarker | Out-Null

    $deadline = (Get-Date).AddSeconds(300)
    while ((Get-Date) -lt $deadline -and
        -not (Test-Path -LiteralPath $deployedMarker) -and
        -not (Test-Path -LiteralPath $failedMarker)) {
        Start-Sleep -Seconds 2
    }

    if (Test-Path -LiteralPath $failedMarker) {
        throw 'WildFly reported a failed SPAT deployment.'
    }
    if (-not (Test-Path -LiteralPath $deployedMarker)) {
        throw 'Timed out waiting for WildFly deployment confirmation.'
    }

    $httpStatus = & curl.exe --max-time 10 -sS -o NUL -w '%{http_code}' 'http://127.0.0.1:8080/spat/'
    if ($LASTEXITCODE -ne 0 -or $httpStatus -ne '200') {
        throw "SPAT returned HTTP $httpStatus after deployment."
    }
    Write-Output "Deployment confirmed. SPAT HTTP status: $httpStatus"
    Write-Output "Previous deployment backup: $backup"
} catch {
    if (Test-Path -LiteralPath $deployment -PathType Leaf) {
        Remove-Item -LiteralPath $deployment
    }
    if (Test-Path -LiteralPath $deployedMarker) {
        Remove-Item -LiteralPath $deployedMarker
    }
    if (Test-Path -LiteralPath $failedMarker) {
        Move-Item -LiteralPath $failedMarker -Destination (Join-Path $backupRoot "failed-spat.war-$stamp")
    }
    if (Test-Path -LiteralPath $deployMarker) {
        Remove-Item -LiteralPath $deployMarker
    }
    if (-not (Test-Path -LiteralPath $deployment) -and
        ((Test-Path -LiteralPath $backup -PathType Container) -or
        (Test-Path -LiteralPath $backup -PathType Leaf))) {
        Move-Item -LiteralPath $backup -Destination $deployment
        New-Item -ItemType File -Path $deployMarker | Out-Null
    }
    throw
}
