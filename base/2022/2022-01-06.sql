
create or replace view FACTURE_CLIENT_MONTANT as
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
       CAST(fm.pu * fm.quantite * nvl(duree, 1) AS NUMBER(30, 3)) AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3))
           AS                                                        montanttaux,
       NVL(montantsanstaux, 0) AS                                    montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 3))
           AS                                                        montantavoiravectaux,
       NVL(fm.MAJORATION, 0) as                                      MAJORATION,
       NVL(fm.REDUCTION, 0) as                                       REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.MAJORATION / 100,
                0) AS NUMBER(30, 3)) as                              montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.REDUCTION / 100,
                0) AS NUMBER(30, 3)) as                              montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE,
       IDAVOIR,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3)) * fm.tva /
       100 as                                                        montanttva
FROM facture_client_Mere_fille fm
         LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID
/


create or replace view FACTURE_CLIENT_MONTANT as
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
       CAST(fm.pu * fm.quantite * nvl(duree, 1) AS NUMBER(30, 3)) AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3))
           AS                                                        montanttaux,
       NVL(montantsanstaux, 0) AS                                    montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 3))
           AS                                                        montantavoiravectaux,
       NVL(fm.MAJORATION, 0) as                                      MAJORATION,
       NVL(fm.REDUCTION, 0) as                                       REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.MAJORATION / 100,
                0) AS NUMBER(30, 3)) as                              montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.REDUCTION / 100,
                0) AS NUMBER(30, 3)) as                              montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE,
       IDAVOIR,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3)) * fm.tva /
       100 as                                                        montanttauxtva
FROM facture_client_Mere_fille fm
         LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID
/

CREATE OR REPLACE VIEW FACTURE_CLIENT_MERE_FILLE ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "DATY", "TIERS", "DESIGNATIONMERE", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDCATEGORIE", "IDPROVISION", "IDPREVISION", "REDUCTION", "MAJORATION", "IDACTIVITE", "DATEFACT", "RUBRIQUE", "IDAVOIR", "DUREE", "MOIS", "ANNEE") AS 
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
       IDAVOIR,
       DUREE,
       fi.MOIS,
       fi.ANNEE 
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id
;

CREATE OR REPLACE VIEW SITUATIONLC_VIDE ("ID", "DESIGNATION", "COMPTE", "ANNEE", "MOIS", "MONTANT", "ETAT", "FACTURE", "PAYE", "ARECOUVRIR", "DATY") AS 
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
    CURRENT_DATE AS daty
FROM
    dual;


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
       fcf1.MONTANTTAUX+MONTANTTAUXTVA as MONTANTTTC,
       round((l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1),3)                     as montantpayepourc,
       round((fcf1.MONTANTTAUX+MONTANTTAUXTVA) * ((l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1)),3) as montantpaye,
       EXERCICE,
       fcf.mois,
       fcf.annee
from FACTURECLIENTMSUM_LIB l
         right join FACTURE_CLIENT_MERE_FILLE fcf on fcf.IDMERE = l.id
         join FACTURE_CLIENT_MONTANT fcf1 on fcf1.id = fcf.id
where l.ETAT >= 11
/
