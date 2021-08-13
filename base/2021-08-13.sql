---
alter table factureclient add code varchar2(500);
alter table factureclient     add estMictsl  varchar2(500);



create or replace view factureclient_sequence_simple as

select fc.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       ETAT,
       IDPREVISION,
       IDCATEGORIE,
       IDPROVISION,
       DEVISEMERE,
       ESTDDPMICTSL,
       CODEPRESTATION,
       CODE,
       substr((CODE), 2, 2) || '/' || substr((CODE), 4, 2) || '/01/'
           || substr((CODE), length((CODE)) - 2, 3) as datemoisseq,
       cast('01/' || substr((CODE), 4, 2) || '/' || substr((CODE), 2, 2) as VARCHAR2(100)) as
         datemois,
       substr((CODE), length((CODE)) - 2, 3) as maxidparmoisane
from FACTURECLIENT fc;

create view numerofacturesimple  as
select to_date(datemois) as datemois, max(maxidparmoisane)as currentsequence,
       cast(max(maxidparmoisane) + 1 as NUMBER(10)) as nextsequence
from factureclient_sequence_1 group by to_date(datemois);



create or replace view factureclient_sequence_mctsl as

select fc.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       ETAT,
       IDPREVISION,
       IDCATEGORIE,
       IDPROVISION,
       DEVISEMERE,
       ESTDDPMICTSL,
       CODEPRESTATION,
       CODE,
       substr((CODE), 2, 2) || '/' || substr((CODE), 4, 2) || '/01/'
           || substr((CODE), length((CODE)) - 5, 6) as datemoisseq,
       cast('01/' || substr((CODE), 4, 2) || '/' || substr((CODE), 2, 2) as VARCHAR2(100)) as
         datemois,
       substr((CODE), length((CODE)) - 5, 6) as maxidparmoisane
from FACTURECLIENT fc;


create or replace view factureclient_sequence_mctsl as

select fc.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       ETAT,
       IDPREVISION,
       IDCATEGORIE,
       IDPROVISION,
       DEVISEMERE,
       ESTDDPMICTSL,
       CODEPRESTATION,
       CODE,
       substr((CODE), 2, 2) || '/' || substr((CODE), 4, 2) || '/01/'
           || substr((CODE), length((CODE)) - 5, 6) as datemoisseq,
       cast('01/' || substr((CODE), 4, 2) || '/' || substr((CODE), 2, 2) as VARCHAR2(100)) as
         datemois,
       substr((CODE), length((CODE)) - 5, 6) as maxidparmoisane,
       estMictsl
from FACTURECLIENT fc
where estMictsl=1;



create or replace view factureclient_sequence_simple as

select fc.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       ETAT,
       IDPREVISION,
       IDCATEGORIE,
       IDPROVISION,
       DEVISEMERE,
       ESTDDPMICTSL,
       CODEPRESTATION,
       CODE,
       substr((CODE), 2, 2) || '/' || substr((CODE), 4, 2) || '/01/'
           || substr((CODE), length((CODE)) - 5, 6) as datemoisseq,
       cast('01/' || substr((CODE), 4, 2) || '/' || substr((CODE), 2, 2) as VARCHAR2(100)) as
         datemois,
       substr((CODE), length((CODE)) - 5, 6) as maxidparmoisane,
       estMictsl
from FACTURECLIENT fc
where estMictsl!=1;



create or replace view NUMEROFACTURESIMPLE as
select to_date(datemois) as datemois, max(maxidparmoisane)as currentsequence,
       cast(max(maxidparmoisane) + 1 as NUMBER(10)) as nextsequence
from FACTURECLIENT_SEQUENCE_SIMPLE
group by to_date(datemois);
create or replace view numerofacturemctsl  as
select to_date(datemois) as datemois, max(maxidparmoisane)as currentsequence,
       cast(max(maxidparmoisane) + 1 as NUMBER(10)) as nextsequence
from factureclient_sequence_mctsl
group by to_date(datemois);

create or replace view factureclient_sequence_simple as

select fc.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       ETAT,
       IDPREVISION,
       IDCATEGORIE,
       IDPROVISION,
       DEVISEMERE,
       ESTDDPMICTSL,
       CODEPRESTATION,
       CODE,
       substr((CODE), 2, 2) || '/' || substr((CODE), 4, 2) || '/01/'
           || substr((CODE), length((CODE)) - 2, 3) as datemoisseq,
       cast('01/' || substr((CODE), 4, 2) || '/' || substr((CODE), 2, 2) as VARCHAR2(100)) as
         datemois,
       substr((CODE), length((CODE)) - 2, 3) as maxidparmoisane,
       ESTMICTSL
from FACTURECLIENT fc;

create or replace view NUMEROFACTURESIMPLE as
select max(datemois),
       max(maxidparmoisane)                         as currentsequence,
       cast(max(maxidparmoisane) + 1 as NUMBER(10)) as nextsequence
from FACTURECLIENT_SEQUENCE_SIMPLE;

CREATE OR REPLACE VIEW FACTURECLIENTMSUM
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION,
             IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB,code,ESTMICTSL)
AS
SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       fc.idprevision,
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 3)) AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3))  AS montanttva,
       NVL(grp.montantavoiravectaux, 0)               AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 3))
                                                      AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                        AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                      AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                         as codePrestationlib,
       fc.code,
       fc.ESTMICTSL
FROM FACTURECLIENT fc
         LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.IDPROVISION = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id;

create or replace view FACTURECLIENTMSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB,CODE,ESTMICTSL)
as
SELECT m.ID,
       m.DATY,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       '--' || m.remarque                        AS remarque,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.idprevision,
       CAST(m.MONTANT AS NUMBER(32, 3)),
       CAST(M.MONTANTTVA AS NUMBER(32, 3)),
       CAST(M.MONTANTAVOIR AS NUMBER(32, 3)),
       CAST(M.MONTANTTTC AS NUMBER(32, 3)),
       CAST(NVL(jc.montant, 0) AS NUMBER(32, 3)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(jc.montant, 0) AS NUMBER(32, 3))
                                                 AS montantreste,
       fup.NOM                                   AS tierslib,
       fup.CONTACT,
       fup.ADRESSE,
       M.ESCALE,
       TYPELIB,
       m.IDCATEGORIE,
       m.CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       m.ESTDDPMICTSL,
       m.devisemere,
       m.codePrestation,
       m.codePrestationlib,
       m.CODE,
       m.ESTMICTSL
FROM factureclientMSum m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN JOURNALCAISSELIB_VISE_SUM jc ON jc.IDPLACEMENT = m.id;
	create or replace view FACTURE_CLIENT_UNION
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB,code,ESTMICTSL)
as
SELECT ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       CAST(TVA AS NUMBER(20, 3)) AS tva,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       CAST(ETAT AS NUMBER(10))   AS etat,
       CAST(MONTANT AS NUMBER(32, 3)),
       CAST(MONTANTTVA AS NUMBER(32, 3)),
       CAST(MONTANTAVOIR AS NUMBER(32, 3)),
       CAST(MONTANTTTC AS NUMBER(32, 3)),
       CAST(MONTANTPAYE AS NUMBER(32, 3)),
       CAST(MONTANTRESTE AS NUMBER(32, 3)),
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       CASE WHEN ETAT = 1 THEN 'CREE(E)' WHEN ETAT = 11 THEN 'VISE(E)' END
                                  AS ETATLIB,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       DEVISEMERE,
       codePrestation,
       codePrestationlib,
       code,
       ESTMICTSL
FROM (SELECT ID,
             DATY,
             TIERS,
             DESIGNATION,
             TYPE,
             CAST(TVA AS NUMBER(20, 3))          AS TVA,
             REMARQUE,
             IDUSER,
             DATE_ECHEANCE,
             CAST(ETAT AS NUMBER(10))            AS etat,
             CAST(MONTANT AS NUMBER(32, 3))      AS MONTANT,
             CAST(MONTANTTVA AS NUMBER(32, 3))   AS MONTANTTVA,
             CAST(MONTANTAVOIR AS NUMBER(32, 3)) AS MONTANTAVOIR,
             CAST(MONTANTTTC AS NUMBER(32, 3))   AS MONTANTTTC,
             CAST(MONTANTPAYE AS NUMBER(32, 3))  AS MONTANTPAYE,
             CAST(MONTANTRESTE AS NUMBER(32, 3)) AS MONTANTRESTE,
             TIERSLIB,
             CONTACT,
             ADRESSE,
             IDPREVISION,
             ESCALE,
             TYPELIB,
             IDCATEGORIE,
             CATEGORIELIB,
             IDPROVISION,
             IDPROVISIONLIB,
             DEVISEMERE,
             codePrestation,
             codePrestationlib,
             code,
             ESTMICTSL
      FROM FACTURECLIENTMSUM_LIB
      UNION ALL
      SELECT ID,
             DATY,
             TIERS,
             DESIGNATION,
             TYPE,
             CAST(TVA AS NUMBER(20, 3))          AS TVA,
             REMARQUE,
             IDUSER,
             DATE_ECHEANCE,
             CAST(ETAT AS NUMBER(10))            AS etat,
             CAST(MONTANT AS NUMBER(32, 3))      AS MONTANT,
             CAST(MONTANTTVA AS NUMBER(32, 3))   AS MONTANTTVA,
             CAST(MONTANTAVOIR AS NUMBER(32, 3)) AS MONTANTAVOIR,
             CAST(MONTANTTTC AS NUMBER(32, 3))   AS MONTANTTTC,
             CAST(MONTANTPAYE AS NUMBER(32, 3))  AS MONTANTPAYE,
             CAST(MONTANTRESTE AS NUMBER(32, 3)) AS MONTANTRESTE,
             TIERSLIB,
             CONTACT,
             ADRESSE,
             '-'                                 AS PREVISION,
             '-'                                 AS ESCALE,
             TYPE                                AS typelib,
             '-'                                 AS IDCATEGORIE,
             '-'                                 AS CATEGORIELIB,
             '-'                                 AS IDPROVISION,
             '-'                                 AS IDPROVISIONLIB,
             '-'                                 AS DEVISEMERE,
             ''                                  as codePrestation,
             ''                                  as codePrestationlib,
             ''                                  as code,
             ''                                  as ESTMICTSL
      FROM analyseglobaleantsika);
create table code_rubrique_mictsl(
    id varchar2(100) constraint code_rubrique_mictsl_pk primary key ,
    val varchar2(500),
    desce varchar2(500)
);


update RUBRIQUE_ACTIVITE_TMP set categorie='CATFC_001' where categorie='CATFC001';
update rubrique_activite set categorie='CATFC_001' where categorie='CATFC001'; 

insert into codeFCPremierCaractere values('cd1','TFC001','1');
insert into codeFCPremierCaractere values('cd2','TFC002','2');
insert into codeFCPremierCaractere values('cd3','CATFCO1','3');
insert into codeFCPremierCaractere values('cd4','CATFCO2','5');
INSERT INTO CATEGORIEFACTURATION (ID, VAL, DESCE) VALUES ('CATFC_001', 'Capitainerie', 'Capitainerie');
DELETE FROM CATEGORIEFACTURATION WHERE ID LIKE 'CATFC001';
commit;
insert into code_rubrique_mictsl values('CRM2','RB0000000027173349','RV');
insert into code_rubrique_mictsl values('CRM3','RB0000000026172740','RF');
commit;


create or replace view PREVISIONLIBCOMPLET as
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
       pre.NOVOYAGE,
       pre.ARMATEUR,
       cons.NOMCLT   as ARMATEURLIB,
       0 as majoration,
       0 as reduction,
       na.NOM as pavillonlib
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
         LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
         left join CONSIGNATAIREMAT cons on cons.CDCLT = pre.ARMATEUR;
create or replace view NUMEROFACTURESIMPLE as
select '-'as id,
       cast(max(maxidparmoisane) + 1 as NUMBER(10)) as val,
        max(maxidparmoisane)                         as desce
from FACTURECLIENT_SEQUENCE_SIMPLE;


create or replace view NUMEROFACTUREMCTSL as
select cast('-' as VARCHAR2(100)) as id,
       cast(cast(max(maxidparmoisane) + 1 as NUMBER(10)) as VARCHAR2(500)) as val,
       '-'as desce
from factureclient_sequence_mctsl;
create or replace view NUMEROFACTURESIMPLE as
select '-'as id,
       cast(max(maxidparmoisane) + 1 as NUMBER(10)) as val,
        '-'                         as desce
from FACTURECLIENT_SEQUENCE_SIMPLE;	

