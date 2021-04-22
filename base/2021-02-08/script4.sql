CREATE OR REPLACE VIEW RECAP_TRESO(DATY, LIBELLE, NUMERO_COMPTE, MONTANT) AS
select DATY,
LIBELLE,
NUMERO_COMPTE,
cast(montant as number(25, 2)) as montant from(
select
DATY,
LIBELLE,
NUMERO_COMPTE,
cast(montant as number(25, 2)) as montant
from recap_caisse
union
select date_placement as daty,
'Placement' as libelle,
null as numero_compte,
cast(montant as number(25, 2)) as montat
from placement);