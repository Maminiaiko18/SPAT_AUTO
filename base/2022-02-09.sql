CREATE OR REPLACE VIEW AVOIRFCFILLE_FACTURE
(
   ID,
   IDMERE,
   IDDETAILFACTURE,
   MONTANT,
   COMPTE,
   REMISE,
   DATY,
   IDFACTURE,
   ETAT,
   DESIGNATION,
   CODE,
   CATEGORIE,
   MOTIF,
   TYPE,
   RUBRIQUE
)
AS
   SELECT fc.ID,
          fc.IDMERE,
          fc.IDDETAILFACTURE,
          fc.MONTANT,
          fcf.COMPTE,
          fc.REMISE,
          fcf.DATY,
          fc.IDFACTURE,
          fc.ETAT,
          fc.DESIGNATION,
          fc.CODE,
          fc.CATEGORIE,
          fc.MOTIF,
          fc.TYPE,
          fcf.RUBRIQUE
     FROM AVOIRFCFILLE_FM fc
          LEFT JOIN FACTURE_CLIENT_MONTANT fcf ON fc.IDDETAILFACTURE = fcf.ID;