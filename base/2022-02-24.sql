create or replace view SITUATIONLCDEPENSEV as
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
       comptecpl,
       substr(l.COMPTE, 7) || substr(l.COMPTE, 1, 6)                               as compteinv,
       substr(l.COMPTE, 7)                                                         as comptesimple,
       substr(l.COMPTE, 1, 6)                                                      as directionProjet,
       substr(substr(l.COMPTE, 1, 6), 1, 3)                                        as direction,
       substr(substr(l.COMPTE, 1, 6), 4, 7)                                        as projet,
       mf.DATY,
       l.PROJET as idprojet ,
       l.CODEETABLISSEMENT as idCODEETABLISSEMENT

from LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
    -- on substr(l.compte, 7, length(l.compte)) = mf.compte AND mf.annee = l.annee
                   on l.compte = mf.comptecpl AND mf.annee = l.annee
where l.etat >= 11
      --and mf.comptecpl is not null
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat, substr(l.compte, 7, length(l.compte)), comptecpl,
         mf.DATY,
         l.PROJET,         l.CODEETABLISSEMENT;


create view ligneCreditDepenseGrp as
select idprojet,
       idcodeEtablissement,
       sum(montant) as montant,
       sum(facture) as facture,
       sum(paye)as paye,
       sum(arecouvrir) as arecouvrir,
       sum(restebudget) as restebudget
        from SITUATIONLCDEPENSEV
        group by idcodeEtablissement, idprojet;


create or replace view AS_BONDELIVRAISON_FILLE_LIB as
select blf.id,
       blf.PRODUIT                                                      as produit,
       blf.numbl,
       blf.quantite,
       blf.quantiteparpack,
       blf.iddetailsfacturefournisseur,
       bcf.pu,
       bcf.TVA,
       cast(bcf.pu * blf.QUANTITE as NUMBER(30,2))                                                  as montant,
       cast(( (bcf.tva / 100)) * (bcf.pu * blf.QUANTITE) as NUMBER(30,2))                        as montanttva,
       cast(((bcf.pu * blf.QUANTITE) + (((bcf.tva / 100) * (bcf.pu * blf.QUANTITE)))) as NUMBER(30,2)) as montantttc
from as_bondelivraison_fille blf
         left join AS_BONDECOMMANDE_FILLE bcf on bcf.id = blf.IDBONDECOMMANDE;


create or replace view FACTFOURN_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION,
             IDACTIVITE, DATEFACT, RUBRIQUE, IDENGAGEMENT,annee)
as
SELECT fi.ID,
       fi.IDMERE,
       fi.DESIGNATION,
       fi.QUANTITE,
       fi.PU,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fc.daty,
       fc.tiers,
       fc.designation        AS designationmere,
       fc.TYPE,
       decode(fi.tva, null, fc.tva, fi.tva),
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.IDPREVISION,
       nvl(fi.REDUCTION, 0)  as REDUCTION,
       nvl(fi.MAJORATION, 0) as MAJORATION,
       fi.IDACTIVITE,
       fi.DATEFACT,
       fi.RUBRIQUE,
       fc.IDENGAGEMENT,ANNEE
FROM FACTURE_FOURNISSEUR_FILLE fi
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fc ON fi.idmere = fc.id;


create or replace view FACTFOURN_MONTANT as
SELECT fm.ID,
       fm.IDMERE,
       fm.DESIGNATION,
       fm.QUANTITE,
       fm.PU,
       fm.COMPTE,
       fm.IDPRODUIT,
       fm.DEVISE,
       fm.TAUX,
       fm.DATY,
       fm.TIERS,
       fm.DESIGNATIONMERE,
       fm.TYPE,
       fm.TVA,
       fm.REMARQUE,
       fm.IDUSER,
       fm.DATE_ECHEANCE,
       fm.ETAT,
       IDPREVISION,
       IDPROVISION,
       IDCATEGORIE,
       CAST(fm.pu * fm.quantite AS NUMBER(30, 2))                                             AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2))
                                                                                              AS montanttaux,
       NVL(montantsanstaux, 0)                                                                AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 2))
                                                                                              AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)                                                                  as MAJORATION,
       NVL(fm.REDUCTION, 0)                                                                   as REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2)) as montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) AS NUMBER(30, 2))  as montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2)) * fm.tva /
       100                                                                                    as montanttauxtva,
       fm.IDENGAGEMENT,
       en.IDLC,
       en.DATY as datyengagement,
       annee
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirffavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID
         left join engagement en on en.id = fm.IDENGAGEMENT;

create or replace view FACTFOURN_MONTANT_ISNULL as
select COMPTE, sum(MONTANT) as montant,annee
from FACTFOURN_MONTANT
where IDENGAGEMENT is null
group by COMPTE,annee;