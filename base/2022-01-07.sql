
CREATE OR REPLACE  VIEW DETAILSFACTUREFOURNISSEUR_PAYE (ID, IDINGREDIENT, QTE, PU, IDMERE, COMPTE, PUDEVISE, IDDQE, MARGE, TVA, DATY, MONTANTTTC, MONTANTPAYEPOURC, MONTANTPAYE, EXERCICE , ANNEE , MOIS) AS 
  select dff.ID,
       cast('-' as varchar2(100))                                                   IDINGREDIENT,
       dff.QUANTITE                                                              as QTE,
       dff.PU,
       dff.IDMERE,
       dff.COMPTE,
       dff.PUDEVISE,
       dff.IDDQE,
       dff.MARGE,
       dff.TVA,
       DATY,
       dff1.MONTANTTTC,
       ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1))                     as montantpayepourc,
       (dff1.MONTANTTTC) * ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1)) as montantpaye,
       ff.EXERCICE , 
       dff.ANNEE  , 
       dff.MOIS 
from factfourn_msum_lib ff
         right join FACTURE_FOURNISSEUR_FILLE dff on dff.IDMERE = ff.id
         right join FACTFOURN_FILLETTC dff1 on dff1.id = dff.id
where ETAT >= 11;


create or replace view FACTURE_CLIENT_MF_PAYE as
select fcf.ID,
       fcf.IDMERE,
       fcf.DESIGNATION,
       fcf.QUANTITE,
       fcf.PU,
       fcf.COMPTE,
       fcf.IDPRODUIT,
       fcf.DEVISE,
       fcf.TAUX,
       fcf.DATY,
       fcf.TIERS,
       fcf.DESIGNATIONMERE,
       fcf.TYPE,
       fcf.TVA,
       fcf.REMARQUE,
       fcf.IDUSER,
       fcf.DATE_ECHEANCE,
       fcf.ETAT,
       (fcf1.MONTANTTAUX+MONTANTTAUXTVA-fcf1.montantavoiravectaux) as MONTANTTTC,
       round((l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1),3)                     as montantpayepourc,
       round( (fcf1.MONTANTTAUX+MONTANTTAUXTVA-fcf1.montantavoiravectaux) * ((l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1)),3) as montantpaye,
       EXERCICE,
       fcf.mois,
       fcf.annee
from FACTURECLIENTMSUM_LIB l
         right join FACTURE_CLIENT_MERE_FILLE fcf on fcf.IDMERE = l.id
         join FACTURE_CLIENT_MONTANT fcf1 on fcf1.id = fcf.id
where l.ETAT >= 11
/



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
       CAST(fm.pu * fm.quantite AS NUMBER(30, 3))                                             AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3))
                                                                                              AS montanttaux,
       NVL(montantsanstaux, 0)                                                                AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 3))
                                                                                              AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)                                                                  as MAJORATION,
       NVL(fm.REDUCTION, 0)                                                                   as REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3)) as montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) AS NUMBER(30, 3))  as montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite ) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3)) * fm.tva /
       100                                                                                    as montanttauxtva
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirffavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID
/

  CREATE OR REPLACE VIEW SITUATIONLC_VIDE ("ID", "DESIGNATION", "COMPTE", "ANNEE", "MOIS", "MONTANT", "ETAT", "FACTURE", "PAYE", "ARECOUVRIR", "RESTEBUDGET", "DATY") AS 
  SELECT
    'ID' AS id,
    'DESIGNATION' AS DESIGNATION,
    'COMPTE' AS COMPTE,
    cast(0 as number(10)) AS ANNEE,
    cast(0 as number(2)) AS MOIS,
    cast(0 as number(30,3)) AS MONTANT,
    cast(0 as number(10)) AS ETAT,
    cast(0 as number(30,3)) AS FACTURE,
    cast(0 as number(30,3)) AS PAYE,
    cast(0 as number(30,3)) AS ARECOUVRIR,
    cast(0 as number(30,3)) AS RESTEBUDGET,
    CURRENT_DATE AS daty
FROM
    dual;
