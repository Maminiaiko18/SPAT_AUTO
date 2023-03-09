
create or replace view NAVIRELIBVALIDE as
select *
from navirelib
where etat != 0
/

UPDATE PROJET
SET DESIGNATION = 'Projet de renseignement et de verification'
WHERE ROWID = 'AACA2gAAGAAKRIeAAB'
  AND ORA_ROWSCN = '126315491';