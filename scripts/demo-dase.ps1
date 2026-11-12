$secTok = Read-Host "Jeton webhook DASE" -AsSecureString
$tok = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($secTok))
$url = "http://localhost:5678/webhook/spat/dase/demandes-achat"
$base = '{"mode":"controle","daty":"2026-11-12","codeetablissement":"CODE000021","projet":"PR0000000201094842","designation":"DEMO-CONTROLE","lignes":[{"designation":"Article demo","unite":"UN0001","qte":QTE,"pu":1000}]}'
foreach ($q in @("2","0")) {
  if ($q -eq "2") { Write-Host "--- Demande COMPLETE (mode controle, rien n'est ecrit)" } else { Write-Host "--- Demande INCOMPLETE : quantite a 0" }
  $f = Join-Path $env:TEMP "dase-demo.json"
  Set-Content -Path $f -Value $base.Replace("QTE",$q) -Encoding ASCII
  curl.exe -s -w "`nCode HTTP : %{http_code}`n" -X POST $url -H "Content-Type: application/json" -H "Authorization: Bearer $tok" --data "@$f"
}
$tok = $null