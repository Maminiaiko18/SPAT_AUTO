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

CREATE OR REPLACE FORCE VIEW ANALYSEGLOBALEFACTURE_VAOVAO
(
   NMFACT,
   DATY,
   CATEGORIE_FACTURE,
   SOUS_CATEGORIE_FACTURE,
   CLIENT,
   CATEGORIE_CLIENT,
   DESIGNATION,
   MTTC,
   MTHT,
   TAXE,
   DEVFACT,
   MTDEVISE,
   MTAVOIR,
   PAYE,
   RESTE,
   NUMCOMPTE,
   VALCAT
)
AS
   SELECT fc.id,
          fc.daty,
          cat.ID,
          '-',
          fc.tiers,
          cl.categorie,
          fc.designation,
          fc.montantttc,
          fc.montant,
          fc.montanttva,
          '-',
          fc.montantttc,
          fc.montantavoir,
          0,
          0,
          '-',
          cat.val
     FROM factureclientmsum_lib fc
          LEFT JOIN FACTURE_CLIENT_FILLE ff ON fc.id = FF.IDMERE
          LEFT JOIN ACTIVITE act ON ff.IDACTIVITE = act.ID
          LEFT JOIN RUBRIQUE_ACTIVITE rub ON act.RUBRIQUE = rub.ID
          LEFT JOIN CATEGORIEFACTURATION cat ON rub.CATEGORIE = cat.ID
          LEFT JOIN V_client_categorie cl ON fc.tiers = CL.CDCLT;
		  


INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00741003', 'Analyse', 'fa fa-area-chart', '/spat/pages/globalnegoce.jsp?but=exploitants/activites-analyse.jsp', 3, 3, 'MEN0074100');
