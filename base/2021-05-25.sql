Insert into CONFIGURATION
   (ID, VALMIN, VALMAX, DESCE, TYPECONFIG)
 Values
   ('CONFEVP', '16', '16', 'Prix EVP', 'Fact');
COMMIT;

CREATE OR REPLACE FORCE VIEW FACTURE_CLIENT_MERE_FILLE
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
   DATY,
   TIERS,
   DESIGNATIONMERE,
   TYPE,
   TVA,
   REMARQUE,
   IDUSER,
   DATE_ECHEANCE,
   ETAT
)
AS
   SELECT fi."ID",
          fi."IDMERE",
          fi."DESIGNATION",
          fi."QUANTITE",
          fi."PU",
          fi."COMPTE",
          fi."IDPRODUIT",
          fi."DEVISE",
          fi."TAUX",
          fc.daty,
          fc.tiers,
          fc.designation AS designationmere,
          fc.TYPE,
          decode (fi.tva,null,fc.tva, fi.tva),
          fc.remarque,
          fc.iduser,
          fc.date_echeance,
          fc.etat
     FROM facture_client_fille fi
          LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;
		  
CREATE OR REPLACE FORCE VIEW FACTURE_CLIENT_FILLE_LIB_RESTE
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
   TVA
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
          CAST (fcm.MONTANTTAUX AS NUMBER (32, 2)),
          CAST (fcm.MONTANT AS NUMBER (32, 5)),
          CAST (fcm.MONTANTAVOIRSANSTAUX AS NUMBER (32, 2)),
          CAST (fcm.MONTANTAVOIRAVECTAUX AS NUMBER (32, 2)),
          CAST (fcm.tva AS NUMBER (20, 2))
     FROM facture_client_fille fc
          LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
          LEFT JOIN as_bondelivraison_cl_grp gr
             ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
          LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id;
