CREATE OR REPLACE VIEW PMTPROVDEFVISER AS SELECT ID, ID1, ID2, ETAT, MONTANT
FROM FCDEFPR
WHERE ETAT = 11;


               ALTER TABLE FCDEFPR 
ADD (montant DECIMAL(20,2) DEFAULT 0);

CREATE OR REPLACE VIEW ETATPROVISIONVRAI (ID, MONTANTFACTURE, MONTANTPROVISION, MONTANTPAYE, ECART, TIERS, TIERSLIB, DATY, TIERSPROVISION, TIERSLIBPROVISION, MONTANTRESTE, IDPROVISION, IDCATEGORIE) AS 
  SELECT fu.id,
       cast(SUM(NVL(FCUV.MONTANTTTC, 0)) as NUMBER(30,3)) AS montantfacture,
       cast(SUM(fu.MONTANTTTC) as NUMBER(30,3)) AS montantprovision,
       cast(SUM(fu.MONTANTPAYE) as NUMBER(30,3)) AS MONTANTPAYE,
       cast(SUM(fu.MONTANTPAYE) -  SUM(NVL(PMT.montant, 0)) - SUM(NVL(FCUV.MONTANTTTC, 0)) as NUMBER(30,3)) AS ecart, --RAP
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
       cast(SUM(fu.MONTANTTTC) - SUM(NVL(PMT.montant, 0)) - NVL(SUM(FCUV.MONTANTTTC), 0) as NUMBER(30,3))
               AS MONTANTRESTE,
            '',
       fu.idcategorie
       --FROM FACTURECLIENTMSUM_LIB  fu
       FROM FACTURE_CLIENT_UNION  fu
            LEFT JOIN FACTURE_CLIENT_UNION_VISE FCUV
               ON fu.id = FCUV.IDPROVISION
              LEFT JOIN PMTPROVDEFVISER pmt ON pmt.ID2 = fu.id
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib,
            fu.idcategorie 

