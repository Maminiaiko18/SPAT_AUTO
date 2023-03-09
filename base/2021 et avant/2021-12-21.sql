

CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE,
             BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET,
             REDEVANCE, CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE,
             DATEFACT, POSTE, POSTELIB, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, VOLUME, VOLUMEARRONDI, CARGAISON,
             IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, NATUREOPERATION, NBQUARTHEURE,
             NBHEURE, NBJOUR, TYPEQUAIS, SURFACE, NB5JOURS, QUAI, FLOTTE, CATEGORIE_FLOTTE, UNITELIB, ESTPETROLIER,
             VOLUMERUBRIQUE, TAUX,TIRANT)
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
               - 60) <= 1
               THEN
               0
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
       ac.TAUX,
       nv.te                                                                       as tirant
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


CREATE OR REPLACE VIEW ORDONNERPAYEMENT_LIBETAT AS 
  SELECT op.ID,
       op.DED_ID,
       op.IDLIGNE,
       op.DATY,
       op.MONTANT,
       op.REMARQUE,
       op.ETAT,
       op.NUMEROOP,
       op.DESTINATION,
       op.MODEPAIEMENT,
       op.IDUSER,
       jc.FOLIO,
       jc.NUMCHEQUE,
       CASE
           WHEN op.etat = 0 THEN 'annule'
           WHEN op.etat = 1 THEN 'cree'
           WHEN op.etat = 11 THEN 'vise'
           END
              AS etatlib,
       md.VAL AS MODEPAIEMENTLIB,
       fup.NOM as TIERS
FROM OrdonnerPayement op
         left join journalcaisse jc on jc.IDORDRE = op.ID
         LEFT JOIN modepaiement md ON md.ID = op.MODEPAIEMENT
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = op.TIERS
 ORDER BY op.DATY DESC;


INSERT INTO CATEGORIEFACTURATION (ID, VAL, DESCE)
VALUES ('CATFCI0020', 'Convention', 'Convention');


update RUBRIQUE_ACTIVITE set CATEGORIE='CATFCI0020' where id in (
     'RB0000000029103544'
    , 'RB0000000036111753'
    , 'RB0000000029113124'
    , 'RB0000000030103808'
    , 'RB0000000034110310'
    , 'RB0000000182111540'
    , 'RB0000000083094342'
    , 'RB0000000142092809'
    , 'RB0000000023102044'
    , 'RB0000000028103047'
    , 'RB0000000032105101'
    , 'RB0000000035111101'
    , 'RB0000000181164922'
    , 'RB0000000040144023'
    , 'RB0000000031104417'
    , 'RB0000000033105632'
    , 'RB0000000026100917'
    , 'RB0000000161102258'
    , 'RB0000000065111213'
    );


create table armateur
(
    id varchar2(100) constraint armateur_pk primary key ,
        nom varchar2(500),
        contact varchar2(500),
        adresse varchar2(500),
        nif varchar2(500),
        stat varchar2(500),
        mail varchar2(500)
);

CREATE SEQUENCE seqarmateur
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqarmateur
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqarmateur.nextval INTO retour FROM dual;
  return retour;
END;

CREATE OR REPLACE  VIEW FACTURE_CLIENT_FILLE_LIBELLE AS 
  SELECT fi.ID,
          fi.IDMERE,
           fi.RUBRIQUE,
          fi.DESIGNATION,
          fi.PU,
          fi.QUANTITE,     
          fi.COMPTE,
          fi.IDPRODUIT,
          fi.DEVISE,
          fi.TAUX,
          fi.IDACTIVITE,
          fi.TVA,
          pr.nom AS produit_lib,
          ac.DESIGNATION AS activitelib,
          TO_DATE (fi.DATEFACT, 'dd/MM/YY') AS DATEFACT,
          ra.DESIGNATION AS rubriquelib,
          fi.MOIS,
          fi.ANNEE,
          fi.HEUREDEBUT,
          fi.HEUREFIN,
       nvl(fi.MAJORATION,0) as MAJORATION,
       nvl(fi.REDUCTION,0) as REDUCTION,
         case when fi.IDACTIVITE is not null then ra.RANG end as rang,
         case when fi.IDACTIVITE is not null then ac.DATY end as daty
     FROM FACTURE_CLIENT_FILLE fi
          LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
          LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = ac.RUBRIQUE;