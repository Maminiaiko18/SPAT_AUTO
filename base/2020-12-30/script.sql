create or replace view bondecommande_sumqte as
select IDBC,sum(QUANTITE) as quantite,etat from AS_BONDECOMMANDE_FILLE bcf
    join AS_BONDECOMMANDE bc on bcf.IDBC = bc.id
where etat>=11
group by IDBC,etat;


create or replace view quantite_bl as
select  numbl, SUM(quantite) AS QUANTITE
from AS_BONDELIVRAISON_FILLE
group by  numbl;
create view quantitelivre as
select b.id_bc ,sum(bl.QUANTITE) as qtelivre from AS_BONDELIVRAISON b
        join quantite_bl bl on bl.NUMBL=b.ID group by ID_BC;

create or replace view AS_BONDECOMMANDE_FILLE_FINAL AS
select bcf.IDBC,
       sum(bcf.QUANTITE)                       as quantitecommande,
       sum(nvl(bl.qtelivre,0))                        as quantitelivre,
       sum(nvl(ff.qte, 0))                     as quantitefacture,
       sum(bcf.QUANTITE) - sum(nvl(bl.qtelivre,0))    as restelivre,
       sum(bcf.QUANTITE) - sum(nvl(ff.qte, 0)) as restefacture,
       ETAT
from bondecommande_sumqte bcf
         left join quantitelivre bl on bl.ID_BC = bcf.IDBC
         left join DETAILSFF_groupe ff on ff.IDINGREDIENT = bcf.IDBC

group by bcf.IDBC, ETAT;

select *from AS_BONDECOMMANDE_LIBELLE_LIB;
create or replace view AS_BONDECOMMANDE_LIBELLE_LIB as
select       --B.ID AS IBBC,
    distinct bcl.id,
             bcl.daty,
             bcl.etat,
             bcl.remarque,
             bcl.designation,
             bcl.modepaiement,
             ti.NOM                                as fournisseur,
             bcl.tva,
             bcl.NUMBC,
             bc.montant,
             bc.montanttva,
             bc.montantttc,
             ff.idfacture,
             nvl(op.montant, 0)                    as montant_paye_reel,
             bc.montantttc - nvl(bl.montantttc, 0) as restepayergeneral,
             bc.montantttc - nvl(op.montant, 0)    as resteapayerreel,
             nvl(bl.montantttc, 0)                 as montant_a_payer,
             BCL.PROJET,
             bcl.CODE_ETAB,
             ff.montantttc                         as montantfacture,
             case
                 when b.RESTELIVRE > 0 then 'VISE'
                 WHEN B.restelivre = 0 AND B.restefacture > 0 THEN 'LIVRE'
                 WHEN B.restelivre = 0 AND B.restefacture = 0 THEN 'FACTURER'
                 WHEN bc.montantttc - nvl(op.montant, 0) = 0 THEN 'PAYER'
                 else 'CREER'
                 END                               as etatlib
from ORDONNERPAYEMENTGROUPEFACT op
         join facturefournisseur_final ff on ff.idfacture = op.DED_ID
         join BONLIVRAISON_FINAL_VISE bl on bl.numbl = ff.IDBL
         join boncommande_final bc on bc.IDBC = bl.IDBC
         right join AS_BONDECOMMANDE_LIBELLE bcl on bcl.ID = bc.idbc
         left join AS_BONDECOMMANDE_FILLE_FINAL b on b.IDBC = bCL.ID
         left join TIERS ti on ti.id = bcl.fournisseur
/