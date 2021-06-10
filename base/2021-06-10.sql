alter table FACTURE_CLIENT_FILLE add datefact date;
alter table OCCUPATIONMATERIELNAVAL add idprevision varchar2(200) constraint occupation_prevision_fk references PREVISION;	


create or replace view     FACTURE_CLIENT_FILLE_PLUS as
SELECT facture_client_fille.ID,
          facture_client_fille.IDMERE,
          facture_client_fille.DESIGNATION,
          facture_client_fille.QUANTITE,
          facture_client_fille.PU,
          facture_client_fille.COMPTE,
          facture_client_fille.IDPRODUIT,
          facture_client_fille.DEVISE,
          facture_client_fille.TAUX,
          CAST (0.0 AS NUMBER (30, 2)) AS montant,
		  facture_client_fille.tva,
       facture_client_fille.IDACTIVITE,
        FACTURE_CLIENT_FILLE.DATEFACT
     FROM facture_client_fille where 1>2;
	 
  CREATE OR REPLACE VIEW OCCUPATIONMATERIELNAVALLIB
(ID, DATY, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, HEUREDEBUT,
    HEUREFIN, IDNAVIRE, IDCLIENT, DUREE, POSITION, OBSERVATION, ETAT, DATEFIN,IDPREVISION) AS
  select
  OCCUPATIONMATERIELNAVAL.ID,
  OCCUPATIONMATERIELNAVAL.DATY,
	IDMATERIEL_NAVAL,
	pilote.val||' '|| pilote.desce as IDPILOTE,
	Commandant.val as IDCOMMANDANT,
	NATUREOPERATION.val as IDNATUREOPERATION,
	MANOEUVREBORD.val as IDMANOEUVREBORD,
	OCCUPATIONMATERIELNAVAL.HEUREDEBUT,
	OCCUPATIONMATERIELNAVAL.HEUREFIN,
	navire.nom as IDNAVIRE,
	IDCLIENT,
	OCCUPATIONMATERIELNAVAL.DUREE,
	OCCUPATIONMATERIELNAVAL.POSITION,
	OCCUPATIONMATERIELNAVAL.OBSERVATION,
	OCCUPATIONMATERIELNAVAL.ETAT,
	OCCUPATIONMATERIELNAVAL.DATEFIN,
     OCCUPATIONMATERIELNAVAL.IDPREVISION
  from OCCUPATIONMATERIELNAVAL
 -- left join MATERIEL_NAVAL on MATERIEL_NAVAL.id=OCCUPATIONMATERIELNAVAL.IDMATERIEL_NAVAL
  left join PILOTE on PILOTE.ID=OCCUPATIONMATERIELNAVAL.IDPILOTE
  left join COMMANDANT on COMMANDANT.id=OCCUPATIONMATERIELNAVAL.IDCOMMANDANT
  left join NATUREOPERATION on NATUREOPERATION.id=OCCUPATIONMATERIELNAVAL.IDNATUREOPERATION
  left join MANOEUVREBORD on MANOEUVREBORD.id=OCCUPATIONMATERIELNAVAL.IDMANOEUVREBORD
    left join MOUVEMENT mv on mv.id=OCCUPATIONMATERIELNAVAL.IDARRIVEE
 left join navire on navire.id=mv.id;

 create or replace view occupationmaterielnavallibcpl as
select oc.ID,
       oc.DATY,
       oc.IDMATERIEL_NAVAL,
       oc.IDPILOTE,
       oc.IDCOMMANDANT,
       oc.IDNATUREOPERATION,
       oc.IDMANOEUVREBORD,
       oc.HEUREDEBUT,
       oc.HEUREFIN,
       oc.IDNAVIRE,
       pr.CONSIGNATAIRE as IDCLIENT,
       oc.DUREE,
       oc.POSITION,
       oc.OBSERVATION,
       oc.ETAT,
       oc.DATEFIN,
       oc.IDPREVISION,
       c.VAL as idclientlib
from OCCUPATIONMATERIELNAVALLIB oc
         left join prevision pr on pr.id = oc.IDPREVISION
         left join CONSIGNATAIRE  c on c.id=pr.CONSIGNATAIRE;
		 
	CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, PRODUIT_LIB,
             ACTIVITELIB,DATEFACT) AS
select fi.ID,
       fi.IDMERE,
       fi.DESIGNATION,
       fi.QUANTITE,
       fi.PU,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fi.IDACTIVITE,
       fi.TVA,
       pr.nom         as produit_lib,
       ac.DESIGNATION as activitelib,
       fi.DATEFACT
from FACTURE_CLIENT_FILLE fi
         left join AS_PRODUITS pr on pr.id = fi.IDPRODUIT
         left join activite ac on ac.id = fi.IDACTIVITE;
