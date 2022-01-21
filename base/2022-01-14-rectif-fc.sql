
CREATE OR REPLACE  VIEW FACTURECLIENTMSUM
            ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT",
             "IDPREVISION", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "ESCALE", "TYPELIB", "IDCATEGORIE",
             "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "ESTDDPMICTSL", "DEVISEMERE", "CODEPRESTATION",
             "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "MONTANTTTCVRAI", "NAVIRE", "ARMATEURLIB",
             "EXERCICE", "IDAVOIR")
AS
SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       fc.idprevision,
       CAST(NVL(grp.montant, 0) AS NUMBER(30, 3))    AS montant,--montanttaux
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3)) AS montanttva,
       cast(NVL(grp.MONTANTAV, 0) as NUMBER(32, 3))  AS montantavoir,
       CAST(NVL(MONTANTTTC, 0) AS NUMBER(30, 3))     AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                       AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                     AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                               AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                        as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                      as codeprovision,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.MONTANT, 0) AS NUMBER(30, 3))
                                                     AS MONTANTTTCVRAI,
       pr.NAVIRE,
       nv.armateurlib,
       fc.exercice,
       fc.IDAVOIR
FROM FACTURECLIENT fc
         LEFT JOIN CAFCFILLECOMPLET grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id
         left join NAVIRELIBCOMPLET nv on pr.NAVIRE = nv.id;


create or replace view FACT_CLT_FILL_LIB_REST_TAXE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION,
             REDUCTION, DATEFACT, RUBRIQUE, RANG, DATY, DUREE, TYPE, ETAT)
as
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                                             AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))                         AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                                          AS resteAlivrer,
       CAST(fcm.MONTANT AS NUMBER(32, 3))                               AS MONTANTTAUX,
       CAST(fcm.MONTANTav AS NUMBER(32, 5))                                 AS MONTANT,
       CAST(fcm.MTAVOIR AS NUMBER(32, 3))
                                                                          AS MONTANTAVOIRSANSTAUX,
       CAST(fcm.MTAVOIR AS NUMBER(32, 3))
                                                                          AS MONTANTAVOIRAVECTAUX,
       CAST(fcm.tva AS NUMBER(20, 3))                                     AS tva,
       fc.idactivite,
       ra.DESIGNATION                                                     AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                                           AS moislib,
       CAST(0 AS NUMBER(32, 2))                                           AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                                           AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                                           AS montantTVAEuro,
       CAST(MONTANTTVA AS NUMBER(20, 3))                                  AS montanttaxe,
       NVL(fc.majoration, 0)                                              AS majoration,
       NVL(fc.reduction, 0)                                               AS reduction,
       fc.DATEFACT,
       nvl(fc.RUBRIQUE, r.ID),
       fc.rang,
       CASE WHEN fc.IDACTIVITE IS NOT NULL THEN ra.DATY else fcm.DATY END AS daty,
       fc.DUREE,
       fcm.TYPE,
       fcm.ETAT
FROM facture_client_fille_rangfinal fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN CAFCFILLECOMPLET fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fc.RUBRIQUE

/
 

 

CREATE OR REPLACE VIEW COMPTECAFACTURE
            (ID, VAL, DESCE, IDMERE, DESIGNATION, QUANTITE, PU, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, HEUREDEBUT,
             HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION, REDUCTION, DATEFACT,
             RUBRIQUE, RANG, DATY, VALMERECA, DESCEMERECA, MOIS, ANNEE, COMPTE, TYPE, MERECA)
AS
select fdc.ID,
       cca.VAL,
       cca.DESCE,
       IDMERE,
       DESIGNATION,
       QUANTITE,
       PU,
       IDPRODUIT,
       DEVISE,
       TAUX,
       cast(0 as NUMBER(10, 2))     as QTELIVREE,
       cast(0 as NUMBER(10, 2))     as RESTEALIVRER,
       MONTANT                      as MONTANTTAUX,
       MONTANT,
       MTAVOIR                      as MONTANTAVOIRSANSTAUX,
       MTAVOIR                      as MONTANTAVOIRAVECTAUX,
       TVA,
       IDACTIVITE,
       cast('-' as VARCHAR2(100))      ACTIVITELIB,
       HEUREDEBUT,
       HEUREFIN,
       MOISLIB,
       cast(0 as NUMBER(10,3)) as TAUXEURO,
       cast(0 as NUMBER(10,3)) as MONTANTHTEURO,
       cast(0 as NUMBER(10,3)) as MONTANTTVAEURO,
       MONTANTTVA                   as MONTANTTAXE,
       MAJORATION,
       REDUCTION,
       DATEFACT,
       RUBRIQUE,
       RANG,
       DATY,
       mca.val                      as valMereCA,
       mca.desce                    as desceMereCA,
       extract(month from fdc.daty) as mois,
       extract(year from fdc.daty)  as annee,
       fdc.compte,
       TYPE,
       cca.DESCE                    as mereca
from CompteCA cca,
     MereCA mca,
     CAFCFILLECOMPLET fdc
where fdc.compte like cca.val || '%'
  and fdc.compte is not null
  and cca.desce = mca.id;