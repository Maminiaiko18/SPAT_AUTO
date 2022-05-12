CREATE OR REPLACE VIEW "AS_BONDECOMMANDE_LIBELLE_LIB" ("ID", "DATY", "ETAT", "REMARQUE", "DESIGNATION", "MODEPAIEMENT", "FOURNISSEUR", "TVA", "NUMBC", "MONTANT", "MONTANTTVA", "MONTANTTTC", "IDFACTURE", "MONTANT_PAYE_REEL", "RESTEPAYERGENERAL", "RESTEAPAYERREEL", "MONTANT_A_PAYER", "PROJET", "CODE_ETAB", "MONTANTFACTURE", "ETATLIB", "MONTANTREMISE", "IDENGAGEMENTLIB", "IDENGAGEMENT", "CODEETABLISSEMENT", "COMPTEBDG", "MONTANTHTSANSREMISE") AS 
  select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                                                      as fournisseur,
       cast(bc.tva as NUMBER(10)),
       bc.NUMBC,
       cast(nvl(c.montantht, 0) as number(32, 2)),
       cast(nvl(c.montanttva, 0) as number(32, 2)),
       cast(nvl(c.montantttc, 0) as NUMBER(32, 2)),
       ''                                                                          as idfacture,
       cast(nvl(lfac.montantpayer, 0) as number(32, 2))                            as montant_paye_reel,
       cast((nvl(c.montantttc, 0) - nvl((bl.MONTANTTTC), 0)) as NUMBER(32, 2))     as resteapayegeneral,
       cast((nvl(c.montantttc, 0) - nvl((lfac.montantpayer), 0)) as NUMBER(32, 2)) as resteapayerreel,
       cast(nvl(bl.montantttc, 0) as NUMBER(32, 2))                                as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       cast(lfac.montantttc as NUMBER(32, 2))                                      as montantfacture,
       case
           when bcf.RESTELIVRE > 0 then 'VISE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE(E)'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and
                (lfac.montantttc - nvl(lfac.montantpayer, 0) is not null)
               THEN 'FACTURE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) > 0
               THEN 'EN ATTENTE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYE(E)'
           else 'CREE(E)'
           END                                                                     as etatlib,
       cast(MONTANTREMISE as NUMBER(32, 2)),
       idengagementlib,
       IDENGAGEMENT,
       CODEETABLISSEMENT,
       CODE_ETAB || PROJET                                                       as comptebdg    , 
       CAST((c.montantht + montantremise) AS number(30 , 3)) AS montantHTSansRemise
from AS_BONDECOMMANDE_LIBELLE bc
     left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
     left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
     left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
     LEFT JOIN AS_BONDELIVRAISON_BC bl on bl.id_bc=bc.id
     left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur;

CREATE OR REPLACE VIEW "BC_BL_LIVRE" ("ID", "PRODUIT", "IDBC", "QUANTITE", "PU", "QUANTITEPARPACK", "MONTANT", "REMARQUE", "QUANTITELIVRE", "QUANTITERESTE", "MONTANTBL", "MONTANTBLRESTE", "UNITE", "TVA", "REMISE", "MONTANTREMISE", "OBSERVATION","MONTANTHTSANSREMISE") AS 
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
       u.val                                     AS UNITE,
       bcf.TVA,
       bcf.REMISE,
       cast((BCF.REMISE * bcf.PU*bcf.QUANTITE) / 100 as NUMBER(30,2)) as montantRemise , 
       bcf.observation,
       cast((bcf.quantite*bcf.pu) as NUMBER(30,2)) as montantHTSansRemise
FROM union_bcf_spat_cemedi BCF
         LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG
                   ON BFG.IDBONDECOMMANDE = BCF.ID
         LEFT JOIN union_produit_tbd_cemedi ap ON BCF.produit = ap.id
         LEFT JOIN union_unite_tbd_cemedi u ON bcf.UNITE = u.id;


