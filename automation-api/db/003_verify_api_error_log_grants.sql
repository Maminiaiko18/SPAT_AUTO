-- Read-only DBA check; run after the two setup scripts have succeeded.
SET LINESIZE 180
SET PAGESIZE 100
COLUMN grantee FORMAT A28
COLUMN privilege FORMAT A18
COLUMN owner FORMAT A24
COLUMN table_name FORMAT A32
COLUMN tablespace_name FORMAT A24

PROMPT === Grants sur le journal ===
SELECT grantee, privilege, grantable
FROM dba_tab_privs
WHERE owner = 'SPAT_CAPITAINERIE'
  AND table_name = 'SPATERP_API_ERROR_LOG'
ORDER BY grantee, privilege;

PROMPT === Quota du propriétaire de la table ===
SELECT username, default_tablespace
FROM dba_users
WHERE username = 'SPAT_CAPITAINERIE';

SELECT tablespace_name, bytes, max_bytes
FROM dba_ts_quotas
WHERE username = 'SPAT_CAPITAINERIE';

SELECT grantee, privilege, admin_option
FROM dba_sys_privs
WHERE grantee = 'SPAT_CAPITAINERIE'
  AND privilege = 'UNLIMITED TABLESPACE';

PROMPT === Privilèges du compte d’audit Spring ===
SELECT grantee, privilege, grantable
FROM dba_tab_privs
WHERE owner = 'SPAT_CAPITAINERIE'
  AND table_name = 'SPATERP_API_ERROR_LOG'
  AND grantee = 'SPAT_API_AUDIT_WRITER';

SELECT grantee, privilege, admin_option
FROM dba_sys_privs
WHERE grantee = 'SPAT_API_AUDIT_WRITER';

EXIT SUCCESS
