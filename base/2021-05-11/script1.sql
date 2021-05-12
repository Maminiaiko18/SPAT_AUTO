CREATE OR REPLACE VIEW STATISTIQUEACTIVITELIB
            (ID, TITRE, DATY, IDTYPEACTIONCONTENEUR, PLEIN20PIEDS, VIDE20PIEDS, PLEIN40PIEDS, VIDE40PIEDS, IDNOMSOCIETE,
             IDTYPEMANIPULATION, IDTYPEMARCHANDISE, IDTYPEMESURE, NOMBREUNITE, POIDS, TYPESAISIE, ETAT, NAVIRE,
             IDTYPESAISIE,TEUS)
AS
SELECT s.ID,
       s.TITRE,
       s.DATY,
       t.VAL                               AS IDTYPEACTIONCONTENEUR,
       s.PLEIN20PIEDS,
       s.VIDE20PIEDS,
       s.PLEIN40PIEDS,
       s.VIDE40PIEDS,
       n.VAL                               AS IDNOMSOCIETE,
       t2.VAL                              AS IDTYPEMANIPULATION,
       t3.VAL                              AS IDTYPEMARCHANDISE,
       t4.VAL                              AS IDTYPEMESURE,
       s.NOMBREUNITE,
       s.POIDS,
       ts.VAL                              as TYPESAISIE,
       s.ETAT,
       na.nom || ' - ' || na.TYPENAVIRELIB as NAVIRE,
       s.TYPESAISIE                        as idTypeSaisie,
       cast(s.vide20pieds + s.plein20pieds + (s.vide40pieds + plein40pieds) * 2 as NUMBER(10)) as teus
FROM STATISTIQUEACTIVITE s
         LEFT JOIN TYPEACTIONCONTENEUR t ON s.IDTYPEACTIONCONTENEUR = t.ID
         LEFT JOIN NOMSOCIETE n ON s.IDNOMSOCIETE = n.ID
         LEFT JOIN TYPEMANIPULATION t2 ON s.IDTYPEMANIPULATION = t2.ID
         LEFT JOIN TYPEMARCHANDISE t3 ON s.IDTYPEMARCHANDISE = t3.ID
         LEFT JOIN TYPEMESURE t4 ON s.IDTYPEMESURE = t4.ID
         left join TYPESAISIE ts on ts.ID = s.TYPESAISIE
         left join NAVIRELIBCOMPLET na on na.ID = s.NAVIRE;
		 
CREATE OR REPLACE VIEW STATISTIQUEACTIVITELIB (ID, TITRE, DATY, IDTYPEACTIONCONTENEUR, PLEIN20PIEDS, VIDE20PIEDS, PLEIN40PIEDS, VIDE40PIEDS, IDNOMSOCIETE, IDTYPEMANIPULATION, IDTYPEMARCHANDISE, IDTYPEMESURE, NOMBREUNITE, POIDS, TYPESAISIE, ETAT, NAVIRE, IDTYPESAISIE, TEUS) AS
  SELECT s.ID,
       s.TITRE,
       s.DATY,
       t.VAL                               AS IDTYPEACTIONCONTENEUR,
       s.PLEIN20PIEDS,
       s.VIDE20PIEDS,
       s.PLEIN40PIEDS,
       s.VIDE40PIEDS,
       n.VAL                               AS IDNOMSOCIETE,
       t2.VAL                              AS IDTYPEMANIPULATION,
       t3.VAL                              AS IDTYPEMARCHANDISE,
       t4.VAL                              AS IDTYPEMESURE,
       s.NOMBREUNITE,
       s.POIDS,
       ts.VAL                              as TYPESAISIE,
       s.ETAT,
       na.NOMNAVIRE || ' - ' || nc.TYPENAVIRELIB as NAVIRE,
       s.TYPESAISIE                        as idTypeSaisie,
       cast(s.vide20pieds + s.plein20pieds + (s.vide40pieds + plein40pieds) * 2 as NUMBER(10)) as teus
FROM STATISTIQUEACTIVITE s
         LEFT JOIN TYPEACTIONCONTENEUR t ON s.IDTYPEACTIONCONTENEUR = t.ID
         LEFT JOIN NOMSOCIETE n ON s.IDNOMSOCIETE = n.ID
         LEFT JOIN TYPEMANIPULATION t2 ON s.IDTYPEMANIPULATION = t2.ID
         LEFT JOIN TYPEMARCHANDISE t3 ON s.IDTYPEMARCHANDISE = t3.ID
         LEFT JOIN TYPEMESURE t4 ON s.IDTYPEMESURE = t4.ID
         left join TYPESAISIE ts on ts.ID = s.TYPESAISIE
         left join MOUVEMENTLIBCOMPLET na on na.ID = s.NAVIRE
         left join NAVIRELIBCOMPLET nc on nc.id=na.NAVIRE;
		 
  CREATE OR REPLACE VIEW STATISTIQUEACTIVITE_LIBCOMPLET (ID, TITRE, DATY, IDTYPEACTIONCONTENEUR, PLEIN20PIEDS, VIDE20PIEDS, PLEIN40PIEDS, VIDE40PIEDS, IDNOMSOCIETE, IDTYPEMANIPULATION, IDTYPEMARCHANDISE, IDTYPEMESURE, NOMBREUNITE, POIDS, TYPESAISIE, ETAT, NAVIRE, IDNOMSOCIETELIB, IDTYPEMANIPULATIONLIB, IDTYPEMARCHANDISELIB, IDTYPEMESURELIB, TYPESAISIELIB, NAVIRELIB, IDTYPEACTIONCONTENEURLIB) AS
  select s.ID,s.TITRE,s.DATY,s.IDTYPEACTIONCONTENEUR,s.PLEIN20PIEDS,s.VIDE20PIEDS,s.PLEIN40PIEDS,s.VIDE40PIEDS,s.IDNOMSOCIETE,s.IDTYPEMANIPULATION,s.IDTYPEMARCHANDISE,s.IDTYPEMESURE,s.NOMBREUNITE,s.POIDS,s.TYPESAISIE,s.ETAT,s.NAVIRE,
       n.VAL                               AS IDNOMSOCIETELIB,
       t2.VAL                              AS IDTYPEMANIPULATIONLIB,
       t3.VAL                              AS IDTYPEMARCHANDISELIB,
       t4.VAL                              AS IDTYPEMESURELIB,
       ts.VAL                              as TYPESAISIELIB,
       na.NOMNAVIRE || ' - ' || nc.TYPENAVIRELIB  as NAVIRELIB,
       t.VAL                               as IDTYPEACTIONCONTENEURLIB

from STATISTIQUEACTIVITE s
         LEFT JOIN TYPEACTIONCONTENEUR t ON s.IDTYPEACTIONCONTENEUR = t.ID
         LEFT JOIN NOMSOCIETE n ON s.IDNOMSOCIETE = n.ID
         LEFT JOIN TYPEMANIPULATION t2 ON s.IDTYPEMANIPULATION = t2.ID
         LEFT JOIN TYPEMARCHANDISE t3 ON s.IDTYPEMARCHANDISE = t3.ID
         LEFT JOIN TYPEMESURE t4 ON s.IDTYPEMESURE = t4.ID
         left join TYPESAISIE ts on ts.ID = s.TYPESAISIE
         left join MOUVEMENTLIBCOMPLET na on na.ID = s.NAVIRE
         left join NAVIRELIBCOMPLET nc on nc.id=na.NAVIRE;

CREATE OR REPLACE VIEW STATISTIQUEACTIVITELIBC as
select l.*
from statistiqueactivitelib l
where l.ETAT = 1;

CREATE OR REPLACE VIEW STATISTIQUEACTIVITELIBV
AS
select *
from statistiqueactivitelib l
where l.ETAT >= 11;


alter table prevision add noVoyage varchar2(100);


CREATE OR REPLACE VIEW PREVISIONLIBCOMPLET
            (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE,
             DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE,
             VALPAYSPROVENANCE, QUAIDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION,
             INTERNEPOVENANCE, LONGUEURPROVENANCE, TIRANTPROVENANCE, PROFONDEURPROVENANCE, REFERENCENAVIRE, NOMNAVIRE,
             PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE,
             REMARQUENAVIRE, ETATNAVIRE, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, VALCARGAISON, DESCECARGAISON, VALPILOTE,
             DESCEPILOTE, INTERNEDESTINATION, LONGUEURDESTINATION, TIRANTDESTINATION, PROFONDEURDESTINATION,
             DESCEPROVENANCE, DESCEDESTINATION, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE,
             VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, DESCEQUAISPROVENANCE, DESCEQUAISDESTINATION,
             TYPEQUAISPROVENANCE, TYPEQUAISDESTINATION, TYPENAVIRE, TYPENAVIRELIB, ESCALE,NOVOYAGE)
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
       pro.QUAI      AS QUAIPROVENANCE,
       q.VAL         AS valquaisprovenance,
       q.PAYS        AS paysprovenance,
       pa.VAL        AS valpaysprovenance,
       pr.QUAI       AS QUAIDESTINATION,
       q1.val        AS valquaisdestination,
       q1.PAYS       AS paysdestination,
       pa1.VAL       AS valpaysdestination,
       pro.INTERNE   AS INTERNEPOVENANCE,
       q.LONGUEUR    AS longueurprovenance,
       q.TIRANT      AS tirantprovenance,
       q.PROFONDEUR  AS profondeurprovenance,
       na.REFERENCE  AS referencenavire,
       na.NOM        AS nomnavire,
       na.PAVILLON   AS pavillonnavire,
       na.JNT        AS jntnavire,
       na.JBT        AS jbtnavire,
       na.PLT        AS pltnavire,
       na.LHT        AS lhtnavire,
       na.LM         AS lmnavire,
       na.TE         AS tenavire,
       na.VOLUME     AS volumenavire,
       na.REMARQUE   AS remarquenavire,
       na.ETAT       AS etatnavire,
       con.NOMCLT    AS valconsignataire,
       con.ADRCLT    AS desceconsignataire,
       car.VAL       AS valcargaison,
       car.DESCE     AS descecargaison,
       pi.VAL        AS valpilote,
       pi.DESCE      AS descepilote,
       pr.INTERNE    AS INTERNEDESTINATION,
       q1.LONGUEUR   AS longueurdestination,
       q1.TIRANT     AS tirantdestination,
       q1.PROFONDEUR AS profondeurdestination,
       pa.DESCE      AS desceprovenance,
       pa1.DESCE     AS descedestination,
       t.VAL         AS valtypequaisprovenance,
       t.DESCE       AS descetypequaisprovenance,
       t2.val        AS valtypequaisdestination,
       t2.DESCE      AS descetypequaisdestination,
       q.DESCE       AS descequaisprovenance,
       q1.DESCE      AS descequaisdestination,
       q.TYPEQUAIS   AS typequaisprovenance,
       q1.TYPEQUAIS  AS typequaisdestination,
       na.TYPE       AS typenavire,
       tn.VAL        AS typenavirelib,
       pre.escale,
       pre.NOVOYAGE
FROM prevision pre
         LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
         left JOIN NAVIRE na ON na.id = pre.NAVIRE
         LEFT JOIN CONSIGNATAIREMAT con ON con.CDCLT = pre.CONSIGNATAIRE
         left JOIN CARGAISON car ON car.id = pre.CARGAISON
         left JOIN commandant pi ON pi.ID = pre.PILOTE
         LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = pre.DESTINATION
         LEFT JOIN QUAIS q ON q.id = pro.QUAI
         LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
         LEFT JOIN PAYS pa ON pa.id = q.PAYS
         LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
         LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
         LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
         LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE;
		 
CREATE OR REPLACE VIEW PREVISIONLIBELLECOMPLET
            (ID, DATE_RADE, PROVENANCE, NAVIRE,
             CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, DESTINATION,
             ETAT, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE,
             JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIVRE,
             QUAIPROVENANCE, INTERNEPROVENANCE, PAYSPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE,
             TIRANTPROVENANCE, QUAIDESTINATION, INTERNEDESTINATION, PAYSDESTINATION, LONGUEURDESTINATION,
             PROFONDEURDESTINATION, TIRANTDESTINATION, IDQUAIPROVENANCE, IDQUAIDESTINATION, CARGVAL, CARGDESCE,
             IDTYPEQUAIPROVENANCE, TYPEQUAIPROVENANCE, IDTYPEQUAIDESTINATION, TYPEQUAIDESTINATION, IDPILOTE, VALPILOTE,
             DESCEPILOTE,NOVOYAGE)
AS
select prev.id,
       prev.DATE_RADE,
       prev.PROVENANCE,
       prev.NAVIRE,
       prev.CONSIGNATAIRE,
       prev.CARGAISON,
       prev.PILOTE,
       prev.DATE_ARRIVEE,
       prev.HEURE_ARRIVEE,
       prev.DATE_DEPART,
       prev.HEURE_DEPART,
       prev.DESTINATION,
       prev.etat,
       c2.nomclt       as valCONSIGNATAIRE,
       c2.nomclt       as desceCONSIGNATAIRE,
       n1.reference    as referenceNAVIRE,
       n1.nom          as nomNAVIRE,
       p3.VAL          as pavillonNAVIRE,
       n1.jnt          as jntNAVIRE,
       n1.jbt          as jbtNAVIRE,
       n1.plt          as pltNAVIRE,
       n1.lht          as lhtNAVIRE,
       n1.lm           as lmNAVIRE,
       n1.te           as teNAVIRE,
       n1.volume       as volumeNAVIRE,
       n1.remarque     as remarqueNAVIRE,
       n1.ETAT         as etatNavivre,
       q1.VAL          as quaiPROVENANCE,
       prov.interne    as internePROVENANCE,
       p1.VAL          as paysPROVENANCE,
       prov.longueur   as longueurPROVENANCE,
       prov.profondeur as profondeurPROVENANCE,
       prov.tirant     as tirantPROVENANCE,
       q2.VAL          as quaiDESTINATION,
       dest.interne    as interneDESTINATION,
       p2.VAL          as paysDESTINATION,
       dest.longueur   as longueurDESTINATION,
       dest.profondeur as profondeurDESTINATION,
       dest.tirant     as tirantDESTINATION,
       q1.id           as idquaiPROVENANCE,
       q2.id           as idquaiDESTINATION,
       carg.val        as cargval,
       carg.val        as cargdesce,
       tpq1.id         as idtypequaiPROVENANCE,
       tpq1.val        as typequaiPROVENANCE,
       tpq2.id         as idtypequaiDESTINATION,
       tpq2.val        as typequaiDESTINATION,
       plt.id          as idpilote,
       plt.val         as valpilote,
       plt.desce       as descepilote,
       prev.NOVOYAGE
from PREVISION prev
         left join NAVIRE n1 on n1.id = prev.NAVIRE
         left join commandant plt on plt.id = prev.PILOTE
         left join clientmat C2 on prev.CONSIGNATAIRE = C2.CDCLT
         left join POSTEDESTINATAIRE prov on prov.id = prev.PROVENANCE
         left join POSTEDESTINATAIRE dest on dest.id = prev.DESTINATION
         left join pays p1 on prov.PAYS = p1.ID
         left join pays p2 on dest.PAYS = p2.ID
         left join QUAIS q1 on q1.id = prov.QUAI
         left join TYPEQUAIS tpq1 on tpq1.ID = q1.TYPEQUAIS
         left join QUAIS q2 on q2.id = dest.QUAI
         left join TYPEQUAIS tpq2 on tpq2.ID = q2.TYPEQUAIS
         left join pays p3 on p3.id = n1.pavillon
         left join CARGAISON carg on carg.id = prev.CARGAISON;
		 
CREATE OR REPLACE VIEW PREVISIONLIB
            (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE,
             DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT,NOVOYAGE)
AS
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
       NOVOYAGE
from PREVISIONLIBELLECOMPLET;

create or replace view PREVISIONLIBCOMPLETA as
select *
from previsionLibComplet
where ETAT = 0;

create or replace view PREVISIONLIBCOMPLETC as
select *
from previsionLibComplet
where ETAT = 1;

create or replace view PREVISIONLIBCOMPLETV as
select *
from previsionLibComplet
where ETAT = 11;

CREATE OR REPLACE VIEW MOUVEMENTLIBCOMPLET
            (ID, DATY, ESCALE, NAVIRE, CONSIGNATAIRE,
             PROVENANCE, DESTINATION, REMARQUE, DUREE, TYPEMVT, CARGAISON, REFERENCENAVIRE, NOMNAVIRE, VALMVT, DESCEMVT,
             VALCARGAISON, DESCECARGAISON, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, QUAIPROVENANCE, VALQUAISPROVENANCE,
             PAYSPROVENANCE, VALPAYSPROVENANCE, QUAISDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION,
             VALPAYSDESTINATION, DATEARRIVEE, HEURE, DATE_DEPART, HEURE_DEPART, INTERNEPROVENANCE, DESCEQUAISPROVENANCE,
             TYPEQUAISPROVENANCE, TIRANTPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE, DESCEPAYSPROVENANCE,
             INTERNEDESTINATION, DESCEQUAISDESTINATION, TYPEQUAISDESTIANANTION, TIRANTDESTINATION, LONGUEURDESTINATION,
             PROFONDEURDESTINATION, DESCEPAYSDESTINATION, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE,
             LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALTYPEQUAISPROVENANCE,
             DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, ETAT, ETATLIB, ESCALELIB,NOVOYAGE)
AS
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
       na.REFERENCE  AS referencenavire,
       na.NOM        AS nomnavire,
       tm.VAL        AS valmvt,
       tm.desce      AS descemvt,
       car.VAL       AS valcargaison,
       car.desce     AS descecargaison,
       cons.VAL      AS valconsignataire,
       cons.DESCE    AS desceconsignataire,
       pro.QUAI      AS quaiprovenance,
       q.val         AS valquaisprovenance,
       q.PAYS        AS paysprovenance,
       p.VAL         AS valpaysprovenance,
       des.QUAI      AS quaisdestination,
       q1.VAL        AS valquaisdestination,
       q1.PAYS       AS paysdestination,
       p1.VAL        AS valpaysdestination,
       mvt.DATEARRIVEE,
       mvt.heure,
       mvt.DATE_DEPART,
       mvt.HEURE_DEPART,
       pro.INTERNE   AS interneprovenance,
       q.DESCE       AS descequaisprovenance,
       q.TYPEQUAIS   AS typequaisprovenance,
       q.TIRANT      AS tirantprovenance,
       q.LONGUEUR    AS longueurprovenance,
       q.PROFONDEUR  AS profondeurprovenance,
       p.DESCE       AS descepaysprovenance,
       des.INTERNE   AS internedestination,
       q1.DESCE      AS descequaisdestination,
       q1.TYPEQUAIS  AS typequaisdestianantion,
       q1.TIRANT     AS tirantdestination,
       q1.LONGUEUR   AS longueurdestination,
       q1.PROFONDEUR AS profondeurdestination,
       p1.DESCE      AS descepaysdestination,
       na.PAVILLON   AS pavillonnavire,
       na.JNT        AS jntnavire,
       na.JBT        AS jbtnavire,
       na.PLT        AS pltnavire,
       na.LHT        AS lhtnavire,
       na.LM         AS lmnavire,
       na.TE         AS tenavire,
       na.VOLUME     AS volumenavire,
       na.REMARQUE   AS remarquenavire,
       na.ETAT       AS etatnavire,
       t.VAL         AS valtypequaisprovenance,
       t.DESCE       AS descetypequaisprovenance,
       t2.val        AS valtypequaisdestination,
       t2.DESCE      AS descetypequaisdestination,
       mvt.etat,
       case
           when mvt.etat = 1 then 'CREE(E)'
           when mvt.etat = 11 then 'VISE(E)'
           END       AS ETATLIB,
       pre.ESCALE,
       pre.NOVOYAGE
FROM MOUVEMENT mvt
         LEFT JOIN NAVIRE na ON na.ID = MVT.NAVIRE
    --LEFT JOIN CONSIGNATAIRETAB cons ON cons.id = mvt.CONSIGNATAIRE
         LEFT JOIN CONSIGNATAIRETAB cons ON cons.val = mvt.CONSIGNATAIRE
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
         left join PREVISION pre on pre.id = mvt.ESCALE;
		 
create or replace view MOUVEMENTLIBCOMPLET_CREE as
select *
from mouvementLibComplet
where etat = 1
/

create or replace view MOUVEMENTLIBCOMPLET_VISE as
select *
from mouvementLibComplet
where etat = 11
/


alter view MVTLIBCOMPLETANALYSEUNION1 compile ;
alter view MVTLIBCOMPLETANALYSEUNIONDATE compile ;

CREATE OR REPLACE VIEW PREVISIONFICHE
            (ID, NOMNAVIRE, VALCONSIGNATAIRE, VALCARGAISON, VALPILOTE, VALQUAISPROVENANCE, VALPAYSPROVENANCE,
             VALQUAISDESTINATION, VALPAYSDESTINATION, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, ETAT,
             TYPE, ESCALE,NOVOYAGE)
AS
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
     , typenavirelib as type
     , ESCALE
     , NOVOYAGE
from previsionLibComplet;

create view MOUVEMENT_ARRIVEE as
select *
from mouvementlibcomplet
where typemvt = 'TPMM00004'
/

create or replace view MOUVEMENTARRIVE_ESCALE as
select *
from MOUVEMENTARRIVE ma
where to_date(DATEARRIVEE || '' || ma.HEURE, 'YYYY-MM-DD HH24:MI:SS') =
      (select min(to_date(m.DATEARRIVEE || '' || m.HEURE, 'YYYY-MM-DD HH24:MI:SS'))
       from MOUVEMENTARRIVE m
       where m.ESCALE = ma.ESCALE)
/

create view arrivee as
select *from MOUVEMENTARRIVE_ESCALE;

 CREATE OR REPLACE  VIEW STATISTIQUEACTIVITELIB (ID, TITRE, DATY, IDTYPEACTIONCONTENEUR, PLEIN20PIEDS, VIDE20PIEDS, PLEIN40PIEDS, VIDE40PIEDS, IDNOMSOCIETE,
  IDTYPEMANIPULATION, IDTYPEMARCHANDISE, IDTYPEMESURE, NOMBREUNITE, POIDS, TYPESAISIE, ETAT, NAVIRE, IDTYPESAISIE, TEUS,NOVOYAGE) AS
  SELECT s.ID,
       s.TITRE,
       s.DATY,
       t.VAL                               AS IDTYPEACTIONCONTENEUR,
       s.PLEIN20PIEDS,
       s.VIDE20PIEDS,
       s.PLEIN40PIEDS,
       s.VIDE40PIEDS,
       n.VAL                               AS IDNOMSOCIETE,
       t2.VAL                              AS IDTYPEMANIPULATION,
       t3.VAL                              AS IDTYPEMARCHANDISE,
       t4.VAL                              AS IDTYPEMESURE,
       s.NOMBREUNITE,
       s.POIDS,
       ts.VAL                              as TYPESAISIE,
       s.ETAT,
       na.NOMNAVIRE || ' - ' || nc.TYPENAVIRELIB as NAVIRE,
       s.TYPESAISIE                        as idTypeSaisie,
       cast(s.vide20pieds + s.plein20pieds + (s.vide40pieds + plein40pieds) * 2 as NUMBER(10)) as teus,
	   na.NOVOYAGE
FROM STATISTIQUEACTIVITE s
         LEFT JOIN TYPEACTIONCONTENEUR t ON s.IDTYPEACTIONCONTENEUR = t.ID
         LEFT JOIN NOMSOCIETE n ON s.IDNOMSOCIETE = n.ID
         LEFT JOIN TYPEMANIPULATION t2 ON s.IDTYPEMANIPULATION = t2.ID
         LEFT JOIN TYPEMARCHANDISE t3 ON s.IDTYPEMARCHANDISE = t3.ID
         LEFT JOIN TYPEMESURE t4 ON s.IDTYPEMESURE = t4.ID
         left join TYPESAISIE ts on ts.ID = s.TYPESAISIE
         left join MOUVEMENTLIBCOMPLET na on na.ID = s.NAVIRE
         left join NAVIRELIBCOMPLET nc on nc.id=na.NAVIRE;
		 



create or replace view STATISTIQUEACTIVITE_LIBCOMPLET as
select s.ID,s.TITRE,s.DATY,s.IDTYPEACTIONCONTENEUR,s.PLEIN20PIEDS,s.VIDE20PIEDS,s.PLEIN40PIEDS,s.VIDE40PIEDS,s.IDNOMSOCIETE,s.IDTYPEMANIPULATION,s.IDTYPEMARCHANDISE,s.IDTYPEMESURE,s.NOMBREUNITE,s.POIDS,s.TYPESAISIE,s.ETAT,s.NAVIRE,
       n.VAL                               AS IDNOMSOCIETELIB,
       t2.VAL                              AS IDTYPEMANIPULATIONLIB,
       t3.VAL                              AS IDTYPEMARCHANDISELIB,
       t4.VAL                              AS IDTYPEMESURELIB,
       ts.VAL                              as TYPESAISIELIB,
       na.NOMNAVIRE || ' - ' || nc.TYPENAVIRELIB  as NAVIRELIB,
       t.VAL                               as IDTYPEACTIONCONTENEURLIB,
        cast(s.vide20pieds + s.plein20pieds + (s.vide40pieds + plein40pieds) * 2 as NUMBER(10)) as teus
        ,na.NOVOYAGE
from STATISTIQUEACTIVITE s
         LEFT JOIN TYPEACTIONCONTENEUR t ON s.IDTYPEACTIONCONTENEUR = t.ID
         LEFT JOIN NOMSOCIETE n ON s.IDNOMSOCIETE = n.ID
         LEFT JOIN TYPEMANIPULATION t2 ON s.IDTYPEMANIPULATION = t2.ID
         LEFT JOIN TYPEMARCHANDISE t3 ON s.IDTYPEMARCHANDISE = t3.ID
         LEFT JOIN TYPEMESURE t4 ON s.IDTYPEMESURE = t4.ID
         left join TYPESAISIE ts on ts.ID = s.TYPESAISIE
         left join MOUVEMENTLIBCOMPLET na on na.ID = s.NAVIRE
         left join NAVIRELIBCOMPLET nc on nc.id=na.NAVIRE;

		 create or replace view STATISTIQUEACTIVITE_MICTSL as
SELECT EXTRACT(MONTH FROM DATY) AS mois,
       EXTRACT(YEAR FROM DATY)  AS annee,
       teus  AS somme_plein20_vide20_plein40,
       IDTYPEACTIONCONTENEUR,
       IDTYPEACTIONCONTENEURLIB
FROM STATISTIQUEACTIVITE_LIBCOMPLET
WHERE TYPESAISIE = 'TSAI001'
  and etat >= 11;
 
 create or replace view STATISTIQUEACTIVITE_MICTSL as
SELECT EXTRACT(MONTH FROM DATY) AS mois,
       EXTRACT(YEAR FROM DATY)  AS annee,
       sum(teus)  AS somme_plein20_vide20_plein40,
       IDTYPEACTIONCONTENEUR,
       IDTYPEACTIONCONTENEURLIB
FROM STATISTIQUEACTIVITE_LIBCOMPLET
WHERE TYPESAISIE = 'TSAI001'
  and etat >= 11
group by EXTRACT(MONTH FROM DATY),EXTRACT(YEAR FROM DATY),
         IDTYPEACTIONCONTENEUR,IDTYPEACTIONCONTENEURLIB;
