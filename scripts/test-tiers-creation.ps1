param(
    [Parameter(Mandatory = $true)][string]$type,
    [string]$nif = "",
    [string]$stat = ""
)
$secTok = Read-Host "Jeton API Tiers" -AsSecureString
$tok = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($secTok))
if ($nif -eq "") { $nif = "9999" + (Get-Random -Minimum 100000 -Maximum 999999) }
if ($stat -eq "") { $stat = "9999" + (Get-Random -Minimum 1000000 -Maximum 9999999) + (Get-Random -Minimum 100000 -Maximum 999999) }
Write-Host "NIF utilise : $nif"
Write-Host "STAT utilise : $stat"
$dir = Join-Path $env:TEMP "tiers-test"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$pdf = Join-Path $dir "nif.pdf"
$png = Join-Path $dir "stat.png"
$payload = Join-Path $dir "payload.json"
[IO.File]::WriteAllBytes($pdf, [Text.Encoding]::ASCII.GetBytes("%PDF-1.4`n% TEST-RECETTE-2026-11-06`n%%EOF`n"))
[IO.File]::WriteAllBytes($png, [byte[]](0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x00))
$obj = @{ nom = "TEST-RECETTE-2026-11-06"; type = $type; nif = $nif; stat = $stat; verificationJustificatifs = $true }
[IO.File]::WriteAllText($payload, ($obj | ConvertTo-Json -Compress), (New-Object Text.UTF8Encoding $false))
curl.exe -i -X POST "http://127.0.0.1:8080/spat/api/tiers" -H "Authorization: Bearer $tok" -F "payload=<$payload;type=application/json" -F "nifDocument=@$pdf;type=application/pdf" -F "statDocument=@$png;type=image/png"
Remove-Item -Recurse -Force $dir
$tok = $null
