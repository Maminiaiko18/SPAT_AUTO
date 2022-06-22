CREATE OR REPLACE VIEW "BC_BL_LIVRE" ("ID", "PRODUIT", "IDBC", "QUANTITE", "PU", "QUANTITEPARPACK", "MONTANT", "REMARQUE", "QUANTITELIVRE", "QUANTITERESTE", "MONTANTBL", "MONTANTBLRESTE", "UNITE", "TVA", "REMISE", "MONTANTREMISE", "OBSERVATION", "MONTANTHTSANSREMISE", "MONTANTTVA", "TAUX", "DEVISE") AS 
  SELECT BCF.ID,
       CASE WHEN BCF.PRODUIT IS NULL THEN BCF.REMARQUE ELSE ap.Nom END  AS PRODUIT,
       BCF.IDBC,
       BCF.QUANTITE,
       BCF.PU,
       BCF.QUANTITEPARPACK,
       CAST((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1))*(1-(remise/100))  AS NUMBER(30 , 3)) as montant , 
       BCF.REMARQUE,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitelivre,
       CAST(BCF.QUANTITE - NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitereste,
       CAST((NVL(BFG.qtelivre, 0) * BCF.PU* nvl(bcf.taux,1)) * (1-(bcf.remise/100)) AS NUMBER(30,2)) AS MontantBL,
       CAST(bcf.pu *nvl(bcf.taux,1) *(1-(bcf.remise/100)) * (bcf.quantite-NVL(BFG.qtelivre, 0)) AS NUMBER(30,2)) AS MontantBLreste,
       u.val                                     AS UNITE,
       bcf.TVA,
       bcf.REMISE,
       cast((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)*bcf.remise) / 100 as NUMBER(30,2)) as montantRemise , 
       bcf.observation , 
       cast(bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)AS NUMBER(30 , 3)) AS montanthtsansremise , 
       CAST(((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1))*(1-(remise/100)) * bcf.tva)/100 AS number(30 , 3)) AS  montantTVA,
       CAST(bcf.taux as number(10,2)) as taux,
        bcf.devise
FROM union_bcf_spat_cemedi BCF
         LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG
                   ON BFG.IDBONDECOMMANDE = BCF.ID
         LEFT JOIN union_produit_tbd_cemedi ap ON BCF.produit = ap.id
         LEFT JOIN union_unite_tbd_cemedi u ON bcf.UNITE = u.id;