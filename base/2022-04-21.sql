create table armateur_TBD (
    id varchar2(100) constraint armateur_TBD_pk primary key ,
    val varchar2(500)  ,
    desce varchar2(500)
);
alter table armateur_TBD allocate extent ;
CREATE OR REPLACE VIEW ESCALEPROFORMAPDF
            (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE,
             DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE,
             VALPAYSPROVENANCE, QUAIDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION,
             INTERNEPOVENANCE, LONGUEURPROVENANCE, TIRANTPROVENANCE, PROFONDEURPROVENANCE, REFERENCENAVIRE, NOMNAVIRE,
             PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE,
             REMARQUENAVIRE, ETATNAVIRE, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, VALCARGAISON, DESCECARGAISON, VALPILOTE,
             DESCEPILOTE, INTERNEDESTINATION, LONGUEURDESTINATION, TIRANTDESTINATION, PROFONDEURDESTINATION,
             DESCEPROVENANCE, DESCEDESTINATION, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE,
             VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, DESCEQUAISPROVENANCE, DESCEQUAISDESTINATION,
             TYPEQUAISPROVENANCE, TYPEQUAISDESTINATION, TYPENAVIRE, TYPENAVIRELIB, ESCALE, NOVOYAGE, ARMATEUR,
             ARMATEURLIB, MAJORATION, REDUCTION, PAVILLONLIB, DESIGNATION, CODE, TONNAGE)
AS
SELECT pre.ID,
       cast(sysdate as date)     as date_rade,
       pre.provenance,
       pre.BATEAU                as navire,
       pre.TIERS                 as consignataire,
       cast('' as VARCHAR(100))  as cargaison,
       cast('' as VARCHAR(100))  as pilote,
       pre.DATEARRIVEE           as date_arrivee,
       pre.HEUREARRIVEE          as heure_arrivee,
       pre.DATEDEPART            as date_depart,
       pre.HEUREDEPART           as heure_depart,
       pre.DESTINATION           as destination,
       pre.etat,
       pro.QUAI                  AS QUAIPROVENANCE,
       q.VAL                     AS valquaisprovenance,
       q.PAYS                    AS paysprovenance,
       pa.VAL                    AS valpaysprovenance,
       pr.QUAI                   AS QUAIDESTINATION,
       cast(q2.val as varchar(100))  AS valquaisdestination,
       cast(q2.pays  as varchar(100))  AS paysdestination,
       cast(pa2.val as varchar(100))  AS valpaysdestination,
       pro.INTERNE               AS INTERNEPOVENANCE,
       q.LONGUEUR                AS longueurprovenance,
       q.TIRANT                  AS tirantprovenance,
       q.PROFONDEUR              AS profondeurprovenance,
       na.REFERENCE              AS referencenavire,
       na.NOM                    AS nomnavire,
       na.PAVILLON               AS pavillonnavire,
       na.JNT                    AS jntnavire,
       na.JBT                    AS jbtnavire,
       na.PLT                    AS pltnavire,
       na.LHT                    AS lhtnavire,
       na.LM                     AS lmnavire,
       na.TE                     AS tenavire,
       na.VOLUME                 AS volumenavire,
       na.REMARQUE               AS remarquenavire,
       na.ETAT                   AS etatnavire,
       con.NOMCLT                AS valconsignataire,
       con.ADRCLT                AS desceconsignataire,
       cast('' as varchar(100))  AS valcargaison,
       cast('' as varchar(100))  AS descecargaison,
       cast('' as varchar(100))  AS valpilote,
       cast('' as varchar(100))  AS descepilote,
       pr.INTERNE                AS INTERNEDESTINATION,
       cast(0 as NUMBER(10, 2))  AS longueurdestination,
       cast(0 as NUMBER(10, 2))  AS tirantdestination,
       cast(0 as NUMBER(10, 2))  AS profondeurdestination,
       pa.DESCE                  AS desceprovenance,
       cast('' as varchar(100))  AS descedestination,
       t.VAL                     AS valtypequaisprovenance,
       t.DESCE                   AS descetypequaisprovenance,
       cast('' as varchar(100))  AS valtypequaisdestination,
       cast('' as varchar(100))  AS descetypequaisdestination,
       q.DESCE                   AS descequaisprovenance,
       cast('' as varchar(100))  AS descequaisdestination,
       q.TYPEQUAIS               AS typequaisprovenance,
       cast('' as varchar(100))  AS typequaisdestination,
       na.TYPE                   AS typenavire,
       tn.VAL                    AS typenavirelib,
       cast(pre.escale  as varchar(100))  as escale,
       cast('' as varchar(100))  as NOVOYAGE,
       cast('' as varchar(100))  as ARMATEUR,
       cast('' as varchar(100))  AS ARMATEURLIB,
       0                         AS majoration,
       0                         AS reduction,
       pay.val                   AS pavillonlib,
       CAST('' AS VARCHAR2(500)) AS DESIGNATION,
       CAST('' AS VARCHAR2(500)) AS CODE,
       cast(0 as number(10, 2))  as TONNAGE
FROM PROFORMA_MERE pre
         LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
         LEFT JOIN NAVIRE na ON na.id = pre.BATEAU
         LEFT JOIN PAYS pay ON pay.id = na.pavillon
         LEFT JOIN clientmat con ON con.CDCLT = pre.TIERS
         LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = pre.DESTINATION
         LEFT JOIN QUAIS q ON q.id = pro.QUAI
         LEFT JOIN PAYS pa ON pa.id = q.PAYS
         LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
         LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
         LEFT JOIN QUAIS q2 ON q2.id = pr.QUAI
          LEFT JOIN PAYS pa2 ON pa2.id = q2.PAYS;


create table armateur_TBD (
    id varchar2(100) constraint armateur_TBD_pk primary key ,
    val varchar2(500)  ,
    desce varchar2(500)
);
alter table armateur_TBD allocate extent ;
insert into armateur_TBD select cdarm,nomarm,nomarm from ARMATEUR@DBSPAT_LINK_TO_ANCIEN_FINANCE;


INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('UM00000024', '1111', 'MEN0000123', NULL, NULL, NULL, 0);
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENDY00001', 'Analyse', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=ligneCredit/situationLCDepense-analyse.jsp', 4, 4, 'MENBDG00021');


create or replace view AS_BONDELIVRAISON_FILLE_MTT as
select bl."ID",
       bl."PRODUIT",
       bl."NUMBL",
       bl."QUANTITE",
       bl."QUANTITEPARPACK",
       bl."IDDETAILSFACTUREFOURNISSEUR",
       bl."IDBONDECOMMANDE",
       cast(bc.pu as NUMBER(30, 3))                                                            as pu,
       bc.TVA,
       cast((bl.QUANTITE * bc.pu) * (1 - nvl(remise, 0) / 100) as NUMBER(30, 2))               as montantht,
       --cast(bl.QUANTITE * bc.pu as NUMBER(30, 2))                                        as montantht,
       cast((bl.QUANTITE * bc.pu) * (1 - nvl(remise, 0) / 100) * (tva / 100) as NUMBER(30, 2)) as montanttva,
       cast((bl.QUANTITE * bc.pu) * (1 - nvl(remise, 0) / 100) * (tva / 100) as NUMBER(30, 2)) +
       cast((bl.QUANTITE * bc.pu) * (1 - nvl(remise, 0) / 100) as NUMBER(30, 2))               as montanttc
from AS_BONDELIVRAISON_FILLe bl
         left join AS_BONDECOMMANDE_FILLE bc on bc.ID = bl.IDBONDECOMMANDE;

/*ARIRY*/
ALTER TABLE navire DROP CONSTRAINT FK_ARMATEUR ; 

ALTER TABLE navire ADD CONSTRAINT navire_armateur_id_fk FOREIGN KEY (armateur) REFERENCES armateur_tbd(id) ; 


CREATE OR REPLACE  VIEW NAVIRELIBCOMPLET (ID, REFERENCE, NOM, PAVILLON, JNT, JBT, PLT, LHT, LM, TE, VOLUME, REMARQUE, ETAT, TYPE, VALPAVILLON, DESCEPAVILLON, TYPENAVIRELIB, ARMATEUR, ARMATEURLIB) AS 
  SELECT nav.ID,
       nav.REFERENCE,
       nav.NOM,
       nav.PAVILLON,
       nav.JNT,
       nav.JBT,
       nav.PLT,
       nav.LHT,
       nav.LM,
       nav.TE,
       nav.VOLUME,
       nav.REMARQUE,
       nav.ETAT,
       nav.TYPE,
       p.val   AS valpavillon,
       p.DESCE AS descepavillon,
       tn.val  AS typenavirelib,
       nav.ARMATEUR,
       a.val   as ARMATEURLIB
FROM navire nav
         left JOIN PAYS p ON p.id = nav.PAVILLON
         LEFT JOIN typenavire tn ON tn.id = nav.TYPE
         left join armateur_tbd  a on a.ID = nav.ARMATEUR;
        
        
        
        
        

CREATE OR REPLACE  VIEW NAVIRELIB (ID, REFERENCE, NOM, PAVILLON, JNT, JBT, PLT, LHT, LM, TE, VOLUME, REMARQUE, ETAT, TYPE, ARMATEURLIB) AS 
  SELECT id,
       reference,
       nom,
       valpavillon   AS pavillon,
       JNT,
       JBT,
       PLT,
       LHT,
       LM,
       TE,
       lht * lm * te as volume,
       REMARQUE,
       etat,
       typenavirelib AS TYPE,
       ARMATEURLIB
FROM navirelibcomplet;

ALTER TABLE factureclient ADD armateur varchar(100) CONSTRAINT factureclient_arm_id_fk references armateur_tbd (id) ; 





CREATE OR REPLACE VIEW NAVIRELIBCOMPLET (ID, REFERENCE, NOM, PAVILLON, JNT, JBT, PLT, LHT, LM, TE, VOLUME, REMARQUE, ETAT, TYPE, VALPAVILLON, DESCEPAVILLON, TYPENAVIRELIB, ARMATEUR, ARMATEURLIB) AS 
  SELECT nav.ID,
       nav.REFERENCE,
       nav.NOM,
       nav.PAVILLON,
       nav.JNT,
       nav.JBT,
       nav.PLT,
       nav.LHT,
       nav.LM,
       nav.TE,
       nav.VOLUME,
       nav.REMARQUE,
       nav.ETAT,
       nav.TYPE,
       p.val   AS valpavillon,
       p.DESCE AS descepavillon,
       tn.val  AS typenavirelib,
       nav.ARMATEUR,
       a.val   as ARMATEURLIB
FROM navire nav
         left JOIN PAYS p ON p.id = nav.PAVILLON
         LEFT JOIN typenavire tn ON tn.id = nav.TYPE
         left join ARMATEUR_tbd a on a.ID = nav.ARMATEUR; 
        
        
        
        
CREATE OR REPLACE  VIEW FACTURECLIENTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION,
MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE,
CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB,
ESTANCIENNE , armateur ) AS 
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
       CAST(NVL(grp.montant, 0) AS NUMBER(30, 3))                                    AS montant, --montanttaux
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3))                                 AS montanttva,
       CAST(NVL(grp.montantavTTCavecTaux, 0) AS NUMBER(32, 3))                      AS montantavoir,
       CAST(NVL(MONTANTTTC, 0) - NVL( grp.montantavTTCavecTaux, 0) AS NUMBER(30, 3)) AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                                                       AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                                                     AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                                               AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                                                        AS codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                                                      AS codeprovision,
       CAST(
               NVL(NVL(grp.MONTANTTVA, 0) + grp.MONTANT, 0) AS NUMBER(30, 3))
                                                                                     AS MONTANTTTCVRAI,
       pr.NAVIRE,
      a.val AS armateurlib , 
       fc.exercice,
       fc.IDAVOIR,
       fc.pourcompte,
       fup.NOM                                                                       as pourcomptelib,
       fc.ESTANCIENNE , 
      	fc.armateur 
      	
FROM FACTURECLIENT fc
         LEFT JOIN CAFCFILLECOMPLET_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
         LEFT JOIN CODE_PRESTATION cp ON fc.codePrestation = cp.id
         LEFT JOIN NAVIRELIBCOMPLET nv ON pr.NAVIRE = nv.id
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = fc.POURCOMPTE
         LEFT JOIN armateur_tbd  a ON a.id = fc.armateur;  
        
        
        
        CREATE OR REPLACE VIEW FACTURECLIENTMSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB, ESTANCIENNE , armateur) AS 
  SELECT m.ID,
       m.DATY,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       '--' || m.remarque                          AS remarque,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.idprevision,
       CAST(m.MONTANT AS NUMBER(32, 3)),
       CAST(M.MONTANTTVA AS NUMBER(32, 3)),
       CAST(M.MONTANTAVOIR AS NUMBER(32, 3)),
       CAST(M.MONTANTTTC AS NUMBER(32, 3)),
       -- CAST (LEAST (NVL (pf.montant, 0),(m.montant-m.montantavoir)) AS NUMBER (32, 3)) AS montantpaye,
       CAST((NVL(pf.montant, 0)) AS NUMBER(32, 3)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(pf.montant, 0) AS NUMBER(32, 3))
                                                   AS montantreste,
       fup.NOM                                     AS tierslib,
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
       m.ESTMICTSL,
       codeprovision,
       CAST(m.MONTANTTTCVRAI AS NUMBER(32, 3)),
       m.NAVIRE,
       m.ARMATEURLIB,
       m.EXERCICE,
       IDAVOIR,
       pourcompte,
       pourcomptelib,
       ESTANCIENNE , 
       m.armateur
FROM factureclientMSum m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id;         
         
        
        
        
        
        CREATE OR REPLACE  VIEW PREVISIONLIBCOMPLET (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, 
        HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE, VALPAYSPROVENANCE,
        QUAIDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION, INTERNEPOVENANCE, LONGUEURPROVENANCE, TIRANTPROVENANCE, 
        PROFONDEURPROVENANCE, REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, 
        VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, VALCARGAISON, DESCECARGAISON, VALPILOTE, DESCEPILOTE, 
        INTERNEDESTINATION, LONGUEURDESTINATION, TIRANTDESTINATION, PROFONDEURDESTINATION, DESCEPROVENANCE, DESCEDESTINATION, VALTYPEQUAISPROVENANCE, 
        DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, DESCEQUAISPROVENANCE, DESCEQUAISDESTINATION, TYPEQUAISPROVENANCE, 
        TYPEQUAISDESTINATION, TYPENAVIRE, TYPENAVIRELIB, ESCALE, NOVOYAGE, ARMATEUR, ARMATEURLIB, MAJORATION, REDUCTION, PAVILLONLIB, DESIGNATION, CODE,
        TONNAGE, ESTFICTIVE) AS 
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
          na.ARMATEUR,
          a.val AS ARMATEURLIB,
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
          LEFT JOIN armateur_TBD a ON a.id = pre.ARMATEUR ;  
         
         
         
         
CREATE OR REPLACE  VIEW FACTURE_CLIENT_UNION (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC,
MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, 
DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB , armateur) AS 
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
       ESTMICTSL,
       CODEPROVISION,
       CAST(MONTANTTTCVRAI AS NUMBER(32, 3)),
       ARMATEURLIB,
       EXERCICE,
       idavoir,pourcompte,pourcomptelib , armateur
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
             ESTMICTSL,
             CODEPROVISION,
             MONTANTTTCVRAI,
             ARMATEURLIB,
             EXERCICE,
             IDAVOIR,pourcompte,pourcomptelib ,
             armateur
      FROM FACTURECLIENTMSUM_LIB
      WHERE DATY >= TO_DATE('2021-10-01', 'YYYY-MM-DD')
         OR ESTANCIENNE=1
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
             ''                                  AS codePrestation,
             ''                                  AS codePrestationlib,
             ''                                  AS code,
             ''                                  AS ESTMICTSL,
             ''                                  AS CODEPROVISION,
             MONTANTTTC - MONTANTAVOIR           AS MONTANTTTCVRAI,
             CAST('-' AS VARCHAR2(500))             ARMATEURLIB,
             CAST(0 AS NUMBER(10))                  EXERCICE,
             '-'                                    idavoir,
             '-'                                    pourcompte,
             '-'                                    pourcomptelib , 
             '-'                                  as  armateur 

      FROM analyseglobaleantsika);

         
     
     
     
     
     
     
     
     
     
     CREATE OR REPLACE  VIEW FACTURECLIENT_LIBCOMPLET (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, 
     IDCATEGORIE, IDPROVISION, DEVISEMERE, ESTDDPMICTSL, CODEPRESTATION, CODE, ESTMICTSL, TIERSLIB, CATEGORIELIB, TYPELIB , armateur , armateurlib) AS 
  select fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       fc.IDPREVISION,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.DEVISEMERE,
       fc.ESTDDPMICTSL,
       fc.CODEPRESTATION,
       fc.CODE,
       fc.ESTMICTSL,
       fup.NOM as tierslib,
       cat.VAL as categorielib,
       tf.VAL  as typelib , 
       fc.armateur , 
       armateur_TBD.val
from FACTURECLIENT fc
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = fc.TIERS
         left join CATEGORIEFC cat on cat.ID = fc.IDCATEGORIE
         left join TYPEFC tf on tf.ID = fc.TYPE 
         LEFT JOIN armateur_TBD ON armateur_TBD.id = fc.ARMATEUR;



UPDATE MENUDYNAMIQUE
SET LIBELLE='Armateur', ICONE='fa fa-plus', HREF='globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=armateur_tbd', RANG=15, NIVEAU=3, ID_PERE='MEN00740'
WHERE ID='MENR0321';

DELETE FROM MENUDYNAMIQUE
WHERE ID='MENR2545';

DELETE FROM MENUDYNAMIQUE
WHERE ID='MENR0327';
