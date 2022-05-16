CREATE OR REPLACE VIEW "BC_BL_LIVRE" ("ID", "PRODUIT", "IDBC", "QUANTITE", "PU", "QUANTITEPARPACK", "MONTANT", "REMARQUE", "QUANTITELIVRE", "QUANTITERESTE", "MONTANTBL", "MONTANTBLRESTE", "UNITE", "TVA", "REMISE", "MONTANTREMISE", "OBSERVATION", "MONTANTHTSANSREMISE") AS 
  SELECT BCF.ID,
       CASE WHEN BCF.PRODUIT IS NULL THEN BCF.REMARQUE ELSE ap.Nom END  AS PRODUIT,
       BCF.IDBC,
       BCF.QUANTITE,
       BCF.PU,
       BCF.QUANTITEPARPACK,
       BCF.MONTANT,
       BCF.REMARQUE,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitelivre,
       CAST(BCF.QUANTITE - NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitereste,
       CAST((NVL(BFG.qtelivre, 0) * BCF.PU) * (1-(bcf.remise/100)) AS NUMBER(30,2)) AS MontantBL,
       CAST(bcf.pu * (1-(bcf.remise/100)) * (bcf.quantite-NVL(BFG.qtelivre, 0)) AS NUMBER(30,2)) AS MontantBLreste,
       u.val                                     AS UNITE,
       bcf.TVA,
       bcf.REMISE,
       cast((BCF.REMISE * bcf.PU*bcf.QUANTITE) / 100 as NUMBER(30,2)) as montantRemise , 
       bcf.observation , 
       cast(bcf.quantite*bcf.pu AS NUMBER(30 , 3)) AS montanthtsansremise
FROM union_bcf_spat_cemedi BCF
         LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG
                   ON BFG.IDBONDECOMMANDE = BCF.ID
         LEFT JOIN union_produit_tbd_cemedi ap ON BCF.produit = ap.id
         LEFT JOIN union_unite_tbd_cemedi u ON bcf.UNITE = u.id;