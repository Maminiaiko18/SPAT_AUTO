create or replace view LIAISONINTRATABLE_OP_VISE as
select lt."ID",lt."ID1",lt."ID2",lt."MONTANT",op.DED_ID,
       op.MONTANT AS MONTANTOP,
       op.etat
from LIAISONINTRATABLE lt
         join ordonnerpayement_paye_lib op on op.id = lt.ID2;



create view AS_BONDECOMMANDE_FILLE_LIB AS
select mon.ID,
       pr.NOM as PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       UNITE,
       TVA,
       MONTANTHT,
       MONTANTTVA,
       MONTANTTTC,
       ETAT

from AS_BONDECOMMANDE_FILLE_MONTANT mon
         left join AS_PRODUITS pr on pr.id = mon.PRODUIT;

create or replace view LIAISONINTRATABLE_OP_VISE as
select lt."ID",
       lt."ID1",
       lt."ID2",
       lt."MONTANT",
       op.DED_ID,
       op.MONTANT AS MONTANTOP,
       op.etat
from LIAISONINTRATABLE lt
         join ordonnerpayement_paye_lib op on op.id = lt.ID2;


create or replace
    view AS_BONDECOMMANDE_FILLE_LIB AS
select mon.ID,
       nvl(pr.NOM,PRODUIT) as PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       UNITE,
       TVA,
       MONTANTHT,
       MONTANTTVA,
       MONTANTTTC,
       ETAT

from AS_BONDECOMMANDE_FILLE_MONTANT mon
         left join AS_PRODUITS pr on pr.id = mon.PRODUIT;