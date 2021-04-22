
alter table MODEPAIEMENT modify val varchar2(500);
create or replace view BC_BL_LIVRE as
SELECT BCF.ID,
       CASE
           WHEN ap.Nom IS NULL THEN BCF.PRODUIT
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
       u.DESCE                                                                        AS UNITE
FROM union_bcf_spat_cemedi BCF
         LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG ON
    BFG.IDBONDECOMMANDE = BCF.ID
         LEFT JOIN AS_PRODUITS ap ON
    BCF.produit = ap.id
         LEFT JOIN UNITECHANTIER u ON
    bcf.UNITE = u.id
/

create or replace view BONDECOMMANDE_GROUPER as
select sum(QUANTITE) as quantite, IDbc
from union_bcf_spat_cemedi
group by IDBC
/

create or replace view AS_BONDECOMMANDE_FILLEQTE_REST as
SELECT BC."ID",
       BC."PRODUIT",
       BC."IDBC",
       BC."QUANTITE",
       BC."PU",
       BC."QUANTITEPARPACK",
       BC."MONTANT",
       BC."REMARQUE",
       cast(NVL(FF.QUANTITE, 0) as number(10, 2))               AS QTEFACTUREE,
       cast(BC.QUANTITE - NVL(FF.QUANTITE, 0) as number(10, 2)) AS QTERESTE,
        pu * bc.QUANTITE               as montantht,
       (pu * bc.QUANTITE * bc.tva) / 100 as montanttva
FROM union_bcf_spat_cemedi BC
         LEFT JOIN DETAILSFF_PARBC FF ON FF.IDINGREDIENT = BC.ID
/

create or replace view BONDELIVRAISON_PRIX as
select blf.numbl,
       BLF.ID,
       blf.qUANTITE                                                      AS QUANTITE,
       IDBONDECOMMANDE                                                   as IDBCF,
       nvl(abf.Pu, 0)                                                    as pu,
       ABF.IDBC,
       nvl(ABF.TVA, 0)                                                   as tva,
       BLF.QUANTITE * ABF.PU                                             AS mONTANTHT,
       (BLF.QUANTITE * ABF.PU * ABF.TVA) / 100                           AS MONTANTTVA,
       (BLF.QUANTITE * ABF.PU) + (BLF.QUANTITE * ABF.PU * ABF.TVA) / 100 AS MONTANTTTC
from AS_BONDELIVRAISON_FILLE blf
         left JOIN union_bcf_spat_cemedi ABF on blf.IDBONDECOMMANDE = ABF.ID
/

create or replace view AS_BONDECOMMANDE_FILLE_LIBELLE as
select bcf.id,
       bcf.produit,
       bcf.idbc,
       bcf.quantite,
       bcf.pu,
       bcf.quantiteparpack,
       bcf.remarque,

       uc.VAL                                                            as unite,
       bcf.TVA,
       bcf.pu * bcf.QUANTITE                                             as montantht,
       (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100                           as montanttva,
       (bcf.pu * bcf.QUANTITE) + (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100 as montant
from union_bcf_spat_cemedi bcf
         left join UNITECHANTIER uc on uc.id = bcf.UNITE
/
create or replace view AS_BONDECOMMANDE_DETSUMLIV as
select bcf.ID,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       bcf.TVA,
       nvl((select sum(bfl.QUANTITE)from AS_BONDELIVRAISON_FILLE bfl where bfl.IDBONDECOMMANDE=bcf.id group by IDBC),0) as quantitelivre,
       QUANTITE-nvl((select sum(bfl.QUANTITE)from AS_BONDELIVRAISON_FILLE bfl where bfl.IDBONDECOMMANDE=bcf.id group by IDBC),0) as quantitereste,
       uc.VAL as unite,
       pu*QUANTITE as montantht,
       (pu*QUANTITE*tva)/100 as montanttva
from union_bcf_spat_cemedi bcf
        left join UNITECHANTIER uc on uc.id=bcf.UNITE
/


