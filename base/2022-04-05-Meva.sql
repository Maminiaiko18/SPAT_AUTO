CREATE OR REPLACE VIEW "MOUVEMENTLIBCOMPLETTA" ("ID", "DATY", "ESCALE", "NAVIRE", "CONSIGNATAIRE", "PROVENANCE", "DESTINATION", "REMARQUE", "DUREE", "TYPEMVT", "CARGAISON", "REFERENCENAVIRE", "NOMNAVIRE", "VALMVT", "DESCEMVT", "VALCARGAISON", "DESCECARGAISON", "VALCONSIGNATAIRE", "DESCECONSIGNATAIRE", "QUAIPROVENANCE", "VALQUAISPROVENANCE", "PAYSPROVENANCE", "VALPAYSPROVENANCE", "QUAISDESTINATION", "VALQUAISDESTINATION", "PAYSDESTINATION", "VALPAYSDESTINATION", "DATEARRIVEE", "HEURE", "DATE_DEPART", "HEURE_DEPART", "INTERNEPROVENANCE", "DESCEQUAISPROVENANCE", "TYPEQUAISPROVENANCE", "TIRANTPROVENANCE", "LONGUEURPROVENANCE", "PROFONDEURPROVENANCE", "DESCEPAYSPROVENANCE", "INTERNEDESTINATION", "DESCEQUAISDESTINATION", "TYPEQUAISDESTIANANTION", "TIRANTDESTINATION", "LONGUEURDESTINATION", "PROFONDEURDESTINATION", "DESCEPAYSDESTINATION", "PAVILLONNAVIRE", "JNTNAVIRE", "JBTNAVIRE", "PLTNAVIRE", "LHTNAVIRE", "LMNAVIRE", "TENAVIRE", "VOLUMENAVIRE", "REMARQUENAVIRE", "ETATNAVIRE", "VALTYPEQUAISPROVENANCE", "DESCETYPEQUAISPROVENANCE", "VALTYPEQUAISDESTINATION", "DESCETYPEQUAISDESTINATION", "ETAT", "ETATLIB", "ESCALELIB", "NOVOYAGE", "NBHEURE", "DATE_DEPART_PREV") AS 
  SELECT mvt.ID,
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
       na.REFERENCE      AS referencenavire,
       na.NOM            AS nomnavire,
       tm.VAL            AS valmvt,
       tm.desce          AS descemvt,
       car.VAL           AS valcargaison,
       car.desce         AS descecargaison,
       mvt.CONSIGNATAIRE AS valconsignataire,
       cons.NOMCLT       AS desceconsignataire,
       pro.QUAI          AS quaiprovenance,
       q.val             AS valquaisprovenance,
       q.PAYS            AS paysprovenance,
       p.VAL             AS valpaysprovenance,
       des.QUAI          AS quaisdestination,
       q1.VAL            AS valquaisdestination,
       q1.PAYS           AS paysdestination,
       p1.VAL            AS valpaysdestination,
       mvt.DATEARRIVEE,
       mvt.heure,
       mvt.DATE_DEPART,
       mvt.HEURE_DEPART,
       pro.INTERNE       AS interneprovenance,
       q.DESCE           AS descequaisprovenance,
       q.TYPEQUAIS       AS typequaisprovenance,
       q.TIRANT          AS tirantprovenance,
       q.LONGUEUR        AS longueurprovenance,
       q.PROFONDEUR      AS profondeurprovenance,
       p.DESCE           AS descepaysprovenance,
       des.INTERNE       AS internedestination,
       q1.DESCE          AS descequaisdestination,
       q1.TYPEQUAIS      AS typequaisdestianantion,
       q1.TIRANT         AS tirantdestination,
       q1.LONGUEUR       AS longueurdestination,
       q1.PROFONDEUR     AS profondeurdestination,
       p1.DESCE          AS descepaysdestination,
       na.PAVILLON       AS pavillonnavire,
       na.JNT            AS jntnavire,
       na.JBT            AS jbtnavire,
       na.PLT            AS pltnavire,
       na.LHT            AS lhtnavire,
       na.LM             AS lmnavire,
       na.TE             AS tenavire,
       na.VOLUME         AS volumenavire,
       na.REMARQUE       AS remarquenavire,
       na.ETAT           AS etatnavire,
       t.VAL             AS valtypequaisprovenance,
       t.DESCE           AS descetypequaisprovenance,
       t2.val            AS valtypequaisdestination,
       t2.DESCE          AS descetypequaisdestination,
       mvt.etat,
       case
           when mvt.etat = 1 then 'CREE(E)'
           when mvt.etat = 11 then 'VISE(E)'
           END           AS ETATLIB,
       pre.ESCALE,
       pre.NOVOYAGE,
       CASE
           WHEN mvt.HEURE_DEPART IS NULL OR mvt.HEURE IS NULL
               or (mvt.DATEARRIVEE is null) or (mvt.DATE_DEPART is null)
               THEN
               0
           ELSE
               (ceil(24 * (TO_DATE(mvt.DATE_DEPART || ' ' || mvt.HEURE_DEPART, 'dd-mm-yy hh24:mi:ss') -
                           TO_DATE(mvt.DATEARRIVEE || ' ' || mvt.HEURE,'dd-mm-yy hh24:mi:ss'))))
           END
                         AS nbHeure,
       pre.DATE_DEPART   as date_depart_prev
FROM MOUVEMENT mvt
         LEFT JOIN NAVIRE na ON na.ID = MVT.NAVIRE
    
         LEFT JOIN CLIENTMAT cons ON cons.CDCLT = mvt.CONSIGNATAIRE
         LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = mvt.PROVENANCE
         LEFT JOIN POSTEDESTINATAIRE des ON des.id = mvt.DESTINATION
         LEFT JOIN TYPEMVT tm ON tm.id = mvt.TYPEMVT
         LEFT JOIN CARGAISON car ON car.id = mvt.CARGAISON
         LEFT JOIN quais q ON q.id = pro.QUAI
         LEFT JOIN pays p ON p.id = q.PAYS
         LEFT JOIN quais q1 ON q1.id = des.QUAI
         LEFT JOIN pays p1 ON p1.id = q1.PAYS
         LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
         LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
         left join PREVISION pre on pre.id = mvt.ESCALE
         
         WHERE pre.estfictive < 1 OR pre.estfictive IS null  ;

CREATE OR REPLACE VIEW "PREVISIONLIBCOMPLET" ("ID", "DATE_RADE", "PROVENANCE", "NAVIRE", "CONSIGNATAIRE", "CARGAISON", "PILOTE", "DATE_ARRIVEE", "HEURE_ARRIVEE", "DATE_DEPART", "HEURE_DEPART", "DESTINATION", "ETAT", "QUAIPROVENANCE", "VALQUAISPROVENANCE", "PAYSPROVENANCE", "VALPAYSPROVENANCE", "QUAIDESTINATION", "VALQUAISDESTINATION", "PAYSDESTINATION", "VALPAYSDESTINATION", "INTERNEPOVENANCE", "LONGUEURPROVENANCE", "TIRANTPROVENANCE", "PROFONDEURPROVENANCE", "REFERENCENAVIRE", "NOMNAVIRE", "PAVILLONNAVIRE", "JNTNAVIRE", "JBTNAVIRE", "PLTNAVIRE", "LHTNAVIRE", "LMNAVIRE", "TENAVIRE", "VOLUMENAVIRE", "REMARQUENAVIRE", "ETATNAVIRE", "VALCONSIGNATAIRE", "DESCECONSIGNATAIRE", "VALCARGAISON", "DESCECARGAISON", "VALPILOTE", "DESCEPILOTE", "INTERNEDESTINATION", "LONGUEURDESTINATION", "TIRANTDESTINATION", "PROFONDEURDESTINATION", "DESCEPROVENANCE", "DESCEDESTINATION", "VALTYPEQUAISPROVENANCE", "DESCETYPEQUAISPROVENANCE", "VALTYPEQUAISDESTINATION", "DESCETYPEQUAISDESTINATION", "DESCEQUAISPROVENANCE", "DESCEQUAISDESTINATION", "TYPEQUAISPROVENANCE", "TYPEQUAISDESTINATION", "TYPENAVIRE", "TYPENAVIRELIB", "ESCALE", "NOVOYAGE", "ARMATEUR", "ARMATEURLIB", "MAJORATION", "REDUCTION", "PAVILLONLIB", "DESIGNATION", "CODE", "TONNAGE", "ESTFICTIVE") AS 
  SELECT pre.ID,
          pre.date_rade,
          pre.provenance,
          pre.navire,
          pre.consignataire,
          pre.cargaison,
          pre.pilote,
          pre.date_arrivee,
          pre.heure_arrivee,
          pre.date_depart,
          pre.heure_depart,
          pre.destination,
          pre.etat,
          pro.QUAI AS QUAIPROVENANCE,
          q.VAL AS valquaisprovenance,
          q.PAYS AS paysprovenance,
          pa.VAL AS valpaysprovenance,
          pr.QUAI AS QUAIDESTINATION,
          q1.val AS valquaisdestination,
          q1.PAYS AS paysdestination,
          pa1.VAL AS valpaysdestination,
          pro.INTERNE AS INTERNEPOVENANCE,
          q.LONGUEUR AS longueurprovenance,
          q.TIRANT AS tirantprovenance,
          q.PROFONDEUR AS profondeurprovenance,
          na.REFERENCE AS referencenavire,
          na.NOM AS nomnavire,
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
          con.NOMCLT AS valconsignataire,
          con.ADRCLT AS desceconsignataire,
          car.VAL AS valcargaison,
          car.DESCE AS descecargaison,
          pi.VAL AS valpilote,
          pi.DESCE AS descepilote,
          pr.INTERNE AS INTERNEDESTINATION,
          q1.LONGUEUR AS longueurdestination,
          q1.TIRANT AS tirantdestination,
          q1.PROFONDEUR AS profondeurdestination,
          pa.DESCE AS desceprovenance,
          pa1.DESCE AS descedestination,
          t.VAL AS valtypequaisprovenance,
          t.DESCE AS descetypequaisprovenance,
          t2.val AS valtypequaisdestination,
          t2.DESCE AS descetypequaisdestination,
          q.DESCE AS descequaisprovenance,
          q1.DESCE AS descequaisdestination,
          q.TYPEQUAIS AS typequaisprovenance,
          q1.TYPEQUAIS AS typequaisdestination,
          na.TYPE AS typenavire,
          tn.VAL AS typenavirelib,
          pre.escale,
          pre.NOVOYAGE,
          pre.ARMATEUR,
          cons.NOMCLT AS ARMATEURLIB,
          0 AS majoration,
          0 AS reduction,
          pay.val AS pavillonlib,
          CAST ('' AS VARCHAR2 (500)) AS DESIGNATION,
          CAST ('' AS VARCHAR2 (500)) AS CODE,
          pre.TONNAGE , 
          pre.ESTFICTIVE 
     FROM prevision pre
          LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
          LEFT JOIN NAVIRE na ON na.id = pre.NAVIRE
          LEFT JOIN PAYS pay ON pay.id = na.pavillon
          LEFT JOIN clientmat con ON con.CDCLT = pre.CONSIGNATAIRE
          LEFT JOIN CARGAISON car ON car.id = pre.CARGAISON
          LEFT JOIN commandant pi ON pi.ID = pre.PILOTE
          LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = pre.DESTINATION
          LEFT JOIN QUAIS q ON q.id = pro.QUAI
          LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
          LEFT JOIN PAYS pa ON pa.id = q.PAYS
          LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
          LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
          LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
          LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
          LEFT JOIN clientmat cons ON cons.CDCLT = pre.ARMATEUR 
         WHERE pre.ESTFICTIVE < 1 OR pre.ESTFICTIVE IS null 
;


CREATE OR REPLACE VIEW "PREVISIONLIB" ("ID", "DATE_RADE", "PROVENANCE", "NAVIRE", "CONSIGNATAIRE", "CARGAISON", "PILOTE", "DATE_ARRIVEE", "HEURE_ARRIVEE", "DATE_DEPART", "HEURE_DEPART", "DESTINATION", "ETAT", "NOVOYAGE", "ARMATEUR", "ARMATEURLIB", "ESTFICTIVE") AS 
  select ID,
       DATE_RADE,
       QUAIPROVENANCE   as provenance,
       NOMNAVIRE        as navire,
       VALCONSIGNATAIRE as consignataire,
       CARGVAL          as cargaison,
       valpilote        as pilote,
       DATE_ARRIVEE,
       HEURE_ARRIVEE,
       DATE_DEPART,
       HEURE_DEPART,
       quaiDESTINATION  as destination,
       etat,
       NOVOYAGE,
         ARMATEUR,
         ARMATEURLIB , 
    ESTFICTIVE
from PREVISIONLIBELLECOMPLET WHERE ESTFICTIVE< 1 OR ESTFICTIVE IS null ;

CREATE OR REPLACE VIEW "PREVISIONLIBCOMPLETA" AS
select *
from previsionLibComplet
where ETAT = 0 ;

CREATE OR REPLACE VIEW "PREVISIONLIBCOMPLETC" AS 
select *
from previsionLibComplet
where ETAT = 1 ;

CREATE OR REPLACE VIEW "PREVISIONLIBCOMPLETV" AS 
select *
from previsionLibComplet
where ETAT = 11  
;

CREATE OR REPLACE VIEW "PREVISIONFACTUREE" ("ID", "DATE_RADE", "PROVENANCE", "NAVIRE", "CONSIGNATAIRE", "CARGAISON", "PILOTE", "DATE_ARRIVEE", "HEURE_ARRIVEE", "DATE_DEPART", "HEURE_DEPART", "DESTINATION", "ETAT", "QUAIPROVENANCE", "VALQUAISPROVENANCE", "PAYSPROVENANCE", "VALPAYSPROVENANCE", "QUAIDESTINATION", "VALQUAISDESTINATION", "PAYSDESTINATION", "VALPAYSDESTINATION", "INTERNEPOVENANCE", "LONGUEURPROVENANCE", "TIRANTPROVENANCE", "PROFONDEURPROVENANCE", "REFERENCENAVIRE", "NOMNAVIRE", "PAVILLONNAVIRE", "JNTNAVIRE", "JBTNAVIRE", "PLTNAVIRE", "LHTNAVIRE", "LMNAVIRE", "TENAVIRE", "VOLUMENAVIRE", "REMARQUENAVIRE", "ETATNAVIRE", "VALCONSIGNATAIRE", "DESCECONSIGNATAIRE", "VALCARGAISON", "DESCECARGAISON", "VALPILOTE", "DESCEPILOTE", "INTERNEDESTINATION", "LONGUEURDESTINATION", "TIRANTDESTINATION", "PROFONDEURDESTINATION", "DESCEPROVENANCE", "DESCEDESTINATION", "VALTYPEQUAISPROVENANCE", "DESCETYPEQUAISPROVENANCE", "VALTYPEQUAISDESTINATION", "DESCETYPEQUAISDESTINATION", "DESCEQUAISPROVENANCE", "DESCEQUAISDESTINATION", "TYPEQUAISPROVENANCE", "TYPEQUAISDESTINATION", "TYPENAVIRE", "TYPENAVIRELIB", "ESCALE", "NOVOYAGE", "ARMATEUR", "ARMATEURLIB", "MAJORATION", "REDUCTION", "PAVILLONLIB", "DESIGNATION", "CODE", "TONNAGE", "ESTFICTIVE") AS 
  select"ID","DATE_RADE","PROVENANCE","NAVIRE","CONSIGNATAIRE","CARGAISON","PILOTE","DATE_ARRIVEE","HEURE_ARRIVEE","DATE_DEPART","HEURE_DEPART",
  "DESTINATION","ETAT","QUAIPROVENANCE","VALQUAISPROVENANCE","PAYSPROVENANCE","VALPAYSPROVENANCE","QUAIDESTINATION","VALQUAISDESTINATION",
  "PAYSDESTINATION","VALPAYSDESTINATION","INTERNEPOVENANCE","LONGUEURPROVENANCE","TIRANTPROVENANCE","PROFONDEURPROVENANCE","REFERENCENAVIRE",
  "NOMNAVIRE","PAVILLONNAVIRE","JNTNAVIRE","JBTNAVIRE","PLTNAVIRE","LHTNAVIRE","LMNAVIRE","TENAVIRE","VOLUMENAVIRE","REMARQUENAVIRE","ETATNAVIRE",
  "VALCONSIGNATAIRE","DESCECONSIGNATAIRE","VALCARGAISON","DESCECARGAISON","VALPILOTE","DESCEPILOTE","INTERNEDESTINATION","LONGUEURDESTINATION",
  "TIRANTDESTINATION","PROFONDEURDESTINATION","DESCEPROVENANCE","DESCEDESTINATION","VALTYPEQUAISPROVENANCE","DESCETYPEQUAISPROVENANCE",
  "VALTYPEQUAISDESTINATION","DESCETYPEQUAISDESTINATION","DESCEQUAISPROVENANCE","DESCEQUAISDESTINATION","TYPEQUAISPROVENANCE","TYPEQUAISDESTINATION",
  "TYPENAVIRE","TYPENAVIRELIB","ESCALE","NOVOYAGE","ARMATEUR","ARMATEURLIB","MAJORATION","REDUCTION","PAVILLONLIB","DESIGNATION","CODE","TONNAGE" , "ESTFICTIVE"
from previsionLibComplet
where id in (select idprevision from factureclient where etat >= 11) AND (estfictive < 1  OR ESTFICTIVE IS null) ;

CREATE OR REPLACE VIEW "PREVISIONNONFACTUREE" ("ID", "DATE_RADE", "PROVENANCE", "NAVIRE", "CONSIGNATAIRE", "CARGAISON", "PILOTE", "DATE_ARRIVEE", "HEURE_ARRIVEE", "DATE_DEPART", "HEURE_DEPART", "DESTINATION", "ETAT", "QUAIPROVENANCE", "VALQUAISPROVENANCE", "PAYSPROVENANCE", "VALPAYSPROVENANCE", "QUAIDESTINATION", "VALQUAISDESTINATION", "PAYSDESTINATION", "VALPAYSDESTINATION", "INTERNEPOVENANCE", "LONGUEURPROVENANCE", "TIRANTPROVENANCE", "PROFONDEURPROVENANCE", "REFERENCENAVIRE", "NOMNAVIRE", "PAVILLONNAVIRE", "JNTNAVIRE", "JBTNAVIRE", "PLTNAVIRE", "LHTNAVIRE", "LMNAVIRE", "TENAVIRE", "VOLUMENAVIRE", "REMARQUENAVIRE", "ETATNAVIRE", "VALCONSIGNATAIRE", "DESCECONSIGNATAIRE", "VALCARGAISON", "DESCECARGAISON", "VALPILOTE", "DESCEPILOTE", "INTERNEDESTINATION", "LONGUEURDESTINATION", "TIRANTDESTINATION", "PROFONDEURDESTINATION", "DESCEPROVENANCE", "DESCEDESTINATION", "VALTYPEQUAISPROVENANCE", "DESCETYPEQUAISPROVENANCE", "VALTYPEQUAISDESTINATION", "DESCETYPEQUAISDESTINATION", "DESCEQUAISPROVENANCE", "DESCEQUAISDESTINATION", "TYPEQUAISPROVENANCE", "TYPEQUAISDESTINATION", "TYPENAVIRE", "TYPENAVIRELIB", "ESCALE", "NOVOYAGE", "ARMATEUR", "ARMATEURLIB", "MAJORATION", "REDUCTION", "PAVILLONLIB", "DESIGNATION", "CODE", "TONNAGE", "ESTFICTIVE") AS 
  select "ID","DATE_RADE","PROVENANCE","NAVIRE","CONSIGNATAIRE","CARGAISON","PILOTE","DATE_ARRIVEE","HEURE_ARRIVEE","DATE_DEPART","HEURE_DEPART",
  "DESTINATION","ETAT","QUAIPROVENANCE","VALQUAISPROVENANCE","PAYSPROVENANCE","VALPAYSPROVENANCE","QUAIDESTINATION","VALQUAISDESTINATION",
  "PAYSDESTINATION","VALPAYSDESTINATION","INTERNEPOVENANCE","LONGUEURPROVENANCE","TIRANTPROVENANCE","PROFONDEURPROVENANCE","REFERENCENAVIRE",
  "NOMNAVIRE","PAVILLONNAVIRE","JNTNAVIRE","JBTNAVIRE","PLTNAVIRE","LHTNAVIRE","LMNAVIRE","TENAVIRE","VOLUMENAVIRE","REMARQUENAVIRE","ETATNAVIRE",
  "VALCONSIGNATAIRE","DESCECONSIGNATAIRE","VALCARGAISON","DESCECARGAISON","VALPILOTE","DESCEPILOTE","INTERNEDESTINATION","LONGUEURDESTINATION",
  "TIRANTDESTINATION","PROFONDEURDESTINATION","DESCEPROVENANCE","DESCEDESTINATION","VALTYPEQUAISPROVENANCE","DESCETYPEQUAISPROVENANCE",
  "VALTYPEQUAISDESTINATION","DESCETYPEQUAISDESTINATION","DESCEQUAISPROVENANCE","DESCEQUAISDESTINATION","TYPEQUAISPROVENANCE","TYPEQUAISDESTINATION",
  "TYPENAVIRE","TYPENAVIRELIB","ESCALE","NOVOYAGE","ARMATEUR","ARMATEURLIB","MAJORATION","REDUCTION","PAVILLONLIB","DESIGNATION","CODE","TONNAGE" , "ESTFICTIVE"
from previsionLibComplet
where id not in (select id from previsionfacturee) AND (estfictive < 1 OR ESTFICTIVE IS null) ;

CREATE OR REPLACE VIEW "PREVISIONLIBCOMPLET" ("ID", "DATE_RADE", "PROVENANCE", "NAVIRE", "CONSIGNATAIRE", "CARGAISON", "PILOTE", "DATE_ARRIVEE", "HEURE_ARRIVEE", "DATE_DEPART", "HEURE_DEPART", "DESTINATION", "ETAT", "QUAIPROVENANCE", "VALQUAISPROVENANCE", "PAYSPROVENANCE", "VALPAYSPROVENANCE", "QUAIDESTINATION", "VALQUAISDESTINATION", "PAYSDESTINATION", "VALPAYSDESTINATION", "INTERNEPOVENANCE", "LONGUEURPROVENANCE", "TIRANTPROVENANCE", "PROFONDEURPROVENANCE", "REFERENCENAVIRE", "NOMNAVIRE", "PAVILLONNAVIRE", "JNTNAVIRE", "JBTNAVIRE", "PLTNAVIRE", "LHTNAVIRE", "LMNAVIRE", "TENAVIRE", "VOLUMENAVIRE", "REMARQUENAVIRE", "ETATNAVIRE", "VALCONSIGNATAIRE", "DESCECONSIGNATAIRE", "VALCARGAISON", "DESCECARGAISON", "VALPILOTE", "DESCEPILOTE", "INTERNEDESTINATION", "LONGUEURDESTINATION", "TIRANTDESTINATION", "PROFONDEURDESTINATION", "DESCEPROVENANCE", "DESCEDESTINATION", "VALTYPEQUAISPROVENANCE", "DESCETYPEQUAISPROVENANCE", "VALTYPEQUAISDESTINATION", "DESCETYPEQUAISDESTINATION", "DESCEQUAISPROVENANCE", "DESCEQUAISDESTINATION", "TYPEQUAISPROVENANCE", "TYPEQUAISDESTINATION", "TYPENAVIRE", "TYPENAVIRELIB", "ESCALE", "NOVOYAGE", "ARMATEUR", "ARMATEURLIB", "MAJORATION", "REDUCTION", "PAVILLONLIB", "DESIGNATION", "CODE", "TONNAGE", "ESTFICTIVE") AS 
  SELECT pre.ID,
          pre.date_rade,
          pre.provenance,
          pre.navire,
          pre.consignataire,
          pre.cargaison,
          pre.pilote,
          pre.date_arrivee,
          pre.heure_arrivee,
          pre.date_depart,
          pre.heure_depart,
          pre.destination,
          pre.etat,
          pro.QUAI AS QUAIPROVENANCE,
          q.VAL AS valquaisprovenance,
          q.PAYS AS paysprovenance,
          pa.VAL AS valpaysprovenance,
          pr.QUAI AS QUAIDESTINATION,
          q1.val AS valquaisdestination,
          q1.PAYS AS paysdestination,
          pa1.VAL AS valpaysdestination,
          pro.INTERNE AS INTERNEPOVENANCE,
          q.LONGUEUR AS longueurprovenance,
          q.TIRANT AS tirantprovenance,
          q.PROFONDEUR AS profondeurprovenance,
          na.REFERENCE AS referencenavire,
          na.NOM AS nomnavire,
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
          con.NOMCLT AS valconsignataire,
          con.ADRCLT AS desceconsignataire,
          car.VAL AS valcargaison,
          car.DESCE AS descecargaison,
          pi.VAL AS valpilote,
          pi.DESCE AS descepilote,
          pr.INTERNE AS INTERNEDESTINATION,
          q1.LONGUEUR AS longueurdestination,
          q1.TIRANT AS tirantdestination,
          q1.PROFONDEUR AS profondeurdestination,
          pa.DESCE AS desceprovenance,
          pa1.DESCE AS descedestination,
          t.VAL AS valtypequaisprovenance,
          t.DESCE AS descetypequaisprovenance,
          t2.val AS valtypequaisdestination,
          t2.DESCE AS descetypequaisdestination,
          q.DESCE AS descequaisprovenance,
          q1.DESCE AS descequaisdestination,
          q.TYPEQUAIS AS typequaisprovenance,
          q1.TYPEQUAIS AS typequaisdestination,
          na.TYPE AS typenavire,
          tn.VAL AS typenavirelib,
          pre.escale,
          pre.NOVOYAGE,
          pre.ARMATEUR,
          cons.NOMCLT AS ARMATEURLIB,
          0 AS majoration,
          0 AS reduction,
          pay.val AS pavillonlib,
          CAST ('' AS VARCHAR2 (500)) AS DESIGNATION,
          CAST ('' AS VARCHAR2 (500)) AS CODE,
          pre.TONNAGE , 
          pre.ESTFICTIVE 
     FROM prevision pre
          LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
          LEFT JOIN NAVIRE na ON na.id = pre.NAVIRE
          LEFT JOIN PAYS pay ON pay.id = na.pavillon
          LEFT JOIN clientmat con ON con.CDCLT = pre.CONSIGNATAIRE
          LEFT JOIN CARGAISON car ON car.id = pre.CARGAISON
          LEFT JOIN commandant pi ON pi.ID = pre.PILOTE
          LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = pre.DESTINATION
          LEFT JOIN QUAIS q ON q.id = pro.QUAI
          LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
          LEFT JOIN PAYS pa ON pa.id = q.PAYS
          LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
          LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
          LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
          LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
          LEFT JOIN clientmat cons ON cons.CDCLT = pre.ARMATEUR  
;

CREATE OR REPLACE FORCE VIEW "PREVISIONLIBCOMPLETTA" ("ID", "DATE_RADE", "PROVENANCE", "NAVIRE", "CONSIGNATAIRE", "CARGAISON", "PILOTE", "DATE_ARRIVEE", "HEURE_ARRIVEE", "DATE_DEPART", "HEURE_DEPART", "DESTINATION", "ETAT", "QUAIPROVENANCE", "VALQUAISPROVENANCE", "PAYSPROVENANCE", "VALPAYSPROVENANCE", "QUAIDESTINATION", "VALQUAISDESTINATION", "PAYSDESTINATION", "VALPAYSDESTINATION", "INTERNEPOVENANCE", "LONGUEURPROVENANCE", "TIRANTPROVENANCE", "PROFONDEURPROVENANCE", "REFERENCENAVIRE", "NOMNAVIRE", "PAVILLONNAVIRE", "JNTNAVIRE", "JBTNAVIRE", "PLTNAVIRE", "LHTNAVIRE", "LMNAVIRE", "TENAVIRE", "VOLUMENAVIRE", "REMARQUENAVIRE", "ETATNAVIRE", "VALCONSIGNATAIRE", "DESCECONSIGNATAIRE", "VALCARGAISON", "DESCECARGAISON", "VALPILOTE", "DESCEPILOTE", "INTERNEDESTINATION", "LONGUEURDESTINATION", "TIRANTDESTINATION", "PROFONDEURDESTINATION", "DESCEPROVENANCE", "DESCEDESTINATION", "VALTYPEQUAISPROVENANCE", "DESCETYPEQUAISPROVENANCE", "VALTYPEQUAISDESTINATION", "DESCETYPEQUAISDESTINATION", "DESCEQUAISPROVENANCE", "DESCEQUAISDESTINATION", "TYPEQUAISPROVENANCE", "TYPEQUAISDESTINATION", "TYPENAVIRE", "TYPENAVIRELIB", "ESCALE", "NOVOYAGE", "ARMATEUR", "ARMATEURLIB", "MAJORATION", "REDUCTION", "PAVILLONLIB", "DESIGNATION", "CODE", "TONNAGE", "ESTFICTIVE") AS 
  SELECT pre.ID,
          pre.date_rade,
          pre.provenance,
          pre.navire,
          pre.consignataire,
          pre.cargaison,
          pre.pilote,
          pre.date_arrivee,
          pre.heure_arrivee,
          pre.date_depart,
          pre.heure_depart,
          pre.destination,
          pre.etat,
          pro.QUAI AS QUAIPROVENANCE,
          q.VAL AS valquaisprovenance,
          q.PAYS AS paysprovenance,
          pa.VAL AS valpaysprovenance,
          pr.QUAI AS QUAIDESTINATION,
          q1.val AS valquaisdestination,
          q1.PAYS AS paysdestination,
          pa1.VAL AS valpaysdestination,
          pro.INTERNE AS INTERNEPOVENANCE,
          q.LONGUEUR AS longueurprovenance,
          q.TIRANT AS tirantprovenance,
          q.PROFONDEUR AS profondeurprovenance,
          na.REFERENCE AS referencenavire,
          na.NOM AS nomnavire,
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
          con.NOMCLT AS valconsignataire,
          con.ADRCLT AS desceconsignataire,
          car.VAL AS valcargaison,
          car.DESCE AS descecargaison,
          pi.VAL AS valpilote,
          pi.DESCE AS descepilote,
          pr.INTERNE AS INTERNEDESTINATION,
          q1.LONGUEUR AS longueurdestination,
          q1.TIRANT AS tirantdestination,
          q1.PROFONDEUR AS profondeurdestination,
          pa.DESCE AS desceprovenance,
          pa1.DESCE AS descedestination,
          t.VAL AS valtypequaisprovenance,
          t.DESCE AS descetypequaisprovenance,
          t2.val AS valtypequaisdestination,
          t2.DESCE AS descetypequaisdestination,
          q.DESCE AS descequaisprovenance,
          q1.DESCE AS descequaisdestination,
          q.TYPEQUAIS AS typequaisprovenance,
          q1.TYPEQUAIS AS typequaisdestination,
          na.TYPE AS typenavire,
          tn.VAL AS typenavirelib,
          pre.escale,
          pre.NOVOYAGE,
          pre.ARMATEUR,
          cons.NOMCLT AS ARMATEURLIB,
          0 AS majoration,
          0 AS reduction,
          pay.val AS pavillonlib,
          CAST ('' AS VARCHAR2 (500)) AS DESIGNATION,
          CAST ('' AS VARCHAR2 (500)) AS CODE,
          pre.TONNAGE , 
          pre.ESTFICTIVE 
     FROM prevision pre
          LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
          LEFT JOIN NAVIRE na ON na.id = pre.NAVIRE
          LEFT JOIN PAYS pay ON pay.id = na.pavillon
          LEFT JOIN clientmat con ON con.CDCLT = pre.CONSIGNATAIRE
          LEFT JOIN CARGAISON car ON car.id = pre.CARGAISON
          LEFT JOIN commandant pi ON pi.ID = pre.PILOTE
          LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = pre.DESTINATION
          LEFT JOIN QUAIS q ON q.id = pro.QUAI
          LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
          LEFT JOIN PAYS pa ON pa.id = q.PAYS
          LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
          LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
          LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
          LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
          LEFT JOIN clientmat cons ON cons.CDCLT = pre.ARMATEUR 
         WHERE pre.ESTFICTIVE < 1 OR pre.ESTFICTIVE IS null 
;