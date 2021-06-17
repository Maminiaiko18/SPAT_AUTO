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