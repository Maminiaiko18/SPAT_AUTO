alter table PROJET modify engage number(10,2);
alter table PROJET modify LIQUIDE number(10,2);
alter table PROJET modify EXERCICE number(10);

create or replace view FACTUREFOURNISSEUR_FINAL as
select IDMERE                                          as idfacture,
       sum(QTE * pu)                                   as montantht,
       DFF.TVA,
       (sum(QTE * pu) * dff.TVA) / 100                 as montanttva,
       sum(QTE * pu) + (sum(QTE * pu) * dff.TVA) / 100 as montantttc,
       FF.REMARQUE                                     as idbl

from DETAILSFACTUREFOURNISSEUR dff
         join FACTUREFOURNISSEUR ff on ff.id = dff.IDMERE
group by IDMERE, TVA, FF.REMARQUE;

create OR REPLACE view FACTUREFOURNISSEUR_FINAL_GROUP
AS
SELECT idbl,
       idfacture,
       SUM(montantht)  AS montantht,
       SUM(montanttva) AS montanttva,
       SUM(montantttc) AS montantttc


FROM FACTUREFOURNISSEUR_FINAL
GROUP BY idbl, idfacture;

CREATE or replace VIEW LIASIONINTRATABLE_FACTURE AS
SELECT ff.*,
       nvl(p.MONTANT, 0)                 as montantpayer,
       ff.montantttc - nvl(p.MONTANT, 0) as reste
FROM ORDONNERPAYEMENTGROUPEFACT P
         right join FACTUREFOURNISSEUR_FINAL_GROUP FF ON FF.IDFACTURE = P.DED_ID;

create or replace view AS_BONDECOMMANDE_FILLE_FINAL as
select bcf.IDBC,

       sum(bcf.QUANTITE)                            as quantitecommande,
       sum(nvl(bl.qtelivre, 0))                     as quantitelivre,
       sum(nvl(ff.qte, 0))                          as quantitefacture,
       sum(bcf.QUANTITE) - sum(nvl(bl.qtelivre, 0)) as restelivre,
       sum(bcf.QUANTITE) - sum(nvl(ff.qte, 0))      as restefacture,
       ETAT
from bondecommande_sumqte bcf
         left join quantitelivre bl on bl.ID_BC = bcf.IDBC
         left join DETAILSFF_groupe ff on ff.IDINGREDIENT = bcf.IDBC

group by bcf.IDBC, ETAT
/

create or REPLACE view bondelivraison_cmpl as
select lfac.*,
       ID_BC
from LIASIONINTRATABLE_FACTURE lfac
         join AS_BONDELIVRAISON bl on bl.id = lfac.idbl;


create or replace view bondelivraison_cmpl_groupe as
select cm.ID_BC,
       sum(cm.montantht)    as montantht,
       sum(cm.montanttva)   as montanttva,
       sum(cm.montantttc)   as montantttc,
       sum(cm.montantpayer) as montantpayer,
       sum(cm.reste)        as reste
from bondelivraison_cmpl cm
group by ID_BC;

create or replace view as_bondecommande_libelle_lib
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR,
             TVA, NUMBC, MONTANT, MONTANTTVA, MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL,
             RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET, CODE_ETAB, MONTANTFACTURE, ETATLIB)
AS

select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                as fournisseur,
       bc.tva,
       bc.NUMBC,
       nvl(lfac.montantht,0),
       nvl(lfac.montanttva,0),
       nvl(lfac.montantttc,0),
       ''                                    as idfacture,
       nvl(lfac.montantpayer,0)                     as montant_paye_reel,
       nvl(lfac.montantttc,0) - nvl((lfac.montantpayer),0) as resteapayegeneral,
       nvl(lfac.montantttc,0) - nvl((lfac.montantpayer),0) as resteapayerreel,
       nvl(lfac.montantttc, 0)               as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       lfac.montantttc                       as montantfacture,
       case
           when bcf.RESTELIVRE > 0 then 'VISE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0 and lfac.montantttc - nvl(lfac.montantpayer,0) !=  0 and lfac.montantttc - nvl(lfac.montantpayer,0) != 0 THEN 'LIVRE'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 THEN 'FACTURER'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0 and lfac.montantttc - nvl(lfac.montantpayer,0) = 0 THEN 'PAYER'
           else 'CREER'
           END                               as etatlib
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join bondelivraison_cmpl_groupe lfac on lfac.ID_BC = bc.ID
         left join TIERS ti on ti.ID = bc.fournisseur;


create or replace view AS_BONDECOMMANDE_LIBELLE_TIERS (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NOMFOURNISSEUR, NUMBC, MONTANT, MONTANTTVA, MONTANTTTC, IDFACTURE, MONTANT_A_PAYER, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, ETATLIB, CODE_ETAB, PROJET) AS
select op.*
from AS_BONDECOMMANDE_LIBELLE_LIB op

/