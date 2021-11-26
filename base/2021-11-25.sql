CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE,
             BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET,
             REDEVANCE, CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, POSTE, POSTELIB, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, VOLUME, VOLUMEARRONDI,
             CARGAISON, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, NATUREOPERATION,
             NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, SURFACE, NB5JOURS, QUAI, FLOTTE, CATEGORIE_FLOTTE, UNITELIB,
             ESTPETROLIER, VOLUMERUBRIQUE, TAUX)
AS
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                                                    AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                                              AS rubriquelib,
       nv.id                                                                       AS navire,
       nv.NOM                                                                      AS bateaulib,
       nv.PLT                                                                      AS poids,
       nv.LHT                                                                      AS longueur,
       nv.LM                                                                       AS largeur,
       CAST('-' AS VARCHAR2(100))                                                  AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                                                     AS clientlib,
       re.VAL                                                                      AS redevancelib,
       di.LIBELLEDIR                                                               AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                                                   AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                                                      AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                                                             AS DATEFACT,
       ac.POSTE,
       pd.VALQUAIS                                                                 AS postelib,
       ac.DATEDEBUT,
       ac.HEUREDEBUT,
       ac.DATEFIN,
       ac.HEUREFIN,
       CAST(trunc(nv.lm, 2) * trunc(nv.lht, 2) * trunc(nv.te, 2) AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((trunc(nv.lm, 2) * trunc(nv.lht, 2) * trunc(nv.te, 2)) / 100) AS NUMBER(10, 3))
                                                                                   AS volumeArrondi,
       NVL(pre.cargaison, '-')                                                     AS cargaison,
       pre.id                                                                      AS idprestation,
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
           WHEN ac.heuredebut BETWEEN '05:00:00' AND '19:00:00' THEN 'JOUR'
           ELSE 'NUIT'
           END
                                                                                   AS estJour,
       CASE
           WHEN ac.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                                                   AS estFerie,
       occ.idmanoeuvrebord                                                         AS manoeuvre,
       CASE
           WHEN TO_CHAR(ac.daty, 'DAY') like '%DIMANCHE%'
               OR TO_CHAR(ac.daty, 'DAY') like '%SAMEDI%'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                                                   AS estWeekend,
       occ.IDNATUREOPERATION                                                       AS natureoperation,
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
               - 60) / 15 < 1
               THEN
               1
           ELSE
               ceil(
                           ((60 * 24 * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
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
               (ceil(24 * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
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
           WHEN ROUND((TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                               'dd-mm-yy hh24:mi:ss')
               - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                         'dd-mm-yy hh24:mi:ss'))) = 0
               THEN
               1
           ELSE
                   ((TO_DATE(ac.DATEFIN, 'dd-mm-yy') - TO_DATE(ac.DATEDEBUT, 'dd-mm-yy'))) + 1
           END
                                                                                   AS nbJour,
       case
           when TYPESOURCE is null then q.typequais
           else ty.TYPEQUAIS
           end                                                                     as typequais,
       --type not postedestinaire
       CAST(nv.LHT * nv.lm AS NUMBER(20, 2))                                       AS surface,
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
                       (
                               TRUNC(
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
       occ.IDMATERIEL_NAVAL                                                        AS flotte,
       cm.IDCATEGORIE                                                              AS categorie_flotte,
       ua.VAL                                                                      AS unitelib,
       CASE WHEN nv.TYPE = 'TP0001' THEN 'TRUE' ELSE 'FALSE' END
                                                                                   AS estPetrolier,
       RA.VOLUME                                                                   AS volumeRubrique,
       ac.TAUX
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
         left join POSTEDESTINATAIRELIBCOMPLET ty on ty.id = ac.TYPESOURCE;