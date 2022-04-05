create or replace view AS_BONDECOMMANDE_FILLE_PRD as
SELECT BCF.ID,
       BCF.PRODUIT,
       BCF.IDBC,
       BCF.QUANTITE,
       BCF.PU,
       BCF.QUANTITEPARPACK,
       BCF.MONTANT,
       BCF.REMARQUE,
       BCF.UNITE,
       BCF.TVA,
       BCF.DESIGNATION,
       pr.NOM as produitlib,
       BCF.REMISE,
       observation
FROM AS_BONDECOMMANDE_FILLE BCF
         left join union_produit_tbd_cemedi pr on pr.id = bcf.PRODUIT
/

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MDO000040', 'Proforma', 'fa fa-table', '#', 13, 3, 'MEN00068');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MDO000041', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=facture/proforma-saisie.jsp', 1, 4, 'MDO000040');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MDO000042', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=facture/proforma-liste.jsp', 2, 4, 'MDO000040');


create or replace view PREVISIONLIBCOMPLETPDF as
SELECT pre.ID,
       pre.date_rade,
       pre.provenance,
       pre.navire,
       pre.consignataire,
       pre.cargaison,
       pre.pilote,
       pe.daty                   as date_arrivee,
       pe.HEUREDEBUT             as heure_arrivee,
       ps.DATEFIN                as date_depart,
       ps.HEUREFIN               as heure_depart,
       esca.DESTINATION          as destination,
       pre.etat,
       pro.QUAI                  AS QUAIPROVENANCE,
       q.VAL                     AS valquaisprovenance,
       q.PAYS                    AS paysprovenance,
       pa.VAL                    AS valpaysprovenance,
       pr.QUAI                   AS QUAIDESTINATION,
       q1.val                    AS valquaisdestination,
       q1.PAYS                   AS paysdestination,
       pa1.VAL                   AS valpaysdestination,
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
       car.VAL                   AS valcargaison,
       car.DESCE                 AS descecargaison,
       pi.VAL                    AS valpilote,
       pi.DESCE                  AS descepilote,
       pr.INTERNE                AS INTERNEDESTINATION,
       q1.LONGUEUR               AS longueurdestination,
       q1.TIRANT                 AS tirantdestination,
       q1.PROFONDEUR             AS profondeurdestination,
       pa.DESCE                  AS desceprovenance,
       pa1.DESCE                 AS descedestination,
       t.VAL                     AS valtypequaisprovenance,
       t.DESCE                   AS descetypequaisprovenance,
       t2.val                    AS valtypequaisdestination,
       t2.DESCE                  AS descetypequaisdestination,
       q.DESCE                   AS descequaisprovenance,
       q1.DESCE                  AS descequaisdestination,
       q.TYPEQUAIS               AS typequaisprovenance,
       q1.TYPEQUAIS              AS typequaisdestination,
       na.TYPE                   AS typenavire,
       tn.VAL                    AS typenavirelib,
       pre.escale,
       pre.NOVOYAGE,
       pre.ARMATEUR,
       cons.NOMCLT               AS ARMATEURLIB,
       0                         AS majoration,
       0                         AS reduction,
       pay.val                   AS pavillonlib,
       CAST('' AS VARCHAR2(500)) AS DESIGNATION,
       CAST('' AS VARCHAR2(500)) AS CODE,
       pre.TONNAGE
FROM prevision pre
         LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
         LEFT JOIN NAVIRE na ON na.id = pre.NAVIRE
         LEFT JOIN PAYS pay ON pay.id = na.pavillon
         LEFT JOIN clientmat con ON con.CDCLT = pre.CONSIGNATAIRE
         LEFT JOIN CARGAISON car ON car.id = pre.CARGAISON
         LEFT JOIN commandant pi ON pi.ID = pre.PILOTE
         left join MOUVEMENTDEPART_ESC esca on esca.ESCALE = pre.id
         LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = esca.DESTINATION
         LEFT JOIN QUAIS q ON q.id = pro.QUAI
         LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
         LEFT JOIN PAYS pa ON pa.id = q.PAYS
         LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
         LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
         LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
         LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
         LEFT JOIN clientmat cons ON cons.CDCLT = pre.ARMATEUR
         left join pilotageEntree pe on pe.IDPREVISION = pre.id
         left join PILOTAGESORTIE ps on ps.IDPREVISION = pre.id
/





create or replace view ESCALEPROFORMAPDF as
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
       q1.val                    AS valquaisdestination,
       q1.PAYS                   AS paysdestination,
       pa1.VAL                   AS valpaysdestination,
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
         LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
         LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
         LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
/
