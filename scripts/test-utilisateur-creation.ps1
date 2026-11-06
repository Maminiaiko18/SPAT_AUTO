$role = Read-Host "idrole valide (role peu privilegie)"
$etab = "CODE000021"
$secPwd = Read-Host "Mot de passe du compte de test (avec une majuscule)" -AsSecureString
$pwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($secPwd))
$secTok = Read-Host "Jeton API Utilisateurs" -AsSecureString
$tok = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($secTok))
$obj = @{ loginuser = "test.recette"; pwduser = $pwd; nomuser = "TEST RECETTE"; idrole = $role; codeEtablissement = $etab }
$file = Join-Path $env:TEMP "utilisateur-creation.json"
Set-Content -Path $file -Value ($obj | ConvertTo-Json -Compress) -Encoding ASCII
curl.exe -i -X POST "http://127.0.0.1:8080/spat/api/utilisateurs" -H "Content-Type: application/json" -H "Authorization: Bearer $tok" --data "@$file"
$tok = $null
$pwd = $null
Remove-Item $file