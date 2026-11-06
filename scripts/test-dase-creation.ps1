$etab = "CODE000021"
$proj = "PR0000000201094842"
$sec = Read-Host "Jeton webhook DASE" -AsSecureString
$tok = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
$body = '{"mode":"creation","daty":"2026-11-03","codeetablissement":"' + $etab + '","projet":"' + $proj + '","designation":"TEST-RECETTE-2-2026-11-03","lignes":[{"designation":"TEST-RECETTE article","unite":"UN0001","qte":1,"pu":1000}]}'
$file = Join-Path $env:TEMP "dase-creation.json"
Set-Content -Path $file -Value $body -Encoding ASCII
curl.exe -i -X POST "http://localhost:5678/webhook/spat/dase/demandes-achat" -H "Content-Type: application/json" -H "Authorization: Bearer $tok" --data "@$file"
$tok = $null



