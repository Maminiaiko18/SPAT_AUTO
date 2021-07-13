
create or replace FORCE  view ACTIVITELIBCOMPLET
as
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         as navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,

       ra.CATEGORIE,
       cf.val                                        as categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               as DATEFACT,
       ac.POSTE,
       pd.VALQUAIS                                   as postelib,
       ac.DATEDEBUT,
       ac.HEUREDEBUT,
       ac.DATEFIN,
       ac.HEUREFIN,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,

       pre.id                                        AS idprestation,
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
           WHEN ac.heuredebut BETWEEN '05:00:00' AND '19:00:00'
               THEN
               'JOUR'
           ELSE
               'NUIT'
           END
                                                     AS estJour,
       CASE
           WHEN ac.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                     AS estFerie,
       occ.idmanoeuvrebord                           AS manoeuvre,
       CASE
           WHEN TO_CHAR(ac.daty, 'DAY') = 'DIMANCHE'
               OR TO_CHAR(ac.daty, 'DAY') = 'SAMEDI'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                     AS estWeekend,
       occ.IDNATUREOPERATION                         AS natureoperation,
       CASE
           WHEN ((60 * 24 * (ac.DATEFIN - ac.DATEDEBUT)) - 60) / 15 < 0
               THEN
               0
           ELSE
               ROUND(((60 * 24 * (ac.DATEFIN - ac.DATEDEBUT)) - 60) / 15)
           END
                                                     AS nbQuartHeure,
       CASE
           WHEN 24 * (ac.DATEFIN - ac.DATEDEBUT) < 0 THEN 0
           ELSE ROUND((24 * (ac.DATEFIN - ac.DATEDEBUT)))
           END
                                                     AS nbHeure,
       CASE
           WHEN (ac.DATEFIN - ac.DATEDEBUT) < 0 THEN 0
           WHEN round(ac.DATEFIN - ac.DATEDEBUT) = 0 THEN 1
           ELSE ROUND(ac.DATEFIN - ac.DATEDEBUT)
           END
                                                     AS nbJour,
       q.typequais,
       cast(nv.LHT * nv.lm as NUMBER(20, 2))         as surface,
       CASE
           WHEN (ac.DATEFIN - ac.DATEDEBUT) < 0 THEN 0
           ELSE case
                    when round(((ac.DATEFIN - ac.DATEDEBUT))) between 0 and 5 then 1
                    else trunc((ac.DATEFIN - ac.DATEDEBUT) / 5) + 1
               end
           END                                       as nb5jours,
       pd2.QUAI,
       occ.IDMATERIEL_NAVAL                          as flotte,
       cm.IDCATEGORIE                                as categorie_flotte
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf on ra.categorie = cf.id
         left join PREVISION pre on pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         left join POSTEDESTINATAIRELIBCOMPLET pd on pd.ID = ac.POSTE
         left join UNITE_ACTIVITE ua on ua.ID = ra.UNITE
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
         LEFT JOIN occupationmaterielnaval occ ON occ.id = ac.REFOBJET
         left join MATERIEL_NAVAL cm on cm.id = occ.IDMATERIEL_NAVAL;

CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET_A
AS
SELECT *
FROM ACTIVITELIBCOMPLET
WHERE ETAT = 0;


  CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET_C as  SELECT * FROM ACTIVITELIBCOMPLET
    WHERE ETAT = 1;

create or replace view ACTIVITELIBCOMPLET_V as
SELECT *  FROM ACTIVITELIBCOMPLET
    WHERE ETAT = 11;

CREATE OR REPLACE VIEW ACTIVITECOMPLETVIEW
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, ANNEE, DATY, BATEAU, ETAT, CLIENTLIB, RUBRIQUELIB, BATEAULIB,
             POSTE, POSTELIB,datedebut,HEUREDEBUT,DATEFIN,HEUREFIN,nbHeure,nbJour)
AS
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ac.clientlib,
       ac.rubriquelib,
       ac.bateaulib,
       ac.POSTE,
       ac.postelib,
       ac.datedebut,
       ac.HEUREDEBUT,
       ac.DATEFIN,
       ac.HEUREFIN,
       ac.nbHeure,
       ac.nbJour
FROM ACTIVITELIBCOMPLET ac;
