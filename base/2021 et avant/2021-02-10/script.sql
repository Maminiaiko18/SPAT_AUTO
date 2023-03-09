create or replace view BC_BL_LIVRE as
SELECT BCF.ID,
       CASE
           WHEN ap.Nom IS NULL THEN BCF.REMARQUE
           ELSE ap.Nom
           END                                                                        AS PRODUIT,
       BCF.IDBC,
       BCF.QUANTITE,
       BCF.PU,
       BCF.QUANTITEPARPACK,
       BCF.MONTANT,
       BCF.REMARQUE,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2))                                    AS quantitelivre,
       CAST(BCF.QUANTITE - NVL(BFG.qtelivre, 0) AS NUMBER(25, 2))                     AS quantitereste,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU                           AS MontantBL,
       (bcf.quantite * bcf.pu) - CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU AS MontantBLreste,
       u.DESCE                                                                        AS UNITE,
       bcf.TVA
FROM union_bcf_spat_cemedi BCF
         LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG ON
    BFG.IDBONDECOMMANDE = BCF.ID
         LEFT JOIN AS_PRODUITS ap ON
    BCF.produit = ap.id
         LEFT JOIN UNITECHANTIER u ON
    bcf.UNITE = u.id
/