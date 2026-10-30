$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$credentialDirectory = Join-Path $repoRoot 'automation-api\local'
$credentialPath = Join-Path $credentialDirectory 'spat-wildfly-api-credentials.xml'

function Read-ApiToken([string]$Prompt) {
    $value = Read-Host $Prompt -AsSecureString
    if ($value.Length -lt 32) {
        $value.Dispose()
        throw 'Chaque jeton doit contenir au moins 32 caractères.'
    }
    return $value
}

if (Test-Path -LiteralPath $credentialPath) {
    $replace = Read-Host 'Des identifiants WildFly locaux existent déjà. Les remplacer ? [o/N]'
    if ($replace -notin @('o', 'O', 'oui', 'Oui', 'y', 'Y', 'yes', 'Yes')) {
        Write-Host 'Configuration existante conservée.'
        exit 0
    }
}

$refuser = (Read-Host 'REFUSER du compte DG actif pour l''audit API [2100 - cdev]').Trim()
if ([string]::IsNullOrWhiteSpace($refuser)) {
    $refuser = '2100'
}
if ($refuser -notmatch '^[0-9]{1,10}$') {
    throw 'Le REFUSER doit contenir uniquement des chiffres.'
}

$tiersToken = Read-ApiToken 'Jeton API Tiers (saisie masquée, 32 caractères minimum)'
$usersToken = Read-ApiToken 'Jeton API utilisateurs (saisie masquée, distinct du jeton Tiers)'
$bedToken = Read-ApiToken 'Jeton API BED (saisie masquée, distinct des autres jetons)'

if (-not (Test-Path -LiteralPath $credentialDirectory)) {
    New-Item -ItemType Directory -Path $credentialDirectory -Force | Out-Null
}

$configuration = [pscustomobject]@{
    Refuser = $refuser
    Tiers = [pscredential]::new('SPATERP_API_TOKEN', $tiersToken)
    Utilisateurs = [pscredential]::new('SPATERP_USER_API_TOKEN', $usersToken)
    Bed = [pscredential]::new('SPATERP_BED_API_TOKEN', $bedToken)
}
$configuration | Export-Clixml -LiteralPath $credentialPath -Force
$tiersToken.Dispose()
$usersToken.Dispose()
$bedToken.Dispose()
$configuration = $null

Write-Host "Configuration enregistrée sous DPAPI pour le compte Windows courant : $credentialPath"
Write-Host 'Les jetons ne sont pas affichés ni écrits dans les fichiers suivis par Git.'
Write-Host 'Arrêtez WildFly, puis lancez la tâche VS Code : SPAT : démarrer WildFly avec API.'
