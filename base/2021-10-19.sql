CREATE OR REPLACE VIEW ETATPROVISIONVRAI
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
            SUM (fu.MONTANTPAYE) - SUM (NVL (FCUV.MONTANTTTC, 0)) AS ecart, --RAP
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0)
               AS MONTANTRESTE,
            ''
       FROM FACTURE_CLIENT_UNION fu
            --left JOIN FACTURE_CLIENT_UNION fac ON fa.id = fac.IDPROVISION
            LEFT JOIN FACTURE_CLIENT_UNION_VISE FCUV
               ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib;
CREATE OR REPLACE VIEW FACTURE_fourn_VISE_gp
        (
           MONTANT,
           MONTANTTVA,
           MONTANTAVOIR,
           MONTANTPAYE,
           MONTANTTTC,
           IDPROVISION
        )
        AS
         SELECT SUM (MONTANT) AS montant,
                SUM (MONTANTTVA) AS MONTANTTVA,
                SUM (MONTANTAVOIR) AS MONTANTAVOIR,
                SUM (MONTANTPAYE) AS MONTANTPAYE,
                SUM (MONTANTTTC) AS MONTANTTTC,
                IDPROVISION
           FROM factfourn_msum_lib
          WHERE ETAT >= 11
        GROUP BY IDPROVISION;			
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
            SUM (fu.MONTANTPAYE) - SUM (NVL (FCUV.MONTANTTTC, 0)) AS ecart, --RAP
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0)
               AS MONTANTRESTE,
            ''
       FROM factfourn_msum_lib fu
            LEFT JOIN FACTURE_fourn_VISE_gp FCUV ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib;			