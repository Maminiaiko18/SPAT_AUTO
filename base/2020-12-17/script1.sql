alter table AS_BONDECOMMANDE add numbc varchar2(100);

alter table as_bondecommande_fille add unite varchar2(100) null constraint fk_unitechantier_bc references unitechantier;

create or replace view AS_BONDECOMMANDE_DETSUMLIV as
select bcf.ID,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       nvl((select sum(bfl.QUANTITE)from AS_BONDELIVRAISON_FILLE bfl where bfl.IDBONDECOMMANDE=bcf.id group by IDBC),0) as quantitelivre,
       QUANTITE-nvl((select sum(bfl.QUANTITE)from AS_BONDELIVRAISON_FILLE bfl where bfl.IDBONDECOMMANDE=bcf.id group by IDBC),0) as quantitereste,
       uc.VAL as unite
from AS_BONDECOMMANDE_FILLE bcf
        left join UNITECHANTIER uc on uc.id=bcf.UNITE;

create or replace view AS_BONDECOMMANDE_FILLE_LIBELLE as
select bcf.id,
       bcf.produit,
       bcf.idbc,
       bcf.quantite,
       bcf.pu,
       bcf.quantiteparpack,
       bcf.remarque,
       bcf.MONTANT,
       uc.VAL as unite
from as_bondecommande_fille bcf
     left join UNITECHANTIER uc on uc.id=bcf.UNITE;

create or replace view AS_BONDECOMMANDE_FILLEQTE_REST as
SELECT BC.ID,
       BC.PRODUIT,
       BC.IDBC,
       BC.QUANTITE,
       BC.PU,
       BC.QUANTITEPARPACK,
       BC.MONTANT,
       BC.REMARQUE,
       cast(NVL(FF.QUANTITE, 0) as number(10, 2))               AS QTEFACTUREE,
       cast(BC.QUANTITE - NVL(FF.QUANTITE, 0) as number(10, 2)) AS QTERESTE,
       uc.VAL as UNITE
FROM AS_BONDECOMMANDE_FILLE BC
         LEFT JOIN DETAILSFF_PARBC FF ON FF.IDINGREDIENT = BC.ID
        left join UNITECHANTIER uc on uc.id=bc.UNITE;

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
from AS_BONDECOMMANDE_FILLE bcf
         join AS_BONDECOMMANDE bc on bc.id = bcf.IDBC
        left join UNITECHANTIER uc on uc.id=bcf.UNITE;


create or replace view AS_BONDECOMMANDE_LIB as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       mp.val as modepaiement,
       tr.nom AS FOURNISSEUR,
       bc.tva,
       bc.NUMBC
from as_bondecommande bc
         join modepaiement mp on bc.modepaiement = mp.id
         JOIN tiers tr ON bc.fournisseur = tr.id;

create or replace view AS_BONDECOMMANDE_LIBELLE as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       mp.val as modepaiement,
       bc.fournisseur,
       bc.tva,
       bc.NUMBC
from as_bondecommande bc
         join modepaiement mp on bc.modepaiement = mp.id;

create or replace view AS_BONDECOMMANDE_LIBELLE_LIB as
select bc.id,
       daty,
       bc.etat,
       remarque,
       designation,
       modepaiement,
       ti.NOM as fournisseur,
       tva,
       bc.NUMBC
from AS_BONDECOMMANDE_LIBELLE bc
         left join TIERS ti on ti.id = bc.fournisseur;

create or replace view AS_BONDECOMMANDE_LIBELLE_TIERS as
select bc.ID,
       bc.DATY,
       bc.ETAT,
       bc.REMARQUE,
       bc.DESIGNATION,
       bc.MODEPAIEMENT,
       bc.FOURNISSEUR,
       bc.TVA,
       nvl(ti.NOM, '-') as nomfournisseur,
       bc.NUMBC
from AS_BONDECOMMANDE_LIBELLE bc
         left join TIERS ti on ti.id = bc.fournisseur;

create or replace view AS_BONDECOMMANDE_LIBELLECREE as
select *
from AS_BONDECOMMANDE_LIBELLE
where etat = 1;

create or replace view AS_BONDECOMMANDE_LIBELLEVISE as
select *
from AS_BONDECOMMANDE_LIBELLE
where etat = 11;    