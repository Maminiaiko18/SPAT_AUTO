
create view PROFORMA_FILLE_RANG_DET as
select fc."ID",fc."IDMERE",fc."DESIGNATION",fc."QUANTITE",fc."PU",fc."COMPTE",fc."IDPRODUIT",fc."DEVISE",fc."TAUX",fc."IDACTIVITE",fc."TVA",fc."DATEFACT",fc."RUBRIQUE",fc."MOIS",fc."ANNEE",fc."HEUREDEBUT",fc."HEUREFIN",fc."REDUCTION",fc."MAJORATION",fc."TEST",fc."RANG",fc."DUREE",
       CASE
           WHEN fc.IDACTIVITE IS NOT NULL THEN r.RANG
           else r1.RANG END AS rang_rubrique ,
       ma.RANG as rang_manoeuvre
from PROFORMA_FILLE fc
         LEFT JOIN ACTIVITELIBCOMPLET ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fc.RUBRIQUE
         left join OCCUPATIONMATERIELNAVAL oc on oc.id=ra.REFOBJET
         left join MANOEUVREBORD ma on ma.id=oc.IDMANOEUVREBORD;


create view PROFORMA_FILLE_RANGFINAL as
select fc.ID,
       IDMERE,
       DESIGNATION,
       QUANTITE,
       PU,
       COMPTE,
       IDPRODUIT,
       DEVISE,
       TAUX,
       IDACTIVITE,
       TVA,
       DATEFACT,
       RUBRIQUE,
       MOIS,
       ANNEE,
       HEUREDEBUT,
       HEUREFIN,
       REDUCTION,
       MAJORATION,
       TEST,
       DUREE,
     --  RANG_RUBRIQUE,
     --  RANG_MANOEUVRE,
       case
           when fc.RANG_MANOEUVRE is null or RANG_MANOEUVRE = 1 then RANG_RUBRIQUE
           when fc.RANG_MANOEUVRE = 2 then 6
           when fc.RANG_MANOEUVRE = 3 then RANG_RUBRIQUE + 5 end as rang
from PROFORMA_FILLE_RANG_DET fc;

create or replace view PROFORMA_FILLE_LIB_REST_TAXE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION,
             REDUCTION, DATEFACT, RUBRIQUE, RANG, DATY, DUREE, TYPE, ETAT)
as
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                                             AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))                         AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                                          AS resteAlivrer,
       CAST(fcm.MONTANT AS NUMBER(32, 3))                               AS MONTANTTAUX,
       CAST(fcm.MONTANT AS NUMBER(32, 5))                                 AS MONTANT,
       CAST(fcm.MTAVOIR AS NUMBER(32, 3))
                                                                          AS MONTANTAVOIRSANSTAUX,
       CAST(fcm.MTAVOIR AS NUMBER(32, 3))
                                                                          AS MONTANTAVOIRAVECTAUX,
       CAST(fcm.tva AS NUMBER(20, 3))                                     AS tva,
       fc.idactivite,
       ra.DESIGNATION                                                     AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                                           AS moislib,
       CAST(0 AS NUMBER(32, 2))                                           AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                                           AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                                           AS montantTVAEuro,
       CAST(MONTANTTVA AS NUMBER(20, 3))                                  AS montanttaxe,
       NVL(fc.majoration, 0)                                              AS majoration,
       NVL(fc.reduction, 0)                                               AS reduction,
       fc.DATEFACT,
       nvl(fc.RUBRIQUE, r.ID),
       fc.rang,
       CASE WHEN fc.IDACTIVITE IS NOT NULL THEN ra.DATY else fcm.DATY END AS daty,
       fc.DUREE,
       fcm.TYPE,
       fcm.ETAT
FROM PROFORMA_FILLE_rangfinal fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN PROFORMA_FILLE_LIB fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fc.RUBRIQUE;

create view proforma_fille_pdf as
    select * from PROFORMA_FILLE_LIB_REST_TAXE;
	
	
create view ESCALEPROFORMAPDF as
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
       cast('' as varchar(100))  AS valquaisdestination,
       cast('' as varchar(100))  AS paysdestination,
       cast('' as varchar(100))  AS valpaysdestination,
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
       cast('' as varchar(100))  as escale,
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
         LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE;