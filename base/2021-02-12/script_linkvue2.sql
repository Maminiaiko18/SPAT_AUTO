
create materialized view tiers_cemedi as
select * from st_tiers@link_test_II ;



ALTER MATERIALIZED VIEW tiers_cemedi
    REFRESH COMPLETE START WITH (sysdate)
    NEXT SYSDATE + 30 / 86400;
    

create or replace view union_unite_tbd_cemedi as
select * from unitechantier
union
select * from unite_cemedi;

create or replace view union_tiers_tbd_cemedi as
select
*
from tiers
union
select
id,
raisonsocial as nom,
'' as description,
nif,
stat,
'' as contact,
'' as responsable,
adresse,
typetiers as type,
etat
from tiers_cemedi;

create or replace view AS_BONDECOMMANDE_LIBELLE_LIB
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB)
as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                             as fournisseur,
       bc.tva,
       bc.NUMBC,
       nvl(c.montantht, 0),
       nvl(c.montanttva, 0),
       nvl(c.montantttc, 0),
       ''                                                 as idfacture,
       nvl(lfac.montantpayer, 0)                          as montant_paye_reel,
       nvl(c.montantttc, 0) - nvl((bl.MONTANTTTC), 0)     as resteapayegeneral,
       nvl(c.montantttc, 0) - nvl((lfac.montantpayer), 0) as resteapayerreel,
       nvl(bl.montantttc, 0)                              as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       lfac.montantttc                                    as montantfacture,
       case
           when bcf.RESTELIVRE > 0 then 'VISE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE(E)'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) != 0
               THEN 'FACTURE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYE(E)'
           else 'CREE(E)'
           END                                            as etatlib
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
         left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
         LEFT JOIN BONDELIVRAISONPARBC bl ON bl.IDBC = bc.ID
         left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur
/

CREATE OR REPLACE FORCE VIEW AS_BONDECOMMANDE_LIBELLE_TIERS
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NOMFOURNISSEUR,
             NUMBC, MONTANT, MONTANTTVA, MONTANTTTC, IDFACTURE, MONTANT_A_PAYER, MONTANT_PAYE_REEL,
             RESTEPAYERGENERAL, RESTEAPAYERREEL, CODE_ETAB, PROJET, ETATLIB, DELAIPAIEMENT, ADRESSE,
             REMISE, TYPEPAIEMENT, DELAILIVRAISON)
AS
select op.ID,
       op.DATY,
       op.ETAT,
       op.REMARQUE,
       op.DESIGNATION,
       op.MODEPAIEMENT,
       ti.id                                    as FOURNISSEUR,
       op.TVA,
       op.FOURNISSEUR,
       op.NUMBC,
       cast(op.montant as number(10, 2))        as MONTANT,
       cast(op.MONTANTTVA as number(10, 2))     as MONTANTTVA,
       cast(op.MONTANTTTC as number(10, 2))     as MONTANTTTC,
       IDFACTURE,
       cast(MONTANT_A_PAYER as number(10, 2))   as MONTANTTTC,
       cast(MONTANT_PAYE_REEL as number(10, 2)) as MONTANT_PAYE_REEL,
       cast(RESTEPAYERGENERAL as number(10, 2)) as RESTEPAYERGENERAL,
       cast(RESTEAPAYERREEL as number(10, 2))   as RESTEAPAYERREEL,
       op.CODE_ETAB,
       op.PROJET,
       ETATLIB,
       bc.DELAIPAIEMENT,
       ti.ADRESSE,
       cast(0 as number(20, 2))                    remise,
       tc.VAL                                   as TYPEPAIEMENT,
       DELAILIVRAISON
from AS_BONDECOMMANDE_LIBELLE_LIB op
         left join union_bc_spat_cemedi bc on op.id = bc.ID
         left join union_tiers_tbd_cemedi ti on ti.NOM = op.FOURNISSEUR
         left join TYPECHEQUE tc on tc.id = bc.TYPEPAIEMENT;





create or replace view union_produit_tbd_cemedi as
select * from as_produits
union
select
id,
designation as nom,
designation,
'' as photo,
'' as calorie,
0 as poids,
'' as pa,
'' as idingredient,
sousgroupe as idouscategorie,
0 as numeroplat,
0 as prixl,
0 as poidsprecuit,
groupee as categorieingredient,
'' as cdg,
'' as ccg,
'' as cda,
'' as cca
from produit_cemedi;

create or replace  view AS_BONDECOMMANDE_FILLE_PRD as
SELECT BCF.*,
       pr.NOM as produitlib
FROM AS_BONDECOMMANDE_FILLE BCF
         left join union_produit_tbd_cemedi pr on pr.id = bcf.PRODUIT
/

create or REPLACE view BC_BL_LIVRE as
SELECT BCF.ID,
          CASE WHEN ap.Nom IS NULL THEN BCF.PRODUIT ELSE ap.Nom END
             AS PRODUIT,
          BCF.IDBC,
          BCF.QUANTITE,
          BCF.PU,
          BCF.QUANTITEPARPACK,
          BCF.MONTANT,
          BCF.REMARQUE,
          CAST (NVL (BFG.qtelivre, 0) AS NUMBER (25, 2)) AS quantitelivre,
          CAST (BCF.QUANTITE - NVL (BFG.qtelivre, 0) AS NUMBER (25, 2))
             AS quantitereste,
          CAST (NVL (BFG.qtelivre, 0) AS NUMBER (25, 2)) * BCF.PU
             AS MontantBL,
            (bcf.quantite * bcf.pu)
          - CAST (NVL (BFG.qtelivre, 0) AS NUMBER (25, 2)) * BCF.PU
             AS MontantBLreste,
          u.DESCE AS UNITE,
          bcf.TVA
     FROM union_bcf_spat_cemedi BCF
          LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG
             ON BFG.IDBONDECOMMANDE = BCF.ID
          LEFT JOIN union_produit_tbd_cemedi ap ON BCF.produit = ap.id
          LEFT JOIN union_unite_tbd_cemedi u ON bcf.UNITE = u.id
/



create or replace view LIAISONDETAILSBCPRODUITLIBELLE as
select liaisonDetailsBCProduit.id
     , liaisonDetailsBCProduit.IDDETAILSBC
     , liaisonDetailsBCProduit.idproduit
     , AS_BONDECOMMANDE.daty
     , AS_BONDECOMMANDE.DESIGNATION         as iddetailslib
     , AS_BONDECOMMANDE.fournisseur         as idfournisseur
     , union_tiers_tbd_cemedi.nom                            as fournisseur
     , union_produit_tbd_cemedi.DESIGNATION as produit
from liaisonDetailsBCProduit
         join union_bc_spat_cemedi AS_BONDECOMMANDE on AS_BONDECOMMANDE.id = liaisonDetailsBCProduit.IDDETAILSBC
         join union_produit_tbd_cemedi on union_produit_tbd_cemedi.id = liaisonDetailsBCProduit.IDPRODUIT
         join union_tiers_tbd_cemedi on union_tiers_tbd_cemedi.id = AS_BONDECOMMANDE.FOURNISSEUR
/


create or replace view AS_BONDECOMMANDE_LIBS as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.MODEPAIEMENT,
       bc.fournisseur,
       bc.tva,
       bc.NUMBC,
       bc.CODE_ETAB,
       bc.PROJET,
       ti.NOM         as fournisseur_lib,
       ce.val         as CODE_ETAB_lib,
       pe.designation as PROJET_lib,
       mp.val         as modepaiement_lib,
       DELAIPAIEMENT
from union_bc_spat_cemedi bc
         join modepaiement mp on bc.modepaiement = mp.id
         left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
         left join PROJET pe on pe.id = bc.projet
         left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur;
         
         create or replace view AS_BONDECOMMANDE_FILLE_LIB as
select mon.ID,
       nvl(pr.NOM, PRODUIT) as PRODUIT,
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
         left join union_produit_tbd_cemedi pr on pr.id = mon.PRODUIT
/

create or replace view AS_BONDECOMMANDE_LIBS as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.MODEPAIEMENT,
       bc.fournisseur,
       bc.tva,
       bc.NUMBC,
       bc.CODE_ETAB,
       bc.PROJET,
       ti.NOM         as fournisseur_lib,
       ce.val         as CODE_ETAB_lib,
       pe.designation as PROJET_lib,
       mp.val         as modepaiement_lib,
       DELAIPAIEMENT
from union_bc_spat_cemedi bc
         join modepaiement mp on bc.modepaiement = mp.id
         left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
         left join PROJET pe on pe.id = bc.projet
         left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur
/
