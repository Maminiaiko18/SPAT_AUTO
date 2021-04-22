------
create view bc_cemedi as
select cast('-' as VARCHAR2(100)) as id,
       cast('01/01/2020' as DATE) as daty,
       cast(1 as number(10))      as etat,
       cast('' as VARCHAR2(500))  as REMARQUE,
       cast('' as varchar2(500))  as DESIGNATION,
       cast('' as VARCHAR2(100))  as MODEPAIEMENT,
       cast('' as VARCHAR2(100))  as FOURNISSEUR,
       cast(20 as NUMBER(10))     as TVA
from dual;



create view bcf_cemedi as
select cast('-' as VARCHAR2(10)) as id,
       cast('' as VARCHAR2(150))    PRODUIT,
       cast('' as VARCHAR2(150)) as IDBC,
       cast(1 as NUMBER(10, 2))  as QUANTITE,
       cast(1 as NUMBER(38, 2))  as PU,
       cast(1 as NUMBER(10, 2))  as QUANTITEPARPACK,
       cast(1 as number(10, 2))  as MONTANT,
       cast('' as VARCHAR2(500)) as REMARQUE,
       cast(20 as NUMBER(38, 2)) as tva,
       cast('' as VARCHAR2(50))  as UNITE
from dual;

create materialized view bc_cemedi_vue as
select *
from bc_cemedi;

create materialized view bcf_cemedi_vue as
select *
from bcf_cemedi;


create view union_bc_spat_cemedi as
select ID,
       DATY,
       ETAT,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       NUMBC,
       PROJET,
       CODE_ETAB,
       DELAIPAIEMENT
from AS_BONDECOMMANDE
union
select id,
       daty,
       etat,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       '' as                 NUMBC,
       '' as                 PROJET,
       '' as                 CODE_ETAB,
       cast(0 as number(10)) DELAIPAIEMENT
from bc_cemedi_vue;

create view union_bcf_spat_cemedi (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA) as
select bcf.ID,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       UNITE,
       TVA
from AS_BONDECOMMANDE_FILLE bcf
union
select id,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       UNITE,
       tva
from bcf_cemedi_vue;
--
create or replace view AS_BONDELIVRAISON_LIBSUME as
select distinct b."ID",
                b."REMARQUE",
                b."IDBC",
                b."DATY",
                b."ETAT",
                b."POINT",
                b."ID_BC",
                bl.QUANTITE * bcf.pu                                                    as montant,
                (bl.QUANTITE * bcf.pu) * (bc.TVA / 100)                                 as montanttva,
                bl.QUANTITE * bcf.pu + (bl.QUANTITE * bcf.pu) * (bc.TVA / 100)          as montantttc,
                nvl((select montantttc from facturefournisseur_final ffl where ffl.IDBL = bl.NUMBL),
                    0)                                                                  as montant_facturer,
                nvl((select op.montant
                     from facturefournisseur_final ffl
                              join ORDONNERPAYEMENTGROUPEFACT op on ffl.idfacture = op.ded_id
                     where ffl.IDBL = bl.NUMBL),
                    0)                                                                  as montant_payer,
                bl.QUANTITE * bcf.pu + (bl.QUANTITE * bcf.pu) * (bc.TVA / 100) - nvl((select op.montant
                                                                                      from facturefournisseur_final ffl
                                                                                               join ORDONNERPAYEMENTGROUPEFACT op on ffl.idfacture = op.ded_id
                                                                                      where ffl.IDBL = bl.NUMBL),
                                                                                     0) as reste_a_payer,
                bl.QUANTITE * bcf.pu + (bl.QUANTITE * bcf.pu) * (bc.TVA / 100) -
                nvl((select montantttc from facturefournisseur_final ffl where ffl.IDBL = bl.NUMBL),
                    0)                                                                  as reste_a_facturer
from AS_BONDELIVRAISON_FILLE bl
         left join union_bcf_spat_cemedi bcf on bcf.ID = bl.IDBONDECOMMANDE
         left join union_bc_spat_cemedi bc on bc.id = bcf.IDBC
         right join as_bondelivraison b on b.id = bl.NUMBL;

create or replace view BONDECOMMANDE as
select bcf."ID",
       bcf."PRODUIT",
       bcf."IDBC",
       bcf."QUANTITE",
       bcf."PU",
       bcf."QUANTITEPARPACK",
       bcf."MONTANT",
       bcf."REMARQUE",
       bc.ETAT,
       bcf.UNITE,
       uc.VAL as uniteval,
       bc.NUMBC
from union_bcf_spat_cemedi bcf
         join union_bc_spat_cemedi bc on bc.id = bcf.IDBC
         left join UNITECHANTIER uc on uc.id = bcf.UNITE
/

create or replace view AS_BONDECOMMANDE_LIBELLE as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       mp.val         as modepaiement,
       bc.fournisseur,
       bc.tva,
       bc.NUMBC,
       ce.val         as CODE_ETAB,
       pe.designation as PROJET
from union_bc_spat_cemedi bc
         join modepaiement mp on bc.modepaiement = mp.id
         left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
         left join PROJET pe on pe.id = bc.projet
/

create or replace view AS_BONDECOMMANDE_LIB as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       mp.val         as modepaiement,
       tr.nom         AS FOURNISSEUR,
       bc.tva,
       bc.NUMBC,
       ce.val         as CODE_ETAB,
       pe.designation as PROJET
from union_bc_spat_cemedi bc
         join modepaiement mp on bc.modepaiement = mp.id
         JOIN tiers tr ON bc.fournisseur = tr.id
         left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
         left join PROJET pe on pe.id = bc.projet
/

create or replace view LIAISONDETAILSBCPRODUITLIBELLE as
select liaisonDetailsBCProduit.id
     , liaisonDetailsBCProduit.IDDETAILSBC
     , liaisonDetailsBCProduit.idproduit
     , AS_BONDECOMMANDE.daty
     , AS_BONDECOMMANDE.DESIGNATION as iddetailslib
     , AS_BONDECOMMANDE.fournisseur as idfournisseur
     , tiers.nom                    as fournisseur
     , as_produits.DESIGNATION      as produit
from liaisonDetailsBCProduit
         join union_bc_spat_cemedi AS_BONDECOMMANDE on AS_BONDECOMMANDE.id = liaisonDetailsBCProduit.IDDETAILSBC
         join as_produits on as_produits.id = liaisonDetailsBCProduit.IDPRODUIT
         join tiers on tiers.id = AS_BONDECOMMANDE.FOURNISSEUR
/

create or replace view BONDECOMMANDE_GROUPER as
select sum(QUANTITE) as quantite, IDbc
from union_bcf_spat_cemedi
group by IDBC
/

create or replace view BONCOMMANDE_FINAL as
select bcg.IDBC,
       bcg.quantite
from bondecommande_grouper bcg
         join union_bc_spat_cemedi bc on bc.id = bcg.IDBC;

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
       mp.val         as modepaiement_lib
from union_bc_spat_cemedi bc
         join modepaiement mp on bc.modepaiement = mp.id
         left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
         left join PROJET pe on pe.id = bc.projet
         left join TIERS ti on ti.ID = bc.fournisseur;

create or replace view AS_BONDELIVRAISON_MONTANT as
select mere."ID",
       mere."REMARQUE",
       mere."IDBC",
       mere."DATY",
       mere."ETAT",
       mere."POINT",
       mere."ID_BC",
       sum(fille.quantite * bcfille.pu) as montant,
       bcmere.tva
from as_bondelivraison mere
         left join as_bondelivraison_fille fille on mere.id = fille.numbl
         left join union_bcf_spat_cemedi bcfille on fille.idbondecommande = bcfille.id
         left join union_bc_spat_cemedi bcmere on bcmere.id = bcfille.idbc
where bcmere.etat >= 11
group by mere.id, mere.remarque, mere.idbc, mere.daty, mere.etat, mere.point, mere.id_bc, bcmere.tva
/

create or replace view AS_BONDECOMMANDE_FILLE_MONTATN as
select bcf.ID,
       bcf.PRODUIT,
       bcf.IDBC,
       bcf.QUANTITE,
       bcf.PU,
       bcf.QUANTITEPARPACK,
       bcf.MONTANT,
       bcf.REMARQUE,
       bcf.UNITE,
       bcf.TVA,
       (bcf.QUANTITE * bcf.pu)                                           as montantht,
       (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100                           as montanttva,
       (bcf.QUANTITE * bcf.pu) + (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100 as montantttc,
       bc.ETAT
from union_bcf_spat_cemedi bcf
         join union_bc_spat_cemedi bc on bc.id = bcf.IDBC
/

create or replace view BONDELIVRAION_AVEC_PU as
select blf.numbl,
       blf.qUANTITE    AS QUANTITE,
       IDBONDECOMMANDE as IDBCF,
       nvl(abf.Pu, 0)  as pu,
       ABF.IDBC,
       nvl(bc.TVA, 0)  as tva
from AS_BONDELIVRAISON_FILLE blf
         left JOIN union_bcf_spat_cemedi ABF on blf.IDBONDECOMMANDE = ABF.ID
         left join union_bc_spat_cemedi bc on bc.id = ABF.IDBC;


create or replace view AS_BONDECOMMANDE_FILLE_MONTANT as
select bcf.ID,
       bcf.PRODUIT,
       bcf.IDBC,
       bcf.QUANTITE,
       bcf.PU,
       bcf.QUANTITEPARPACK,
       bcf.MONTANT,
       bcf.REMARQUE,
       u.VAL                                                             AS UNITE,
       bcf.TVA,
       (bcf.QUANTITE * bcf.pu)                                           as montantht,
       (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100                           as montanttva,
       (bcf.QUANTITE * bcf.pu) + (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100 as montantttc,
       bc.ETAT
from union_bcf_spat_cemedi bcf
         join union_bc_spat_cemedi bc on bc.id = bcf.IDBC
         LEFT JOIN UNITECHANTIER u ON U.ID = BCF.UNITE;

CREATE OR REPLACE FORCE VIEW AS_BONDECOMMANDE_LIBELLE_TIERS
            ("ID", "DATY", "ETAT", "REMARQUE", "DESIGNATION", "MODEPAIEMENT", "FOURNISSEUR", "TVA", "NOMFOURNISSEUR",
             "NUMBC", "MONTANT", "MONTANTTVA", "MONTANTTTC", "IDFACTURE", "MONTANT_A_PAYER", "MONTANT_PAYE_REEL",
             "RESTEPAYERGENERAL", "RESTEAPAYERREEL", "CODE_ETAB", "PROJET", "ETATLIB", "DELAIPAIEMENT", "adresse",
             "remise")
AS
select distinct op.ID,
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
                cast(0 as number(20, 2))                    remise
from AS_BONDECOMMANDE_LIBELLE_LIB op
         left join union_bc_spat_cemedi bc on op.id = bc.ID
         join tiers ti on ti.NOM = op.FOURNISSEUR;

create or replace view AS_BONDELIVRAISON_FILLEQTE_RES as
SELECT blf."ID",
       blf."PRODUIT",
       blf."NUMBL",
       blf."QUANTITE",
       blf."QUANTITEPARPACK",
       blf."IDDETAILSFACTUREFOURNISSEUR",
       blf."IDBONDECOMMANDE",
       NVL(qff.QTE, 0)                                                AS facture,
       blf.QUANTITE - NVL(qff.QTE, 0)                                 AS quantitereste,
       bcf.PU,
       tiers.nom                                                      AS nomTiers,
       tiers.id                                                       as idtiers,
       bcf.TVA,
       cast((blf.QUANTITE * bcf.PU) as number(34, 2))                 as montantht,
       cast((blf.QUANTITE * bcf.PU * bcf.TVA) / 100 as number(34, 2)) as montanttva
FROM AS_BONDELIVRAISON_FILLE blf
         LEFT JOIN union_bcf_spat_cemedi bcf
                   ON bcf.id = blf.IDBONDECOMMANDE
         LEFT JOIN union_bc_spat_cemedi bc ON bc.id = bcf.idbc
         LEFT JOIN tiers ON tiers.id = bc.fournisseur
         LEFT JOIN DETAILSFACTUREFOURNISSEUR qff
                   ON qff.IDINGREDIENT = blf.id;

