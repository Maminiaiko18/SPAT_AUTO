CREATE OR REPLACE VIEW FACT_CLT_FILL_LIB_REST_TAXE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION, REDUCTION) AS 
  SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3)) as MONTANTTAUX,
       CAST(fcm.MONTANT AS NUMBER(32, 5)) as MONTANT,
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3)) as MONTANTAVOIRSANSTAUX,
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3)) as MONTANTAVOIRAVECTAUX,
       CAST(fcm.tva AS NUMBER(20, 3)) as tva,
       fc.idactivite,
       ra.DESIGNATION                             AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                   AS moislib,
       CAST(0 AS NUMBER(32, 2))                   AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                   AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                   AS montantTVAEuro,
       CAST((fc.pu * fc.QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                  AS montanttaxe,
       nvl(fc.majoration, 0)                      as majoration,
       nvl(fc.reduction, 0)                       as reduction
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois;
		 
CREATE OR REPLACE VIEW FACT_CLT_FILL_LIB_REST_TAXE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION, REDUCTION, DATEFACT) AS 
  SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3)) as MONTANTTAUX,
       CAST(fcm.MONTANT AS NUMBER(32, 5)) as MONTANT,
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3)) as MONTANTAVOIRSANSTAUX,
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3)) as MONTANTAVOIRAVECTAUX,
       CAST(fcm.tva AS NUMBER(20, 3)) as tva,
       fc.idactivite,
       ra.DESIGNATION                             AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                   AS moislib,
       CAST(0 AS NUMBER(32, 2))                   AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                   AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                   AS montantTVAEuro,
       CAST((fc.pu * fc.QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                  AS montanttaxe,
       nvl(fc.majoration, 0)                      as majoration,
       nvl(fc.reduction, 0)                       as reduction,
       fc.DATEFACT 
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois;
CREATE OR REPLACE  "FACTURECLIENTVALIDE" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "MONTANTPAYE", "MONTANTRESTE", "TIERSLIB", "CONTACT", "ADRESSE", "IDPREVISION", "ESCALE", "ETATLIB", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE") AS
  SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
        cast(fc.TVA as number(30,3)) as TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
         cast(fc.MONTANT as NUMBER(30,3)) as MONTANT,
         cast(fc.MONTANTTVA as NUMBER(30,3)) as MONTANTTVA,
         cast(fc.MONTANTAVOIR as NUMBER(30,3)) as MONTANTAVOIR,
         cast(fc.MONTANTTTC as NUMBER(30,3)) as MONTANTTTC,
         cast(fc.MONTANTPAYE as NUMBER(30,3)) as MONTANTPAYE,
         cast(fc.MONTANTRESTE as NUMBER(30,3)) as MONTANTRESTE,
       fc.TIERSLIB,
       fc.CONTACT,
       fc.ADRESSE,
       fc.IDPREVISION,
       fc.ESCALE,
       fc.ETATLIB,
       fc.TYPELIB,
       fc.IDCATEGORIE,
       fc.CATEGORIELIB,
       fc.IDPROVISION,
       fc.IDPROVISIONLIB,
       fc.DEVISEMERE,
       fc.CODEPRESTATION,
       fc.CODEPRESTATIONLIB,
       fc.CODE
FROM facture_client_union fc
WHERE id NOT IN (SELECT id FROM ProvisionFactureDefinitive);
alter table PREVISION drop constraint FK_CONSIGNATAIRE_ARM;
alter table V_CLIENT_CATEGORIE add primary key (CDCLT);
alter table CONSIGNATAIREMAT add primary key (CDCLT);
alter table PREVISION add  constraint FK_CONSIGNATAIRE_ARM foreign key (ARMATEUR)references CONSIGNATAIREMAT;

alter table PREVISION
    drop constraint SYS_C00203806;
	
