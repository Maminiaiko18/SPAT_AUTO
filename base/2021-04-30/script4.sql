create or replace view BORDEREAU_LIBCOMPLET as
select bo."ID",bo."DATY",bo."NUMERO",bo."DESIGNATION",bo."ETAT",bo."TIERS",
       fiu.NOM as tierslib
from bordereau bo
       left  join FOURNISSEUR_UNION_PERSONNEL fiu on fiu.id = bo.TIERS
/

