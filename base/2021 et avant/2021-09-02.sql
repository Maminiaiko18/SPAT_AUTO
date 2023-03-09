CREATE OR REPLACE FORCE VIEW PREVISIONLIBCOMPLET
(
   ID,
   DATE_RADE,
   PROVENANCE,
   NAVIRE,
   CONSIGNATAIRE,
   CARGAISON,
   PILOTE,
   DATE_ARRIVEE,
   HEURE_ARRIVEE,
   DATE_DEPART,
   HEURE_DEPART,
   DESTINATION,
   ETAT,
   QUAIPROVENANCE,
   VALQUAISPROVENANCE,
   PAYSPROVENANCE,
   VALPAYSPROVENANCE,
   QUAIDESTINATION,
   VALQUAISDESTINATION,
   PAYSDESTINATION,
   VALPAYSDESTINATION,
   INTERNEPOVENANCE,
   LONGUEURPROVENANCE,
   TIRANTPROVENANCE,
   PROFONDEURPROVENANCE,
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
   VALCARGAISON,
   DESCECARGAISON,
   VALPILOTE,
   DESCEPILOTE,
   INTERNEDESTINATION,
   LONGUEURDESTINATION,
   TIRANTDESTINATION,
   PROFONDEURDESTINATION,
   DESCEPROVENANCE,
   DESCEDESTINATION,
   VALTYPEQUAISPROVENANCE,
   DESCETYPEQUAISPROVENANCE,
   VALTYPEQUAISDESTINATION,
   DESCETYPEQUAISDESTINATION,
   DESCEQUAISPROVENANCE,
   DESCEQUAISDESTINATION,
   TYPEQUAISPROVENANCE,
   TYPEQUAISDESTINATION,
   TYPENAVIRE,
   TYPENAVIRELIB,
   ESCALE,
   NOVOYAGE,
   ARMATEUR,
   ARMATEURLIB,
   MAJORATION,
   REDUCTION,
   PAVILLONLIB,
   DESIGNATION,
   CODE
)
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
          tn.VAL AS typenavirelib,
          pre.escale,
          pre.NOVOYAGE,
          pre.ARMATEUR,
          cons.NOMCLT AS ARMATEURLIB,
          0 AS majoration,
          0 AS reduction,
          pay.val AS pavillonlib,
          fc.DESIGNATION,
          fc.CODE
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
          LEFT JOIN CONSIGNATAIREMAT cons ON cons.CDCLT = pre.ARMATEUR
          LEFT JOIN FACTURECLIENT fc ON fc.IDPREVISION = pre.id;


create or replace view previsiontypeBornage as          
select p.*,n.type from prevision p
join navire n on p.navire=n.id
where n.type='TYPE000062';    	  




  CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE, CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE, DATEFACT, POSTE, POSTELIB, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, VOLUME, VOLUMEARRONDI, CARGAISON, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, SURFACE, NB5JOURS, QUAI, FLOTTE, CATEGORIE_FLOTTE, UNITELIB, ESTPETROLIER, VOLUMERUBRIQUE) AS
  SELECT ac.ID,
          ac.DESIGNATION,
          ac.CLIENT,
          ac.RUBRIQUE,
          ac.QTE,
          ac.MOIS,
          MOIS.VAL AS MOISLIB,
          ac.ANNEE,
          ac.DATY,
          ac.BATEAU,
          ac.ETAT,
          ra.DESIGNATION AS rubriquelib,
          nv.id AS navire,
          nv.NOM AS bateaulib,
          nv.PLT AS poids,
          nv.LHT AS longueur,
          nv.LM AS largeur,
          CAST ('-' AS VARCHAR2 (100)) AS autres,
          ra.pu,
          ra.devise,
          ra.compte,
          ra.unite,
          ra.direction,
          ra.condition,
          ra.tva,
          ra.objet,
          ra.redevance,
          fup.NOM AS clientlib,
          re.VAL AS redevancelib,
          di.LIBELLEDIR AS directionlib,
          CASE
             WHEN ac.etat = 1 THEN 'CREE(E)'
             WHEN AC.ETAT = 11 THEN 'VISE(E)'
             WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
          END
             AS ETATLIB,
          ra.CATEGORIE,
          cf.val AS categorieLib,
          ac.REFOBJET,
          ac.TYPESOURCE,
          pre.DATE_DEPART AS DATEFACT,
          ac.POSTE,
          pd.VALQUAIS AS postelib,
          ac.DATEDEBUT,
          ac.HEUREDEBUT,
          ac.DATEFIN,
          ac.HEUREFIN,
          CAST (nv.lm * nv.lht * nv.te AS NUMBER (10, 3)) AS volume,
          CAST (ROUND ( (nv.lm * nv.lht * nv.te) / 100) AS NUMBER (10, 3))
             AS volumeArrondi,
          NVL (pre.cargaison, '-') AS cargaison,
          pre.id AS idprestation,
          CASE
             WHEN    nv.pavillon = 'PAYS000054'
                  OR nv.pavillon = 'PAYS000010'
                  OR nv.pavillon = 'PAYS000057'
             THEN
                'National'
             WHEN    nv.pavillon != 'PAYS000054'
                  OR nv.pavillon != 'PAYS000010'
                  OR nv.pavillon != 'PAYS000057'
             THEN
                'International'
          END
             AS estNational,
          CASE
             WHEN ac.heuredebut BETWEEN '05:00:00' AND '19:00:00' THEN 'JOUR'
             ELSE 'NUIT'
          END
             AS estJour,
          CASE
             WHEN ac.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
             ELSE 'NONFERIE'
          END
             AS estFerie,
          occ.idmanoeuvrebord AS manoeuvre,
          CASE
             WHEN    TO_CHAR (ac.daty, 'DAY') = 'DIMANCHE'
                  OR TO_CHAR (ac.daty, 'DAY') = 'SAMEDI'
             THEN
                'weekend'
             ELSE
                'normal'
          END
             AS estWeekend,
          occ.IDNATUREOPERATION AS natureoperation,
          CASE
             WHEN   (  (  60
                        * 24
                        * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss')))
                     - 60)
                  / 15 < 0
             THEN
                0
             ELSE
                ROUND (
                     (  (  60
                         * 24
                         * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                       'dd-mm-yy hh24:mi:ss')
                            - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                       'dd-mm-yy hh24:mi:ss')))
                      - 60)
                   / 15)
          END
             AS nbQuartHeure,
          CASE
             WHEN   24
                  * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                'dd-mm-yy hh24:mi:ss')
                     - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                'dd-mm-yy hh24:mi:ss')) < 0
             THEN
                0
             ELSE
                ROUND (
                     24
                   * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                 'dd-mm-yy hh24:mi:ss')
                      - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                 'dd-mm-yy hh24:mi:ss'))+1)
          END
             AS nbHeure,
          CASE
             WHEN (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                              'dd-mm-yy hh24:mi:ss')
                   - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                              'dd-mm-yy hh24:mi:ss')) < 0
             THEN
                0
             WHEN ROUND (
                     (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                 'dd-mm-yy hh24:mi:ss')
                      - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                 'dd-mm-yy hh24:mi:ss'))) = 0
             THEN
                1
             ELSE
                CASE
                   WHEN ROUND (
                             TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss')) <
                           ROUND (
                              (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                          'dd-mm-yy hh24:mi:ss')
                               - TO_DATE (
                                    ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                    'dd-mm-yy hh24:mi:ss')),
                              1)
                   THEN
                        ROUND (
                             TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss'))
                      + 1
                   ELSE
                      ROUND (
                           TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                    'dd-mm-yy hh24:mi:ss')
                         - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                    'dd-mm-yy hh24:mi:ss'))+1
                END
          END
             AS nbJour,
          q.typequais,
          CAST (nv.LHT * nv.lm AS NUMBER (20, 2)) AS surface,
          CASE
             WHEN (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                              'dd-mm-yy hh24:mi:ss')
                   - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                              'dd-mm-yy hh24:mi:ss')) < 0
             THEN
                0
             ELSE
                CASE
                   WHEN ROUND (
                           (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                       'dd-mm-yy hh24:mi:ss')
                            - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                       'dd-mm-yy hh24:mi:ss'))) BETWEEN 0
                                                                    AND 5
                   THEN
                      1
                   ELSE
                      ROUND (
                           TRUNC (
                                (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                            'dd-mm-yy hh24:mi:ss')
                                 - TO_DATE (
                                      ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss'))
                              / 5)
                         + 1)
                END
          END
             AS nb5jours,
          pd2.QUAI,
          occ.IDMATERIEL_NAVAL AS flotte,
          cm.IDCATEGORIE AS categorie_flotte,
          ua.VAL AS unitelib,
          CASE WHEN nv.TYPE = 'TP0001' THEN 'TRUE' ELSE 'FALSE' END
             AS estPetrolier,
          RA.VOLUME as volumeRubrique
     FROM ACTIVITE ac
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
          LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
          LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
          LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
          LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
          LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
          LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
          LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
          LEFT JOIN UNITE_ACTIVITE ua ON ua.ID = ra.UNITE
          LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
          LEFT JOIN quais q ON q.id = pd2.quai
          LEFT JOIN occupationmaterielnaval occ ON occ.id = ac.REFOBJET
          LEFT JOIN MATERIEL_NAVAL cm ON cm.id = occ.IDMATERIEL_NAVAL;