param([Parameter(Mandatory = $true)][ValidateSet("desactiver", "reactiver")][string]$action)
$secTok = Read-Host "Jeton API Utilisateurs" -AsSecureString
$tok = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($secTok))
curl.exe -i -X POST "http://127.0.0.1:8080/spat/api/utilisateurs/2520/$action" -H "Authorization: Bearer $tok"
$tok = $null