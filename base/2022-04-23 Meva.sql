CREATE OR REPLACE VIEW "BONDELIVRAISON_PRIX" ("NUMBL", "ID", "QUANTITE", "IDBCF", "PU", "IDBC", "TVA", "MONTANTHT", "MONTANTTVA", "MONTANTTTC") AS 
  select blf.numbl,
       BLF.ID,
       blf.qUANTITE                                                      AS QUANTITE,
       IDBONDECOMMANDE                                                   as IDBCF,
       nvl(abf.Pu, 0)                                                    as pu,
       ABF.IDBC,
       nvl(ABF.TVA, 0)                                                   as tva,
       blf.MONTANTHT                                             AS mONTANTHT,
       blf.MONTANTTVA                            AS MONTANTTVA,
       blf.montanttc AS MONTANTTTC
from AS_BONDELIVRAISON_FILLE_MTT blf
         left JOIN union_bcf_spat_cemedi ABF on blf.IDBONDECOMMANDE = ABF.ID;


CREATE OR REPLACE VIEW "AS_BONDECOMMANDE_LIBELLE_LIB" ("ID", "DATY", "ETAT", "REMARQUE", "DESIGNATION", "MODEPAIEMENT", "FOURNISSEUR", "TVA", "NUMBC", "MONTANT", "MONTANTTVA", "MONTANTTTC", "IDFACTURE", "MONTANT_PAYE_REEL", "RESTEPAYERGENERAL", "RESTEAPAYERREEL", "MONTANT_A_PAYER", "PROJET", "CODE_ETAB", "MONTANTFACTURE", "ETATLIB", "MONTANTREMISE", "IDENGAGEMENTLIB", "IDENGAGEMENT", "CODEETABLISSEMENT", "COMPTEBDG") AS 
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
       CODE_ETAB || PROJET                                                         as comptebdg
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
         left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
         LEFT JOIN BONDELIVRAISONPARBC bl ON bl.IDBC = bc.ID
         left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur;

CREATE OR REPLACE VIEW "AS_BONDELIVRAISON_FILLEQTE_RES" ("ID", "PRODUIT", "NUMBL", "QUANTITE", "QUANTITEPARPACK", "IDDETAILSFACTUREFOURNISSEUR", "IDBONDECOMMANDE", "FACTURE", "QUANTITERESTE", "PU", "NOMTIERS", "IDTIERS", "TVA", "MONTANTHT", "MONTANTTVA", "PROJET", "PROJETLIB", "CODE_ETABLISSEMENT", "CODE_ETABLISSEMENTLIB","remise") AS 
  SELECT blf.ID,
       blf.PRODUIT,
       blf.NUMBL,
       blf.QUANTITE,
       blf.QUANTITEPARPACK,
       blf.IDDETAILSFACTUREFOURNISSEUR,
       blf.IDBONDECOMMANDE,
       NVL(qff.quantite, 0)                                                AS facture,
       blf.QUANTITE - NVL(qff.quantite, 0)                                 AS quantitereste,
       bcf.PU,
       tiers.nom                                                      AS nomTiers,
       tiers.id                                                       as idtiers,
       bcf.TVA,
       cast((blf.QUANTITE * bcf.PU) as number(34, 2))                 as montantht,
       cast((blf.QUANTITE * bcf.PU * bcf.TVA) / 100 as number(34, 2)) as montanttva,
       bc.PROJET,
       pr.DESIGNATION                                                 as projetlib,
       bc.CODE_ETAB                                                   as code_etablissement,
       ce.VAL                                                         as code_etablissementlib,
       bcf.remise AS remise
FROM AS_BONDELIVRAISON_FILLE blf
         LEFT JOIN union_bcf_spat_cemedi bcf
                   ON bcf.id = blf.IDBONDECOMMANDE
         LEFT JOIN union_bc_spat_cemedi bc ON bc.id = bcf.idbc
         LEFT JOIN tiers ON tiers.id = bc.fournisseur
         LEFT JOIN FACTURE_FOURNISSEUR_QTE qff
                   ON qff.IDBLF = blf.id
         left join PROJET pr on pr.id = bc.PROJET
         left join CODEETABLISSEMENT ce on ce.id = CODE_ETAB;


         
