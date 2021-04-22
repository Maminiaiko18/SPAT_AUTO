  CREATE OR REPLACE view  OCCUPMATERIELNAVALLIB (ID, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, IDNAVIRE, POSITION, OBSERVATION, ETAT,  IDARRIVEE, IDARRIVEELIB, POSITIONLIB,  duree,
       daty, heuredebut, datefin, heurefin, ETATLIB) AS 
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
       etatlib

from OCCUPMATERIELNAVALLIBCOMPLET
order by DATY desc;
