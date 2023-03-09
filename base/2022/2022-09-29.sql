ALTER TABLE mouvement 
ADD  Numero varchar(500);

alter table PROFORMA_MERE
add(
lht number(30,3),
lm number(30,3),
te number(30,3),
jnt number(30,3)
);

ALTER TABLE prevision
DROP CONSTRAINT FK_CONSIGNATAIRE_ARM;
UPDATE ARMATEUR_TBD
SET ID ='0260430'
WHERE ID='260430';
UPDATE ARMATEUR_TBD
SET ID ='0100268'
WHERE ID='100268';
UPDATE ARMATEUR_TBD
SET ID ='0260443'
WHERE ID='260443';
UPDATE ARMATEUR_TBD
SET ID ='0260485'
WHERE ID='260485';
UPDATE ARMATEUR_TBD
SET ID ='0260394'
WHERE ID='260394';
UPDATE ARMATEUR_TBD
SET ID ='0260365'
WHERE ID='260365';
UPDATE ARMATEUR_TBD
SET ID ='0260266'
WHERE ID='260266';
UPDATE ARMATEUR_TBD
SET ID ='0260278'
WHERE ID='260278';
UPDATE ARMATEUR_TBD
SET ID ='0260378'
WHERE ID='260378';
UPDATE ARMATEUR_TBD
SET ID ='0260480'
WHERE ID='260480';
UPDATE ARMATEUR_TBD
SET ID ='0260334'
WHERE ID='260334';
UPDATE ARMATEUR_TBD
SET ID ='0260276'
WHERE ID='260276';
UPDATE ARMATEUR_TBD
SET ID ='0260483'
WHERE ID='260483';
UPDATE ARMATEUR_TBD
SET ID ='0260021'
WHERE ID='260021';
UPDATE ARMATEUR_TBD
SET ID ='0260240'
WHERE ID='260240';
UPDATE ARMATEUR_TBD
SET ID ='0260192'
WHERE ID='260192';
UPDATE ARMATEUR_TBD
SET ID ='0260395'
WHERE ID='260395';
INSERT into	 ARMATEUR_TBD values ('0260395','HERIMANDIMBISOA','HERIMANDIMBISOA');	  
INSERT into	 ARMATEUR_TBD values ('0260336','REGIS','REGIS');

ALTER TABLE prevision
ADD CONSTRAINT arm_armtbd_fk  FOREIGN KEY (armateur) REFERENCES armateur_tbd(id);


CREATE OR REPLACE  VIEW PREVISIONLIBCOMPLET_ORDRE (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE, CARGAISON, TONNAGE, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE, VALPAYSPROVENANCE, QUAIDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION, INTERNEPOVENANCE, LONGUEURPROVENANCE, TIRANTPROVENANCE, PROFONDEURPROVENANCE, REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, VALCARGAISON, DESCECARGAISON, VALPILOTE, DESCEPILOTE, INTERNEDESTINATION, LONGUEURDESTINATION, TIRANTDESTINATION, PROFONDEURDESTINATION, DESCEPROVENANCE, DESCEDESTINATION, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, DESCEQUAISPROVENANCE, DESCEQUAISDESTINATION, TYPEQUAISPROVENANCE, TYPEQUAISDESTINATION, TYPENAVIRE, TYPENAVIRELIB, ESCALE, NOVOYAGE, ARMATEUR, ARMATEURLIB, MAJORATION, REDUCTION, PAVILLONLIB, DESIGNATION, CODE, ESTFICTIVE) AS 
  SELECT pre.ID,
       pre.date_rade,
       pre.provenance,
       pre.navire,
       pre.consignataire,
       pre.cargaison,

       pre.TONNAGE,
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
       cons.val   AS ARMATEURLIB,
       0             AS majoration,
       0             AS reduction,
       pay.val       AS pavillonlib,
       fc.DESIGNATION,
       fc.CODE ,
       pre.ESTFICTIVE
FROM prevision pre
         LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
         LEFT JOIN NAVIRE na ON na.id = pre.NAVIRE
         LEFT JOIN PAYS pay ON pay.id = na.pavillon
         LEFT JOIN CONSIGNATAIREMAT con ON con.CDCLT = pre.CONSIGNATAIRE
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
         LEFT JOIN armateur_tbd cons ON cons.id = pre.ARMATEUR
         LEFT JOIN FACTURECLIENT fc ON fc.IDPREVISION = pre.id;
        
        
        


CREATE OR REPLACE  VIEW MOUVEMENTLIBCOMPLET (ID, DATY, ESCALE, NAVIRE, CONSIGNATAIRE, PROVENANCE, DESTINATION, REMARQUE, DUREE, TYPEMVT, CARGAISON, REFERENCENAVIRE, NOMNAVIRE, VALMVT, DESCEMVT, VALCARGAISON, DESCECARGAISON, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE, VALPAYSPROVENANCE, QUAISDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION, DATEARRIVEE, HEURE, DATE_DEPART, HEURE_DEPART, INTERNEPROVENANCE, DESCEQUAISPROVENANCE, TYPEQUAISPROVENANCE, TIRANTPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE, DESCEPAYSPROVENANCE, INTERNEDESTINATION, DESCEQUAISDESTINATION, TYPEQUAISDESTIANANTION, TIRANTDESTINATION, LONGUEURDESTINATION, PROFONDEURDESTINATION, DESCEPAYSDESTINATION, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, ETAT, ETATLIB, ESCALELIB, NOVOYAGE, NBHEURE, DATE_DEPART_PREV,numero) AS 
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
       pre.DATE_DEPART   as date_depart_prev,
       mvt.numero
FROM MOUVEMENT mvt
         LEFT JOIN NAVIRE na ON na.ID = MVT.NAVIRE
    --LEFT JOIN CONSIGNATAIRETAB cons ON cons.id = mvt.CONSIGNATAIRE
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
         left join PREVISION pre on pre.id = mvt.ESCALE;



        CREATE OR REPLACE  VIEW FCFILLECOMPLET (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MONTANTAVOIRAVECTSAUX, MONTANTAVTTCAVECTAUX, MONTANTAVTVAAVECTAUX,code) AS 
  SELECT fcf.ID,
       fcf.IDMERE,
       fcf.DESIGNATION,
       fcf.QUANTITE,
       fcf.PU,
       fcf.COMPTE,
       fcf.IDPRODUIT,
       fcf.DEVISE,
       fcf.TAUX,
       fcf.IDACTIVITE,
       fcf.TVA,
       fcf.DATEFACT,
       fcf.RUBRIQUE,
       EXTRACT(MONTH FROM fc.DATY)                          AS mois,
       EXTRACT(YEAR FROM fc.DATY)                           AS annee,
       fcf.HEUREDEBUT,
       fcf.HEUREFIN,
       fcf.REDUCTION,
       fcf.MAJORATION,
       fcf.TEST,
       fcf.RANG,
       fcf.DUREE,
       fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) AS montantAV,
       DECODE(fcf.rubrique, NULL, a.rubrique, fcf.rubrique)
                                                            AS rubriquecpl,
       fc.daty,
       fc.tiers,
       fc.idcategorie,
       fc.TYPE,
       fc.devisemere,
       fc.exercice,
       FC.IDAVOIr,
       fc.etat,
       NVL(AV.montantsanstaux, 0)                                   AS mtavoir,
       fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.REDUCTION, 0)
           / 100
                                                            AS montantReduction,
       fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.MAJORATION, 0)
           / 100
                                                            AS montantMajoration,
       fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1)
           + (fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.MAJORATION, 0))
           / 100
           - (fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.REDUCTION, 0))
           / 100
                                                            AS montant,
       (fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1)
            + (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.MAJORATION, 0))
            / 100
           - (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.REDUCTION, 0))
            / 100)
           * NVL(fcf.tva / 100, 0)
                                                            AS montanttva,
       (fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1)
            + (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.MAJORATION, 0))
            / 100
           - (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.REDUCTION, 0))
            / 100)
           * (1 + NVL(fcf.tva / 100, 0))
                                                            AS montantttc,
       m.VAL                                                AS moislib,
       f.MONTANTHTSIMPLE,
       t.nomclt,
       CAST(nvl(av.montantavectsaux, 0) AS  NUMBER (30, 3)) AS  montantavoiravectsaux ,
       CAST(nvl(av.MONTANTTTC, 0) AS NUMBER (30, 3)) as montantavTTCavecTaux,
       CAST(nvl(av.MONTANTTVA, 0) AS NUMBER (30, 3)) as montantavTVAavecTaux,
       fc.code
FROM facture_client_fille fcf
         JOIN factureclient fc ON fcf.idmere = fc.id
         LEFT JOIN activite a ON a.id = fcf.idactivite
         LEFT JOIN AVOIRFCAVECTAUX_GRP av
                   ON AV.IDDETAILFACTURE = fcf.id
         LEFT JOIN mois m ON m.ID = EXTRACT(MONTH FROM fc.DATY)
         LEFT JOIN facture_client_filleTTC f ON f.ID = fcf.ID
         left join client_union t on fc.TIERS = t.cdclt;
        
        



	CREATE OR REPLACE  VIEW CAFCFILLECOMPLET_AVOIR (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MERECA,code) AS 
  SELECT ff.ID,
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
         cast(MOIS as NUMBER(10)),
         cast(ANNEE as NUMBER(10)),
          HEUREDEBUT,
          HEUREFIN,
          REDUCTION,
          MAJORATION,
          TEST,
          RANG,
          DUREE,
         cast(MONTANTAV as NUMBER(30,3)),
          RUBRIQUECPL,
          DATY,
          TIERS,
          IDCATEGORIE,
          ff.TYPE,
          DEVISEMERE,
          EXERCICE,
          IDAVOIR,
          ff.ETAT,
         cast(MTAVOIR as NUMBER(30,2)),
         cast(MONTANTREDUCTION as NUMBER(30,2)),
         cast(MONTANTMAJORATION as NUMBER(30,2)),
         cast(MONTANT-nvl(ff.MONTANTAVOIRAVECTSAUX,0)  as NUMBER(30,2)),
         cast(ff.MONTANTTVA-nvl(ff.montantavTVAavecTaux,0) as NUMBER(30,2)),
         cast(ff.MONTANTTTC-nvl(ff.MONTANTAVTTCAVECTAUX,0) as number(30,2)),
          moislib,
         cast(ff.MONTANTHTSIMPLE-nvl(ff.MONTANTAVOIRAVECTSAUX,0) as NUMBER(30,2)),
          ff.client,
          cptM.id,
          ff.code
     FROM fcfillecomplet ff
     LEFT JOIN compteCA cptCA ON cptCA.val=ff.COMPTE
     LEFT join mereCA cptM ON cptM.id=cptCA.desce
     WHERE FF.IDCATEGORIE <> 'CATFCO2' AND FF.IDCATEGORIE <> 'CATFCO1'  and etat>=11;

    
    

CREATE OR REPLACE  VIEW AS_BONDELIVRAISON_FILLE_MTT (ID, PRODUIT, NUMBL, QUANTITE, QUANTITEPARPACK, IDDETAILSFACTUREFOURNISSEUR, IDBONDECOMMANDE, PU, TVA, MONTANTHT, MONTANTTVA, MONTANTTC,observation,remise) AS 
  select bl.ID,
       bl.PRODUIT,
       bl.NUMBL,
       bl.QUANTITE,
       bl.QUANTITEPARPACK,
       bl.IDDETAILSFACTUREFOURNISSEUR,
       bl.IDBONDECOMMANDE,
       cast(bc.pu as NUMBER(30, 3))                                                            as pu,
       bc.TVA,
       cast((bl.QUANTITE * bc.pu * nvl(bc.taux,1)) * (1 - nvl(remise, 0) / 100) as NUMBER(30, 2))               as montantht,
       --cast(bl.QUANTITE * bc.pu as NUMBER(30, 2))                                        as montantht,
       cast((bl.QUANTITE * bc.pu * nvl(bc.taux,1)) * (1 - nvl(remise, 0) / 100) * (tva / 100) as NUMBER(30, 2)) as montanttva,
       cast((bl.QUANTITE * bc.pu * nvl(bc.taux,1)) * (1 - nvl(remise, 0) / 100) * (tva / 100) as NUMBER(30, 2)) +
       cast((bl.QUANTITE * bc.pu * nvl(bc.taux,1)) * (1 - nvl(remise, 0) / 100) as NUMBER(30, 2))               as montanttc,
       bc.observation,
       bc.remise
from AS_BONDELIVRAISON_FILLe bl
         left join AS_BONDECOMMANDE_FILLE bc on bc.ID = bl.IDBONDECOMMANDE;

        
        CREATE OR REPLACE  VIEW PROFORMA_MERE_ORDRE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDCATEGORIE, IDPROVISION, DEVISEMERE, ESTDDPMICTSL, CODEPRESTATION, CODE, ESTMICTSL, EXERCICE, IDAVOIR, ESTAUTO, TYPEENGAGEMENT, POURCOMPTE, ESTANCIENNE, DATEARRIVEE, HEUREARRIVEE, DATEDEPART, HEUREDEPART, BATEAU, PROVENANCE, DESTINATION, ESCALE, VOLUME100, VOLUME,lht,lm,te,jnt) AS 
  SELECT PROFORMA_MERE.ID,
       PROFORMA_MERE.DATY,
       PROFORMA_MERE.TIERS,
       PROFORMA_MERE.DESIGNATION,
       PROFORMA_MERE.TYPE,
       PROFORMA_MERE.TVA,
       PROFORMA_MERE.REMARQUE,
       PROFORMA_MERE.IDUSER,
       PROFORMA_MERE.DATE_ECHEANCE,
       PROFORMA_MERE.ETAT,
       PROFORMA_MERE.IDPREVISION,
       PROFORMA_MERE.IDCATEGORIE,
       PROFORMA_MERE.IDPROVISION,
       PROFORMA_MERE.DEVISEMERE,
       PROFORMA_MERE.ESTDDPMICTSL,
       PROFORMA_MERE.CODEPRESTATION,
       PROFORMA_MERE.CODE,
       PROFORMA_MERE.ESTMICTSL,
       PROFORMA_MERE.EXERCICE,
       PROFORMA_MERE.IDAVOIR,
       PROFORMA_MERE.ESTAUTO,
       PROFORMA_MERE.TYPEENGAGEMENT,
       PROFORMA_MERE.POURCOMPTE,
       PROFORMA_MERE.ESTANCIENNE,
       PROFORMA_MERE.DATEARRIVEE,
       PROFORMA_MERE.HEUREARRIVEE,
       PROFORMA_MERE.DATEDEPART,
       PROFORMA_MERE.HEUREDEPART,
       PROFORMA_MERE.BATEAU,
       PROFORMA_MERE.PROVENANCE,
       PROFORMA_MERE.DESTINATION,
       PROFORMA_MERE.ESCALE,
       PROFORMA_MERE.volume100,
       cast(navirelibcomplet.VOLUME as number(10, 3)) as volume,
       PROFORMA_MERE.lht ,
       PROFORMA_MERE.lm, 
       PROFORMA_MERE.te, 
       PROFORMA_MERE.jnt 
FROM PROFORMA_MERE
    left join navirelibcomplet on navirelibcomplet.id=PROFORMA_MERE.BATEAU;



   
   CREATE OR REPLACE  VIEW MOUVEMENT_ARRIVEE_PREV (ID, DATY, ESCALE, NAVIRE, CONSIGNATAIRE, DATEARRIVEE, HEURE, PROVENANCE, DESTINATION, REMARQUE, DUREE, TYPEMVT, ETAT, CARGAISON, HEURE_DEPART, DATE_DEPART, VALMVT, DESCEMVT, VALCARGAISON, DESCECARGAISON, QUAIPROVENANCE, INTERNEPROVENANCE, PAYSPROVENANCE, VALQUAISPROVENANCE, DESCEQUAISPROVENANCE, TYPEQUAISPROVENANCE, TIRANTPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE, VALPAYSPROVENANCE, DESCEPAYSPROVENANCE, QUAISDESTINATION, INTERNEDESTINATION, PAYSDESTINATION, VALQUAISDESTINATION, DESCEQUAISDESTINATION, TYPEQUAISDESTIANANTION, TIRANTDESTINATION, LONGUEURDESTINATION, PROFONDEURDESTINATION, VALPAYSDESTINATION, DESCEPAYSDESTINATION, REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION,numero) AS 
  SELECT
	ID,
	DATY,
	 escale,
	NAVIRE,
	CONSIGNATAIRE,
	DATEARRIVEE,
	HEURE,
	PROVENANCE,
	DESTINATION,
	REMARQUE,
	DUREE,
	TYPEMVT,
	ETAT,
	CARGAISON,
	HEURE_DEPART,
	DATE_DEPART,
	VALMVT,
	DESCEMVT,
	VALCARGAISON,
	DESCECARGAISON,
	QUAIPROVENANCE,
	INTERNEPROVENANCE,
	PAYSPROVENANCE,
	VALQUAISPROVENANCE,
	DESCEQUAISPROVENANCE,
	TYPEQUAISPROVENANCE,
	TIRANTPROVENANCE,
	LONGUEURPROVENANCE,
	PROFONDEURPROVENANCE,
	VALPAYSPROVENANCE,
	DESCEPAYSPROVENANCE,
	QUAISDESTINATION,
	INTERNEDESTINATION,
	PAYSDESTINATION,
	VALQUAISDESTINATION,
	DESCEQUAISDESTINATION,
	TYPEQUAISDESTIANANTION,
	TIRANTDESTINATION,
	LONGUEURDESTINATION,
	PROFONDEURDESTINATION,
	VALPAYSDESTINATION,
	DESCEPAYSDESTINATION,
	REFERENCENAVIRE,
	NOMNAVIRE,
	PAVILLONNAVIRE,
	JNTNAVIRE,
	JBTNAVIRE,
	PLTNAVIRE,
	LHTNAVIRE,
	LMNAVIRE,
	TENAVIRE,
	VOLUMENAVIRE,
	REMARQUENAVIRE,
	ETATNAVIRE,
	VALCONSIGNATAIRE,
	DESCECONSIGNATAIRE,
	VALTYPEQUAISPROVENANCE,
	DESCETYPEQUAISPROVENANCE,
	VALTYPEQUAISDESTINATION,
	DESCETYPEQUAISDESTINATION,
	numero
FROM
	mouvementlibcomplet
WHERE
	typemvt = 'TPMM00004';













CREATE OR REPLACE  VIEW MOUVEMENT_DEPART_PREV (ID, DATY, ESCALE, NAVIRE, CONSIGNATAIRE, DATEARRIVEE, HEURE, PROVENANCE, DESTINATION, REMARQUE, DUREE, TYPEMVT, ETAT, CARGAISON, HEURE_DEPART, DATE_DEPART, VALMVT, DESCEMVT, VALCARGAISON, DESCECARGAISON, QUAIPROVENANCE, INTERNEPROVENANCE, PAYSPROVENANCE, VALQUAISPROVENANCE, DESCEQUAISPROVENANCE, TYPEQUAISPROVENANCE, TIRANTPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE, VALPAYSPROVENANCE, DESCEPAYSPROVENANCE, QUAISDESTINATION, INTERNEDESTINATION, PAYSDESTINATION, VALQUAISDESTINATION, DESCEQUAISDESTINATION, TYPEQUAISDESTIANANTION, TIRANTDESTINATION, LONGUEURDESTINATION, PROFONDEURDESTINATION, VALPAYSDESTINATION, DESCEPAYSDESTINATION, REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION,numero) AS 
  SELECT
	ID,
	DATY,
	  ESCALE,
	NAVIRE,
	CONSIGNATAIRE,
	DATEARRIVEE,
	HEURE,
	PROVENANCE,
	DESTINATION,
	REMARQUE,
	DUREE,
	TYPEMVT,
	ETAT,
	CARGAISON,
	HEURE_DEPART,
	DATE_DEPART,
	VALMVT,
	DESCEMVT,
	VALCARGAISON,
	DESCECARGAISON,
	QUAIPROVENANCE,
	INTERNEPROVENANCE,
	PAYSPROVENANCE,
	VALQUAISPROVENANCE,
	DESCEQUAISPROVENANCE,
	TYPEQUAISPROVENANCE,
	TIRANTPROVENANCE,
	LONGUEURPROVENANCE,
	PROFONDEURPROVENANCE,
	VALPAYSPROVENANCE,
	DESCEPAYSPROVENANCE,
	QUAISDESTINATION,
	INTERNEDESTINATION,
	PAYSDESTINATION,
	VALQUAISDESTINATION,
	DESCEQUAISDESTINATION,
	TYPEQUAISDESTIANANTION,
	TIRANTDESTINATION,
	LONGUEURDESTINATION,
	PROFONDEURDESTINATION,
	VALPAYSDESTINATION,
	DESCEPAYSDESTINATION,
	REFERENCENAVIRE,
	NOMNAVIRE,
	PAVILLONNAVIRE,
	JNTNAVIRE,
	JBTNAVIRE,
	PLTNAVIRE,
	LHTNAVIRE,
	LMNAVIRE,
	TENAVIRE,
	VOLUMENAVIRE,
	REMARQUENAVIRE,
	ETATNAVIRE,
	VALCONSIGNATAIRE,
	DESCECONSIGNATAIRE,
	VALTYPEQUAISPROVENANCE,
	DESCETYPEQUAISPROVENANCE,
	VALTYPEQUAISDESTINATION,
	DESCETYPEQUAISDESTINATION,
	numero
FROM
	mouvementlibcomplet
WHERE
	typemvt = 'TPMM00003';