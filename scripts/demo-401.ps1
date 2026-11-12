$b = "http://localhost:8080/spat/api"
$routes = @("factureclient","demandes-achat/ID-INEXISTANT","utilisateurs/999999999","bordereaux-bed/999999999")
foreach ($r in $routes) {
  $code = curl.exe -s -o NUL -w "%{http_code}" "$b/$r"
  Write-Host ("{0,-35} -> {1}" -f $r, $code)
}