

CREATE OR REPLACE VIEW AS_BONDECOMMANDE_FILLE_MONTANT
            (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA, REMISE, MONTANTHT,
             MONTANTTVA, MONTANTTTC, MONTANTREMISE, ETAT)
AS
select bcf.ID,
       bcf.PRODUIT,
       bcf.IDBC,
       bcf.QUANTITE,
       bcf.PU,
       bcf.QUANTITEPARPACK,
       bcf.MONTANT,
       bcf.REMARQUE,
       u.VAL                                                             AS UNITE,
       bcf.TVA,
       bcf.REMISE,
       (bcf.QUANTITE * bcf.pu)                                           as montantht,
       (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100                           as montanttva,
       (bcf.QUANTITE * bcf.pu) + (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100 as montantttc,
       nvl((bcf.QUANTITE * bcf.pu) * (REMISE / 100),0)                          as montantremise,
       bc.ETAT
from union_bcf_spat_cemedi bcf
         join union_bc_spat_cemedi bc on bc.id = bcf.IDBC
         LEFT JOIN UNITECHANTIER u ON U.ID = BCF.UNITE;

	
create or replace view AS_BONDECOMMANDE_FILLE_GROUPER as
SELECT IDBC,
       sum(montantht)  as montantht,
       sum(montanttva) as montanttva,
       sum(montantttc)-nvl(sum(montantremise),0) as montantttc,
       nvl(sum(montantremise),0) as montantremise
FROM AS_BONDECOMMANDE_FILLE_MONTANT
--WHERE ETAT >= 11
group by IDBC;



create or replace FORCE view ACTIVITELIBCOMPLET
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
                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) between 0 and 5 then 1
                    else round(trunc((to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) / 5) + 1)
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
		 
		 
UPDATE OCCUPATIONMATERIELNAVAL SET IDCOMMANDANT = 'COMM000001' WHERE IDCOMMANDANT = 'COMM000003';
commit;

  CREATE OR REPLACE VIEW AS_BONDECOMMANDE_LIBELLE_TIERS
      (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NOMFOURNISSEUR, NUMBC,
          MONTANT, MONTANTTVA, MONTANTTTC, IDFACTURE, MONTANT_A_PAYER, MONTANT_PAYE_REEL,
          RESTEPAYERGENERAL, RESTEAPAYERREEL, CODE_ETAB, PROJET, ETATLIB, DELAIPAIEMENT, ADRESSE,
          REMISE, TYPEPAIEMENT, DELAILIVRAISON,MONTANTREMISE) AS
  select op.ID,
       op.DATY,
       op.ETAT,
       op.REMARQUE,
       op.DESIGNATION,
       op.MODEPAIEMENT,
       ti.id                                    as FOURNISSEUR,
       op.TVA,
       op.FOURNISSEUR,
       op.NUMBC,
       cast(op.montant as number(25, 2))        as MONTANT,
       cast(op.MONTANTTVA as number(25, 2))     as MONTANTTVA,
       cast(op.MONTANTTTC as number(25, 2))     as MONTANTTTC,
       cast(IDFACTURE as varchar2(100)),
       cast(MONTANT_A_PAYER as number(25, 2))   as MONTANTTTC,
       cast(MONTANT_PAYE_REEL as number(25, 2)) as MONTANT_PAYE_REEL,
       cast(RESTEPAYERGENERAL as number(25, 2)) as RESTEPAYERGENERAL,
       cast(RESTEAPAYERREEL as number(25, 2))   as RESTEAPAYERREEL,
       op.CODE_ETAB,
       op.PROJET,
       ETATLIB,
       bc.DELAIPAIEMENT,
       ti.ADRESSE,
       cast(0 as number(25, 2))                    remise,
       tc.VAL                                   as TYPEPAIEMENT,
       DELAILIVRAISON,
       MONTANTREMISE
from AS_BONDECOMMANDE_LIBELLE_LIB op
         left join union_bc_spat_cemedi bc on op.id = bc.ID
         left join union_tiers_tbd_cemedi ti on ti.NOM = op.FOURNISSEUR
         left join TYPECHEQUE tc on tc.id = bc.TYPEPAIEMENT



  CREATE OR REPLACE VIEW AS_BONDECOMMANDE_FILLE_LIB (ID, PRODUIT, IDBC, QUANTITE,
      PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA, MONTANTHT, MONTANTTVA, MONTANTTTC, ETAT,MONTANTREMISE) AS
  select mon.ID,
       case when mon.produit is null then mon.remarque else pr.nom end,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       UNITE,
       TVA,
       MONTANTHT,
       MONTANTTVA,
       MONTANTTTC-MONTANTREMISE,
       ETAT,
       MONTANTREMISE
from AS_BONDECOMMANDE_FILLE_MONTANT mon
         left join union_produit_tbd_cemedi pr on pr.id = mon.PRODUIT;

CREATE OR REPLACE  VIEW ACTIVITELIBCOMPLET
            (ID, DESIGNATION,
             CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE,
             BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION,
             CONDITION, TVA, OBJET, REDEVANCE, CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB,
             CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE, DATEFACT, POSTE, POSTELIB, DATEDEBUT,
             HEUREDEBUT, DATEFIN, HEUREFIN, VOLUME, VOLUMEARRONDI, CARGAISON, IDPRESTATION, ESTNATIONAL,
             ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR,
             TYPEQUAIS, SURFACE, NB5JOURS, QUAI, FLOTTE, CATEGORIE_FLOTTE,unitelib)
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
       ua.VAL as unitelib
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