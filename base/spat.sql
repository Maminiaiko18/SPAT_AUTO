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
CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, PRODUIT_LIB,
             ACTIVITELIB, DATEFACT)
AS
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
       cast(to_date(fi.DATEFACT, 'DD/MM/YY') as VARCHAR2(100)) AS DATEFACT
from FACTURE_CLIENT_FILLE fi
         left join AS_PRODUITS pr on pr.id = fi.IDPRODUIT
         left join activite ac on ac.id = fi.IDACTIVITE;
CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT,
             RUBRIQUELIB, navire,BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE,
             UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE, CLIENTLIB, REDEVANCELIB,
             DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE, DATEFACT)
AS
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                   AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION             AS rubriquelib,
       nv.id                      as navire,
       nv.NOM                     AS bateaulib,
       nv.PLT                     AS poids,
       nv.LHT                     AS longueur,
       nv.LM                      AS largeur,
       CAST('-' AS VARCHAR2(100)) AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                    AS clientlib,
       re.VAL                     AS redevancelib,
       di.LIBELLEDIR              AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                  AS ETATLIB,

       ra.CATEGORIE,
       cf.val                     as categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART            as DATEFACT
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE

         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf on ra.categorie = cf.id
         left join PREVISION pre on pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE;
create or replace view ACTIVITELIBCOMPLET_A as
SELECT *
     FROM ACTIVITELIBCOMPLET
    WHERE ETAT = 0;
create or replace view ACTIVITELIBCOMPLET_C as
SELECT *
     FROM ACTIVITELIBCOMPLET
    WHERE ETAT = 1;
create or replace view ACTIVITELIBCOMPLET_V as
SELECT *
     FROM ACTIVITELIBCOMPLET
    WHERE ETAT = 11;
create or replace view ACTIVITESFACTUREES as
select *from ACTIVITELIBCOMPLET ac
where id in (select idactivite from facture_client_fille_vm WHERE ac.id = IDACTIVITE);

  alter table commandant add iduser number(10) constraint fk_utilisateur_commandant references  UTILISATEUR;
create OR REPLACE view FACTURE_CLIENT_FILLE_LIBELLE as
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
       to_date(fi.DATEFACT, 'dd/MM/YY') AS DATEFACT
from FACTURE_CLIENT_FILLE fi
         left join AS_PRODUITS pr on pr.id = fi.IDPRODUIT
         left join activite ac on ac.id = fi.IDACTIVITE;
create table jour_ferie
(
    id          varchar2(100)
        constraint jour_ferie_pk primary key,
    daty        date,
    designation varchar2(500)
);
CREATE SEQUENCE seqjour_ferie
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;
create or replace FUNCTION get_seqjour_ferie
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqjour_ferie.nextval INTO retour FROM dual;
  return retour;
END;
CREATE OR REPLACE VIEW OCCUPATIONMATERIELNAVALLIB (ID, DATY, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, HEUREDEBUT, HEUREFIN, IDNAVIRE, IDCLIENT, DUREE, POSITION, OBSERVATION, ETAT, DATEFIN, IDPREVISION) AS
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
CREATE OR REPLACE VIEW OCCUPATIONMATERIELNAVALLIBCPL
            (ID, DATY, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, HEUREDEBUT,
             HEUREFIN, IDNAVIRE, IDCLIENT, DUREE, POSITION, OBSERVATION, ETAT, DATEFIN, IDPREVISION,
             IDCLIENTLIB, CARGAISON, CARGAISONlib, pavillon, pavillonlib)
AS
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
       pr.CONSIGNATAIRE  as IDCLIENT,
       oc.DUREE,
       oc.POSITION,
       oc.OBSERVATION,
       oc.ETAT,
       oc.DATEFIN,
       oc.IDPREVISION,
       c.VAL             as idclientlib,
       pr.CARGAISON,
       pr.VALCARGAISON   as CARGAISONlib,
       pr.PAVILLONNAVIRE as pavillon,
       pa.VAL            as pavillonlib
from OCCUPATIONMATERIELNAVALLIB oc
         left join PREVISIONLIBCOMPLET pr on pr.id = oc.IDPREVISION
         left join CONSIGNATAIRE c on c.id = pr.CONSIGNATAIRE
         left join pays pa on pa.id = pr.PAVILLONNAVIRE;
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM08', 'Jours fériés', 'fa fa-calendar', '#', 9, 3, 'MENM01');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM09', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=exploitant/jourferie-saisie.jsp', 1, 4, 'MENM08');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM10', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=exploitant/jourferie-liste.jsp', 2, 4, 'MENM08');
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMEN00020', '1300', 'MEN0001', NULL, NULL, NULL, null);
alter table JOUR_FERIE add heuredebut varchar2(100);
CREATE OR REPLACE VIEW OCCUPMATERIELNAVALLIBCOMPLET (ID, DATY, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, HEUREDEBUT, HEUREFIN, IDNAVIRE, IDCLIENT, DUREE, POSITION, OBSERVATION, ETAT, DATEFIN, IDARRIVEE, DENOMINATION, DATE_AQUISITION, IDMARQUE, PUISSANCE, DETENTEUR, MAINTENANCE, IDTYPE_MATERIEL, IMMATRICULATION, ETATMATERIELNAVAL, VALMARQUE, DESCEMARQUE, VALTYPEMATERIEL, DESCETYPEMATERIEL, VALPILOTE, DESCEPILOTE, VALCOMMANDANT, DESCECOMMANDANT, VALNATUREOPERATION, DESCENATUREOPERATION, VALMANOEUVREBORD, DESCEMANOEUVREBORD, REFERENCE, NOMNAVIRE, PAVILLONNAVIRE, JNT, JBT, PLT, LHT, LM, TE, VOLUME, REMARQUE, VALPAVILLON, DESCEPAVILLON, IDARRIVEELIB, POSITIONLIB, ETATLIB, IDPREVISION) AS
  SELECT occup.ID,
          occup.DATY,
          occup.IDMATERIEL_NAVAL,
          occup.IDPILOTE,
          occup.IDCOMMANDANT,
          occup.IDNATUREOPERATION,
          occup.IDMANOEUVREBORD,
          occup.HEUREDEBUT,
          occup.HEUREFIN,
          occup.IDNAVIRE,
          occup.IDCLIENT,
          occup.DUREE,
          occup.POSITION,
          occup.OBSERVATION,
          occup.ETAT,
          occup.DATEFIN,
          occup.IDARRIVEE,
          mat.denomination,
          mat.DATE_AQUISITION,
          mat.IDMARQUE,
          mat.PUISSANCE,
          mat.DETENTEUR,
          mat.MAINTENANCE,
          mat.IDTYPE_MATERIEL,
          mat.IMMATRICULATION,
          mat.etat AS etatmaterielnaval,
          mat.valmarque,
          mat.descemarque,
          mat.valtypemateriel,
          mat.descetypemateriel,
          p.VAL AS valpilote,
          p.DESCE AS descepilote,
          comm.val AS valcommandant,
          comm.DESCE AS descecommandant,
          nat.val AS valnatureoperation,
          nat.DESCE AS descenatureoperation,
          manb.val AS valmanoeuvrebord,
          manb.DESCE AS descemanoeuvrebord,
          nav.reference,
          nav.nom AS nomnavire,
          nav.pavillon AS pavillonnavire,
          nav.jnt,
          nav.JBT,
          nav.PLT,
          nav.LHT,
          nav.lm,
          nav.te,
          nav.volume,
          nav.remarque,
          nav.valpavillon,
          nav.descepavillon,
          ML.ESCALE || '-' || ML.NAVIRELIB AS IDARRIVEELIB,
          CASE
             WHEN POSITION = '1' THEN 'Tribord'
             WHEN POSITION = '2' THEN 'babord '
             ELSE '-'
          END
             AS positionlib,
          CASE
             WHEN occup.etat = 1 THEN 'CREER'
             WHEN occup.etat = 11 THEN 'VISEE'
          END
             AS ETATLIB,
             occup.IDPREVISION
     FROM OCCUPATIONMATERIELNAVAL occup
          LEFT JOIN MATERIELNAVALLIBCOMPLET mat
             ON mat.ID = occup.IDMATERIEL_NAVAL
          LEFT JOIN pilote p ON p.ID = occup.IDPILOTE
          LEFT JOIN COMMANDANT comm ON comm.id = occup.IDCOMMANDANT
          LEFT JOIN NATUREOPERATION nat ON nat.id = occup.IDNATUREOPERATION
          LEFT JOIN MANOEUVREBORD manb ON manb.id = occup.IDMANOEUVREBORD
          LEFT JOIN MOUVEMENT_LIBCOMPLET ML ON ML.ID = occup.IDARRIVEE
		  LEFT JOIN NAVIRELIBCOMPLET nav ON nav.ID = ml.NAVIRE;
CREATE OR REPLACE VIEW OCCUPMATERIELNAVALLIB (ID, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, IDNAVIRE, POSITION, OBSERVATION, ETAT, IDARRIVEE, IDARRIVEELIB, POSITIONLIB, DUREE, DATY, HEUREDEBUT, DATEFIN, HEUREFIN, ETATLIB, IDPREVISION) AS
  select id,
       denomination       as idmateriel_naval,
       valpilote          as idpilote,
       valcommandant      as idcommandant,
       valnatureoperation as idnatureoperation,
       valmanoeuvrebord   as idmanoeuvrebord,
       nomnavire          as idnavire,
       position,
       observation,
       etat,
       IDARRIVEE,
       IDARRIVEELIB,
       positionlib,
       duree,
       daty,
        heuredebut,
         datefin,
          heurefin,
       etatlib,
       IDPREVISION
from OCCUPMATERIELNAVALLIBCOMPLET
order by DATY desc;
CREATE OR REPLACE VIEW OCCUPMATERIELNAVALLIB (ID, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, IDNAVIRE, POSITION, OBSERVATION, ETAT, IDARRIVEE, IDARRIVEELIB, POSITIONLIB, DUREE, DATY, HEUREDEBUT, DATEFIN, HEUREFIN, ETATLIB, IDPREVISION,COMMANDANTID) AS
  select id,
       denomination       as idmateriel_naval,
       valpilote          as idpilote,
       valcommandant      as idcommandant,
       valnatureoperation as idnatureoperation,
       valmanoeuvrebord   as idmanoeuvrebord,
       nomnavire          as idnavire,
       position,
       observation,
       etat,
       IDARRIVEE,
       IDARRIVEELIB,
       positionlib,
       duree,
       daty,
        heuredebut,
         datefin,
          heurefin,
       etatlib,
       IDPREVISION,
       IDCOMMANDANT AS COMMANDANTID
from OCCUPMATERIELNAVALLIBCOMPLET
order by DATY desc;
create or replace view occupmaterielnavallibC as
select *
from occupmaterielnavallib where ETAT=1;
create or replace view occupmaterielnavallibV as
select *
from occupmaterielnavallib where ETAT=11;
CREATE OR REPLACE  VIEW OCCUPATIONMATERIELNAVALLIBCPL
(
   ID,
   DATY,
   IDMATERIEL_NAVAL,
   IDPILOTE,
   IDCOMMANDANT,
   IDNATUREOPERATION,
   IDMANOEUVREBORD,
   HEUREDEBUT,
   HEUREFIN,
   IDNAVIRE,
   IDCLIENT,
   DUREE,
   POSITION,
   OBSERVATION,
   ETAT,
   DATEFIN,
   IDPREVISION,
   IDCLIENTLIB,
   CARGAISON,
   CARGAISONLIB,
   PAVILLON,
   PAVILLONLIB
)
AS
   SELECT oc.ID,
          oc.DATY,
          oc.IDMATERIEL_NAVAL,
          oc.IDPILOTE,
          oc.IDCOMMANDANT,
          oc.IDNATUREOPERATION,
          oc.IDMANOEUVREBORD,
          oc.HEUREDEBUT,
          oc.HEUREFIN,
          oc.IDNAVIRE,
          pr.CONSIGNATAIRE AS IDCLIENT,
          oc.DUREE,
          oc.POSITION,
          oc.OBSERVATION,
          oc.ETAT,
          oc.DATEFIN,
          oc.IDPREVISION,
          c.nomclt AS idclientlib,
          pr.CARGAISON,
          pr.VALCARGAISON AS CARGAISONlib,
          pr.PAVILLONNAVIRE AS pavillon,
          pa.VAL AS pavillonlib
     FROM OCCUPATIONMATERIELNAVALLIB oc
          LEFT JOIN PREVISIONLIBCOMPLET pr ON pr.id = oc.IDPREVISION
          LEFT JOIN clientmat c ON c.cdclt = pr.CONSIGNATAIRE
          LEFT JOIN pays pa ON pa.id = pr.PAVILLONNAVIRE;CREATE OR REPLACE VIEW OCCUPMATERIELNAVALLIBCOMPLET (ID, DATY, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, HEUREDEBUT, HEUREFIN, IDNAVIRE, IDCLIENT, DUREE, POSITION, OBSERVATION, ETAT, DATEFIN, IDARRIVEE, DENOMINATION, DATE_AQUISITION, IDMARQUE, PUISSANCE, DETENTEUR, MAINTENANCE, IDTYPE_MATERIEL, IMMATRICULATION, ETATMATERIELNAVAL, VALMARQUE, DESCEMARQUE, VALTYPEMATERIEL, DESCETYPEMATERIEL, VALPILOTE, DESCEPILOTE, VALCOMMANDANT, DESCECOMMANDANT, VALNATUREOPERATION, DESCENATUREOPERATION, VALMANOEUVREBORD, DESCEMANOEUVREBORD, REFERENCE, NOMNAVIRE, PAVILLONNAVIRE, JNT, JBT, PLT, LHT, LM, TE, VOLUME, REMARQUE, VALPAVILLON, DESCEPAVILLON, IDARRIVEELIB, POSITIONLIB, ETATLIB, IDPREVISION) AS
  SELECT occup.ID,
          occup.DATY,
          occup.IDMATERIEL_NAVAL,
          occup.IDPILOTE,
          occup.IDCOMMANDANT,
          occup.IDNATUREOPERATION,
          occup.IDMANOEUVREBORD,
          occup.HEUREDEBUT,
          occup.HEUREFIN,
          occup.IDNAVIRE,
          occup.IDCLIENT,
          occup.DUREE,
          occup.POSITION,
          occup.OBSERVATION,
          occup.ETAT,
          occup.DATEFIN,
          occup.IDARRIVEE,
          mat.denomination,
          mat.DATE_AQUISITION,
          mat.IDMARQUE,
          mat.PUISSANCE,
          mat.DETENTEUR,
          mat.MAINTENANCE,
          mat.IDTYPE_MATERIEL,
          mat.IMMATRICULATION,
          mat.etat AS etatmaterielnaval,
          mat.valmarque,
          mat.descemarque,
          mat.valtypemateriel,
          mat.descetypemateriel,
          p.VAL AS valpilote,
          p.DESCE AS descepilote,
          comm.val AS valcommandant,
          comm.DESCE AS descecommandant,
          nat.val AS valnatureoperation,
          nat.DESCE AS descenatureoperation,
          manb.val AS valmanoeuvrebord,
          manb.DESCE AS descemanoeuvrebord,
          nav.reference,
          nav.nom AS nomnavire,
          nav.pavillon AS pavillonnavire,
          nav.jnt,
          nav.JBT,
          nav.PLT,
          nav.LHT,
          nav.lm,
          nav.te,
          nav.volume,
          nav.remarque,
          nav.valpavillon,
          nav.descepavillon,
          ML.ESCALE || '-' || ML.NAVIRELIB AS IDARRIVEELIB,
          CASE
             WHEN POSITION = '1' THEN 'Tribord'
             WHEN POSITION = '2' THEN 'babord '
             ELSE '-'
          END
             AS positionlib,
          CASE
             WHEN occup.etat = 1 THEN 'CREER'
             WHEN occup.etat = 11 THEN 'VISEE'
          END
             AS ETATLIB,
             occup.IDPREVISION
     FROM OCCUPATIONMATERIELNAVAL occup
          LEFT JOIN MATERIELNAVALLIBCOMPLET mat
             ON mat.ID = occup.IDMATERIEL_NAVAL
          LEFT JOIN pilote p ON p.ID = occup.IDPILOTE
          LEFT JOIN COMMANDANT comm ON comm.id = occup.IDCOMMANDANT
          LEFT JOIN NATUREOPERATION nat ON nat.id = occup.IDNATUREOPERATION
          LEFT JOIN MANOEUVREBORD manb ON manb.id = occup.IDMANOEUVREBORD
          LEFT JOIN MOUVEMENT_LIBCOMPLET ML ON ML.ID = occup.IDARRIVEE
		  LEFT JOIN NAVIRELIBCOMPLET nav ON nav.ID = ml.NAVIRE;
CREATE OR REPLACE VIEW OCCUPMATERIELNAVALLIB (ID, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, IDNAVIRE, POSITION, OBSERVATION, ETAT, IDARRIVEE, IDARRIVEELIB, POSITIONLIB, DUREE, DATY, HEUREDEBUT, DATEFIN, HEUREFIN, ETATLIB, IDPREVISION) AS
  select id,
       denomination       as idmateriel_naval,
       valpilote          as idpilote,
       valcommandant      as idcommandant,
       valnatureoperation as idnatureoperation,
       valmanoeuvrebord   as idmanoeuvrebord,
       nomnavire          as idnavire,
       position,
       observation,
       etat,
       IDARRIVEE,
       IDARRIVEELIB,
       positionlib,
       duree,
       daty,
        heuredebut,
         datefin,
          heurefin,
       etatlib,
       IDPREVISION
from OCCUPMATERIELNAVALLIBCOMPLET
order by DATY desc;
CREATE OR REPLACE VIEW OCCUPMATERIELNAVALLIB (ID, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, IDNAVIRE, POSITION, OBSERVATION, ETAT, IDARRIVEE, IDARRIVEELIB, POSITIONLIB, DUREE, DATY, HEUREDEBUT, DATEFIN, HEUREFIN, ETATLIB, IDPREVISION,COMMANDANTID) AS
  select id,
       denomination       as idmateriel_naval,
       valpilote          as idpilote,
       valcommandant      as idcommandant,
       valnatureoperation as idnatureoperation,
       valmanoeuvrebord   as idmanoeuvrebord,
       nomnavire          as idnavire,
       position,
       observation,
       etat,
       IDARRIVEE,
       IDARRIVEELIB,
       positionlib,
       duree,
       daty,
        heuredebut,
         datefin,
          heurefin,
       etatlib,
       IDPREVISION,
       IDCOMMANDANT AS COMMANDANTID

from OCCUPMATERIELNAVALLIBCOMPLET
order by DATY desc;
create or replace view occupmaterielnavallibC as
select *
from occupmaterielnavallib where ETAT=1;
create or replace view occupmaterielnavallibV as
select *
from occupmaterielnavallib where ETAT=11;
CREATE OR REPLACE  VIEW OCCUPATIONMATERIELNAVALLIBCPL
(
   ID,
   DATY,
   IDMATERIEL_NAVAL,
   IDPILOTE,
   IDCOMMANDANT,
   IDNATUREOPERATION,
   IDMANOEUVREBORD,
   HEUREDEBUT,
   HEUREFIN,
   IDNAVIRE,
   IDCLIENT,
   DUREE,
   POSITION,
   OBSERVATION,
   ETAT,
   DATEFIN,
   IDPREVISION,
   IDCLIENTLIB,
   CARGAISON,
   CARGAISONLIB,
   PAVILLON,
   PAVILLONLIB
)
AS
   SELECT oc.ID,
          oc.DATY,
          oc.IDMATERIEL_NAVAL,
          oc.IDPILOTE,
          oc.IDCOMMANDANT,
          oc.IDNATUREOPERATION,
          oc.IDMANOEUVREBORD,
          oc.HEUREDEBUT,
          oc.HEUREFIN,
          oc.IDNAVIRE,
          pr.CONSIGNATAIRE AS IDCLIENT,
          oc.DUREE,
          oc.POSITION,
          oc.OBSERVATION,
          oc.ETAT,
          oc.DATEFIN,
          oc.IDPREVISION,
          c.nomclt AS idclientlib,
          pr.CARGAISON,
          pr.VALCARGAISON AS CARGAISONlib,
          pr.PAVILLONNAVIRE AS pavillon,
          pa.VAL AS pavillonlib
     FROM OCCUPATIONMATERIELNAVALLIB oc
          LEFT JOIN PREVISIONLIBCOMPLET pr ON pr.id = oc.IDPREVISION
          LEFT JOIN clientmat c ON c.cdclt = pr.CONSIGNATAIRE
          LEFT JOIN pays pa ON pa.id = pr.PAVILLONNAVIRE;
CREATE OR REPLACE  VIEW ACTIVITELIBCOMPLET
(
   ID,
   DESIGNATION,
   CLIENT,
   RUBRIQUE,
   QTE,
   MOIS,
   MOISLIB,
   ANNEE,
   DATY,
   BATEAU,
   ETAT,
   RUBRIQUELIB,
   NAVIRE,
   BATEAULIB,
   POIDS,
   LONGUEUR,
   LARGEUR,
   AUTRES,
   PU,
   DEVISE,
   COMPTE,
   UNITE,
   DIRECTION,
   CONDITION,
   TVA,
   OBJET,
   REDEVANCE,
   CLIENTLIB,
   REDEVANCELIB,
   DIRECTIONLIB,
   ETATLIB,
   CATEGORIE,
   CATEGORIELIB,
   REFOBJET,
   TYPESOURCE,
   DATEFACT,
   pavillon,
   volume,
   cargaison
)
AS
   SELECT ac.ID,
          ac.DESIGNATION,
          ac.CLIENT,
          ac.RUBRIQUE,
          ac.QTE,
          ac.MOIS,
          MOIS.VAL AS MOISLIB,
          ac.ANNEE,
          ac.DATY,
          ac.BATEAU,
          ac.ETAT,
          ra.DESIGNATION AS rubriquelib,
          nv.id AS navire,
          nv.NOM AS bateaulib,
          nv.PLT AS poids,
          nv.LHT AS longueur,
          nv.LM AS largeur,
          CAST ('-' AS VARCHAR2 (100)) AS autres,
          ra.pu,
          ra.devise,
          ra.compte,
          ra.unite,
          ra.direction,
          ra.condition,
          ra.tva,
          ra.objet,
          ra.redevance,
          fup.NOM AS clientlib,
          re.VAL AS redevancelib,
          di.LIBELLEDIR AS directionlib,
          CASE
             WHEN ac.etat = 1 THEN 'CREE(E)'
             WHEN AC.ETAT = 11 THEN 'VISE(E)'
             WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
          END
             AS ETATLIB,
          ra.CATEGORIE,
          cf.val AS categorieLib,
          ac.REFOBJET,
          ac.TYPESOURCE,
          pre.DATE_DEPART AS DATEFACT,
          NV.PAVILLON,
          nv.lm*nv.lht*nv.te  as volume,
          pre.cargaison
     FROM ACTIVITE ac
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
          LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
          LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
          LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
          LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
          LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
          LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE;
CREATE OR REPLACE VIEW LIAISONBORDEREAUFF_LIBCOMPLET
(ID, IDBORDEREAU, IDOP, REMARQUE, IDFACTURE, IDBORDEREAULIB, MONTANT,CODE_ETABLISSEMENT) AS
select li.ID,
       li.IDBORDEREAU,
       li.IDOP,
       op.DESIGNATION,
       op.id          as idfacture,
       b2.designation as idbordereaulib,
       op.MONTANTTTC  as montant,
       op.CODE_ETABLISSEMENT
from liaisonbordereauff li
         left join bordereauFF_libcomplet b2 on li.idBordereau = b2.id
         left join ETATFACTUREMONTANTDATY op on op.id = li.idOP;
ALTER TABLE ACTIVITE
    ADD poste VARCHAR2(100)
        CONSTRAINT fk_postedestinataire_ACT REFERENCES POSTEDESTINATAIRE;

  CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET
      (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU,
          ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES,
          PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
          CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB,
          REFOBJET, TYPESOURCE, DATEFACT,POSTE,POSTELIB) AS
  SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                   AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION             AS rubriquelib,
       nv.id                      as navire,
       nv.NOM                     AS bateaulib,
       nv.PLT                     AS poids,
       nv.LHT                     AS longueur,
       nv.LM                      AS largeur,
       CAST('-' AS VARCHAR2(100)) AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                    AS clientlib,
       re.VAL                     AS redevancelib,
       di.LIBELLEDIR              AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                  AS ETATLIB,

       ra.CATEGORIE,
       cf.val                     as categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART            as DATEFACT,
       ac.POSTE,
        pd.VALQUAIS as postelib
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE

         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf on ra.categorie = cf.id
         left join PREVISION pre on pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         left join POSTEDESTINATAIRELIBCOMPLET pd on pd.ID=ac.POSTE ;
CREATE OR REPLACE VIEW ACTIVITECOMPLETVIEW (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, ANNEE, DATY, BATEAU, ETAT, CLIENTLIB, RUBRIQUELIB, BATEAULIB, POSTE, POSTELIB) AS 
  SELECT ac.ID,
          ac.DESIGNATION,
          ac.CLIENT,
          ac.RUBRIQUE,
          ac.QTE,
          ac.MOIS,
          ac.ANNEE,
          ac.DATY,
          ac.BATEAU,
          ac.ETAT,
          fup.NOM AS clientlib,
          ra.DESIGNATION AS rubriquelib,
          nv.NOM AS bateaulib,
          ac.POSTE,
          pd.VALQUAIS AS postelib
     FROM activite ac
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
          LEFT JOIN NAVIRE nv ON nv.ID = ac.BATEAU
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
          LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
          LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
          LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
          LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
          left join POSTEDESTINATAIRELIBCOMPLET pd on pd.ID=ac.POSTE;
alter table facture_client_fille
    modify pu number(30, 3);
create or replace view FACTURE_CLIENT_FILLE_PLUS as
SELECT facture_client_fille.ID,
       facture_client_fille.IDMERE,
       facture_client_fille.DESIGNATION,
       facture_client_fille.QUANTITE,
       facture_client_fille.PU,
       facture_client_fille.COMPTE,
       facture_client_fille.IDPRODUIT,
       facture_client_fille.DEVISE,
       facture_client_fille.TAUX,
       CAST(0.0 AS NUMBER(30, 3)) AS montant,
       facture_client_fille.tva,
       facture_client_fille.IDACTIVITE,
       FACTURE_CLIENT_FILLE.DATEFACT
FROM facture_client_fille
where 1 > 2;
create or replace view AVOIRFCAVECTAUX as
select ac.*,
       cast(nvl(fc.TAUX, 1) as number(30, 3))              as taux,
       nvl(fc.DEVISE, 'Ar')                                as devise,
       cast(ac.MONTANT * nvl(fc.TAUX, 1) as number(30, 3)) as montantavectsaux,
       a.ETAT
from AVOIRFCFILLE ac
         left join FACTURE_CLIENT_FILLE fc on fc.ID = ac.IDDETAILFACTURE
         left join avoirfc a on ac.IDMERE = a.ID;
create or replace view ANALYSEGLOBALEFACTURE_VAOVAO
            (NMFACT, DATY, CATEGORIE_FACTURE, SOUS_CATEGORIE_FACTURE, CLIENT, CATEGORIE_CLIENT, DESIGNATION, MTTC, MTHT,
             TAXE, DEVFACT, MTDEVISE, MTAVOIR, PAYE, RESTE, NUMCOMPTE, VALCAT)
as
SELECT fc.id,
       fc.daty,
       cat.ID,
       '-',
       fc.tiers,
       cl.categorie,
       fc.designation,
       cast(fc.montantttc as number(32, 3)),
       cast(fc.montant as NUMBER(32, 3)),
       cast(fc.montanttva as NUMBER(32, 3)),
       '-',
       cast(fc.montantttc as NUMBER(32, 3)),
       cast(fc.montantavoir as NUMBER(32, 3)),
       cast(fc.MONTANTPAYE as NUMBER(32, 3)),
       cast(fc.MONTANTTTC - fc.MONTANTPAYE as NUMBER(32, 3)),
       '-',
       cat.val
FROM factureclientmsum_lib fc
         LEFT JOIN FACTURE_CLIENT_FILLE ff ON fc.id = FF.IDMERE
         LEFT JOIN ACTIVITE act ON ff.IDACTIVITE = act.ID
         LEFT JOIN RUBRIQUE_ACTIVITE rub ON act.RUBRIQUE = rub.ID
         LEFT JOIN CATEGORIEFACTURATION cat ON rub.CATEGORIE = cat.ID
         LEFT JOIN V_client_categorie cl ON fc.tiers = CL.CDCLT;
create view FACTURE_CLIENT_FILLE_LIBELLE as
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
       pr.nom                           as produit_lib,
       ac.DESIGNATION                   as activitelib,
       to_date(fi.DATEFACT, 'dd/MM/YY') AS DATEFACT
from FACTURE_CLIENT_FILLE fi
         left join AS_PRODUITS pr on pr.id = fi.IDPRODUIT
         left join activite ac on ac.id = fi.IDACTIVITE;
create or replace view FACTURE_CLIENT_FILLE_VM as
select fcf.*
from facture_client_fille fcf
         join factureclient fc on fcf.IDMERE = fc.ID
where fc.etat >= 11;
create or replace view FACTURE_CLIENT_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT)
as
SELECT fi."ID",
       fi."IDMERE",
       fi."DESIGNATION",
       fi."QUANTITE",
       fi."PU",
       fi."COMPTE",
       fi."IDPRODUIT",
       fi."DEVISE",
       fi."TAUX",
       fc.daty,
       fc.tiers,
       fc.designation AS designationmere,
       fc.TYPE,
       decode(fi.tva, null, fc.tva, fi.tva),
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;
create or replace view AS_BONDELIVRAISON_CL_PDT as
select fi.ID,
       nvl(fil.idPRODUIT, fil.DESIGNATION) as produit,
       fi.NUMBL,
       fi.QUANTITE,
       fi.IDDETAILSFACTUREFOURNISSEUR,
       cast('' as varchar2(400))           as pdt
from as_bondelivraison_cl_fille fi
         left join FACTURE_CLIENT_FILLE fil on fi.IDDETAILSFACTUREFOURNISSEUR = fil.ID;
create  or replace view FACTURE_CLIENT_FILLE_LIB_RESTE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB)
as
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANT AS NUMBER(32, 5)),
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3)),
       CAST(fcm.tva AS NUMBER(20, 3)),
       idactivite,
       ra.DESIGNATION                             as activitelib
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         left join ACTIVITE ra on ra.id = fc.IDACTIVITE;
create or replace view FACTURE_CLIENT_FILLE_LIB as
select ID,
       IDMERE,
       DESIGNATION,
       cast(QUANTITE as NUMBER(32, 3))             as QUANTITE,
       cast(PU as NUMBER(32, 3))                   as PU,
       COMPTE,
       IDPRODUIT,
       DEVISE,
       TAUX,
       cast(QTELIVREE as number(32, 3))            as QTELIVREE,
       cast(RESTEALIVRER as NUMBER(32, 3))         as RESTEALIVRER,
       cast(MONTANTTAUX as NUMBER(32, 3))          as MONTANTTAUX,
       cast(MONTANT as NUMBER(32, 3))              as MONTANT,
       cast(MONTANTAVOIRSANSTAUX as NUMBER(32, 3)) as MONTANTAVOIRSANSTAUX,
       cast(MONTANTAVOIRAVECTAUX as NUMBER(32, 3)) as MONTANTAVOIRAVECTAUX,
       IDPRODUITLIB,
       IDACTIVITE,
       CATEGORIEFACTURELIB,
       CATEGORIECLIENTLIB
from (
         select fc.ID,
                fc.IDMERE,
                fc.DESIGNATION,
                fc.QUANTITE,
                fc.PU,
                fc.COMPTE,
                fc.IDPRODUIT,
                fc.DEVISE,
                fc.TAUX,
                cast(nvl(gr.QUANTITE, 0) as number(10, 3))               as qteLivree,
                cast(fc.QUANTITE - nvl(gr.QUANTITE, 0) as number(10, 3)) as resteAlivrer,
                cast(fcm.MONTANTTAUX as number(32, 3))                   as MONTANTTAUX,
                cast(fcm.MONTANT as NUMBER(32, 3))                       as MONTANT,
                cast(fcm.MONTANTAVOIRSANSTAUX as number(32, 3))          as MONTANTAVOIRSANSTAUX,
                cast(fcm.MONTANTAVOIRAVECTAUX as NUMBER(32, 3))          as MONTANTAVOIRAVECTAUX,
                pr.nom                                                   AS IDPRODUITlib,
                fc.IDACTIVITE,
                al.CATEGORIELIB                                          as categorieFacturelib,
                fcm.CATEGORIE                                            as categorieclientlib
         from facture_client_fille fc
                  left join AS_PRODUITS pr on pr.ID = fc.IDPRODUIT
                  left join as_bondelivraison_cl_grp gr on gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
                  left join FACTURE_CLIENT_MONTANT_LIB fcm on fcm.id = fc.id
                  left join ACTIVITELIBCOMPLET al on al.id = fc.IDACTIVITE
         union all
         select *
         from ANALYSEGLOBALFACTURE_FAC);
CREATE OR REPLACE VIEW OCCUPMATERIELNAVALLIBCOMPLET (ID, DATY, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, HEUREDEBUT, HEUREFIN, IDNAVIRE, IDCLIENT, DUREE, POSITION, OBSERVATION, ETAT, DATEFIN, IDARRIVEE, DENOMINATION, DATE_AQUISITION, IDMARQUE, PUISSANCE, DETENTEUR, MAINTENANCE, IDTYPE_MATERIEL, IMMATRICULATION, ETATMATERIELNAVAL, VALMARQUE, DESCEMARQUE, VALTYPEMATERIEL, DESCETYPEMATERIEL, VALPILOTE, DESCEPILOTE, VALCOMMANDANT, DESCECOMMANDANT, VALNATUREOPERATION, DESCENATUREOPERATION, VALMANOEUVREBORD, DESCEMANOEUVREBORD, REFERENCE, NOMNAVIRE, PAVILLONNAVIRE, JNT, JBT, PLT, LHT, LM, TE, VOLUME, REMARQUE, VALPAVILLON, DESCEPAVILLON, IDARRIVEELIB, POSITIONLIB, ETATLIB, IDPREVISION) AS
  SELECT occup.ID,
          occup.DATY,
          occup.IDMATERIEL_NAVAL,
          occup.IDPILOTE,
          occup.IDCOMMANDANT,
          occup.IDNATUREOPERATION,
          occup.IDMANOEUVREBORD,
          occup.HEUREDEBUT,
          occup.HEUREFIN,
          occup.IDNAVIRE,
          re.consignataire as  IDCLIENT,
          occup.DUREE,
          occup.POSITION,
          occup.OBSERVATION,
          occup.ETAT,
          occup.DATEFIN,
          occup.IDARRIVEE,
          mat.denomination,
          mat.DATE_AQUISITION,
          mat.IDMARQUE,
          mat.PUISSANCE,
          mat.DETENTEUR,
          mat.MAINTENANCE,
          mat.IDTYPE_MATERIEL,
          mat.IMMATRICULATION,
          mat.etat AS etatmaterielnaval,
          mat.valmarque,
          mat.descemarque,
          mat.valtypemateriel,
          mat.descetypemateriel,
          p.VAL AS valpilote,
          p.DESCE AS descepilote,
          comm.val AS valcommandant,
          comm.DESCE AS descecommandant,
          nat.val AS valnatureoperation,
          nat.DESCE AS descenatureoperation,
          manb.val AS valmanoeuvrebord,
          manb.DESCE AS descemanoeuvrebord,
          nav.reference,
          nav.nom AS nomnavire,
          nav.pavillon AS pavillonnavire,
          nav.jnt,
          nav.JBT,
          nav.PLT,
          nav.LHT,
          nav.lm,
          nav.te,
          nav.volume,
          nav.remarque,
          nav.valpavillon,
          nav.descepavillon,
          ML.ESCALE || '-' || ML.NAVIRELIB AS IDARRIVEELIB,
          CASE
             WHEN POSITION = '1' THEN 'Tribord'
             WHEN POSITION = '2' THEN 'babord '
             ELSE '-'
          END
             AS positionlib,
          CASE
             WHEN occup.etat = 1 THEN 'CREER'
             WHEN occup.etat = 11 THEN 'VISEE'
          END
             AS ETATLIB,
             occup.IDPREVISION
     FROM OCCUPATIONMATERIELNAVAL occup
          LEFT JOIN MATERIELNAVALLIBCOMPLET mat
             ON mat.ID = occup.IDMATERIEL_NAVAL
          LEFT JOIN pilote p ON p.ID = occup.IDPILOTE
          LEFT JOIN COMMANDANT comm ON comm.id = occup.IDCOMMANDANT
          LEFT JOIN NATUREOPERATION nat ON nat.id = occup.IDNATUREOPERATION
          LEFT JOIN MANOEUVREBORD manb ON manb.id = occup.IDMANOEUVREBORD
          LEFT JOIN MOUVEMENT_LIBCOMPLET ML ON ML.ID = occup.IDARRIVEE
		  LEFT JOIN NAVIRELIBCOMPLET nav ON nav.ID = ml.NAVIRE
          left join PREVISIONLIBELLECOMPLET re on re.id=occup.IDPREVISION ;
CREATE or replace VIEW ACTIVITECOMPLETFORMULE_I
AS
SELECT ac.ID                                    as id,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       sysdate                                            AS datedebut,
       '00:00:00'                                    as heuredebut,
       sysdate                                       AS datefin,
       '00:00:00'                                    as HEUREFIN ,
       '-'                                           AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       'NUIT'
                                                     AS estJour,
       'FERIE'                                          estFerie,
       '-'                                           AS manoeuvre,
       'weekend'
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       cast('-' as VARCHAR2(500))                    AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
    --  LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
     -- LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
where ac.RUBRIQUE in ('RB0000000021170444', 'RB0000000021170448');
CREATE or replace VIEW ACTIVITECOMPLETFORMULE_II
AS
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       occ.daty                                      AS datedebut,
       occ.heuredebut,
       OCC.DATEFIN                                   AS datefin,
       OCC.HEUREFIN                                  AS heurefin,
       occ.id                                        AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       CASE
           WHEN occ.heuredebut BETWEEN '05:00:00' AND '19:00:00'
               THEN
               'JOUR'
           ELSE
               'NUIT'
           END
                                                     AS estJour,
       CASE
           WHEN occ.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                     AS estFerie,
       occ.idmanoeuvrebord                           AS manoeuvre,
       CASE
           WHEN TO_CHAR(occ.daty, 'DAY') = 'DIMANCHE'
               OR TO_CHAR(occ.daty, 'DAY') = 'SAMEDI'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       nat.id                                        AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
         LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
where Ra.ID not in ('RB0000000021170444', 'RB0000000021170448');
create or replace view ACTIVITECOMPLETFORMULE
            (
             ID,
             DESIGNATION,
             CLIENT,
             RUBRIQUE,
             QTE,
             MOIS,
             MOISLIB,
             ANNEE,
             DATY,
             BATEAU,
             ETAT,
             RUBRIQUELIB,
             NAVIRE,
             BATEAULIB,
             POIDS,
             LONGUEUR,
             LARGEUR,
             AUTRES,
             PU,
             DEVISE,
             COMPTE,
             UNITE,
             DIRECTION,
             CONDITION,
             TVA,
             OBJET,
             REDEVANCE,
             CLIENTLIB,
             REDEVANCELIB,
             DIRECTIONLIB,
             ETATLIB,
             CATEGORIE,
             CATEGORIELIB,
             REFOBJET,
             TYPESOURCE,
             DATEFACT,
             PAVILLON,
             VOLUME,
             VOLUMEARRONDI,
             CARGAISON,
             DATEDEBUT,
             HEUREDEBUT,
             datefin,
             heurefin,
             IDPRESTATION,
             ESTNATIONAL,
             ESTJOUR,
             ESTFERIE,
             MANOEUVRE,
             ESTWEEKEND,
             POSTE,
             POSTELIB,
             NATUREOPERATION,
             nbreheure,
             nbquartheure
                )
as
select *
from ACTIVITECOMPLETFORMULE_I
union
select *
from ACTIVITECOMPLETFORMULE_II;
UPDATE MENUDYNAMIQUE x
	SET x.ID_PERE='MEN0006',x.NIVEAU=2,x.RANG=10
	WHERE x.ID='MENBDG0001';
/*Unite*/Insert into UNITE_ACTIVITE
   (ID, VAL, DESCE)
 Values
   ('UNIT0000000000164621', '100M3', '100M3');
   /*Droit de port*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170444', 'Droit de port calcule', 'CATFC001', 'REDV001', 'Eur', 
    'UNIT0000000000164621', 0, 'DIR00006');
/*Droit de port inférieur à 3000 national */	
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170444', 'Droit de port V<3000 national', '70601',1, 1, '1.833', 'UA006', 
    'RB0000000021170444', '[estNational]==''National''&&[volume]<3000', '1');	
	/*Droit de port entre 3000 à 9000 national */	
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170445', 'Droit de port 3000<=V<9000 national', '70601', 1, 1, '0.47', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''National''&&[volume]>=3000&&[volume]<9000', '[volumeArrondi]');
/*Droit de port supérieur à 9000 national */
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170446', 'Droit de port V>9000 national', '70601', 1, 1, '0.74', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''National''&&[volume]>=9000&&[cargaison]!=''CGM00001''', '[volumeArrondi]');
/*Droit de port supérieur à 9000 national pétrolier */
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170447', 'Droit de port V>9000 petrolier national', '70601', 1, 1, '0.74', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''National''&&[volume]>=9000&&[cargaison]==''CGM00001''', '[volumeArrondi]');
/*Droit de port inférieur à 3000 international */		
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170448', 'Droit de port V<3000 international', '70601', 1, 1, '3.483', 'UA006', 
    'RB0000000021170444', '[estNational]==''International''&&[volume]<3000', '1');
/*Droit de port entre 3000 à 9000 international */
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170449', 'Droit de port 3000<=V<9000 international', '70601', 1, 1, '0.893', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''International''&&[volume]>=3000&&[volume]<9000', '[volumeArrondi]');
/*Droit de port supérieur à 9000 international */	
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170450', 'Droit de port V>9000 international', '70601', 1, 1, '1.405', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''International''&&[volume]>=9000&&[cargaison]!=''CGM00001''', '[volumeArrondi]');
/*Droit de port supérieur à 9000 international pétrolier */
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170451', 'Droit de port V>=9000 international petrolier', '70601', 1, 1, '1.546', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''International''&&[volume]>=9000&&[cargaison]==''CGM00001''', '[volumeArrondi]');
/*conteneur sy passagers navela aloha*/
/*PILOTAGE*/
/*Minimum de perception jour normal*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170445', 'Pilotage calcule', 'CATFC001', 'REDV001', 'Eur', 
    'UNIT0000000000164621', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170453', 'Min. percept. pilotage national', '70631', 1, 1, '174.105', 'UA016', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]<15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '1');    
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170452', 'Min. percept. pilotage international', '70631',1, 1, '91.634', 'UA016', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]<15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '1');  
/*Minimum de perception nuit et férié*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170454', 'Min. percept. pilotage national ferie', '70631', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]<15000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170455','Min. percept. pilotage international ferie', '70631', 1, 1, '2.298', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]<15000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '[volumeArrondi]');	
/*Manoeuvre entrée et sortie jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170456', 'Pilotage Entree/Sortie national', '70631',1, 1, '0.537', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170457', 'Pilotage Entree/Sortie international', '70631', 1, 1, '1.532', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');
/*Manoeuvre entrée et sortie nuit et férié */		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170458', 'Pilotage Entree/Sortie national ferie', '70631', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170459', 'Pilotage Entree/Sortie international ferie', '70631', 1, 1, '2.298', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
/*Mouvement jour normal */		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170460', 'Pilotage Mouvement national', '70631', 1, 1, '0.47', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0004''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170461', 'Pilotage Mouvement international', '70631', 1, 1, '0.899', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0004''', '[volumeArrondi]');
/*Mouvement jour normal nuit et férié*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170462', 'Pilotage Mouvement national ferie', '70631', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0004''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170463', 'Pilotage Mouvement international ferie', '70631', 1, 1, '1.349', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0004''', '[volumeArrondi]');	
/*Sortie Pétrolier jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170464', 'Pilotage Sortie petrolier national', '70631', 1, 1, '0.537', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0005''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170465', 'Pilotage Sortie petrolier international', '70631', 1, 1, '1.532', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0005''&&[cargaison]==''CGM00001''', '[volumeArrondi]');
/*Sortie Pétrolier jour férié et nuit*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170466', 'Pilotage Sortie petrolier national ferie', '70631', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0005''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170467', 'Pilotage Sortie petrolier international ferie', '70631', 1, 1, '2.298', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0005''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
	/*Entrée Pétrolier jour normal*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170468', 'Pilotage Entrée petrolier national', '70631', 1, 1, '0.537', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0003''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170469', 'Pilotage Entrée petrolier international', '70631', 1, 1, '1.685', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0003''&&[cargaison]==''CGM00001''', '[volumeArrondi]');
	/*Entrée Pétrolier jour férié et nuit*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170470', 'Pilotage Entrée petrolier national ferie', '70631', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0003''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170471', 'Pilotage Entrée petrolier international ferie', '70631', 1, 1, '2.527', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0003''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
/*25-06-2021*/	
/*REMORQUAGE*/	
/*Minimum de perception remorquage jour normal*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170446', 'Remorquage calcule', 'CATFC001', 'REDV001', 'Eur', 
    'UNIT0000000000164621', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170472', 'Min. percept. Remorquage national', '70632', 1, 1, '91.634', 'UA016', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]<3000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170473', 'Min. percept. Remorquage international', '70632', 1, 1, '174.105', 'UA016', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]<3000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '1');	
/*Minimum de perception remorquage nuit et jour ferié*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170474', 'Min. percept. Remorquage national ferie', '70632', 1, 1, '0.806', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]<3000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170475', 'Min. percept. Remorquage international ferie', '70632', 1, 1, '2.298', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]<3000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '1');	
	/*Remorquage Entre 3000 et 5000M3 jour normal cargo*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170476', 'Remorquage 3.000<=V<5.000 national', '70632', 1, 1, '2.187', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170477', 'Remorquage 3.000<=V<5.000 international', '70632', 1, 1, '4.154', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
	/*Remorquage Entre 3000 et 5000M3 nuit et jour férié  cargo*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170478', 'Remorquage 3.000<=V<5.000 national ferie', '70632', 1, 1, '3.281', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170479', 'Remorquage 3.000<=V<5.000 international ferie', '70632', 1, 1, '6.231', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
/*Remorquage Supérieur à 5000M3 jour normal  cargo*/			
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170480', 'Remorquage V>=5.000 national', '70632', 1, 1, '2.824', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF00000000231704781', 'Remorquage V>=5.000 international', '70632', 1, 1, '5.363', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
/*Remorquage Supérieur à 5000M3 nuit et jour férié  cargo*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170482', 'Remorquage V>=5.000 national ferie', '70632', 1, 1, '4.236', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170483', 'Remorquage V>=5.000 international ferie', '70632', 1, 1, '8.045', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
/*Majoration Remorquage entre 3.000 et 5.000 jour normal cargo*/ --manomboka 535
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170535', 'Maj. Remorq. 3000<=V<5.000 national', '70632', 1, 1, '65.67', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF00000000231704536', 'Maj. Remorq. 3000<=V<5.000 international', '70632', 1, 1, '124.775', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
/*Majoration Remorquage entre 3.000 et 5.000 jour normal férié et nuit cargo*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170537', 'Maj. Remorq. 3000<=V<5.000 national ferie', '70632', 1, 1, '98.505', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170538', 'Maj. Remorq. 3000<=V<5.000 international ferie', '70632', 1, 1, '187.163', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
/*Majoration Remorquage supérieur à 5.000 jour normal cargo*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170539', 'Maj. Remorq. V>=5.000 national', '70632', 1, 1, '126.385', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF00000000231704540', 'Maj. Remorq. V>=5.000 international', '70632', 1, 1, '198.765', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
/*Majoration Remorquage supérieur à 5.000 jour férié et nuit cargo*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170541', 'Maj. Remorq. V>=5.000 national ferie', '70632', 1, 1, '98.505', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170542', 'Maj. Remorq. V>=5.000 international ferie', '70632', 1, 1, '187.163', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
/*Remorquage sortie pétrolier Entre 3000 et 20.000 jour normal*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170484', 'Remorquage 3000<=V<20.000 petrolier national', '70632', 1, 1, '2.187', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170485', 'Remorquage 3000<=V<20.000 petrolier international', '70632', 1, 1, '4.154', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier Entre 3000 et 20.000 jour férié et nuit*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170486', 'Remorquage 3000<=V<20.000 petrolier national ferie', '70632', 1, 1, '3.281', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170487', 'Remorquage 3000<=V<20.000 petrolier international ferie', '70632', 1, 1, '6.231', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier Entre 20.000 et 50.000 jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170488', 'Remorquage sortie 20.000<=V<50.000 petrolier national', '70632', 1, 1, '4.582', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170489', 'Remorquage sortie 20.000<=V<50.000 petrolier international', '70632', 1, 1, '8.704', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier entre 20.000 et 50.000 jour férié et nuit*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170490', 'Remorquage sortie 20.000<=V<50.000 petrolier national ferie', '70632', 1, 1, '6.873', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170491', 'Remorquage sortie 20.000<=V<50.000 petrolier international ferie', '70632', 1, 1, '13.05', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier Entre 50.000 et 100.000 jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170492', 'Remorquage sortie 50.000<=V<100.000 petrolier national', '70632', 1, 1, '6.216', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170493', 'Remorquage sortie 50.000<=V<100.000 petrolier international', '70632', 1, 1, '11.809', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier Entre 50.000 et 100.000 jour férié et nuit*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170494', 'Remorquage sortie 50.000<=V<100.000 petrolier national ferie', '70632', 1, 1, '9.324', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170495', 'Remorquage sortie 50.000<=V<100.000 petrolier international ferie', '70632', 1, 1, '17.71', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier supérieur à 100.000 jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170496', 'Remorquage sortie V>=100.000 petrolier national', '70632', 1, 1, '8.014', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170497', 'Remorquage sortie V>=100.000 petrolier international', '70632', 1, 1, '15.226', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier supérieur à 100.000 jour férié et nuit*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170498', 'Remorquage sortie V>=100.000 petrolier national ferie', '70632', 1, 1, '12.021', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170499', 'Remorquage sortie V>=100.000 petrolier international ferie', '70632', 1, 1, '22.839', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Veille de sécurité sortie pétrolier*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170500', 'Veille de sécurité sortie pétrolier national', '70636', 1, 1, '28.647', 'UA002', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[nbHeure]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170501', 'Veille de sécurité sortie pétrolier national', '70636', 1, 1, '54.429', 'UA002', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[nbHeure]');	
/*Remorquage entrée pétrolier entre 3.000 et 20.000 jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170502', 'Remorquage entrée 3.000<=V<20.000 petrolier national', '70632', 1, 1, '2.187', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170503', 'Remorquage entrée 3.000<=V<20.000 petrolier international', '70632', 1, 1, '4.569', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
/*Remorquage entrée pétrolier entre 3.000 et 20.000 jour férié et nuit*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170504', 'Remorquage entrée 3.000<=V<20.000 petrolier national ferie', '70632', 1, 1, '3.281', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170505', 'Remorquage entrée 3.000<=V<20.000 petrolier international ferie', '70632', 1, 1, '6.854', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
/*Remorquage entrée pétrolier entre 20.000 et 50.000 jour normal*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170506', 'Remorquage entrée 20.000<=V<50.000 petrolier national', '70632', 1, 1, '4.582', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170507', 'Remorquage entrée 20.000<=V<50.000 petrolier international', '70632', 1, 1, '9.574', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
/*Remorquage entrée pétrolier entre 20.000 et 50.000 jour férié et nuit*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170508', 'Remorquage entrée 20.000<=V<50.000 petrolier national ferie', '70632', 1, 1, '6.873', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170509', 'Remorquage entrée 20.000<=V<50.000 petrolier international ferie', '70632', 1, 1, '14.362', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
/*Remorquage entrée pétrolier entre 50.000 et 100.000 jour normal*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170510', 'Remorquage entrée 50.000<=V<100.000 petrolier national', '70632', 1, 1, '6.216', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170511', 'Remorquage entrée 50.000<=V<100.000 petrolier international', '70632', 1, 1, '12.99', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
	/*Remorquage entrée pétrolier entre 50.000 et 100.000 jour ferie et nuit*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170512', 'Remorquage entrée 50.000<=V<100.000 petrolier national ferie', '70632', 1, 1, '9.324', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170513', 'Remorquage entrée 50.000<=V<100.000 petrolier international ferie', '70632', 1, 1, '19.485', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
/*Remorquage entrée pétrolier supérieur à 100.000 jour normal*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170514', 'Remorquage entrée V>=100.000 petrolier national', '70632', 1, 1, '8.014', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170515', 'Remorquage entrée V>=100.000 petrolier international', '70632', 1, 1, '16.749', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
	/*Remorquage entrée pétrolier supérieur à 100.000 jour ferie et nuit*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170516', 'Remorquage entrée V>=100.000 petrolier national ferie', '70632', 1, 1, '12.021', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170517', 'Remorquage entrée V>=100.000 petrolier international ferie', '70632', 1, 1, '25.123', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
/*Veille de sécurité entrée pétrolier*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170518', 'Veille de sécurité entrée pétrolier national', '70636', 1, 1, '28.647', 'UA002', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[nbHeure]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170519', 'Veille de sécurité entrée pétrolier international', '70636', 1, 1, '59.872', 'UA002', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[nbHeure]');	

/*Lamanage cargo jour normal*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170447', 'Lamanage calcule', 'CATFC001', 'REDV001', 'Eur', 
    'UA048', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170520', 'Amarr. et desamarr. cargo national', '70633', 1, 1, '0.537', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170521', 'Amarr. et desamarr. cargo international', '70633', 1, 1, '1.021', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
	/*Lamanage cargo jour ferie et nuit*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170522', 'Amarr. et desamarr. cargo national ferie', '70633', 1, 1, '0.805', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170523', 'Amarr. et desamarr. cargo national ferie', '70633', 1, 1, '1.531', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
	/*Lamanage sortie pétrolier jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170524', 'Amarr. et desamarr. petrolier national', '70633', 1, 1, '0.807', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170525', 'Amarr. et desamarr. petrolier international', '70633', 1, 1, '1.532', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
	/*Lamanage sortie pétrolier jour férié*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170526', 'Amarr. et desamarr. sortie petrolier national ferie ', '70633', 1, 1, '1.211', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170527', 'Amarr. et desamarr. sortie petrolier international ferie', '70633', 1, 1, '2.298', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
	/*Lamanage entrée pétrolier jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170528', 'Amarr. et desamarr. entrée petrolier national', '70633', 1, 1, '0.807', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170529', 'Amarr. et desamarr. entrée petrolier international', '70633', 1, 1, '1.685', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
		/*Lamanage entrée pétrolier jour ferie*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170530', 'Amarr. et desamarr. sortie petrolier national ferie', '70633', 1, 1, '1.211', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170531', 'Amarr. et desamarr. sortie petrolier international ferie', '70633', 1, 1, '2.527', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
	/*Redevance communale*/	
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170448', 'Redevance communale calcule', 'CATFC001', 'REDV001', 'Ar', 
    'UA006', 0, 'DIR00006');
/*Redevance LC étranger */	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170532', 'Redevance communale LC international', '46733', 1, 1, '400000', 'UA006', 
    'RB0000000021170448', '[estNational]==''International''&&[cargaison]!=''CGM00001''', '1');	
	/*Redevance pétrolier étranger */		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170533', 'Redevance communale pour pétrolier international', '46733', 1, 1, '400000', 'UA006', 
    'RB0000000021170448', '[estNational]==''International''&&[cargaison]==''CGM00001''', '1');		
	/*Redevance LC national */	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170534', 'Redevance communale cabotage national', '46733', 1, 1, '30000', 'UA006', 
    'RB0000000021170448', '[estNational]==''National''', '1');	
/*Manomboka 543*/	
/*Stationnement à quais ordinaire*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170449', 'Stationnement calcule', 'CATFC001', 'REDV001', 'Eur', 
    'UA045', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170543', 'Stationnement poste ordinaire nav. national', '70634', 1, 1, '0.033', 'UA045', 
    'RB0000000021170448', '[estNational]==''National''&&[typequais]==''TYPE000003''', '[longueur]*[nbheure]');		
	Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170544', 'Stationnement poste ordinaire nav. international', '70634', 1, 1, '0.063', 'UA045', 
    'RB0000000021170448', '[estNational]==''International''&&[typequais]==''TYPE000003''', '[longueur]*[nbheure]');	
/*Stationnement à quais spécialisé*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170545', 'Stationnement poste spec. nav. national', '70634', 1, 1, '0.048', 'UA045', 
    'RB0000000021170448', '[estNational]==''National''&&[typequais]==''TQ001''', '[longueur]*[nbheure]');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170546', 'Stationnement poste spec. nav. international', '70634', 1, 1, '0.091', 'UA045', 
    'RB0000000021170448', '[estNational]==''International''&&[typequais]==''TQ001''', '[longueur]*[nbheure]');	
	/*Stationnement poste pétrolier*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170547', 'Stationnement poste petrolier nav. national', '70634', 1, 1, '3.971', 'UA045', 
    'RB0000000021170448', '[estNational]==''National''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');		
	Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170548', 'Stationnement poste petrolier nav. international', '70634', 1, 1, '7.545', 'UA045', 
    'RB0000000021170448', '[estNational]==''International''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');	
/*Stationnement en rade*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170549', 'Stationnement poste de mouillage nav. national', '70634', 1, 1, '0.025', 'UA045', 
    'RB0000000021170448', '[estNational]==''National''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');		
	Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170550', 'Stationnement poste de mouillage nav. international', '70634', 1, 1, '0.048', 'UA045', 
    'RB0000000021170448', '[estNational]==''International''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');	
/*Stationnement sans operation commerciale*/		
INSERT INTO NATUREOPERATION (ID, VAL, DESCE) VALUES('NATM0001', 'Cession eau douce', 'Cession eau douce');
INSERT INTO NATUREOPERATION (ID, VAL, DESCE) VALUES('NATM0002', 'Service en haute mer', 'Service en haute mer');
INSERT INTO NATUREOPERATION (ID, VAL, DESCE) VALUES('NATM0003', 'Autorisation piquage de rouille et peinture coque', 'Autorisation piquage de rouille et peinture coque');
INSERT INTO NATUREOPERATION (ID, VAL, DESCE) VALUES('NATM0004', 'Autorisation immobilisation', 'Autorisation immobilisation');
INSERT INTO NATUREOPERATION (ID, VAL, DESCE) VALUES('NATM0005', 'Enlevement ordure', 'Enlevement ordure');
INSERT INTO UNITE_ACTIVITE (ID, VAL, DESCE) VALUES('UA049', 'TM', 'Tonne metrique');
INSERT INTO UNITE_ACTIVITE (ID, VAL, DESCE) VALUES('UA050', 'EVP', 'EVP');
INSERT INTO UNITE_ACTIVITE (ID, VAL, DESCE) VALUES('UA051', 'JOUR INDIVISBLE', 'JOUR INDIVISBLE');
INSERT INTO CATEGORIEFACTURATION (ID, VAL, DESCE) VALUES('CATFC009', 'Assistance aux navires', 'Assistance aux navires');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0101', 'Hydrocarbures embarquement','CATFC003','0.5','Eur','UA049');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0102', 'Hydrocarbures debarquement','CATFC003','1.6','Eur','UA049');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0103', 'Marchandise conventionnelles embarquement','CATFC004','1.628','Eur','U1');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0104', 'Marchandise conventionnelles debarquement','CATFC004','2.4','Eur','U1');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0105', 'Conteneur plein 20 pieds plein embarquement','CATFC002','4','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0106', 'Conteneur plein 20 pieds vide embarquement','CATFC002','0.55','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0107', 'Conteneur plein 20 pieds plein debarquement','CATFC002','12.8','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0108', 'Conteneur plein 20 pieds vide debarquement','CATFC002','1.76','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0109', 'Conteneur plein 40 pieds plein embarquement','CATFC002','8','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0110', 'Conteneur plein 40 pieds vide embarquement','CATFC002','1.1','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0111', 'Conteneur plein 40 pieds plein debarquement','CATFC002','20.8','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0112', 'Conteneur plein 40 pieds vide debarquement','CATFC002','3.52','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0113', 'Conteneur plein 45 pieds plein embarquement','CATFC002','9','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0114', 'Conteneur plein 45 pieds vide embarquement','CATFC002','1.24','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0115', 'Conteneur plein 45 pieds plein debarquement','CATFC002','28.8','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0116', 'Conteneur plein 45 pieds vide debarquement','CATFC002','3.96','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0117', 'Conteneur plein 20 pieds plein transbordement','CATFC002','8.4','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0118', 'Conteneur plein 20 pieds vide transbordement','CATFC002','1.16','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0119', 'Conteneur plein 40 pieds plein transbordement','CATFC002','13.65','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0120', 'Conteneur plein 40 pieds vide transbordement','CATFC002','2.31','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0121', 'Conteneur plein 45 pieds plein transbordement','CATFC002','18.9','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0122', 'Conteneur plein 45 pieds vide transbordement','CATFC002','2.6','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0123', 'Port Malagasy','CATFC002','1','Eur','UA001');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0124', 'Port situe dans un etat membre de la COI','CATFC008','4','Eur','UA001');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0125', 'Autres ports','CATFC008','5','Eur','UA001');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0126', 'Cession d''eau douce calcule','CATFC009','','Eur','UA003');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0127', 'Services en haute mer calcule','CATFC009','','Eur','UA002');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0128', 'Autorisation piquage de rouille et peinture coque calcule','CATFC009','','Eur','UA051');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0129', 'Autorisation d''immobilisation calcule','CATFC009','','Eur','UA051');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0130', 'Enlevement d''ordures calcule','CATFC009','','Eur','');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300001', 'Cession d''eau douce cabotage national', 1, 1, '1.263', 'UA003', 
    'RBR0126', '[natureoperation]==''NATM0001''&&[estNational]==''National''', '[volume]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300002', 'Cession d''eau douce cabotage international/Long', 1, 1, '2.399', 'UA003', 
    'RBR0126', '[natureoperation]==''NATM0001''&&[estNational]==''International''', '[volume]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300003', 'Autorisation piquage de rouille et peinture coque cabotage national', 1, 1, '11', 'UA051', 
    'RBR0128', '[natureoperation]==''NATM0003''&&[estNational]==''National''', '[nbJour]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300004', 'Autorisation piquage de rouille et peinture coque cabotage international/Long', 1, 1, '24.852', 'UA051', 
    'RBR0128', '[natureoperation]==''NATM0003''&&[estNational]==''International''', '[nbJour]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300005', 'Autorisation d''immobilisation cabotage national', 1, 1, '13.08', 'UA051', 
    'RBR0129', '[natureoperation]==''NATM0004''&&[estNational]==''National''', '[nbJour]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300006', 'Autorisation d''immobilisation cabotage international/Long', 1, 1, '24.852', 'UA051', 
    'RBR0129', '[natureoperation]==''NATM0004''&&[estNational]==''International''', '[nbJour]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300007', 'Services en haute mer cabotage national', 1, 1, '79.944', 'UA002', 
    'RBR0127', '[natureoperation]==''NATM0002''&&[estNational]==''National''', '[nbHeure]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300008', 'Services en haute mer cabotage international/Long', 1, 1, '79.944', 'UA051', 
    'RBR0127', '[natureoperation]==''NATM0002''&&[estNational]==''International''', '[nbHeure]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300009', 'Enlevement d''ordures 1er au 5e jour cabotage national', 1, 1, '50.607', 'UA006', 
    'RBR0130', '[natureoperation]==''NATM0005''&&[estNational]==''National''', '1');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300010', 'Enlevement d''ordures 1er au 5e jour cabotage international/Long', 1, 1, '96.154', 'UA006', 
    'RBR0130', '[natureoperation]==''NATM0005''&&[estNational]==''International''', '1');
UPDATE OCCUPATIONMATERIELNAVAL occup 
SET IDPREVISION = (
	SELECT m.escale FROM MOUVEMENT m 
	WHERE occup.IDARRIVEE = m.id 
	AND m.ESCALE IN (SELECT id FROM prevision prev WHERE prev.id = m.ESCALE)
);
UPDATE USERMENU SET REFUSER='1060', IDMENU='MENBDG0001', IDROLE='', CODESERVICE=NULL, CODEDIR=NULL, INTERDIT=NULL WHERE ID='USRMEN0001';
UPDATE MENUDYNAMIQUE SET LIBELLE='Ligne crédit recette', ICONE='fa fa-money', HREF='#', RANG=1, NIVEAU=3, ID_PERE='MENBDG0001' WHERE ID='MENBDG00011';
UPDATE MENUDYNAMIQUE SET LIBELLE='Ligne crédit dépense', ICONE='fa fa-money', HREF='#', RANG=2, NIVEAU=3, ID_PERE='MENBDG0001' WHERE ID='MENBDG00021';
UPDATE MENUDYNAMIQUE SET LIBELLE='Saisie', ICONE='fa fa-plus', HREF='/spat/pages/globalnegoce.jsp?but=ligneCredit/saisie-ligneCreditRecette.jsp', RANG=1, NIVEAU=4, ID_PERE='MENBDG00011' WHERE ID='MENBDG000111';
UPDATE MENUDYNAMIQUE SET LIBELLE='Liste', ICONE='fa fa-list', HREF='/spat/pages/globalnegoce.jsp?but=ligneCredit/situation-ligneCreditRecette.jsp', RANG=2, NIVEAU=4, ID_PERE='MENBDG00011' WHERE ID='MENBDG000112';
UPDATE MENUDYNAMIQUE SET LIBELLE='Saisie', ICONE='fa fa-plus', HREF='/spat/pages/globalnegoce.jsp?but=ligneCredit/saisie-ligneCreditDepense.jsp', RANG=1, NIVEAU=4, ID_PERE='MENBDG00021' WHERE ID='MENBDG000211';
UPDATE MENUDYNAMIQUE SET LIBELLE='Liste', ICONE='fa fa-list', HREF='/spat/pages/globalnegoce.jsp?but=ligneCredit/situation-ligneCreditDepense.jsp', RANG=2, NIVEAU=4, ID_PERE='MENBDG00021' WHERE ID='MENBDG000212';

	
alter table detformufact add compte varchar2(500);
alter table facture_client_fille add rubrique varchar(100);

create view OCCUPATIONMATERIELNAVAL_DATY as
select to_date(extract(day from DATY) || '-' || extract(month from DATY) || '-' || extract(year from DATY) || OCCUPATIONMATERIELNAVAL.HEUREDEBUT, 'dd-mm-yyyy hh24:mi:ss') as datydebut,
       to_date(extract(day from DATEFIN) || '-' || extract(month from DATEFIN) || '-' || extract(year from DATEFIN) || OCCUPATIONMATERIELNAVAL.HEUREFIN, 'dd-mm-yyyy hh24:mi:ss') as datyfin
       ,id
from OCCUPATIONMATERIELNAVAL;



CREATE or replace VIEW ACTIVITECOMPLETFORMULE_I
AS
SELECT ac.ID                                         as id,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       sysdate                                       AS datedebut,
       '00:00:00'                                    as heuredebut,
       sysdate                                       AS datefin,
       '00:00:00'                                    as HEUREFIN,
       '-'                                           AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       'NUIT'
                                                     AS estJour,
       'FERIE'                                          estFerie,
       '-'                                           AS manoeuvre,
       'weekend'
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       cast('-' as VARCHAR2(500))                    AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
    --  LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
     -- LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
where ac.RUBRIQUE in ('RB0000000021170444', 'RB0000000021170448');



CREATE or replace VIEW ACTIVITECOMPLETFORMULE_II
AS
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       occ.daty                                      AS datedebut,
       occ.heuredebut,
       OCC.DATEFIN                                   AS datefin,
       OCC.HEUREFIN                                  AS heurefin,
       occ.id                                        AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       CASE
           WHEN occ.heuredebut BETWEEN '05:00:00' AND '19:00:00'
               THEN
               'JOUR'
           ELSE
               'NUIT'
           END
                                                     AS estJour,
       CASE
           WHEN occ.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                     AS estFerie,
       occ.idmanoeuvrebord                           AS manoeuvre,
       CASE
           WHEN TO_CHAR(occ.daty, 'DAY') = 'DIMANCHE'
               OR TO_CHAR(occ.daty, 'DAY') = 'SAMEDI'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       nat.id                                        AS natureoperation,
       CAST(na.DATYFIN-na.DATYDEBUT AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
         LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
         left join OCCUPATIONMATERIELNAVAL_daty na on na.id=occ.id
where Ra.ID not in ('RB0000000021170444', 'RB0000000021170448');



create or replace view ACTIVITECOMPLETFORMULE
            (
             ID,
             DESIGNATION,
             CLIENT,
             RUBRIQUE,
             QTE,
             MOIS,
             MOISLIB,
             ANNEE,
             DATY,
             BATEAU,
             ETAT,
             RUBRIQUELIB,
             NAVIRE,
             BATEAULIB,
             POIDS,
             LONGUEUR,
             LARGEUR,
             AUTRES,
             PU,
             DEVISE,
             COMPTE,
             UNITE,
             DIRECTION,
             CONDITION,
             TVA,
             OBJET,
             REDEVANCE,
             CLIENTLIB,
             REDEVANCELIB,
             DIRECTIONLIB,
             ETATLIB,
             CATEGORIE,
             CATEGORIELIB,
             REFOBJET,
             TYPESOURCE,
             DATEFACT,
             PAVILLON,
             VOLUME,
             VOLUMEARRONDI,
             CARGAISON,
             DATEDEBUT,
             HEUREDEBUT,
             datefin,
             heurefin,
             IDPRESTATION,
             ESTNATIONAL,
             ESTJOUR,
             ESTFERIE,
             MANOEUVRE,
             ESTWEEKEND,
             POSTE,
             POSTELIB,
             NATUREOPERATION,
             nbreheure,
             nbquartheure
                )
as
select *
from ACTIVITECOMPLETFORMULE_I 
union all
select a.*
from ACTIVITECOMPLETFORMULE_II a;

create or replace view ACTIVITECOMPLETFORMULE_II as
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       occ.daty                                      AS datedebut,
       occ.heuredebut,
       OCC.DATEFIN                                   AS datefin,
       OCC.HEUREFIN                                  AS heurefin,
       occ.id                                        AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       CASE
           WHEN occ.heuredebut BETWEEN '05:00:00' AND '19:00:00'
               THEN
               'JOUR'
           ELSE
               'NUIT'
           END
                                                     AS estJour,
       CASE
           WHEN occ.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                     AS estFerie,
       occ.idmanoeuvrebord                           AS manoeuvre,
       CASE
           WHEN TO_CHAR(occ.daty, 'DAY') = 'DIMANCHE'
               OR TO_CHAR(occ.daty, 'DAY') = 'SAMEDI'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       nat.id                                        AS natureoperation,
       na.DATYFIN,
       na.DATYDEBUT,
       case when (round((60*24*(na.DATYFIN-na.DATYDEBUT)-60)/15))<0 then 0
           else (round((60*24*(na.DATYFIN-na.DATYDEBUT)-60)/15)) end
           AS nbHeure,
       round(60*24*(na.DATYFIN-na.DATYDEBUT))                             AS nbQuartHeure
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
         LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
         left join OCCUPATIONMATERIELNAVAL_daty na on na.id=occ.id
where Ra.ID not in ('RB0000000021170444', 'RB0000000021170448');


CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE AS 
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
       to_date(fi.DATEFACT, 'dd/MM/YY') AS DATEFACT,
       fi.RUBRIQUE
from FACTURE_CLIENT_FILLE fi
         left join AS_PRODUITS pr on pr.id = fi.IDPRODUIT
         left join activite ac on ac.id = fi.IDACTIVITE;
		 
CREATE OR REPLACE VIEW "FACTURE_CLIENT_FILLE_PLUS" AS 
SELECT facture_client_fille.ID,
          facture_client_fille.IDMERE,
          facture_client_fille.DESIGNATION,
          facture_client_fille.QUANTITE,
          facture_client_fille.PU,
          facture_client_fille.COMPTE,
          facture_client_fille.IDPRODUIT,
          facture_client_fille.DEVISE,
          facture_client_fille.TAUX,
          CAST (0.0 AS NUMBER (30, 3)) AS montant,
		  facture_client_fille.tva,
       facture_client_fille.IDACTIVITE,
        FACTURE_CLIENT_FILLE.DATEFACT,
        facture_client_fille.RUBRIQUE 
     FROM facture_client_fille where 1>2;
	 
CREATE or replace VIEW ACTIVITECOMPLETFORMULE_I
AS
SELECT ac.ID                                         as id,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       sysdate                                       AS datedebut,
       '00:00:00'                                    as heuredebut,
       sysdate                                       AS datefin,
       '00:00:00'                                    as HEUREFIN,
       '-'                                           AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       'NUIT'
                                                     AS estJour,
       'FERIE'                                          estFerie,
       '-'                                           AS manoeuvre,
       'weekend'
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       cast('-' as VARCHAR2(500))                    AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure,
       cast(1 as number(10))                         as nombredejour
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
    --  LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
     -- LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
where ac.RUBRIQUE in ('RB0000000021170444', 'RB0000000021170448');


CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE_II (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB,
      ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU,
      DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE, CLIENTLIB, REDEVANCELIB,
      DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE, DATEFACT, PAVILLON,
      VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, IDPRESTATION,
      ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, POSTE, POSTELIB, NATUREOPERATION,
      DATYFIN, DATYDEBUT, NBHEURE, NBQUARTHEURE,nbJour) AS
  SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       occ.daty                                      AS datedebut,
       occ.heuredebut,
       OCC.DATEFIN                                   AS datefin,
       OCC.HEUREFIN                                  AS heurefin,
       occ.id                                        AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       CASE
           WHEN occ.heuredebut BETWEEN '05:00:00' AND '19:00:00'
               THEN
               'JOUR'
           ELSE
               'NUIT'
           END
                                                     AS estJour,
       CASE
           WHEN occ.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                     AS estFerie,
       occ.idmanoeuvrebord                           AS manoeuvre,
       CASE
           WHEN TO_CHAR(occ.daty, 'DAY') = 'DIMANCHE'
               OR TO_CHAR(occ.daty, 'DAY') = 'SAMEDI'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       nat.id                                        AS natureoperation,
       na.DATYFIN,
       na.DATYDEBUT,
        case
                  when (round((60 * 24 * (na.DATYFIN - na.DATYDEBUT) - 60) / 15)) < 0 then cast(0 as NUMBER(10))
                  else cast((round((60 * 24 * (na.DATYFIN - na.DATYDEBUT) - 60) / 15)) as NUMBER(10)) end
             AS nbQuartHeure  ,
         cast(round(60 * 24 * (na.DATYFIN - na.DATYDEBUT)) as NUMBER(10))                             AS nbHeure,
         cast(na.DATYFIN - na.DATYDEBUT as NUMBER(10)) as nbJour
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
         LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
         left join OCCUPATIONMATERIELNAVAL_daty na on na.id=occ.id
where Ra.ID not in ('RB0000000021170444', 'RB0000000021170448');

CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE (ID, IDMERE, DESIGNATION,
      QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, PRODUIT_LIB,
      ACTIVITELIB, DATEFACT, RUBRIQUE,RUBRIQUELIB) AS
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
       to_date(fi.DATEFACT, 'dd/MM/YY') AS DATEFACT,
       fi.RUBRIQUE,
        ra.DESIGNATION as  rubriquelib
from FACTURE_CLIENT_FILLE fi
         left join AS_PRODUITS pr on pr.id = fi.IDPRODUIT
         left join activite ac on ac.id = fi.IDACTIVITE
         left join RUBRIQUE_ACTIVITE ra on ra.ID=fi.RUBRIQUE;
		 
		 create or replace view FACTURE_CLIENT_MEREF_paye as
select fcf.* ,
       l.MONTANTTTC,
       (l.MONTANTPAYE*100)/nvl(nullif(MONTANTTTC,0),1) as montantpayepourc,
       (fcf.QUANTITE*fcf.PU)*((l.MONTANTPAYE*100)/nvl(nullif(MONTANTTTC,0),1)) as montantpaye
           from FACTURECLIENTMSUM_LIB l
    left join FACTURE_CLIENT_MERE_FILLE fcf on fcf.IDMERE=l.id;
		 
create or replace view situationLCDepense as
select l.id                       as id,
       l.DESIGNATION              as designation,
       l.COMPTE                  as compte,
       l.ANNEE                    as annee,
       l.MONTANT as montant,
       cast(sum(MONTANTTTC) as number(30,3))  as facture,
       cast(sum(montantpaye) as number(30,3))   paye
from LIGNECREDITRECETTE l
         left join FACTURE_CLIENT_MEREF_paye mf
                   on SUBSTR(mf.COMPTE, 0, length(l.COMPTE)) like l.COMPTE and extract(year from DATY) = l.ANNEE
group by l.id, l.DESIGNATION, l.COMPTE, l.ANNEE, l.MONTANT;

create materialized view OCCUPATIONMATERIELNAVAL_DATY
    refresh on COMMIT as
select to_date(extract(year from DATY) || '-' || extract(month from DATY) || '-' || extract(DAy from DATY) || ' ' ||
               OCCUPATIONMATERIELNAVAL.HEUREDEBUT, 'yy-mm-dd hh24:mi:ss') as datydebut,
       to_date(extract(year from DATEFIN) || '-' || extract(month from DATEFIN) || '-' || extract(DAy from DATEFIN) ||
               ' ' ||
               OCCUPATIONMATERIELNAVAL.HEUREFIN, 'yy-mm-dd hh24:mi:ss')   as datyfin
        ,
       id
from OCCUPATIONMATERIELNAVAL;

CREATE or replace VIEW ACTIVITECOMPLETFORMULE_I
AS
SELECT ac.ID                                         as id,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       sysdate                                       AS datedebut,
       '00:00:00'                                    as heuredebut,
       sysdate                                       AS datefin,
       '00:00:00'                                    as HEUREFIN,
       '-'                                           AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       'NUIT'
                                                     AS estJour,
       'FERIE'                                          estFerie,
       '-'                                           AS manoeuvre,
       'weekend'
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       cast('-' as VARCHAR2(500))                    AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure,
       cast(1 as number(10))                         as nbjour
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
    --  LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
     -- LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
where ac.RUBRIQUE in ('RB0000000021170444', 'RB0000000021170448');


CREATE or replace VIEW ACTIVITECOMPLETFORMULE_II
AS
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                                               AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                                         AS rubriquelib,
       nv.id                                                                  AS navire,
       nv.NOM                                                                 AS bateaulib,
       nv.PLT                                                                 AS poids,
       nv.LHT                                                                 AS longueur,
       nv.LM                                                                  AS largeur,
       CAST('-' AS VARCHAR2(100))                                             AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                                                AS clientlib,
       re.VAL                                                                 AS redevancelib,
       di.LIBELLEDIR                                                          AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                                              AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                                                 AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                                                        AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3))                          AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                                              AS volumeArrondi,
       pre.cargaison,
       occ.daty                                                               AS datedebut,
       occ.heuredebut,
       OCC.DATEFIN                                                            AS datefin,
       OCC.HEUREFIN                                                           AS heurefin,
       occ.id                                                                 AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                                              AS estNational,
       CASE
           WHEN occ.heuredebut BETWEEN '05:00:00' AND '19:00:00'
               THEN
               'JOUR'
           ELSE
               'NUIT'
           END
                                                                              AS estJour,
       CASE
           WHEN occ.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                                              AS estFerie,
       occ.idmanoeuvrebord                                                    AS manoeuvre,
       CASE
           WHEN TO_CHAR(occ.daty, 'DAY') = 'DIMANCHE'
               OR TO_CHAR(occ.daty, 'DAY') = 'SAMEDI'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                                              AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                                            AS postelib,
       nat.id                                                                 AS natureoperation,
       case
           when ((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15 < 0 then 0
           else
               round(((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15) end AS nbQuartHeure,
       case
           when 24 * (na.DATYFIN - na.DATYDEBUT) < 0 then 0
           else
               round((24 * (na.DATYFIN - na.DATYDEBUT))) end                  as nbHeure,
       case
           when 24 * (na.DATYFIN - na.DATYDEBUT) < 0 then 0
           else
               round(na.DATYFIN - na.DATYDEBUT) end                           AS nbJour
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
         LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
         left join OCCUPATIONMATERIELNAVAL_daty na on na.id = occ.id
where Ra.ID not in ('RB0000000021170444', 'RB0000000021170448');




create or replace view ACTIVITECOMPLETFORMULE
            (
             ID,
             DESIGNATION,
             CLIENT,
             RUBRIQUE,
             QTE,
             MOIS,
             MOISLIB,
             ANNEE,
             DATY,
             BATEAU,
             ETAT,
             RUBRIQUELIB,
             NAVIRE,
             BATEAULIB,
             POIDS,
             LONGUEUR,
             LARGEUR,
             AUTRES,
             PU,
             DEVISE,
             COMPTE,
             UNITE,
             DIRECTION,
             CONDITION,
             TVA,
             OBJET,
             REDEVANCE,
             CLIENTLIB,
             REDEVANCELIB,
             DIRECTIONLIB,
             ETATLIB,
             CATEGORIE,
             CATEGORIELIB,
             REFOBJET,
             TYPESOURCE,
             DATEFACT,
             PAVILLON,
             VOLUME,
             VOLUMEARRONDI,
             CARGAISON,
             DATEDEBUT,
             HEUREDEBUT,
             datefin,
             heurefin,
             IDPRESTATION,
             ESTNATIONAL,
             ESTJOUR,
             ESTFERIE,
             MANOEUVRE,
             ESTWEEKEND,
             POSTE,
             POSTELIB,
             NATUREOPERATION,
             nbreheure,
             nbquartheure,
             nbjour

                )
as
select *
from ACTIVITECOMPLETFORMULE_I
union all
select a.*
from ACTIVITECOMPLETFORMULE_II a;


create  view DETAILSFACTUREFOURNISSEUR_paye as
select dff.*,
       ff.MONTANTTTC,
       (ff.MONTANTPAYE * 100) / nvl(nullif(MONTANTTTC, 0), 1)                        as montantpayepourc,
       (dff.Qte * dff.PU) * ((ff.MONTANTPAYE * 100) / nvl(nullif(MONTANTTTC, 0), 1)) as montantpaye
from ETATFACTUREMONTANTDATY ff
         left join DETAILSFACTUREFOURNISSEUR dff on dff.IDMERE = ff.id;

create or replace view DETAILSFACTUREFOURNISSEUR_paye as
select dff.*,
       DATY,
       ff.MONTANTTTC,
       (ff.MONTANTPAYE * 100) / nvl(nullif(MONTANTTTC, 0), 1)                        as montantpayepourc,
       (dff.Qte * dff.PU) * ((ff.MONTANTPAYE * 100) / nvl(nullif(MONTANTTTC, 0), 1)) as montantpaye
from ETATFACTUREMONTANTDATY ff
         left join DETAILSFACTUREFOURNISSEUR dff on dff.IDMERE = ff.id;

		 
alter table detformufact add compte varchar2(500);
alter table facture_client_fille add rubrique varchar(100);

create view OCCUPATIONMATERIELNAVAL_DATY as
select to_date(extract(day from DATY) || '-' || extract(month from DATY) || '-' || extract(year from DATY) || OCCUPATIONMATERIELNAVAL.HEUREDEBUT, 'dd-mm-yyyy hh24:mi:ss') as datydebut,
       to_date(extract(day from DATEFIN) || '-' || extract(month from DATEFIN) || '-' || extract(year from DATEFIN) || OCCUPATIONMATERIELNAVAL.HEUREFIN, 'dd-mm-yyyy hh24:mi:ss') as datyfin
       ,id
from OCCUPATIONMATERIELNAVAL;



CREATE or replace VIEW ACTIVITECOMPLETFORMULE_I
AS
SELECT ac.ID                                         as id,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       sysdate                                       AS datedebut,
       '00:00:00'                                    as heuredebut,
       sysdate                                       AS datefin,
       '00:00:00'                                    as HEUREFIN,
       '-'                                           AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       'NUIT'
                                                     AS estJour,
       'FERIE'                                          estFerie,
       '-'                                           AS manoeuvre,
       'weekend'
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       cast('-' as VARCHAR2(500))                    AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
    --  LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
     -- LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
where ac.RUBRIQUE in ('RB0000000021170444', 'RB0000000021170448');



CREATE or replace VIEW ACTIVITECOMPLETFORMULE_II
AS
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       occ.daty                                      AS datedebut,
       occ.heuredebut,
       OCC.DATEFIN                                   AS datefin,
       OCC.HEUREFIN                                  AS heurefin,
       occ.id                                        AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       CASE
           WHEN occ.heuredebut BETWEEN '05:00:00' AND '19:00:00'
               THEN
               'JOUR'
           ELSE
               'NUIT'
           END
                                                     AS estJour,
       CASE
           WHEN occ.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                     AS estFerie,
       occ.idmanoeuvrebord                           AS manoeuvre,
       CASE
           WHEN TO_CHAR(occ.daty, 'DAY') = 'DIMANCHE'
               OR TO_CHAR(occ.daty, 'DAY') = 'SAMEDI'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       nat.id                                        AS natureoperation,
       CAST(na.DATYFIN-na.DATYDEBUT AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
         LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
         left join OCCUPATIONMATERIELNAVAL_daty na on na.id=occ.id
where Ra.ID not in ('RB0000000021170444', 'RB0000000021170448');



create or replace view ACTIVITECOMPLETFORMULE
            (
             ID,
             DESIGNATION,
             CLIENT,
             RUBRIQUE,
             QTE,
             MOIS,
             MOISLIB,
             ANNEE,
             DATY,
             BATEAU,
             ETAT,
             RUBRIQUELIB,
             NAVIRE,
             BATEAULIB,
             POIDS,
             LONGUEUR,
             LARGEUR,
             AUTRES,
             PU,
             DEVISE,
             COMPTE,
             UNITE,
             DIRECTION,
             CONDITION,
             TVA,
             OBJET,
             REDEVANCE,
             CLIENTLIB,
             REDEVANCELIB,
             DIRECTIONLIB,
             ETATLIB,
             CATEGORIE,
             CATEGORIELIB,
             REFOBJET,
             TYPESOURCE,
             DATEFACT,
             PAVILLON,
             VOLUME,
             VOLUMEARRONDI,
             CARGAISON,
             DATEDEBUT,
             HEUREDEBUT,
             datefin,
             heurefin,
             IDPRESTATION,
             ESTNATIONAL,
             ESTJOUR,
             ESTFERIE,
             MANOEUVRE,
             ESTWEEKEND,
             POSTE,
             POSTELIB,
             NATUREOPERATION,
             nbreheure,
             nbquartheure
                )
as
select *
from ACTIVITECOMPLETFORMULE_I 
union all
select a.*
from ACTIVITECOMPLETFORMULE_II a;

create or replace view ACTIVITECOMPLETFORMULE_II as
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       occ.daty                                      AS datedebut,
       occ.heuredebut,
       OCC.DATEFIN                                   AS datefin,
       OCC.HEUREFIN                                  AS heurefin,
       occ.id                                        AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       CASE
           WHEN occ.heuredebut BETWEEN '05:00:00' AND '19:00:00'
               THEN
               'JOUR'
           ELSE
               'NUIT'
           END
                                                     AS estJour,
       CASE
           WHEN occ.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                     AS estFerie,
       occ.idmanoeuvrebord                           AS manoeuvre,
       CASE
           WHEN TO_CHAR(occ.daty, 'DAY') = 'DIMANCHE'
               OR TO_CHAR(occ.daty, 'DAY') = 'SAMEDI'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       nat.id                                        AS natureoperation,
       na.DATYFIN,
       na.DATYDEBUT,
       case when (round((60*24*(na.DATYFIN-na.DATYDEBUT)-60)/15))<0 then 0
           else (round((60*24*(na.DATYFIN-na.DATYDEBUT)-60)/15)) end
           AS nbHeure,
       round(60*24*(na.DATYFIN-na.DATYDEBUT))                             AS nbQuartHeure
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
         LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
         left join OCCUPATIONMATERIELNAVAL_daty na on na.id=occ.id
where Ra.ID not in ('RB0000000021170444', 'RB0000000021170448');


CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE AS 
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
       to_date(fi.DATEFACT, 'dd/MM/YY') AS DATEFACT,
       fi.RUBRIQUE
from FACTURE_CLIENT_FILLE fi
         left join AS_PRODUITS pr on pr.id = fi.IDPRODUIT
         left join activite ac on ac.id = fi.IDACTIVITE;
		 
CREATE OR REPLACE VIEW "FACTURE_CLIENT_FILLE_PLUS" AS 
SELECT facture_client_fille.ID,
          facture_client_fille.IDMERE,
          facture_client_fille.DESIGNATION,
          facture_client_fille.QUANTITE,
          facture_client_fille.PU,
          facture_client_fille.COMPTE,
          facture_client_fille.IDPRODUIT,
          facture_client_fille.DEVISE,
          facture_client_fille.TAUX,
          CAST (0.0 AS NUMBER (30, 3)) AS montant,
		  facture_client_fille.tva,
       facture_client_fille.IDACTIVITE,
        FACTURE_CLIENT_FILLE.DATEFACT,
        facture_client_fille.RUBRIQUE 
     FROM facture_client_fille where 1>2;
	 
CREATE or replace VIEW ACTIVITECOMPLETFORMULE_I
AS
SELECT ac.ID                                         as id,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       sysdate                                       AS datedebut,
       '00:00:00'                                    as heuredebut,
       sysdate                                       AS datefin,
       '00:00:00'                                    as HEUREFIN,
       '-'                                           AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       'NUIT'
                                                     AS estJour,
       'FERIE'                                          estFerie,
       '-'                                           AS manoeuvre,
       'weekend'
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       cast('-' as VARCHAR2(500))                    AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure,
       cast(1 as number(10))                         as nombredejour
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
    --  LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
     -- LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
where ac.RUBRIQUE in ('RB0000000021170444', 'RB0000000021170448');


CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE_II (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB,
      ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU,
      DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE, CLIENTLIB, REDEVANCELIB,
      DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE, DATEFACT, PAVILLON,
      VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, IDPRESTATION,
      ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, POSTE, POSTELIB, NATUREOPERATION,
      DATYFIN, DATYDEBUT, NBHEURE, NBQUARTHEURE,nbJour) AS
  SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       occ.daty                                      AS datedebut,
       occ.heuredebut,
       OCC.DATEFIN                                   AS datefin,
       OCC.HEUREFIN                                  AS heurefin,
       occ.id                                        AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       CASE
           WHEN occ.heuredebut BETWEEN '05:00:00' AND '19:00:00'
               THEN
               'JOUR'
           ELSE
               'NUIT'
           END
                                                     AS estJour,
       CASE
           WHEN occ.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                     AS estFerie,
       occ.idmanoeuvrebord                           AS manoeuvre,
       CASE
           WHEN TO_CHAR(occ.daty, 'DAY') = 'DIMANCHE'
               OR TO_CHAR(occ.daty, 'DAY') = 'SAMEDI'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       nat.id                                        AS natureoperation,
       na.DATYFIN,
       na.DATYDEBUT,
        case
                  when (round((60 * 24 * (na.DATYFIN - na.DATYDEBUT) - 60) / 15)) < 0 then cast(0 as NUMBER(10))
                  else cast((round((60 * 24 * (na.DATYFIN - na.DATYDEBUT) - 60) / 15)) as NUMBER(10)) end
             AS nbQuartHeure  ,
         cast(round(60 * 24 * (na.DATYFIN - na.DATYDEBUT)) as NUMBER(10))                             AS nbHeure,
         cast(na.DATYFIN - na.DATYDEBUT as NUMBER(10)) as nbJour
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
         LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
         left join OCCUPATIONMATERIELNAVAL_daty na on na.id=occ.id
where Ra.ID not in ('RB0000000021170444', 'RB0000000021170448');

CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE (ID, IDMERE, DESIGNATION,
      QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, PRODUIT_LIB,
      ACTIVITELIB, DATEFACT, RUBRIQUE,RUBRIQUELIB) AS
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
       to_date(fi.DATEFACT, 'dd/MM/YY') AS DATEFACT,
       fi.RUBRIQUE,
        ra.DESIGNATION as  rubriquelib
from FACTURE_CLIENT_FILLE fi
         left join AS_PRODUITS pr on pr.id = fi.IDPRODUIT
         left join activite ac on ac.id = fi.IDACTIVITE
         left join RUBRIQUE_ACTIVITE ra on ra.ID=fi.RUBRIQUE;
		 
		 create or replace view FACTURE_CLIENT_MEREF_paye as
select fcf.* ,
       l.MONTANTTTC,
       (l.MONTANTPAYE*100)/nvl(nullif(MONTANTTTC,0),1) as montantpayepourc,
       (fcf.QUANTITE*fcf.PU)*((l.MONTANTPAYE*100)/nvl(nullif(MONTANTTTC,0),1)) as montantpaye
           from FACTURECLIENTMSUM_LIB l
    left join FACTURE_CLIENT_MERE_FILLE fcf on fcf.IDMERE=l.id;
		 
create or replace view situationLCDepense as
select l.id                       as id,
       l.DESIGNATION              as designation,
       l.COMPTE                  as compte,
       l.ANNEE                    as annee,
       l.MONTANT as montant,
       cast(sum(MONTANTTTC) as number(30,3))  as facture,
       cast(sum(montantpaye) as number(30,3))   paye
from LIGNECREDITRECETTE l
         left join FACTURE_CLIENT_MEREF_paye mf
                   on SUBSTR(mf.COMPTE, 0, length(l.COMPTE)) like l.COMPTE and extract(year from DATY) = l.ANNEE
group by l.id, l.DESIGNATION, l.COMPTE, l.ANNEE, l.MONTANT;

create materialized view OCCUPATIONMATERIELNAVAL_DATY
    refresh on COMMIT as
select to_date(extract(year from DATY) || '-' || extract(month from DATY) || '-' || extract(DAy from DATY) || ' ' ||
               OCCUPATIONMATERIELNAVAL.HEUREDEBUT, 'yy-mm-dd hh24:mi:ss') as datydebut,
       to_date(extract(year from DATEFIN) || '-' || extract(month from DATEFIN) || '-' || extract(DAy from DATEFIN) ||
               ' ' ||
               OCCUPATIONMATERIELNAVAL.HEUREFIN, 'yy-mm-dd hh24:mi:ss')   as datyfin
        ,
       id
from OCCUPATIONMATERIELNAVAL;

CREATE or replace VIEW ACTIVITECOMPLETFORMULE_I
AS
SELECT ac.ID                                         as id,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       sysdate                                       AS datedebut,
       '00:00:00'                                    as heuredebut,
       sysdate                                       AS datefin,
       '00:00:00'                                    as HEUREFIN,
       '-'                                           AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       'NUIT'
                                                     AS estJour,
       'FERIE'                                          estFerie,
       '-'                                           AS manoeuvre,
       'weekend'
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       cast('-' as VARCHAR2(500))                    AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure,
       cast(1 as number(10))                         as nbjour
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
    --  LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
     -- LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
where ac.RUBRIQUE in ('RB0000000021170444', 'RB0000000021170448');


CREATE or replace VIEW ACTIVITECOMPLETFORMULE_II
AS
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                                               AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                                         AS rubriquelib,
       nv.id                                                                  AS navire,
       nv.NOM                                                                 AS bateaulib,
       nv.PLT                                                                 AS poids,
       nv.LHT                                                                 AS longueur,
       nv.LM                                                                  AS largeur,
       CAST('-' AS VARCHAR2(100))                                             AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                                                AS clientlib,
       re.VAL                                                                 AS redevancelib,
       di.LIBELLEDIR                                                          AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                                              AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                                                 AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                                                        AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3))                          AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                                              AS volumeArrondi,
       pre.cargaison,
       occ.daty                                                               AS datedebut,
       occ.heuredebut,
       OCC.DATEFIN                                                            AS datefin,
       OCC.HEUREFIN                                                           AS heurefin,
       occ.id                                                                 AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                                              AS estNational,
       CASE
           WHEN occ.heuredebut BETWEEN '05:00:00' AND '19:00:00'
               THEN
               'JOUR'
           ELSE
               'NUIT'
           END
                                                                              AS estJour,
       CASE
           WHEN occ.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                                              AS estFerie,
       occ.idmanoeuvrebord                                                    AS manoeuvre,
       CASE
           WHEN TO_CHAR(occ.daty, 'DAY') = 'DIMANCHE'
               OR TO_CHAR(occ.daty, 'DAY') = 'SAMEDI'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                                              AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                                            AS postelib,
       nat.id                                                                 AS natureoperation,
       case
           when ((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15 < 0 then 0
           else
               round(((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15) end AS nbQuartHeure,
       case
           when 24 * (na.DATYFIN - na.DATYDEBUT) < 0 then 0
           else
               round((24 * (na.DATYFIN - na.DATYDEBUT))) end                  as nbHeure,
       case
           when 24 * (na.DATYFIN - na.DATYDEBUT) < 0 then 0
           else
               round(na.DATYFIN - na.DATYDEBUT) end                           AS nbJour
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
         LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
         left join OCCUPATIONMATERIELNAVAL_daty na on na.id = occ.id
where Ra.ID not in ('RB0000000021170444', 'RB0000000021170448');




create or replace view ACTIVITECOMPLETFORMULE
            (
             ID,
             DESIGNATION,
             CLIENT,
             RUBRIQUE,
             QTE,
             MOIS,
             MOISLIB,
             ANNEE,
             DATY,
             BATEAU,
             ETAT,
             RUBRIQUELIB,
             NAVIRE,
             BATEAULIB,
             POIDS,
             LONGUEUR,
             LARGEUR,
             AUTRES,
             PU,
             DEVISE,
             COMPTE,
             UNITE,
             DIRECTION,
             CONDITION,
             TVA,
             OBJET,
             REDEVANCE,
             CLIENTLIB,
             REDEVANCELIB,
             DIRECTIONLIB,
             ETATLIB,
             CATEGORIE,
             CATEGORIELIB,
             REFOBJET,
             TYPESOURCE,
             DATEFACT,
             PAVILLON,
             VOLUME,
             VOLUMEARRONDI,
             CARGAISON,
             DATEDEBUT,
             HEUREDEBUT,
             datefin,
             heurefin,
             IDPRESTATION,
             ESTNATIONAL,
             ESTJOUR,
             ESTFERIE,
             MANOEUVRE,
             ESTWEEKEND,
             POSTE,
             POSTELIB,
             NATUREOPERATION,
             nbreheure,
             nbquartheure,
             nbjour

                )
as
select *
from ACTIVITECOMPLETFORMULE_I
union all
select a.*
from ACTIVITECOMPLETFORMULE_II a;


create  view DETAILSFACTUREFOURNISSEUR_paye as
select dff.*,
       ff.MONTANTTTC,
       (ff.MONTANTPAYE * 100) / nvl(nullif(MONTANTTTC, 0), 1)                        as montantpayepourc,
       (dff.Qte * dff.PU) * ((ff.MONTANTPAYE * 100) / nvl(nullif(MONTANTTTC, 0), 1)) as montantpaye
from ETATFACTUREMONTANTDATY ff
         left join DETAILSFACTUREFOURNISSEUR dff on dff.IDMERE = ff.id;

create or replace view DETAILSFACTUREFOURNISSEUR_paye as
select dff.*,
       DATY,
       ff.MONTANTTTC,
       (ff.MONTANTPAYE * 100) / nvl(nullif(MONTANTTTC, 0), 1)                        as montantpayepourc,
       (dff.Qte * dff.PU) * ((ff.MONTANTPAYE * 100) / nvl(nullif(MONTANTTTC, 0), 1)) as montantpaye
from ETATFACTUREMONTANTDATY ff
         left join DETAILSFACTUREFOURNISSEUR dff on dff.IDMERE = ff.id;
		 

create or replace view situationLCDepense as
select l.id                       as id,
       l.DESIGNATION              as designation,
       l.COMPTE                  as compte,
       l.ANNEE                    as annee,
       l.MONTANT as montant,
       cast(sum(MONTANTTTC) as number(30,3))  as facture,
       cast(sum(montantpaye) as number(30,2))   paye
from LIGNECREDITDEPENSE l
         left join DETAILSFACTUREFOURNISSEUR_paye mf
                   on SUBSTR(mf.COMPTE, 0, length(l.COMPTE)) like l.COMPTE and extract(year from daty) = l.ANNEE
group by l.id, l.DESIGNATION, l.COMPTE, l.ANNEE, l.MONTANT;





alter table facture_client_fille
    modify pu number(30, 3);
create or replace view FACTURE_CLIENT_FILLE_PLUS as
SELECT facture_client_fille.ID,
       facture_client_fille.IDMERE,
       facture_client_fille.DESIGNATION,
       facture_client_fille.QUANTITE,
       facture_client_fille.PU,
       facture_client_fille.COMPTE,
       facture_client_fille.IDPRODUIT,
       facture_client_fille.DEVISE,
       facture_client_fille.TAUX,
       CAST(0.0 AS NUMBER(30, 3)) AS montant,
       facture_client_fille.tva,
       facture_client_fille.IDACTIVITE,
       FACTURE_CLIENT_FILLE.DATEFACT
FROM facture_client_fille
where 1 > 2;



create or replace view AVOIRFCAVECTAUX as
select ac.*,
       cast(nvl(fc.TAUX, 1) as number(30, 3))              as taux,
       nvl(fc.DEVISE, 'Ar')                                as devise,
       cast(ac.MONTANT * nvl(fc.TAUX, 1) as number(30, 3)) as montantavectsaux,
       a.ETAT
from AVOIRFCFILLE ac
         left join FACTURE_CLIENT_FILLE fc on fc.ID = ac.IDDETAILFACTURE
         left join avoirfc a on ac.IDMERE = a.ID;


create or replace view ANALYSEGLOBALEFACTURE_VAOVAO
            (NMFACT, DATY, CATEGORIE_FACTURE, SOUS_CATEGORIE_FACTURE, CLIENT, CATEGORIE_CLIENT, DESIGNATION, MTTC, MTHT,
             TAXE, DEVFACT, MTDEVISE, MTAVOIR, PAYE, RESTE, NUMCOMPTE, VALCAT)
as
SELECT fc.id,
       fc.daty,
       cat.ID,
       '-',
       fc.tiers,
       cl.categorie,
       fc.designation,
       cast(fc.montantttc as number(32, 3)),
       cast(fc.montant as NUMBER(32, 3)),
       cast(fc.montanttva as NUMBER(32, 3)),
       '-',
       cast(fc.montantttc as NUMBER(32, 3)),
       cast(fc.montantavoir as NUMBER(32, 3)),
       cast(fc.MONTANTPAYE as NUMBER(32, 3)),
       cast(fc.MONTANTTTC - fc.MONTANTPAYE as NUMBER(32, 3)),
       '-',
       cat.val
FROM factureclientmsum_lib fc
         LEFT JOIN FACTURE_CLIENT_FILLE ff ON fc.id = FF.IDMERE
         LEFT JOIN ACTIVITE act ON ff.IDACTIVITE = act.ID
         LEFT JOIN RUBRIQUE_ACTIVITE rub ON act.RUBRIQUE = rub.ID
         LEFT JOIN CATEGORIEFACTURATION cat ON rub.CATEGORIE = cat.ID
         LEFT JOIN V_client_categorie cl ON fc.tiers = CL.CDCLT;


create view FACTURE_CLIENT_FILLE_LIBELLE as
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
       pr.nom                           as produit_lib,
       ac.DESIGNATION                   as activitelib,
       to_date(fi.DATEFACT, 'dd/MM/YY') AS DATEFACT
from FACTURE_CLIENT_FILLE fi
         left join AS_PRODUITS pr on pr.id = fi.IDPRODUIT
         left join activite ac on ac.id = fi.IDACTIVITE;


create or replace view FACTURE_CLIENT_FILLE_VM as
select fcf.*
from facture_client_fille fcf
         join factureclient fc on fcf.IDMERE = fc.ID
where fc.etat >= 11;


create or replace view FACTURE_CLIENT_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT)
as
SELECT fi."ID",
       fi."IDMERE",
       fi."DESIGNATION",
       fi."QUANTITE",
       fi."PU",
       fi."COMPTE",
       fi."IDPRODUIT",
       fi."DEVISE",
       fi."TAUX",
       fc.daty,
       fc.tiers,
       fc.designation AS designationmere,
       fc.TYPE,
       decode(fi.tva, null, fc.tva, fi.tva),
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;


create or replace view AS_BONDELIVRAISON_CL_PDT as
select fi.ID,
       nvl(fil.idPRODUIT, fil.DESIGNATION) as produit,
       fi.NUMBL,
       fi.QUANTITE,
       fi.IDDETAILSFACTUREFOURNISSEUR,
       cast('' as varchar2(400))           as pdt
from as_bondelivraison_cl_fille fi
         left join FACTURE_CLIENT_FILLE fil on fi.IDDETAILSFACTUREFOURNISSEUR = fil.ID;

create  or replace view FACTURE_CLIENT_FILLE_LIB_RESTE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB)
as
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANT AS NUMBER(32, 5)),
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3)),
       CAST(fcm.tva AS NUMBER(20, 3)),
       idactivite,
       ra.DESIGNATION                             as activitelib
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         left join ACTIVITE ra on ra.id = fc.IDACTIVITE;



create or replace view FACTURE_CLIENT_FILLE_LIB as
select ID,
       IDMERE,
       DESIGNATION,
       cast(QUANTITE as NUMBER(32, 3))             as QUANTITE,
       cast(PU as NUMBER(32, 3))                   as PU,
       COMPTE,
       IDPRODUIT,
       DEVISE,
       TAUX,
       cast(QTELIVREE as number(32, 3))            as QTELIVREE,
       cast(RESTEALIVRER as NUMBER(32, 3))         as RESTEALIVRER,
       cast(MONTANTTAUX as NUMBER(32, 3))          as MONTANTTAUX,
       cast(MONTANT as NUMBER(32, 3))              as MONTANT,
       cast(MONTANTAVOIRSANSTAUX as NUMBER(32, 3)) as MONTANTAVOIRSANSTAUX,
       cast(MONTANTAVOIRAVECTAUX as NUMBER(32, 3)) as MONTANTAVOIRAVECTAUX,
       IDPRODUITLIB,
       IDACTIVITE,
       CATEGORIEFACTURELIB,
       CATEGORIECLIENTLIB
from (
         select fc.ID,
                fc.IDMERE,
                fc.DESIGNATION,
                fc.QUANTITE,
                fc.PU,
                fc.COMPTE,
                fc.IDPRODUIT,
                fc.DEVISE,
                fc.TAUX,
                cast(nvl(gr.QUANTITE, 0) as number(10, 3))               as qteLivree,
                cast(fc.QUANTITE - nvl(gr.QUANTITE, 0) as number(10, 3)) as resteAlivrer,
                cast(fcm.MONTANTTAUX as number(32, 3))                   as MONTANTTAUX,
                cast(fcm.MONTANT as NUMBER(32, 3))                       as MONTANT,
                cast(fcm.MONTANTAVOIRSANSTAUX as number(32, 3))          as MONTANTAVOIRSANSTAUX,
                cast(fcm.MONTANTAVOIRAVECTAUX as NUMBER(32, 3))          as MONTANTAVOIRAVECTAUX,
                pr.nom                                                   AS IDPRODUITlib,
                fc.IDACTIVITE,
                al.CATEGORIELIB                                          as categorieFacturelib,
                fcm.CATEGORIE                                            as categorieclientlib
         from facture_client_fille fc
                  left join AS_PRODUITS pr on pr.ID = fc.IDPRODUIT
                  left join as_bondelivraison_cl_grp gr on gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
                  left join FACTURE_CLIENT_MONTANT_LIB fcm on fcm.id = fc.id
                  left join ACTIVITELIBCOMPLET al on al.id = fc.IDACTIVITE
         union all
         select *
         from ANALYSEGLOBALFACTURE_FAC);





