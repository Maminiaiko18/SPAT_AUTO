param(
    [string]$ConnectString = 'SPAT_RO@//127.0.0.1:1521/XEPDB1'
)

$ErrorActionPreference = 'Stop'
$sqlPath = Join-Path $env:TEMP ("spat-api-error-log-{0}.sql" -f [guid]::NewGuid().ToString('N'))
$sql = @'
WHENEVER OSERROR EXIT 9
WHENEVER SQLERROR EXIT SQL.SQLCODE
SET ECHO OFF
SET FEEDBACK ON
SET HEADING ON
SET PAGESIZE 100
SET LINESIZE 220
SET TRIMSPOOL ON
ALTER SESSION SET TIME_ZONE = 'Indian/Antananarivo';
COLUMN service_name FORMAT A28
COLUMN http_method FORMAT A8
COLUMN endpoint FORMAT A42
COLUMN error_code FORMAT A12
COLUMN summary FORMAT A44
PROMPT === Nombre d'erreurs enregistrées depuis 24 heures ===
SELECT COUNT(*) AS total_24h
FROM SPAT_CAPITAINERIE.SPATERP_API_ERROR_LOG
WHERE ERROR_AT >= SYSTIMESTAMP - INTERVAL '1' DAY;
PROMPT === Dernières erreurs API ===
SELECT TO_CHAR(ERROR_AT AT TIME ZONE 'Indian/Antananarivo', 'YYYY-MM-DD HH24:MI:SS TZH:TZM') AS error_at,
       SERVICE_NAME AS service_name,
       HTTP_METHOD AS http_method,
       ENDPOINT AS endpoint,
       HTTP_STATUS AS status,
       ERROR_CODE AS error_code,
       SUMMARY AS summary
FROM SPAT_CAPITAINERIE.SPATERP_API_ERROR_LOG
WHERE ERROR_AT >= SYSTIMESTAMP - INTERVAL '1' DAY
ORDER BY ERROR_AT DESC
FETCH FIRST 50 ROWS ONLY;
EXIT SUCCESS
'@

try {
    [System.IO.File]::WriteAllText($sqlPath, $sql, [System.Text.Encoding]::ASCII)
    & sqlplus -L $ConnectString "@$sqlPath"
    if ($LASTEXITCODE -ne 0) {
        throw "SQL*Plus a terminé avec le code $LASTEXITCODE. Vérifie le compte, la connexion et le droit SELECT sur SPATERP_API_ERROR_LOG."
    }
}
finally {
    Remove-Item -LiteralPath $sqlPath -ErrorAction SilentlyContinue
}
