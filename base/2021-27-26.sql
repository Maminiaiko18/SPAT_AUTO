CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIB
            (ID, IDMERE, DESIGNATION, QUANTITE, PU,
             COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX,
             MONTANTAVOIRAVECTAUX, IDPRODUITLIB, IDACTIVITE, CATEGORIEFACTURELIB, CATEGORIECLIENTLIB, RUBRIQUELIB,clientlib)
AS
select ID,
       IDMERE,
       DESIGNATION,
       cast(QUANTITE as NUMBER(32, 3))             as QUANTITE,
       cast(PU as NUMBER(32, 3))                   as PU,
       COMPTE,
       IDPRODUIT,
       DEVISE,
       TAUX,
       cast(QTELIVREE as number(32, 3))            as QTELIVREE,
       cast(RESTEALIVRER as NUMBER(32, 3))         as RESTEALIVRER,
       cast(MONTANTTAUX as NUMBER(32, 3))          as MONTANTTAUX,
       cast(MONTANT as NUMBER(32, 3))              as MONTANT,
       cast(MONTANTAVOIRSANSTAUX as NUMBER(32, 3)) as MONTANTAVOIRSANSTAUX,
       cast(MONTANTAVOIRAVECTAUX as NUMBER(32, 3)) as MONTANTAVOIRAVECTAUX,
       IDPRODUITLIB,
       IDACTIVITE,
       CATEGORIEFACTURELIB,
       CATEGORIECLIENTLIB,
       RUBRIQUELIB,
       clientlib
from (
         select fc.ID,
                fc.IDMERE,
                fc.DESIGNATION,
                fc.QUANTITE,
                fc.PU,
                fc.COMPTE,
                fc.IDPRODUIT,
                fc.DEVISE,
                fc.TAUX,
                cast(nvl(gr.QUANTITE, 0) as number(10, 3))               as qteLivree,
                cast(fc.QUANTITE - nvl(gr.QUANTITE, 0) as number(10, 3)) as resteAlivrer,
                cast(fcm.MONTANTTAUX as number(32, 3))                   as MONTANTTAUX,
                cast(fcm.MONTANT as NUMBER(32, 3))                       as MONTANT,
                cast(fcm.MONTANTAVOIRSANSTAUX as number(32, 3))          as MONTANTAVOIRSANSTAUX,
                cast(fcm.MONTANTAVOIRAVECTAUX as NUMBER(32, 3))          as MONTANTAVOIRAVECTAUX,
                pr.nom                                                   AS IDPRODUITlib,
                fc.IDACTIVITE,
                al.CATEGORIELIB                                          as categorieFacturelib,
                fcm.CATEGORIE                                            as categorieclientlib,
                nvl(RUBRIQUELIB, ra.DESIGNATION)                         as RUBRIQUELIB,
                v.NOMCLT as clientlib
         from facture_client_fille fc
                  left join AS_PRODUITS pr on pr.ID = fc.IDPRODUIT
                  left join as_bondelivraison_cl_grp gr on gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
                  left join FACTURE_CLIENT_MONTANT_LIB fcm on fcm.id = fc.id
                  left join ACTIVITELIBCOMPLET al on al.id = fc.IDACTIVITE
                  left join RUBRIQUE_ACTIVITE ra on ra.id = fc.RUBRIQUE
                  left join FACTURECLIENT f on fc.IDMERE = f.ID
                   left join  V_CLIENT_CATEGORIE v on v.CDCLT=f.TIERS
         union all
         select a.*,
                cast('-' as VARCHAR2(500)) as RUBRIQUELIB,
                cast('-' as VARCHAR2(500)) as clientlib
         from ANALYSEGLOBALFACTURE_FAC a);
		 

CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE,
             BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET,
             REDEVANCE, CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE,
             DATEFACT, POSTE, POSTELIB, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, VOLUME, VOLUMEARRONDI, CARGAISON,
             IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, NATUREOPERATION, NBQUARTHEURE,
             NBHEURE, NBJOUR, TYPEQUAIS, SURFACE, NB5JOURS, QUAI, FLOTTE, CATEGORIE_FLOTTE, UNITELIB,estPetrolier )
AS
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
           WHEN ((60 * 24 * (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                             to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) - 60) / 15 < 0
               THEN
               0
           ELSE
               ROUND(((60 * 24 * (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                                  to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) - 60) / 15)
           END
                                                     AS nbQuartHeure,
       CASE
           WHEN 24 * (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) < 0 THEN 0
           ELSE ROUND(24 * (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                            to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')))
           END
                                                     AS nbHeure,
       CASE
           WHEN (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                 to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) < 0 THEN 0
           WHEN round((to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                       to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) = 0 THEN 1
           ELSE round(to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))
           END
                                                     AS nbJour,
       q.typequais,
       cast(nv.LHT * nv.lm as NUMBER(20, 2))         as surface,
       CASE
           WHEN (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                 to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) < 0 THEN 0
           ELSE case
                    when round((to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                                to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) between 0 and 5
                        then 1
                    else round(trunc((to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) / 5) + 1)
               end
           END                                       as nb5jours,
       pd2.QUAI,
       occ.IDMATERIEL_NAVAL                          as flotte,
       cm.IDCATEGORIE                                as categorie_flotte,
       ua.VAL                                        as unitelib,
       case
           when nv.TYPE = 'TP0001' then 'TRUE'
           else 'FALSE' end                          as estPetrolier
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
		 

CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE,
             BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET,
             REDEVANCE, CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE,
             DATEFACT, POSTE, POSTELIB, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, VOLUME, VOLUMEARRONDI, CARGAISON,
             IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, NATUREOPERATION, NBQUARTHEURE,
             NBHEURE, NBJOUR, TYPEQUAIS, SURFACE, NB5JOURS, QUAI, FLOTTE, CATEGORIE_FLOTTE, UNITELIB,estPetrolier )
AS
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
       nvl(pre.cargaison,'-') as cargaison,

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
           WHEN ((60 * 24 * (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                             to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) - 60) / 15 < 0
               THEN
               0
           ELSE
               ROUND(((60 * 24 * (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                                  to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) - 60) / 15)
           END
                                                     AS nbQuartHeure,
       CASE
           WHEN 24 * (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) < 0 THEN 0
           ELSE ROUND(24 * (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                            to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')))
           END
                                                     AS nbHeure,
       CASE
           WHEN (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                 to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) < 0 THEN 0
           WHEN round((to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                       to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) = 0 THEN 1
           ELSE round(to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))
           END
                                                     AS nbJour,
       q.typequais,
       cast(nv.LHT * nv.lm as NUMBER(20, 2))         as surface,
       CASE
           WHEN (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                 to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) < 0 THEN 0
           ELSE case
                    when round((to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                                to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) between 0 and 5
                        then 1
                    else round(trunc((to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) / 5) + 1)
               end
           END                                       as nb5jours,
       pd2.QUAI,
       occ.IDMATERIEL_NAVAL                          as flotte,
       cm.IDCATEGORIE                                as categorie_flotte,
       ua.VAL                                        as unitelib,
       case
           when nv.TYPE = 'TP0001' then 'TRUE'
           else 'FALSE' end                          as estPetrolier
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
		 
alter table prevision add armateur varchar2(100) constraint fk_consignataire_arm references  consignataire;


  CREATE OR REPLACE VIEW PREVISIONLIBCOMPLET (ID, DATE_RADE, PROVENANCE, NAVIRE,
      CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART,
      HEURE_DEPART, DESTINATION, ETAT, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE,
      VALPAYSPROVENANCE, QUAIDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION,
      INTERNEPOVENANCE, LONGUEURPROVENANCE, TIRANTPROVENANCE, PROFONDEURPROVENANCE, REFERENCENAVIRE,
      NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE,
      REMARQUENAVIRE, ETATNAVIRE, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, VALCARGAISON, DESCECARGAISON, VALPILOTE,
      DESCEPILOTE, INTERNEDESTINATION, LONGUEURDESTINATION, TIRANTDESTINATION, PROFONDEURDESTINATION,
      DESCEPROVENANCE, DESCEDESTINATION, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION,
      DESCETYPEQUAISDESTINATION, DESCEQUAISPROVENANCE, DESCEQUAISDESTINATION, TYPEQUAISPROVENANCE,
      TYPEQUAISDESTINATION, TYPENAVIRE, TYPENAVIRELIB, ESCALE, NOVOYAGE,ARMATEUR,ARMATEURlib) AS
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
       cons.NOMCLT as ARMATEURLIB
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
        left join CONSIGNATAIREMAT cons on cons.CDCLT=pre.ARMATEUR;
CREATE OR REPLACE VIEW PREVISIONFACTUREE
AS
select *
from previsionLibComplet
where id in (select idprevision from factureclient where etat >= 11)


CREATE OR REPLACE VIEW PREVISIONFICHE
            (ID, NOMNAVIRE, VALCONSIGNATAIRE, VALCARGAISON, VALPILOTE, VALQUAISPROVENANCE, VALPAYSPROVENANCE,
             VALQUAISDESTINATION, VALPAYSDESTINATION, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, ETAT,
             TYPE, ESCALE, NOVOYAGE, IDNAVIRE,ARMATEUR,ARMATEURLIB)
AS
select id
     , nomnavire
     , valconsignataire
     , valcargaison
     , valpilote
     , valquaisprovenance
     , valpaysprovenance
     , valquaisdestination
     , valpaysdestination
     , date_arrivee
     , heure_arrivee
     , date_depart
     , heure_depart
     , etat
     , typenavirelib as type
     , ESCALE
     , NOVOYAGE
     , NAVIRE        as idnavire,
       ARMATEUR,
       ARMATEURLIB
from previsionLibComplet ;
 CREATE OR REPLACE VIEW PREVISIONFICHE_II (ID, NOMNAVIRE, VALCONSIGNATAIRE,
      VALCARGAISON, VALPILOTE, VALQUAISPROVENANCE, VALPAYSPROVENANCE, VALQUAISDESTINATION,
      VALPAYSDESTINATION, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, ETAT,
      TYPE, ESCALE, NOVOYAGE, IDNAVIRE, LHTNAVIRE, LMNAVIRE, JNTNAVIRE, JBTNAVIRE, TENAVIRE,
      PAVILLONNAVIRE,ARMATEUR,ARMATEURLIB) AS
  select previsionLibComplet.id
     , nomnavire
     , valconsignataire
     , valcargaison
     , valpilote
     , valquaisprovenance
     , valpaysprovenance
     , valquaisdestination
     , valpaysdestination
     , date_arrivee
     , heure_arrivee
     , date_depart
     , heure_depart
     , etat
     , typenavirelib as type
     , ESCALE
     , NOVOYAGE
     , NAVIRE        as idnavire
     , Lhtnavire
     , Lmnavire
     , Jntnavire
     , jbtnavire
     , TENAVIRE
     , pays.VAL as PAVILLONNAVIRE,
         ARMATEUR,ARMATEURLIB
from previsionLibComplet
    left join pays  on pays.ID=PAVILLONNAVIRE;
	

  CREATE OR REPLACE VIEW PREVISIONLIBELLECOMPLET (ID, DATE_RADE, PROVENANCE,
      NAVIRE, CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE,
      DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT, VALCONSIGNATAIRE, DESCECONSIGNATAIRE,
      REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE,
      LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIVRE, QUAIPROVENANCE,
      INTERNEPROVENANCE, PAYSPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE,
      TIRANTPROVENANCE, QUAIDESTINATION, INTERNEDESTINATION, PAYSDESTINATION, LONGUEURDESTINATION,
      PROFONDEURDESTINATION, TIRANTDESTINATION, IDQUAIPROVENANCE, IDQUAIDESTINATION, CARGVAL,
      CARGDESCE, IDTYPEQUAIPROVENANCE, TYPEQUAIPROVENANCE, IDTYPEQUAIDESTINATION, TYPEQUAIDESTINATION,
      IDPILOTE, VALPILOTE, DESCEPILOTE, NOVOYAGE,ARMATEUR,ARMATEURlib) AS
  select prev.id,
       prev.DATE_RADE,
       prev.PROVENANCE,
       prev.NAVIRE,
       prev.CONSIGNATAIRE,
       prev.CARGAISON,
       prev.PILOTE,
       prev.DATE_ARRIVEE,
       prev.HEURE_ARRIVEE,
       prev.DATE_DEPART,
       prev.HEURE_DEPART,
       prev.DESTINATION,
       prev.etat,
       c2.nomclt       as valCONSIGNATAIRE,
       c2.nomclt       as desceCONSIGNATAIRE,
       n1.reference    as referenceNAVIRE,
       n1.nom          as nomNAVIRE,
       p3.VAL          as pavillonNAVIRE,
       n1.jnt          as jntNAVIRE,
       n1.jbt          as jbtNAVIRE,
       n1.plt          as pltNAVIRE,
       n1.lht          as lhtNAVIRE,
       n1.lm           as lmNAVIRE,
       n1.te           as teNAVIRE,
       n1.volume       as volumeNAVIRE,
       n1.remarque     as remarqueNAVIRE,
       n1.ETAT         as etatNavivre,
       q1.VAL          as quaiPROVENANCE,
       prov.interne    as internePROVENANCE,
       p1.VAL          as paysPROVENANCE,
       prov.longueur   as longueurPROVENANCE,
       prov.profondeur as profondeurPROVENANCE,
       prov.tirant     as tirantPROVENANCE,
       q2.VAL          as quaiDESTINATION,
       dest.interne    as interneDESTINATION,
       p2.VAL          as paysDESTINATION,
       dest.longueur   as longueurDESTINATION,
       dest.profondeur as profondeurDESTINATION,
       dest.tirant     as tirantDESTINATION,
       q1.id           as idquaiPROVENANCE,
       q2.id           as idquaiDESTINATION,
       carg.val        as cargval,
       carg.val        as cargdesce,
       tpq1.id         as idtypequaiPROVENANCE,
       tpq1.val        as typequaiPROVENANCE,
       tpq2.id         as idtypequaiDESTINATION,
       tpq2.val        as typequaiDESTINATION,
       plt.id          as idpilote,
       plt.val         as valpilote,
       plt.desce       as descepilote,
       prev.NOVOYAGE,
       prev.ARMATEUR,
       con.NOMCLT as  ARMATEURlib
from PREVISION prev
         left join NAVIRE n1 on n1.id = prev.NAVIRE
         left join commandant plt on plt.id = prev.PILOTE
         left join clientmat C2 on prev.CONSIGNATAIRE = C2.CDCLT
         left join POSTEDESTINATAIRE prov on prov.id = prev.PROVENANCE
         left join POSTEDESTINATAIRE dest on dest.id = prev.DESTINATION
         left join pays p1 on prov.PAYS = p1.ID
         left join pays p2 on dest.PAYS = p2.ID
         left join QUAIS q1 on q1.id = prov.QUAI
         left join TYPEQUAIS tpq1 on tpq1.ID = q1.TYPEQUAIS
         left join QUAIS q2 on q2.id = dest.QUAI
         left join TYPEQUAIS tpq2 on tpq2.ID = q2.TYPEQUAIS
         left join pays p3 on p3.id = n1.pavillon
         left join CARGAISON carg on carg.id = prev.CARGAISON
         left join CONSIGNATAIREMAT con on con.CDCLT=prev.ARMATEUR;

CREATE OR REPLACE VIEW PREVISIONLIB (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE,
      CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART,
      DESTINATION, ETAT, NOVOYAGE,ARMATEUR,ARMATEURLIB) AS
  select ID,
       DATE_RADE,
       QUAIPROVENANCE   as provenance,
       NOMNAVIRE        as navire,
       VALCONSIGNATAIRE as consignataire,
       CARGVAL          as cargaison,
       valpilote        as pilote,
       DATE_ARRIVEE,
       HEURE_ARRIVEE,
       DATE_DEPART,
       HEURE_DEPART,
       quaiDESTINATION  as destination,
       etat,
       NOVOYAGE,
         ARMATEUR,
         ARMATEURLIB

from PREVISIONLIBELLECOMPLET;

CREATE OR REPLACE  VIEW PREVISIONLIBCOMPLETA
AS
select *
from previsionLibComplet
where ETAT = 0;
CREATE OR REPLACE  VIEW PREVISIONLIBCOMPLETC
AS
select *
from previsionLibComplet
where ETAT = 1;
CREATE OR REPLACE  VIEW PREVISIONLIBCOMPLETV
AS
select *
from previsionLibComplet
where ETAT = 11;

CREATE OR REPLACE VIEW PREVISIONQUAIS (ID, DATE_RADE, PROVENANCE,
    NAVIRE, CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART,
    HEURE_DEPART, DESTINATION, IDPOSTE, QUAI, INTERNE, PAYS, LONGUEUR, PROFONDEUR, TIRANT,ARMATEUR,armateurlib) AS
  select
	p.ID,p.DATE_RADE,p.PROVENANCE,p.NAVIRE,p.CONSIGNATAIRE,p.CARGAISON,p.PILOTE,p.DATE_ARRIVEE,p.HEURE_ARRIVEE,p.DATE_DEPART,p.HEURE_DEPART,p.DESTINATION,
  pd.id as idposte,
  quai,
  interne,
  pays,
  longueur,
  profondeur,
  tirant,
  ARMATEUR,
  co.NOMCLT as armateurlib
from prevision p
join postedestinataire pd
on p.provenance=pd.id
    left join CONSIGNATAIREMAT co on co.CDCLT=p.ARMATEUR

create table typefc
(
    id varchar2(100) constraint typefc_fk primary key ,
        val varchar2(500),
        desce varchar2(500)
);
CREATE SEQUENCE seqtypefc
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqtypefc
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqtypefc.nextval INTO retour FROM dual;
  return retour;
END;


  INSERT INTO TYPEFC (ID, VAL, DESCE) VALUES ('TFC001', 'a credit', 'a credit');
INSERT INTO TYPEFC (ID, VAL, DESCE) VALUES ('TFC002', 'au comptant', 'au comptant');
INSERT INTO TYPEFC (ID, VAL, DESCE) VALUES ('TFC003', 'provision', 'provision');
commit;
alter table factureclient add  constraint fk_typeFC foreign key (type)  references typefc;

CREATE OR REPLACE VIEW FACTURECLIENTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA,
      REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA,
      MONTANTAVOIR, MONTANTTTC, ESCALE,typelib) AS
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 2)) AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 2))  AS montanttva,
       NVL(grp.montantavoiravectaux, 0)               AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 2))
                                                      AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL as typelib
FROM FACTURECLIENT fc
         LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id
         left join PREVISION pr on pr.id = fc.IDPREVISION
         left join TYPEFC tfc on tfc.ID=fc.TYPE;


create or replace view FACTURECLIENTMSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,TYPELIB)
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
       CAST(m.MONTANT AS NUMBER(32, 2)),
       CAST(M.MONTANTTVA AS NUMBER(32, 2)),
       CAST(M.MONTANTAVOIR AS NUMBER(32, 2)),
       CAST(M.MONTANTTTC AS NUMBER(32, 2)),
       CAST(NVL(jc.montant, 0) AS NUMBER(32, 2)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(jc.montant, 0) AS NUMBER(32, 2))
                                                 AS montantreste,
       fup.NOM                                   AS tierslib,
       fup.CONTACT,
       fup.ADRESSE,
       M.ESCALE,TYPELIB

FROM factureclientMSum m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN JOURNALCAISSELIB_VISE_SUM jc ON jc.IDPLACEMENT = m.id;
		 


create or replace view FACTURE_CLIENT_UNION
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB,TYPElib)
as
select ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       cast(TVA as NUMBER(20, 2)) as tva,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       cast(ETAT as NUMBER(10))   as etat,
       cast(MONTANT as NUMBER(32, 2)),
       cast(MONTANTTVA as number(32, 2)),
       cast(MONTANTAVOIR as number(32, 2)),
       cast(MONTANTTTC as NUMBER(32, 2)),
       cast(MONTANTPAYE as NUMBER(32, 2)),
       cast(MONTANTRESTE as NUMBER(32, 2)),
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       CASE WHEN ETAT=1 THEN 'CREE(E)'
            WHEN ETAT=11 THEN  'VISE(E)' END AS ETATLIB,
       TYPELIB
from (
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                cast(TVA as NUMBER(20, 2))          as TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                cast(ETAT as number(10))            as etat,
                cast(MONTANT as NUMBER(32, 2))      as MONTANT,
                cast(MONTANTTVA as NUMBER(32, 2))   as MONTANTTVA,
                cast(MONTANTAVOIR as NUMBER(32, 2)) as MONTANTAVOIR,
                cast(MONTANTTTC as NUMBER(32, 2))   as MONTANTTTC,
                cast(MONTANTPAYE as NUMBER(32, 2))  as MONTANTPAYE,
                cast(MONTANTRESTE as NUMBER(32, 2)) as MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                IDPREVISION,
                ESCALE,
                TYPELIB
         from FACTURECLIENTMSUM_LIB
         union all
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                cast(TVA as NUMBER(20, 2))          as TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                cast(ETAT as NUMBER(10))            as etat,
                cast(MONTANT as NUMBER(32, 2))      as MONTANT,
                cast(MONTANTTVA as NUMBER(32, 2))   as MONTANTTVA,
                cast(MONTANTAVOIR as NUMBER(32, 2)) as MONTANTAVOIR,
                cast(MONTANTTTC as NUMBER(32, 2))   as MONTANTTTC,
                cast(MONTANTPAYE as NUMBER(32, 2))  as MONTANTPAYE,
                cast(MONTANTRESTE as NUMBER(32, 2)) as MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                '-' as PREVISION,
                '-' as ESCALE,
                TYPE as typelib
         from analyseglobaleantsika);
		 
CREATE OR REPLACE VIEW FACTURECLIENTMSUMC as   select *from FACTURECLIENTMSUM_LIB
where etat = 1;
CREATE OR REPLACE VIEW FACTURECLIENTMSUMV as
select *
from FACTURECLIENTMSUM_LIB
where etat >= 11;

CREATE OR REPLACE VIEW FACTURE_CLIENT_UNIONC
AS
select *
from facture_client_union
where etat = 1;
 
 CREATE OR REPLACE VIEW FACTURE_CLIENT_UNIONV
AS
select *
from facture_client_union
where etat = 11;

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENM025011', 'Type facture client', 'fa fa-cog', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=typeFC', 11, 3, 'MEN00505');


create or replace view FACTURE_CLIENT_FILLE_LIB_RESTE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB,tauxEuro,montantHTEuro,montantTVAEuro)
as
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANT AS NUMBER(32, 5)),
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3)),
       CAST(fcm.tva AS NUMBER(20, 3)),
       idactivite,
       ra.DESIGNATION                             as activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL as moislib,
       cast(0 as NUMBER(32,2)) as tauxEuro,
       cast(0 as NUMBER(32,2)) as montantHTEuro ,
       cast(0 as NUMBER(32,2)) as montantTVAEuro
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         left join ACTIVITE ra on ra.id = fc.IDACTIVITE
        left join mois on mois.id=fc.mois;
