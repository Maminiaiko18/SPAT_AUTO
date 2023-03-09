
delete from typeff where val like '%Simple%';
create or replace view AS_BONDECOMMANDE_FILLE_LIBELLE as
select bcf.id, bcf.produit, bcf.idbc, bcf.quantite, bcf.pu, bcf.quantiteparpack, bcf.remarque,bcf.MONTANT
from as_bondecommande_fille bcf;

alter table AS_BONDELIVRAISON_FILLE add idbondecommande varchar2(100)constraint as_bondelivraison_fille_bc_fk references AS_BONDECOMMANDE_FILLE null;

create view as_bondecommande_DetSumLiv as
select bcf.ID,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       nvl((select sum(bfl.QUANTITE)from AS_BONDELIVRAISON_FILLE bfl where bfl.IDBONDECOMMANDE=bcf.id group by IDBC),0) as quantitelivre
from AS_BONDECOMMANDE_FILLE bcf;