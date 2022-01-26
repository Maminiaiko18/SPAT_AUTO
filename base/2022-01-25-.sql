

CREATE OR REPLACE VIEW DETAILSFACTUREFOURNISSEUR_PAYE
            (ID, IDINGREDIENT, QTE, PU, IDMERE, COMPTE, PUDEVISE, IDDQE, MARGE,
             TVA, DATY, MONTANTTTC, MONTANTPAYEPOURC,
             MONTANTPAYE, EXERCICE, ANNEE, MOIS, comptecpl)
AS
select dff.ID,
       cast('-' as varchar2(100))                                  IDINGREDIENT,
       dff.QUANTITE                                             as QTE,
       dff.PU,
       dff.IDMERE,
       dff.COMPTE,
       dff.PUDEVISE,
       dff.IDDQE,
       dff.MARGE,
       dff.TVA,
       ff.DATY,
       dff1.MONTANTTAUX + MONTANTTAUXTVA - MONTANTAVOIRAVECTAUX as MONTANTTTC,
       ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1))    as montantpayepourc,
       (dff1.MONTANTTAUX + MONTANTTAUXTVA - MONTANTAVOIRAVECTAUX) *
       ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1))    as montantpaye,
       ff.EXERCICE,
       dff.ANNEE,
       dff.MOIS,
       ff.code_etablissementlib || '' || ff.projetlib || '' || dff.compte
from factfourn_msum_lib ff
         right join FACTURE_FOURNISSEUR_FILLE dff on dff.IDMERE = ff.id
         right join FACTFOURN_MONTANT dff1 on dff1.id = dff.id
where ff.ETAT >= 11;
CREATE OR REPLACE VIEW SSITUATIONLCDEPENSEV
            (ID, DESIGNATION, COMPTE, ANNEE, MONTANT, ETAT, COMPTESTR, FACTURE, PAYE, ARECOUVRIR, RESTEBUDGET,
             POURCENGAGE, POURCPAYE,   comptecpl)
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
       cast(((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100 as number(30, 3))       as pourcPaye,
       comptecpl
from LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
    -- on substr(l.compte, 7, length(l.compte)) = mf.compte AND mf.annee = l.annee
                   on l.compte = mf.compte AND mf.annee = l.annee
where l.etat >= 11
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat, substr(l.compte, 7, length(l.compte)),comptecpl;


CREATE OR REPLACE VIEW SSITUATIONLCDEPENSEV
            (ID, DESIGNATION, COMPTE, ANNEE, MONTANT, ETAT, COMPTESTR, FACTURE, PAYE, ARECOUVRIR, RESTEBUDGET,
             POURCENGAGE, POURCPAYE,   comptecpl)
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
       cast(((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100 as number(30, 3))       as pourcPaye,
       comptecpl
from LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
    -- on substr(l.compte, 7, length(l.compte)) = mf.compte AND mf.annee = l.annee
                   on l.compte like mf.comptecpl||'%' AND mf.annee = l.annee
where l.etat >= 11
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat, substr(l.compte, 7, length(l.compte)),comptecpl;

