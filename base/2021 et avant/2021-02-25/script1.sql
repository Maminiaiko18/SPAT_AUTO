    CREATE OR REPLACE  VIEW MOUVEMENTLIBCOMPLET (ID, DATY, ESCALE, NAVIRE, CONSIGNATAIRE, PROVENANCE, DESTINATION, REMARQUE, DUREE, TYPEMVT, CARGAISON, REFERENCENAVIRE, NOMNAVIRE, VALMVT, DESCEMVT, VALCARGAISON, DESCECARGAISON, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE, VALPAYSPROVENANCE, QUAISDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION, DATEARRIVEE, HEURE, DATE_DEPART, HEURE_DEPART, INTERNEPROVENANCE, DESCEQUAISPROVENANCE, TYPEQUAISPROVENANCE, TIRANTPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE, DESCEPAYSPROVENANCE, INTERNEDESTINATION, DESCEQUAISDESTINATION, TYPEQUAISDESTIANANTION, TIRANTDESTINATION, LONGUEURDESTINATION, PROFONDEURDESTINATION, DESCEPAYSDESTINATION, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, ETAT, ETATLIB) AS 
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
                   case when mvt.etat=1 then 'CREE(E)'
                        when mvt.etat=11 then 'VISE(E)'
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


  alter table prevision add escale varchar2(400);

  CREATE OR REPLACE  VIEW PREVISIONLIBCOMPLET (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, 
  HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE, VALPAYSPROVENANCE, QUAIDESTINATION, VALQUAISDESTINATION,
  PAYSDESTINATION, VALPAYSDESTINATION, INTERNEPOVENANCE, LONGUEURPROVENANCE, TIRANTPROVENANCE, PROFONDEURPROVENANCE, REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, 
  PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, VALCARGAISON, DESCECARGAISON, VALPILOTE, DESCEPILOTE, INTERNEDESTINATION, 
  LONGUEURDESTINATION, TIRANTDESTINATION, PROFONDEURDESTINATION, DESCEPROVENANCE, DESCEDESTINATION, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION,
  DESCEQUAISPROVENANCE, DESCEQUAISDESTINATION, TYPEQUAISPROVENANCE, TYPEQUAISDESTINATION, TYPENAVIRE, TYPENAVIRELIB,ESCALE) AS 
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
          pre.escale
     FROM prevision pre
          LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
          JOIN NAVIRE na ON na.id = pre.NAVIRE
          LEFT JOIN CONSIGNATAIREMAT con ON con.CDCLT = pre.CONSIGNATAIRE
          JOIN CARGAISON car ON car.id = pre.CARGAISON
          left JOIN pilote pi ON pi.ID = pre.PILOTE
          LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = pre.DESTINATION
          LEFT JOIN QUAIS q ON q.id = pro.QUAI
          LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
          LEFT JOIN PAYS pa ON pa.id = q.PAYS
          LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
          LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
          LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
          LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE;



CREATE OR REPLACE VIEW PREVISIONFICHE (ID, NOMNAVIRE, VALCONSIGNATAIRE, VALCARGAISON, VALPILOTE, VALQUAISPROVENANCE, VALPAYSPROVENANCE, VALQUAISDESTINATION, 
VALPAYSDESTINATION, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, ETAT, TYPE,ESCALE) AS 
  select id
     , nomnavire
     , valconsignataire
     , valcargaison
     , valpilote
     , valquaisprovenance
     , valpaysprovenance
     , valquaisdestination
     , valpaysdestination
     , date_arrivee
     , heure_arrivee
     , date_depart
     , heure_depart
     , etat
     , typenavirelib as type,
     ESCALE
from previsionLibComplet;

create view prestations_escale as
select occ.*,prev.id as idprevision, prev.escale from occupationmaterielnaval occ
  join mouvement mvt on mvt.id=occ.idarrivee 
  join prevision prev on prev.id=mvt.escale;

   CREATE OR REPLACE view PREVISIONLIBCOMPLETC  AS 
  select* from previsionLibComplet where ETAT=1;
  
  
  CREATE OR REPLACE  VIEW PREVISIONLIBCOMPLETA  AS 
  select * from previsionLibComplet where ETAT=0;
  
   CREATE OR REPLACE  VIEW PREVISIONLIBCOMPLETV  AS 
  select *   from previsionLibComplet where ETAT=11;

   CREATE OR REPLACE  VIEW MOUVEMENTLIBCOMPLET (ID, DATY, ESCALE, NAVIRE, CONSIGNATAIRE, PROVENANCE, 
 DESTINATION, REMARQUE, DUREE, TYPEMVT, CARGAISON, REFERENCENAVIRE, NOMNAVIRE, VALMVT, DESCEMVT, VALCARGAISON, 
 DESCECARGAISON, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE, VALPAYSPROVENANCE, 
 QUAISDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION, DATEARRIVEE, HEURE, DATE_DEPART, HEURE_DEPART, INTERNEPROVENANCE, 
 DESCEQUAISPROVENANCE, TYPEQUAISPROVENANCE, TIRANTPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE, DESCEPAYSPROVENANCE, INTERNEDESTINATION, 
 DESCEQUAISDESTINATION, TYPEQUAISDESTIANANTION, TIRANTDESTINATION, LONGUEURDESTINATION, PROFONDEURDESTINATION, DESCEPAYSDESTINATION, PAVILLONNAVIRE, JNTNAVIRE,
 JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, 
 DESCETYPEQUAISDESTINATION, ETAT, ETATLIB,idprevision) AS 
  SELECT  mvt.ID,
                   mvt.daty,
                   pre.escale as ESCALE,
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
                   case when mvt.etat=1 then 'CREE(E)'
                        when mvt.etat=11 then 'VISE(E)'
                        END AS ETATLIB,
                      pre.id as  idprevision
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
          LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
          left join prevision pre on pre.id=mvt.escale;
          