
create view FACTURE_CLIENT_MFVAOVAO
as
SELECT fi.*,
       fc.daty,
       fc.tiers,
       fc.designation AS designationmere,
       fc.TYPE,
       decode(fi.tva, null, fc.tva, fi.tva) AS TVAFILLE,
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;

	create or replace view factureFilleActivitePrestation as
select fcf.*,
       occ.id as idprestation
from FACTURE_CLIENT_FILLE_VM fcf
    left join ACTIVITE ac on fcf.IDACTIVITE = ac.ID
    left join OCCUPATIONMATERIELNAVAL occ on occ.ID=ac.REFOBJET;
	
create view occupationmaterielnavalfacture as
select *
from occupationmaterielnaval
where id in (select idPrestation from factureFilleActivitePrestation);

create or replace view occupationmaterielnavalfacture as
select *
from occupationmaterielnaval
where id in (select idPrestation from factureFilleActivitePrestation);


create view factureclientApayer as
select *
from facture_client_union
where MONTANTRESTE > 0;

create view activiteviseenonfacturee  as
select * from ACTIVITESNONFACTUREES where etat>=11;


CREATE OR REPLACE VIEW OCCUPMATERIELNAVALLIB
            (ID, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, IDNAVIRE, POSITION,
             OBSERVATION, ETAT, IDARRIVEE, IDARRIVEELIB, POSITIONLIB, DUREE, DATY, HEUREDEBUT, DATEFIN, HEUREFIN,
             ETATLIB, IDPREVISION, COMMANDANTID,IDACTIVITE,stFacture )
AS
select oc.id,
       oc.denomination       as idmateriel_naval,
       oc.valpilote          as idpilote,
       oc.valcommandant      as idcommandant,
       oc.valnatureoperation as idnatureoperation,
       oc.valmanoeuvrebord   as idmanoeuvrebord,
       oc.nomnavire          as idnavire,
       oc.position,
       oc.observation,
       oc.etat,
       oc.IDARRIVEE,
       oc.IDARRIVEELIB,
       oc.positionlib,
       oc.duree,
       oc.daty,
       oc.heuredebut,
       oc.datefin,
       oc.heurefin,
       oc.etatlib,
       oc.IDPREVISION,
       oc.IDCOMMANDANT       AS COMMANDANTID,
       fc.IDACTIVITE,
       case when fc.id is not null  then 'OUI'
        else 'NON' end  as estFacture
from OCCUPMATERIELNAVALLIBCOMPLET oc
    left join factureFilleActivitePrestation fc on fc.idprestation=oc.id
order by DATY desc ;

create or replace view occupationmaterielnavalfacture as
select o.*,
       c.id as idfacturefille,
       c.IDMERE as idfacturemere
from occupationmaterielnaval o
join  factureFilleActivitePrestation c on c.idprestation=o.id;


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
       u.VAL                                                                      AS UNITE,
       bcf.TVA,
       bcf.REMISE,
       (bcf.QUANTITE * bcf.pu) - nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0) as montantht,
       (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100                                    as montanttva,
       ((bcf.QUANTITE * bcf.pu) - nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0)) +
       (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100                                    as montantttc,
       nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0)                           as montantremise,
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

       uc.VAL                                                                     as unite,
       bcf.TVA,
       (bcf.QUANTITE * bcf.pu) - nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0) as montantht,
       (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100                                    as montanttva,
       ((bcf.QUANTITE * bcf.pu) - nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100), 0)) +
       (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100                                    as montant
from union_bcf_spat_cemedi bcf
         left join UNITECHANTIER uc on uc.id = bcf.UNITE;
		 
		 

create or replace
    view AS_BONDECOMMANDE_FILLE_LIB
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
