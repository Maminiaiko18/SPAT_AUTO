create or replace view REMBOURSEMENTPLACEMENTLIB as
select r."ID",r."DATY",r."IDPLACEMENT",r."MONTANTPLACE",r."INTERET",r."CAISSE",r."ETAT",
       p.entite,
       p.banque,
       c.val as caisselib
from remboursementPlacement r
    left join placementlib p on r.idplacement=p.ID
    left join caisse c on r.caisse=c.ID
/



CREATE OR REPLACE VIEW SITUATIONLCDEPENSEV
            (ID, DESIGNATION, COMPTE, ANNEE, MONTANT, ETAT, COMPTESTR, FACTURE, PAYE, ARECOUVRIR, RESTEBUDGET,
             POURCENGAGE, POURCPAYE)
AS
select l.id,
       l.DESIGNATION,
       l.compte,
       l.ANNEE,
       l.montant                                                                   as montant,
       l.etat,
       substr(l.compte, 7, length(l.compte))                                       as comptestr,
       cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))                              as facture,
       cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3))                             as PAYE,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3)) as arecouvrir,
       cast((l.montant) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                as restebudget,
       cast(((nvl(sum(MONTANTTTC), 0)) / l.MONTANT) * 100 as NUMBER(30, 3))        as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100 as number(30, 3))       as pourcPaye
from LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
                  -- on substr(l.compte, 7, length(l.compte)) = mf.compte AND mf.annee = l.annee
                   on l.compte = mf.compte AND mf.annee = l.annee
where l.etat >= 11
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat, substr(l.compte, 7, length(l.compte));
 