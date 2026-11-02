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

$newTokens = @()
if (Test-Path -LiteralPath $credentialPath) {
    $existing = Import-Clixml -LiteralPath $credentialPath
    if ($existing.Refuser -notmatch '^[0-9]{1,10}$' -or
        $existing.Tiers.UserName -ne 'SPATERP_API_TOKEN' -or
        $existing.Utilisateurs.UserName -ne 'SPATERP_USER_API_TOKEN' -or
        $existing.Bed.UserName -ne 'SPATERP_BED_API_TOKEN') {
        throw 'La configuration existante ne contient pas les identités API attendues; elle est conservée.'
    }
    $daseToken = Read-ApiToken 'Nouveau jeton API DASE (saisie masquée, distinct des autres jetons)'
    $newTokens += $daseToken
    $configuration = [pscustomobject]@{
        Refuser      = $existing.Refuser
        Tiers        = $existing.Tiers
        Utilisateurs = $existing.Utilisateurs
        Bed          = $existing.Bed
        Dase         = [pscredential]::new('SPATERP_DASE_API_TOKEN', $daseToken)
    }
}
else {
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
    $daseToken = Read-ApiToken 'Jeton API DASE (saisie masquée, distinct des autres jetons)'
    $newTokens += $tiersToken, $usersToken, $bedToken, $daseToken
    $configuration = [pscustomobject]@{
        Refuser      = $refuser
        Tiers        = [pscredential]::new('SPATERP_API_TOKEN', $tiersToken)
        Utilisateurs = [pscredential]::new('SPATERP_USER_API_TOKEN', $usersToken)
        Bed          = [pscredential]::new('SPATERP_BED_API_TOKEN', $bedToken)
        Dase         = [pscredential]::new('SPATERP_DASE_API_TOKEN', $daseToken)
    }
}

if (-not (Test-Path -LiteralPath $credentialDirectory)) {
    New-Item -ItemType Directory -Path $credentialDirectory -Force | Out-Null
}

$configuration | Export-Clixml -LiteralPath $credentialPath -Force
foreach ($token in $newTokens) { $token.Dispose() }
$existing = $null
$configuration = $null

Write-Host "Configuration enregistrée sous DPAPI pour le compte Windows courant : $credentialPath"
Write-Host 'Les jetons ne sont pas affichés ni écrits dans les fichiers suivis par Git.'
Write-Host 'Arrêtez WildFly, puis lancez la tâche VS Code : SPAT : démarrer WildFly avec API.'
