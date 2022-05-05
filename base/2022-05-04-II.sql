
  CREATE OR REPLACE  VIEW ACTIVITELIBCOMPLET (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE, CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE, DATEFACT, POSTE, POSTELIB, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, VOLUME, VOLUMEARRONDI, CARGAISON, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, SURFACE, NB5JOURS, QUAI, FLOTTE, CATEGORIE_FLOTTE, UNITELIB, ESTPETROLIER, VOLUMERUBRIQUE, TAUX, TIRANT, VOLUMEVIR, NBHEUREPREV, DEPART, ARRIVE) AS 
  SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                              AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                        AS rubriquelib,
       nv.id                                 AS navire,
       nv.NOM                                AS bateaulib,
       nv.PLT                                AS poids,
       nv.LHT                                AS longueur,
       nv.LM                                 AS largeur,
       CAST('-' AS VARCHAR2(100))            AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       case
           when nv.PAVILLON not in ('PAYS000054', 'PAYS000010', 'PAYS000057')
               and rubrique in ('RB0000000021170445', 'RB0000000021170446', 'RB0000000021170447')
               then 0
           else ra.tva
           end                               as tva,
       ra.objet,
       ra.redevance,
       fup.NOM                               AS clientlib,
       re.VAL                                AS redevancelib,
       di.LIBELLEDIR                         AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                             AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                       AS DATEFACT,
       ac.POSTE,
       pd.VALQUAIS                           AS postelib,
       ac.DATEDEBUT,
       ac.HEUREDEBUT,
       ac.DATEFIN,
       ac.HEUREFIN,
       CAST(
               TRUNC(nv.lm, 2) * TRUNC(nv.lht, 2) * TRUNC(nv.te, 2) AS NUMBER(10, 3))
                                             AS volume,
       cast(round((TRUNC(nv.lm, 2) * TRUNC(nv.lht, 2) * TRUNC(nv.te, 2))/100,1) AS number(10,0)) AS volumeArrondi,
       NVL(pre.cargaison, '-')               AS cargaison,
       pre.id                                AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                             AS estNational,
       CASE
           WHEN ac.heuredebut BETWEEN '05:00:00' AND '18:59:59' THEN 'JOUR'
           ELSE 'NUIT'
           END
                                             AS estJour,
       CASE
           WHEN ac.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                             AS estFerie,
       occ.idmanoeuvrebord                   AS manoeuvre,
       CASE
           WHEN TO_CHAR(ac.daty, 'DAY') LIKE '%DIMANCHE%'
               OR TO_CHAR(ac.daty, 'DAY') LIKE '%SAMEDI%'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                             AS estWeekend,
       occ.IDNATUREOPERATION                 AS natureoperation,
       CASE
           WHEN ((60
               * 24
               * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                          'dd-mm-yy hh24:mi:ss')
                   - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                             'dd-mm-yy hh24:mi:ss')))
               - 60) < 0
               THEN
               0
           WHEN ((60
               * 24
               * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                          'dd-mm-yy hh24:mi:ss')
                   - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                             'dd-mm-yy hh24:mi:ss')))
               - 60) <= 1
               THEN
               0
           ELSE
               CEIL(
                           ((60
                               * 24
                               * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                          'dd-mm-yy hh24:mi:ss')
                                   - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                             'dd-mm-yy hh24:mi:ss')))
                               - 60)
                           / 15)
           END
                                             AS nbQuartHeure,
       CASE
           WHEN 24
                    * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                               'dd-mm-yy hh24:mi:ss')
                   - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                             'dd-mm-yy hh24:mi:ss')) < 0
               THEN
               0
           ELSE
               (CEIL(
                           24
                           * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                     'dd-mm-yy hh24:mi:ss'))))
           END
                                             AS nbHeure,
       CASE
           WHEN (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                         'dd-mm-yy hh24:mi:ss')
               - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                         'dd-mm-yy hh24:mi:ss')) < 0
               THEN
               0
           WHEN ROUND(
                        (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                 'dd-mm-yy hh24:mi:ss')
                            - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss'))) = 0 or ROUND(
                        (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                 'dd-mm-yy hh24:mi:ss')
                            - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss'))) = 1
               THEN
               1
           ELSE
                   ((TO_DATE(ac.DATEFIN, 'dd-mm-yy')
                       - TO_DATE(ac.DATEDEBUT, 'dd-mm-yy')))
                   + 1
           END
                                             AS nbJour,
       CASE WHEN TYPESOURCE IS NULL THEN q.typequais ELSE ty.TYPEQUAIS END
                                             AS typequais,
       --type not postedestinaire
       CAST(nv.LHT * nv.lm AS NUMBER(20, 2)) AS surface,
       CASE
           WHEN (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                         'dd-mm-yy hh24:mi:ss')
               - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                         'dd-mm-yy hh24:mi:ss')) < 0
               THEN
               0
           ELSE
               CASE
                   WHEN ROUND(
                           (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                    'dd-mm-yy hh24:mi:ss')
                               - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                         'dd-mm-yy hh24:mi:ss'))) BETWEEN 0
                       AND 5
                       THEN
                       1
                   ELSE
                       (TRUNC(
                                    (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                             'dd-mm-yy hh24:mi:ss')
                                        - TO_DATE(
                                             ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                             'dd-mm-yy hh24:mi:ss'))
                                    / 5)
                           + 1)
                   END
           END
                                             AS nb5jours,
       pd2.QUAI,
       occ.IDMATERIEL_NAVAL                  AS flotte,
       cm.IDCATEGORIE                        AS categorie_flotte,
       ua.VAL                                AS unitelib,
       CASE WHEN nv.TYPE = 'TP0001' THEN 'TRUE' ELSE 'FALSE' END
                                             AS estPetrolier,
       RA.VOLUME                             AS volumeRubrique,
       ac.TAUX,
       nv.te                                 AS tirant,
       cast( (TRUNC(nv.lm, 2) * TRUNC(nv.lht, 2) * TRUNC(nv.te, 2))/100 as number(10, 2)) AS volumeVir,
       CASE
           WHEN pre.DATE_DEPART IS NULL
               OR pre.DATE_ARRIVEE IS NULL
               OR HEURE_DEPART IS NULL
               OR HEURE_ARRIVEE IS NULL
               OR (24
                       * (TO_DATE(
                                  pre.DATE_DEPART || ' ' || pre.HEURE_DEPART,
                                  'dd-mm-yy hh24:mi:ss')
                       - TO_DATE(
                                  pre.DATE_ARRIVEE || ' ' || pre.HEURE_ARRIVEE,
                                  'dd-mm-yy hh24:mi:ss')) < 0)
               THEN
               0
           ELSE
               (CEIL(
                           24
                           * (TO_DATE(pre.DATE_DEPART || ' ' || pre.HEURE_DEPART,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE(
                                      pre.DATE_ARRIVEE || ' ' || pre.HEURE_ARRIVEE,
                                      'dd-mm-yy hh24:mi:ss'))))
           END
                                             AS nbHeurePrev,
       CASE
           WHEN pre.DATE_DEPART IS NULL
               OR pre.DATE_ARRIVEE IS NULL
               OR HEURE_DEPART IS NULL
               OR HEURE_ARRIVEE IS NULL
               THEN
               NULL
           ELSE
               TO_DATE(pre.DATE_DEPART || ' ' || pre.HEURE_DEPART,
                       'dd-mm-yy hh24:mi:ss')
           END
                                             AS depart,
       CASE
           WHEN pre.DATE_DEPART IS NULL
               OR pre.DATE_ARRIVEE IS NULL
               OR HEURE_DEPART IS NULL
               OR HEURE_ARRIVEE IS NULL
               THEN
               NULL
           ELSE
               TO_DATE(pre.DATE_ARRIVEE || ' ' || pre.HEURE_ARRIVEE,
                       'dd-mm-yy hh24:mi:ss')
           END
                                             AS arrive
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
         LEFT JOIN MATERIEL_NAVAL cm ON cm.id = occ.IDMATERIEL_NAVAL
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET ty ON ty.id = ac.TYPESOURCE;


CREATE OR REPLACE VIEW ACTIVITESNONFACTUREES
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE,
             BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET,
             REDEVANCE, CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE,
             DATEFACT, POSTE, POSTELIB, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, VOLUME, VOLUMEARRONDI, CARGAISON,
             IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, NATUREOPERATION, NBQUARTHEURE,
             NBHEURE, NBJOUR, TYPEQUAIS, SURFACE, NB5JOURS, QUAI, FLOTTE, CATEGORIE_FLOTTE, UNITELIB, TAUX, TIRANT)
AS
SELECT ID,
       DESIGNATION,
       CLIENT,
       RUBRIQUE,
       cast(QTE as number(10, 2)),
       cast(MOIS as number(10)),
       MOISLIB,
       cast(ANNEE as number(10)),
       DATY,
       BATEAU,
       cast(ETAT as NUMBER(10)),
       RUBRIQUELIB,
       NAVIRE,
       BATEAULIB,
       cast(POIDS as NUMBER(30, 3)),
       cast(LONGUEUR as NUMBER(30, 3)),
       cast(LARGEUR as NUMBER(30, 3)),
       AUTRES,
       PU,
       DEVISE,
       COMPTE,
       UNITE,
       DIRECTION,
       CONDITION,
       cast(TVA as NUMBER(10, 2)),
       OBJET,
       REDEVANCE,
       CLIENTLIB,
       REDEVANCELIB,
       DIRECTIONLIB,
       ETATLIB,
       CATEGORIE,
       CATEGORIELIB,
       REFOBJET,
       TYPESOURCE,
       DATEFACT,
       POSTE,
       POSTELIB,
       DATEDEBUT,
       HEUREDEBUT,
       DATEFIN,
       HEUREFIN,
       VOLUME,
       VOLUMEARRONDI,
       CARGAISON,
       IDPRESTATION,
       ESTNATIONAL,
       ESTJOUR,
       ESTFERIE,
       MANOEUVRE,
       ESTWEEKEND,
       NATUREOPERATION,
       cast(NBQUARTHEURE as NUMBER(20)),
       cast(NBHEURE as number(20)),
       cast(NBJOUR as NUMBER(20)),
       TYPEQUAIS,
       SURFACE,
       cast(NB5JOURS as NUMBER(20)),
       QUAI,
       FLOTTE,
       CATEGORIE_FLOTTE,
       UNITELIB,
       cast(TAUX as NUMBER(10, 3)),
       cast(TIRANT as NUMBER(18, 3))
FROM ACTIVITELIBCOMPLET ac
WHERE id not IN (select idactivite from ecartAvoirFCParFille where round(ecart) = 0 and etat >= 11 AND idactivite IS NOT null);

CREATE OR REPLACE VIEW ACTIVITESNONFACTUREES
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE,
             BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET,
             REDEVANCE, CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE,
             DATEFACT, POSTE, POSTELIB, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, VOLUME, VOLUMEARRONDI, CARGAISON,
             IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, NATUREOPERATION, NBQUARTHEURE,
             NBHEURE, NBJOUR, TYPEQUAIS, SURFACE, NB5JOURS, QUAI, FLOTTE, CATEGORIE_FLOTTE, UNITELIB, TAUX, TIRANT)
AS
SELECT ID,
       DESIGNATION,
       CLIENT,
       RUBRIQUE,
       cast(QTE as number(10, 2)),
       cast(MOIS as number(10)),
       MOISLIB,
       cast(ANNEE as number(10)),
       DATY,
       BATEAU,
       cast(ETAT as NUMBER(10)),
       RUBRIQUELIB,
       NAVIRE,
       BATEAULIB,
       cast(POIDS as NUMBER(30, 3)),
       cast(LONGUEUR as NUMBER(30, 3)),
       cast(LARGEUR as NUMBER(30, 3)),
       AUTRES,
       PU,
       DEVISE,
       COMPTE,
       UNITE,
       DIRECTION,
       CONDITION,
       cast(TVA as NUMBER(10, 2)),
       OBJET,
       REDEVANCE,
       CLIENTLIB,
       REDEVANCELIB,
       DIRECTIONLIB,
       ETATLIB,
       CATEGORIE,
       CATEGORIELIB,
       REFOBJET,
       TYPESOURCE,
       DATEFACT,
       POSTE,
       POSTELIB,
       DATEDEBUT,
       HEUREDEBUT,
       DATEFIN,
       HEUREFIN,
       VOLUME,
       VOLUMEARRONDI,
       CARGAISON,
       IDPRESTATION,
       ESTNATIONAL,
       ESTJOUR,
       ESTFERIE,
       MANOEUVRE,
       ESTWEEKEND,
       NATUREOPERATION,
       cast(NBQUARTHEURE as NUMBER(20)),
       cast(NBHEURE as number(20)),
       cast(NBJOUR as NUMBER(20)),
       TYPEQUAIS,
       SURFACE,
       cast(NB5JOURS as NUMBER(20)),
       QUAI,
       FLOTTE,
       CATEGORIE_FLOTTE,
       UNITELIB,
       cast(TAUX as NUMBER(10, 3)),
       cast(TIRANT as NUMBER(18, 3))
FROM ACTIVITELIBCOMPLET ac
WHERE id  IN (select idactivite from ecartAvoirFCParFille where round(ecart) = 0 and etat >= 11 AND idactivite IS NOT null)
 


 


