CREATE OR REPLACE VIEW FACT_CLT_FILL_LIB_REST_TAXE
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   QTELIVREE,
   RESTEALIVRER,
   MONTANTTAUX,
   MONTANT,
   MONTANTAVOIRSANSTAUX,
   MONTANTAVOIRAVECTAUX,
   TVA,
   IDACTIVITE,
   ACTIVITELIB,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   MOISLIB,
   TAUXEURO,
   MONTANTHTEURO,
   MONTANTTVAEURO,
   MONTANTTAXE,
   MAJORATION,
   REDUCTION,
   DATEFACT,
   RUBRIQUE,
   RANG,
   DATY
)
AS
   SELECT fc.ID,
          fc.IDMERE,
          fc.DESIGNATION,
          fc.QUANTITE,
          fc.PU,
          fc.COMPTE,
          pr.NOM AS IDPRODUIT,
          fc.DEVISE,
          fc.TAUX,
          CAST (NVL (gr.QUANTITE, 0) AS NUMBER (10, 2)) AS qteLivree,
          CAST (fc.QUANTITE - NVL (gr.QUANTITE, 0) AS NUMBER (10, 2))
             AS resteAlivrer,
          CAST (fcm.MONTANTTAUX AS NUMBER (32, 3)) AS MONTANTTAUX,
          CAST (fcm.MONTANT AS NUMBER (32, 5)) AS MONTANT,
          CAST (fcm.MONTANTAVOIRSANSTAUX AS NUMBER (32, 3))
             AS MONTANTAVOIRSANSTAUX,
          CAST (fcm.MONTANTAVOIRAVECTAUX AS NUMBER (32, 3))
             AS MONTANTAVOIRAVECTAUX,
          CAST (fcm.tva AS NUMBER (20, 3)) AS tva,
          fc.idactivite,
          ra.DESIGNATION AS activitelib,
          fc.mois,
          fc.annee,
          fc.heureDebut,
          fc.heureFin,
          mois.VAL AS moislib,
          CAST (0 AS NUMBER (32, 2)) AS tauxEuro,
          CAST (0 AS NUMBER (32, 2)) AS montantHTEuro,
          CAST (0 AS NUMBER (32, 2)) AS montantTVAEuro,
          CAST ( (fc.pu * fc.QUANTITE * fc.TVA) / 100 AS NUMBER (20, 3))
             AS montanttaxe,
          NVL (fc.majoration, 0) AS majoration,
          NVL (fc.reduction, 0) AS reduction,
          fc.DATEFACT,
          fc.RUBRIQUE,
          CASE WHEN fc.IDACTIVITE IS NOT NULL THEN r.RANG END AS rang,
          CASE WHEN fc.IDACTIVITE IS NOT NULL THEN ra.DATY END AS daty
     FROM facture_client_fille fc
          LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
          LEFT JOIN as_bondelivraison_cl_grp gr
             ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
          LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
          LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
          LEFT JOIN mois ON mois.id = fc.mois
          LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE;
		  
CREATE TABLE PAIEMENTFACTURE
(
  ID       VARCHAR2(100 BYTE),
  IDMVT    VARCHAR2(50 BYTE),
  IDFACT   VARCHAR2(500 BYTE),
  MONTANT  NUMBER(30,3)
)   ;
ALTER TABLE PAIEMENTFACTURE ADD (
  CONSTRAINT PK_PAIEMENTFACTURE
  PRIMARY KEY
  (ID));

ALTER TABLE PAIEMENTFACTURE ADD (
  CONSTRAINT FK_PAIEMENTFACT_FACTURECLIENT 
  FOREIGN KEY (IDFACT) 
  REFERENCES FACTURECLIENT (ID)
  ENABLE VALIDATE,
  CONSTRAINT FK_PAIEMENTFACT_JOURNALCAISSE 
  FOREIGN KEY (IDMVT) 
  REFERENCES JOURNALCAISSE (ID)
  ENABLE VALIDATE);
  
CREATE OR REPLACE  VIEW PAIEMENTFACTURESUM
(
   MONTANT,
   IDFACT
)
AS
     SELECT SUM (montant) AS montant, idfact
       FROM paiementfacture
   GROUP BY idfact;		  

/* Formatted on 01/10/2021 02:40:19 (QP5 v5.256.13226.35538) */
CREATE OR REPLACE  VIEW FACTURECLIENTMSUM_LIB
(
   ID,
   DATY,
   TIERS,
   DESIGNATION,
   TYPE,
   TVA,
   REMARQUE,
   IDUSER,
   DATE_ECHEANCE,
   ETAT,
   IDPREVISION,
   MONTANT,
   MONTANTTVA,
   MONTANTAVOIR,
   MONTANTTTC,
   MONTANTPAYE,
   MONTANTRESTE,
   TIERSLIB,
   CONTACT,
   ADRESSE,
   ESCALE,
   TYPELIB,
   IDCATEGORIE,
   CATEGORIELIB,
   IDPROVISION,
   IDPROVISIONLIB,
   ESTDDPMICTSL,
   DEVISEMERE,
   CODEPRESTATION,
   CODEPRESTATIONLIB,
   CODE,
   ESTMICTSL,
   CODEPROVISION
)
AS
   SELECT m.ID,
          m.DATY,
          m.TIERS,
          m.DESIGNATION,
          m.TYPE,
          m.TVA,
          '--' || m.remarque AS remarque,
          m.IDUSER,
          m.DATE_ECHEANCE,
          m.ETAT,
          m.idprevision,
          CAST (m.MONTANT AS NUMBER (32, 3)),
          CAST (M.MONTANTTVA AS NUMBER (32, 3)),
          CAST (M.MONTANTAVOIR AS NUMBER (32, 3)),
          CAST (M.MONTANTTTC AS NUMBER (32, 3)),
          CAST (NVL (pf.montant, 0) AS NUMBER (32, 3)) AS montantpaye,
          CAST (M.MONTANTTTC - NVL (pf.montant, 0) AS NUMBER (32, 3))
             AS montantreste,
          fup.NOM AS tierslib,
          fup.CONTACT,
          fup.ADRESSE,
          M.ESCALE,
          TYPELIB,
          m.IDCATEGORIE,
          m.CATEGORIELIB,
          IDPROVISION,
          IDPROVISIONLIB,
          m.ESTDDPMICTSL,
          m.devisemere,
          m.codePrestation,
          m.codePrestationlib,
          m.CODE,
          m.ESTMICTSL,
          codeprovision
     FROM factureclientMSum m
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
          LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id;
		  