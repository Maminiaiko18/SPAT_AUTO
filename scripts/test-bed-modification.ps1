param(
    [Parameter(Mandatory = $true)][string]$id,
    [string]$designation = "TEST-RECETTE-2026-11-06"
)
$secTok = Read-Host "Jeton API BED" -AsSecureString
$tok = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($secTok))
$url = "http://127.0.0.1:8080/spat/api/bordereaux-bed/$id"
$hdr = "Authorization: Bearer $tok"
Write-Host "--- Lecture avant modification"
$avant = curl.exe -s -H $hdr $url
Write-Host $avant
$bed = ($avant -join "") | ConvertFrom-Json
$noms = @("daty", "anneebudgetaire", "designation", "typebordereau")
$manque = $noms | Where-Object { $bed.PSObject.Properties.Name -notcontains $_ }
if ($manque) { Write-Host "Champs absents de la lecture : $manque. Arret, rien n'a ete modifie."; $tok = $null; return }
$corps = @{ daty = $bed.daty; anneebudgetaire = $bed.anneebudgetaire; designation = $designation; typebordereau = $bed.typebordereau }
$json = $corps | ConvertTo-Json -Compress
Write-Host "Corps a envoyer : $json"
$ok = Read-Host "Envoyer ce PUT ? (o/n)"
if ($ok -ne "o") { $tok = $null; return }
$file = Join-Path $env:TEMP "bed-modification.json"
[IO.File]::WriteAllText($file, $json, (New-Object Text.UTF8Encoding $false))
curl.exe -i -X PUT $url -H $hdr -H "Content-Type: application/json" --data-binary "@$file"
Write-Host "--- Lecture apres modification"
curl.exe -s -H $hdr $url
Remove-Item $file
$tok = $null