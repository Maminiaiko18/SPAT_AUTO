create view bordereau_lib as
select bo.id,
       bo.daty,
       bo.numero,
       bo.designation,
       bo.etat,
       fiu.NOM as tiers
from bordereau bo
         join FOURNISSEUR_UNION_PERSONNEL fiu on fiu.id = bo.TIERS;
create view bordereau_libcomplet as
select bo.*,
       fiu.NOM as tierslib
from bordereau bo
         join FOURNISSEUR_UNION_PERSONNEL fiu on fiu.id = bo.TIERS;

create view liaisonbordereau_libcomplet as
select
       li.*,
       op.REMARQUE,
       op.DED_ID as idfacture,
       b2.designation as idbordereaulib
from liaisonbordereau li
    join bordereau b2 on li.idBordereau = b2.id
    join ORDONNERPAYEMENT op on op.id=li.idOP ;