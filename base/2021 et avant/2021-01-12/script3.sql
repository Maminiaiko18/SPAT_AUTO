 CREATE OR REPLACE FORCE VIEW REPORTDETAILSCAISSE AS
   SELECT r.id,
          '' AS idmere,
          c.val AS idingredient,
          '' AS iduser,
          r.montant AS quantiter,
          '' AS explication,
          r.etat,
          '' AS idcategorieingredient,
          r.daty,
          r.caisse AS iding,
          r.devise AS unite,
          '' AS COMPOSE,
          '' AS idcating
     FROM report r JOIN caisse c ON r.caisse = c.id
    WHERE r.etat >= 11;
	
CREATE OR REPLACE FORCE VIEW MVTCAISSEDETAILSLIB as
 SELECT fille.id,
          ca.ID AS idingredients,
          fille.DEBIT AS sortie,
          fille.CREDIT AS entree,
          fille.DATeeffet AS daty,
          fille.IDDEVISE AS unite,
          ca.val AS INGREDIENTs,
          ca.ID AS depot
     FROM journalcaisse fille JOIN caisse ca ON ca.ID = fille.CAISSE
    WHERE fille.etat >= 11;
	
CREATE OR REPLACE FORCE VIEW AS_ETATSTOCKVIDE
AS
   SELECT '-' AS id,
          '-' AS ingredients,
          '-' AS unite,
          CAST (0 AS NUMBER (10, 2)) AS entree,
          CAST (0 AS NUMBER (10, 2)) AS sortie,
          CAST (0 AS NUMBER (10, 2)) AS reste,
          CAST (0 AS NUMBER (10, 2)) AS report,
          '' AS daty,
          '' AS idcategorieingredient,
          '-' AS point,
          CAST (0 AS NUMBER (10, 2)) AS besoin,
          '-' AS idfournisseur,
          CAST (0 AS NUMBER (10, 2)) AS pu,
          CAST (0 AS NUMBER (10, 2)) AS montant,
          CAST (0 AS NUMBER (10, 2)) AS montantStock,
          '-' AS idingredient,
          '-' AS fournisseur,
          CAST (0 AS NUMBER (10, 2)) AS reportSuiv,
          CAST (0 AS NUMBER (10, 2)) AS ecart,
          '-' AS magasin,
          '-' AS typemagasin,
          CAST (0 AS NUMBER (10, 2)) AS pudonation,
          CAST (0 AS NUMBER (10, 2)) AS pugros,
          '-' AS idmagasin,
          CAST (0 AS NUMBER (15, 2)) AS pump,
          CAST (0 AS NUMBER (15, 2)) AS dernierprix,
          '-' AS idUnite
     FROM DUAL;