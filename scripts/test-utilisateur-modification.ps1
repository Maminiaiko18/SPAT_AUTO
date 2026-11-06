$secPwd = Read-Host "Mot de passe (en MINUSCULES, comme a la creation)" -AsSecureString
$pwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($secPwd))
$secTok = Read-Host "Jeton API Utilisateurs" -AsSecureString
$tok = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($secTok))
$obj = @{ loginuser = "test.recette"; pwduser = $pwd; nomuser = "TEST RECETTE"; idrole = "redacteur"; teluser = "1002067" }
$file = Join-Path $env:TEMP "utilisateur-modification.json"
Set-Content -Path $file -Value ($obj | ConvertTo-Json -Compress) -Encoding ASCII
curl.exe -i -X PUT "http://127.0.0.1:8080/spat/api/utilisateurs/2520" -H "Content-Type: application/json" -H "Authorization: Bearer $tok" --data "@$file"
$tok = $null
$pwd = $null
Remove-Item $file
