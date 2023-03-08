
create view AS_BONDECOMMANDE_LIBCOMPLET as
select bc.*,
       mp.val         as modepaiementlibelle,
       tr.nom         AS FOURNISSEURLIBELLE,
       ce.val         as CODE_ETABLIBELLE,
       pe.designation as PROJETLIBELLE
from union_bc_spat_cemedi bc
         join modepaiement mp on bc.modepaiement = mp.id
         JOIN tiers tr ON bc.fournisseur = tr.id
         left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
         left join PROJET pe on pe.id = bc.projet
/

create view AS_BONDECOMMANDE_FILLE_PRD AS
SELECT BCF.*,
        pr.NOM as produitlib
FROM AS_BONDECOMMANDE_FILLE BCF
        left join AS_PRODUITS pr on pr.id=bcf.PRODUIT;


CREATE OR REPLACE FORCE VIEW PLACEMENTLIB_CREE AS
select id,
       valentite as entite,
       date_placement,
       date_echeance,
       duree,
       montant,
       taux,
       numero,
       VALBANQUE as BANQUE,
       etat,
       iddeviselib as iddevise,
       MONTANTDEVISE
from PLACEMENTLIBCOMPLET
where etat = 1;

CREATE OR REPLACE FORCE VIEW PLACEMENTLIB_VISEE AS
select id,
       valentite as entite,
       date_placement,
       date_echeance,
       duree,
       montant,
       taux,
       numero,
       VALBANQUE as BANQUE,
       etat,
       iddeviselib as iddevise,
       MONTANTDEVISE
from PLACEMENTLIBCOMPLET
where etat = 11;
 
CREATE OR REPLACE FORCE VIEW PLACEMENTLIB_ECHU AS
select id,
       valentite as entite,
       date_placement,
       date_echeance,
       duree,
       montant,
       taux,
       numero,
       VALBANQUE as BANQUE,
       etat,
       iddeviselib as iddevise,
       MONTANTDEVISE
from PLACEMENTLIBCOMPLET
where etat = 12; 