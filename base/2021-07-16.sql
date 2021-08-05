create or replace view AS_BONDECOMMANDE_FILLE_MONTANT
            (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA, REMISE, MONTANTHT,
             MONTANTTVA, MONTANTTTC, MONTANTREMISE, ETAT)
as
select bcf.ID,
       bcf.PRODUIT,
       bcf.IDBC,
       bcf.QUANTITE,
       bcf.PU,
       bcf.QUANTITEPARPACK,
       bcf.MONTANT,
       bcf.REMARQUE,
       u.VAL                                                                                        AS UNITE,
       bcf.TVA,
       bcf.REMISE,
       (bcf.QUANTITE * bcf.pu) - nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0)                   as montantht,
       ((bcf.QUANTITE * bcf.pu) - nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0)) * bcf.TVA / 100 as montanttva,
       ((bcf.QUANTITE * bcf.pu) - nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0)) +
       ((bcf.QUANTITE * bcf.pu) - nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0)) * bcf.TVA / 100 as montantttc,
       nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0)                                             as montantremise,
       bc.ETAT
from union_bcf_spat_cemedi bcf
         join union_bc_spat_cemedi bc on bc.id = bcf.IDBC
         LEFT JOIN UNITECHANTIER u ON U.ID = BCF.UNITE;
		 
	create or replace view AS_BONDECOMMANDE_FILLE_LIBELLE
            (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, REMARQUE, UNITE, TVA, MONTANTHT, MONTANTTVA, MONTANT)
as
select bcf.id,
       bcf.produit,
       bcf.idbc,
       bcf.quantite,
       bcf.pu,
       bcf.quantiteparpack,
       bcf.remarque,

       uc.VAL                                                                                       as unite,
       bcf.TVA,
       (bcf.QUANTITE * bcf.pu) - nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0)                  as montantht,
       ((bcf.QUANTITE * bcf.pu) - nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0)) * bcf.TVA / 100 as montanttva,
       ((bcf.QUANTITE * bcf.pu) - nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0)) +
       ((bcf.QUANTITE * bcf.pu) - nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0)) * bcf.TVA / 100  as montant
from union_bcf_spat_cemedi bcf
         left join UNITECHANTIER uc on uc.id = bcf.UNITE;

create or replace view AS_BONDECOMMANDE_FILLE_LIB
            (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA, MONTANTHT, MONTANTTVA,
             MONTANTTTC, ETAT, MONTANTREMISE)
as
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
       ETAT,
       MONTANTREMISE
from AS_BONDECOMMANDE_FILLE_MONTANT mon
         left join union_produit_tbd_cemedi pr on pr.id = mon.PRODUIT;
		 
		 create or replace view AS_BONDECOMMANDE_FILLE_GROUPER as
SELECT IDBC,
       sum(montantht)  as montantht,
       sum(montanttva) as montanttva,
       sum(montantttc) as montantttc,
       nvl(sum(montantremise),0) as montantremise
FROM AS_BONDECOMMANDE_FILLE_MONTANT
--WHERE ETAT >= 11
group by IDBC;