create or replace view ETATFACTUREMONTANTDATYVISE as
SELECT *
FROM EtatFactureMontantDaty
WHERE etat = 11
/
create or replace view ETATFACTUREMONTANTDATYCREE as
SELECT *
FROM EtatFactureMontantDaty
WHERE etat = 1
/

create or replace view AS_BONDECOMMANDE_LIBS as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.MODEPAIEMENT,
       bc.fournisseur,
       bc.tva,
       bc.NUMBC,
       bc.CODE_ETAB,
       bc.PROJET,
       ti.NOM         as fournisseur_lib,
       ce.val         as CODE_ETAB_lib,
       pe.designation as PROJET_lib,
       mp.val         as modepaiement_lib,
       DELAIPAIEMENT
from union_bc_spat_cemedi bc
         join modepaiement mp on bc.modepaiement = mp.id
         left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
         left join PROJET pe on pe.id = bc.projet
         left join TIERS ti on ti.ID = bc.fournisseur;