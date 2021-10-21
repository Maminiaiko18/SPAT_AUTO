CREATE OR REPLACE VIEW FACTURE_FOURN_MERE_VIDE
(
   ID,
   DATY,
   TIERS,
   DESIGNATION,
   TYPE,
   REMARQUE,
   CODE,
   MONTANT,
   IDCATEGORIE
)
AS
   SELECT CAST ('' AS VARCHAR2 (500)) AS id,
          CAST ('' AS DATE) AS daty,
          CAST ('' AS VARCHAR2 (100)) AS tiers,
          CAST ('' AS VARCHAR2 (1000)) AS designation,
          CAST ('' AS VARCHAR2 (500)) AS TYPE,
          CAST ('' AS VARCHAR2 (1000)) AS remarque,
          CAST ('' AS VARCHAR2 (200)) AS code,
          CAST (0 AS NUMBER (30, 3)) AS montant,
          CAST ('' AS VARCHAR2 (50)) AS idcategorie
     FROM DUAL;
	 
CREATE OR REPLACE VIEW ETATBPVRAI
(
   ID,
   MONTANTFACTURE,
   MONTANTPROVISION,
   MONTANTPAYE,
   ECART,
   TIERS,
   TIERSLIB,
   DATY,
   TIERSPROVISION,
   TIERSLIBPROVISION,
   MONTANTRESTE,
   IDPROVISION
)
AS
     SELECT fu.id,
            SUM (NVL (FCUV.MONTANTTTC, 0)) AS montantfacture,
            SUM (fu.MONTANTTTC) AS montantprovision,
            SUM (fu.MONTANTPAYE) AS MONTANTPAYE,
            0 AS ecart,
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0)
               AS MONTANTRESTE,
            ''
       FROM factfourn_msum_lib fu
            LEFT JOIN factfourn_msum_libv FCUV
               ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib;
CREATE OR REPLACE VIEW PAIEMENTFACTURESUM
(
   MONTANT,
   IDFACT
)
AS
     SELECT SUM (montant) AS montant, idfact
       FROM paiementfacture
   GROUP BY idfact;
   
CREATE OR REPLACE VIEW PAIEMENTFACTUREfSUM
(
   MONTANT,
   IDFACT
)
AS
     SELECT SUM (montant) AS montant, idfact
       FROM paiementfacturef
   GROUP BY idfact;   
   
CREATE OR REPLACE  VIEW FACTFOURN_MSUM_LIB
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
   CODEPROVISION,
   ETATLIB
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
          codeprovision,
          CASE
             WHEN m.etat = 1 THEN 'CREE'
             WHEN m.etat >= 11 THEN 'VISE'
             ELSE ''
          END
             AS etatlib
     FROM FACTFOURN_MSUM m
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
          LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id;
   
			