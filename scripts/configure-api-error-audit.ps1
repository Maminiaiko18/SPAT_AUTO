$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$credentialPath = Join-Path $repoRoot 'automation-api\local\spat-ro-connection.xml'

if (-not (Test-Path -LiteralPath $credentialPath)) {
    throw 'Configuration Oracle absente. Lance avant scripts\setup-automation-api-autostart.ps1.'
}

$settings = Import-Clixml -LiteralPath $credentialPath
if (-not $settings.JdbcUrl -or $settings.Credential.UserName -ne 'SPAT_RO') {
    throw "La configuration locale doit contenir l'URL Oracle et le compte SPAT_RO."
}

Write-Host "Cette configuration est enregistrée localement avec DPAPI; elle ne doit pas être écrite dans Git."
$auditUser = (Read-Host 'Utilisateur Oracle audit [SPAT_API_AUDIT_WRITER]').Trim()
if (-not $auditUser) { $auditUser = 'SPAT_API_AUDIT_WRITER' }
if ($auditUser -ne 'SPAT_API_AUDIT_WRITER') {
    throw 'Le nom doit correspondre au compte créé par automation-api/db/002_api_error_log_writer.sql.'
}
$auditPassword = Read-Host "Mot de passe du compte d'audit (saisie masquée)" -AsSecureString
if ($auditPassword.Length -eq 0) { throw 'Mot de passe du compte audit manquant.' }

$settings | Add-Member -NotePropertyName AuditJdbcUrl -NotePropertyValue $settings.JdbcUrl -Force
$settings | Add-Member -NotePropertyName AuditCredential `
    -NotePropertyValue ([pscredential]::new($auditUser, $auditPassword)) -Force
$settings | Export-Clixml -LiteralPath $credentialPath -Force

Write-Host 'Compte audit enregistré. Redémarre le service Spring Boot pour charger SPAT_API_AUDIT_*.'
