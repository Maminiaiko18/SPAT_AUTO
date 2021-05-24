Insert into CONFIGURATION
   (ID, VALMIN, VALMAX, DESCE, TYPECONFIG)
 Values
   ('CONFEVP', '16', '16', 'Prix EVP', 'Fact');
COMMIT;

CREATE OR REPLACE FORCE VIEW SPAT.FACTURE_CLIENT_MERE_FILLE
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
