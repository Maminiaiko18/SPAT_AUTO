CREATE OR REPLACE VIEW BC_BL_LIVRE
            (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, QUANTITELIVRE, QUANTITERESTE,
             MONTANTBL, MONTANTBLRESTE, UNITE, TVA)
AS
SELECT BCF.ID,
       CASE WHEN BCF.PRODUIT IS NULL THEN BCF.REMARQUE ELSE ap.Nom END
                                                   AS PRODUIT,
       BCF.IDBC,
       BCF.QUANTITE,
       BCF.PU,
       BCF.QUANTITEPARPACK,
       BCF.MONTANT,
       BCF.REMARQUE,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitelivre,
       CAST(BCF.QUANTITE - NVL(BFG.qtelivre, 0) AS NUMBER(25, 2))
                                                   AS quantitereste,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU
                                                   AS MontantBL,
       (bcf.quantite * bcf.pu)
           - CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU
                                                   AS MontantBLreste,
       u.DESCE                                     AS UNITE,
       bcf.TVA
FROM union_bcf_spat_cemedi BCF
         LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG
                   ON BFG.IDBONDECOMMANDE = BCF.ID
         LEFT JOIN union_produit_tbd_cemedi ap ON BCF.produit = ap.id
         LEFT JOIN union_unite_tbd_cemedi u ON bcf.UNITE = u.id;




CREATE OR REPLACE VIEW AS_BONDECOMMANDE_FILLE_LIB
            (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA,
             MONTANTHT, MONTANTTVA, MONTANTTTC, ETAT)
AS
select mon.ID,
       case when mon.produit is null then mon.remarque else pr.nom end,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       UNITE,
       TVA,
       MONTANTHT,
       MONTANTTVA,
       MONTANTTTC,
       ETAT

from AS_BONDECOMMANDE_FILLE_MONTANT mon
         left join union_produit_tbd_cemedi pr on pr.id = mon.PRODUIT;