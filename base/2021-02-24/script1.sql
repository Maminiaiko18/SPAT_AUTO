CREATE OR REPLACE  VIEW MOUVEMENTLIBCOMPLET (ID, DATY, ESCALE, NAVIRE, CONSIGNATAIRE, PROVENANCE, DESTINATION, 
    REMARQUE, DUREE, TYPEMVT, CARGAISON, REFERENCENAVIRE, NOMNAVIRE, VALMVT, DESCEMVT, VALCARGAISON, DESCECARGAISON, 
    VALCONSIGNATAIRE, DESCECONSIGNATAIRE, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE, VALPAYSPROVENANCE, QUAISDESTINATION, 
    VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION, DATEARRIVEE, HEURE, DATE_DEPART, HEURE_DEPART, INTERNEPROVENANCE, 
    DESCEQUAISPROVENANCE, TYPEQUAISPROVENANCE, TIRANTPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE, DESCEPAYSPROVENANCE, INTERNEDESTINATION, 
    DESCEQUAISDESTINATION, TYPEQUAISDESTIANANTION, TIRANTDESTINATION, LONGUEURDESTINATION, PROFONDEURDESTINATION, DESCEPAYSDESTINATION, PAVILLONNAVIRE, 
    JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, ETAT,ETATLIB) AS 
  SELECT  mvt.ID,
                   mvt.daty,
                   mvt.ESCALE,
                   mvt.NAVIRE,
                   mvt.CONSIGNATAIRE,
                   mvt.PROVENANCE,
                   mvt.DESTINATION,
                   mvt.REMARQUE,
                   mvt.DUREE,
                   mvt.TYPEMVT,
                   mvt.CARGAISON,
                   na.REFERENCE AS referencenavire,
                   na.NOM AS nomnavire,
                   tm.VAL AS valmvt,
                   tm.desce AS descemvt,
                   car.VAL AS valcargaison,
                   car.desce AS descecargaison,
                   cons.VAL AS valconsignataire,
                   cons.DESCE AS desceconsignataire,
                   pro.QUAI AS quaiprovenance,
                   q.val AS valquaisprovenance,
                   q.PAYS AS paysprovenance,
                   p.VAL AS valpaysprovenance,
                   des.QUAI AS quaisdestination,
                   q1.VAL AS valquaisdestination,
                   q1.PAYS AS paysdestination,
                   p1.VAL AS valpaysdestination,
                   mvt.DATEARRIVEE,
                   mvt.heure,
                   mvt.DATE_DEPART,
                   mvt.HEURE_DEPART,
                   pro.INTERNE AS interneprovenance,
                   q.DESCE AS descequaisprovenance,
                   q.TYPEQUAIS AS typequaisprovenance,
                   q.TIRANT AS tirantprovenance,
                   q.LONGUEUR AS longueurprovenance,
                   q.PROFONDEUR AS profondeurprovenance,
                   p.DESCE AS descepaysprovenance,
                   des.INTERNE AS internedestination,
                   q1.DESCE AS descequaisdestination,
                   q1.TYPEQUAIS AS typequaisdestianantion,
                   q1.TIRANT AS tirantdestination,
                   q1.LONGUEUR AS longueurdestination,
                   q1.PROFONDEUR AS profondeurdestination,
                   p1.DESCE AS descepaysdestination,
                   na.PAVILLON AS pavillonnavire,
                   na.JNT AS jntnavire,
                   na.JBT AS jbtnavire,
                   na.PLT AS pltnavire,
                   na.LHT AS lhtnavire,
                   na.LM AS lmnavire,
                   na.TE AS tenavire,
                   na.VOLUME AS volumenavire,
                   na.REMARQUE AS remarquenavire,
                   na.ETAT AS etatnavire,
                   t.VAL AS valtypequaisprovenance,
                   t.DESCE AS descetypequaisprovenance,
                   t2.val AS valtypequaisdestination,
                   t2.DESCE AS descetypequaisdestination,
                   mvt.etat,
                   case when mvt.etat=1 then 'CREER'
                        when mvt.etat=11 then 'VISEE'
                        END AS ETATLIB
     FROM MOUVEMENT mvt
          LEFT JOIN NAVIRE na ON na.ID = MVT.NAVIRE
          LEFT JOIN CONSIGNATAIRETAB cons ON cons.id = mvt.CONSIGNATAIRE
          LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = mvt.PROVENANCE
          LEFT JOIN POSTEDESTINATAIRE des ON des.id = mvt.DESTINATION
          LEFT JOIN TYPEMVT tm ON tm.id = mvt.TYPEMVT
          LEFT JOIN CARGAISON car ON car.id = mvt.CARGAISON
          LEFT JOIN quais q ON q.id = pro.QUAI
          LEFT JOIN pays p ON p.id = q.PAYS
          LEFT JOIN quais q1 ON q1.id = des.QUAI
          LEFT JOIN pays p1 ON p1.id = q1.PAYS
          LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
          LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS;


CREATE OR REPLACE  VIEW OCCUPMATERIELNAVALLIBCOMPLET (ID, DATY, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, HEUREDEBUT, HEUREFIN, IDNAVIRE, IDCLIENT, 
DUREE, POSITION, OBSERVATION, ETAT, DATEFIN, IDARRIVEE, DENOMINATION, DATE_AQUISITION, IDMARQUE, PUISSANCE, DETENTEUR, MAINTENANCE, IDTYPE_MATERIEL, IMMATRICULATION, ETATMATERIELNAVAL, 
VALMARQUE, DESCEMARQUE, VALTYPEMATERIEL, DESCETYPEMATERIEL, VALPILOTE, DESCEPILOTE, VALCOMMANDANT, DESCECOMMANDANT, VALNATUREOPERATION, DESCENATUREOPERATION, VALMANOEUVREBORD, DESCEMANOEUVREBORD,
REFERENCE, NOMNAVIRE, PAVILLONNAVIRE, JNT, JBT, PLT, LHT, LM, TE, VOLUME, REMARQUE, VALPAVILLON, DESCEPAVILLON, IDARRIVEELIB, POSITIONLIB,ETATLIB) AS 
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
	 case when occup.etat=1 then 'CREER'
		when occup.etat=11 then 'VISEE' END AS ETATLIB
     FROM OCCUPATIONMATERIELNAVAL occup
          left JOIN MATERIELNAVALLIBCOMPLET mat ON mat.ID = occup.IDMATERIEL_NAVAL
          LEFT JOIN pilote p ON p.ID = occup.IDPILOTE
          left JOIN COMMANDANT comm ON comm.id = occup.IDCOMMANDANT
          left JOIN NATUREOPERATION nat ON nat.id = occup.IDNATUREOPERATION
          left JOIN MANOEUVREBORD manb ON manb.id = occup.IDMANOEUVREBORD
          LEFT JOIN NAVIRELIBCOMPLET nav ON nav.ID = occup.IDNAVIRE
          LEFT JOIN MOUVEMENT_LIBCOMPLET ML ON ML.ID = occup.IDARRIVEE;

     CREATE OR REPLACE  VIEW OCCUPMATERIELNAVALLIB 
    (ID, DATY, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, 
    HEUREDEBUT, HEUREFIN, IDNAVIRE, DUREE, POSITION, OBSERVATION, ETAT, DATEFIN, IDARRIVEE, IDARRIVEELIB, POSITIONLIB,ETATLIB) AS 
  select id,
       daty,
       denomination       as idmateriel_naval,
       valpilote          as idpilote,
       valcommandant      as idcommandant,
       valnatureoperation as idnatureoperation,
       valmanoeuvrebord   as idmanoeuvrebord,
       heuredebut,
       heurefin,
       nomnavire          as idnavire,
       duree,
       position,
       observation,
       etat,
       datefin,
       IDARRIVEE,
       IDARRIVEELIB,
     positionlib,
     etatlib

from OCCUPMATERIELNAVALLIBCOMPLET
order by DATY desc;