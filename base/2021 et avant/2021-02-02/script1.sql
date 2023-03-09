CREATE OR REPLACE FORCE VIEW PREVISIONLIBCOMPLET
AS
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
          tn.VAL AS typenavirelib
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
		  
		  
insert into navire(id,nom,etat) values('NAV00001','HAFNIA ASIA',11);
insert into navire(id,nom,etat) values('NAV00002','GLORIOUS LEADER',11);
insert into navire(id,nom,etat) values('NAV00003','MARGUERITE ACE',11);
insert into navire(id,nom,etat) values('NAV00004','GRANDMA LILA',11);
insert into navire(id,nom,etat) values('NAV00005','DESTINY',11);
insert into navire(id,nom,etat) values('NAV00006','DOLPHIN 18',11);
insert into navire(id,nom,etat) values('NAV00007','MAERSK DOUALA',11);
insert into navire(id,nom,etat) values('NAV00008','HOEGH OSLO',11);
insert into navire(id,nom,etat) values('NAV00009','KOTA AZAM',11);
insert into navire(id,nom,etat) values('NAV00010','SAGAR SHAKTI',11);
insert into navire(id,nom,etat) values('NAV00011','CAPE GULL',11);
insert into navire(id,nom,etat) values('NAV00012','GRAND VICTORY',11);
insert into navire(id,nom,etat) values('NAV00013','GARNET ACE',11);
insert into navire(id,nom,etat) values('NAV00014','HOEGH SEOUL',11);
insert into navire(id,nom,etat) values('NAV00015','GRAND CHOICE',11);
insert into navire(id,nom,etat) values('NAV00016','HOEGH LONDON',11);
insert into navire(id,nom,etat) values('NAV00017','HOEGH TRIDENT',11);
insert into navire(id,nom,etat) values('NAV00018','HOEGH COPENHAGUE',11);
insert into navire(id,nom,etat) values('NAV00019','HOEGH TRACER',11);

insert into cargaison values('CG0001','Riz','');

insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00001','NAV000115','100180','CGM00001','02/02/2021','01:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00002','NAV00001','100054','CGM00001','02/02/2021','06:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00003','NAV000090','100293','CGM00002','03/02/2021','04:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00004','NAV000120','100024','CGM00002','05/02/2021','05:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00005','NAV00002','100293','CARG000004','05/02/2021','14:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00006','NAV000034','100180','CGM00001','05/02/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00007','NAV00003','100180','CGM00001','06/02/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00008','NAV00004','100024','CARG000009','07/02/2021','23:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00009','NAV00005','100019','CG0001','08/02/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00010','NAV00006','100293','CG0001','08/02/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00011','NAV00007','100293','CGM00002','08/02/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00012','NAV000018','100020','CGM00002','08/02/2021','06:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00013','NAV000037','100042','CGM00003','08/02/2021','18:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00014','NAV000044','100180','CGM00001','11/02/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00015','NAV00008','100180','CARG000004','11/02/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00016','NAV00009','100014','CGM00002','12/02/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00017','NAV00010','100024','CARG000002','14/02/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00018','NAV00011','100024','CARG000003','15/02/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00019','NAV000049','100023','CGM00001','16/02/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00020','NAV000022','100024','CGM00002','24/02/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00021','NAV00012','100293','CARG000004','08/03/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00022','NAV00013','100180','CARG000004','08/03/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00023','NAV00014','100180','CARG000004','13/03/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00024','NAV00015','100180','CARG000004','09/04/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00025','NAV00016','100180','CARG000004','10/05/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00026','NAV000062','100180','CARG000004','10/06/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00027','NAV00017','100180','CARG000004','10/07/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00028','NAV00018','100180','CARG000004','10/08/2021','00:00:00','11');
insert into prevision(id,navire,consignataire,cargaison,date_arrivee,heure_arrivee,etat) values('PREVI00029','NAV00019','100180','CARG000004','10/09/2021','00:00:00','11');

