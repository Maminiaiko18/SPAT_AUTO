CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE_I
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface, nb5jours)
AS
SELECT ac.ID                                                                       AS id,
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
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3))                               AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                                                   AS volumeArrondi,
       pre.cargaison,
       SYSDATE                                                                     AS datedebut,
       '00:00:00'                                                                  AS heuredebut,
       SYSDATE                                                                     AS datefin,
       '00:00:00'                                                                  AS HEUREFIN,
       '-'                                                                         AS idprestation,
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
       'NUIT'                                                                      AS estJour,
       'FERIE'                                                                        estFerie,
       '-'                                                                         AS manoeuvre,
       'weekend'                                                                   AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                                                 AS postelib,
       CAST('-' AS VARCHAR2(500))                                                  AS natureoperation,
       CASE
           WHEN ((60 * 24 * (DATE_ARRIVEE - DATE_DEPART)) - 60) / 15 < 0
               THEN
               0
           ELSE
               ROUND(((60 * 24 * (DATE_ARRIVEE - DATE_DEPART)) - 60) / 15)
           END
                                                     AS nbQuartHeure,
       CASE
           WHEN 24 * (DATE_ARRIVEE - DATE_DEPART) < 0 THEN 0
           ELSE ROUND((24 * (DATE_ARRIVEE- DATE_DEPART)))
           END
                                                     AS nbHeure,
       CASE
           WHEN (DATE_ARRIVEE - DATE_DEPART) < 0 THEN 0
           ELSE ROUND(DATE_ARRIVEE - DATE_DEPART)
           END
                                                     AS nbJour,
       q.typequais,
       cast(nv.LHT * nv.lm as NUMBER(20, 2))         as surface,
       CASE
           WHEN (DATE_ARRIVEE - DATE_DEPART) < 0 THEN 0
           ELSE case
                    when ((DATE_ARRIVEE - DATE_DEPART) / 5) < 1 then 0
                    else trunc((DATE_ARRIVEE - DATE_DEPART) / 5)+1
               end
           END                                       as nb5jours
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
    --  LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
    -- LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
WHERE ac.RUBRIQUE IN ('RB0000000021170444',
                      'RB0000000021170448',
                      'RB0000000021170449', 'RBR0101', 'RBR0102', 'RBR0103', 'RBR0104', 'RBR0105', 'RBR0106', 'RBR0107',
                      'RBR0108', 'RBR0109', 'RBR0110', 'RBR0111', 'RBR0112', 'RBR0113', 'RBR0114', 'RBR0115', 'RBR0116',
                      'RBR0117', 'RBR0118', 'RBR0119', 'RBR0120', 'RBR0121', 'RBR0122', 'RBR0123', 'RBR0124',
                      'RBR0125');

CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface, nb5jours, QUAI,
             flotte,categorie_flotte)
AS
select ID,
       DESIGNATION,
       CLIENT,
       RUBRIQUE,
       QTE,
       MOIS,
       MOISLIB,
       ANNEE,
       DATY,
       BATEAU,
       ETAT,
       RUBRIQUELIB,
       NAVIRE,
       BATEAULIB,
       POIDS,
       LONGUEUR,
       LARGEUR,
       AUTRES,
       cast(PU as VARCHAR2(100)) as PU,
       DEVISE,
       COMPTE,
       UNITE,
       DIRECTION,
       CONDITION,
       TVA,
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
       PAVILLON,
       cast(VOLUME as number(20, 2)) as VOLUME,
       cast(VOLUMEARRONDI as number(20,2)) as VOLUMEARRONDI,
       CARGAISON ,
       DATEDEBUT,
       HEUREDEBUT,
       DATEFIN,
       HEUREFIN,
       IDPRESTATION,
       cast(ESTNATIONAL as varchar2(100)) as ESTNATIONAL,
       cast(ESTJOUR as VARCHAR2(100)) as ESTJOUR,
       cast(ESTFERIE as VARCHAR2(100)) as ESTFERIE,
       MANOEUVRE,
       cast(ESTWEEKEND as VARCHAR2(100)) as ESTWEEKEND,
       POSTE,
       POSTELIB,
       NATUREOPERATION,
       cast(NBQUARTHEURE as NUMBER(20))as NBQUARTHEURE,
       cast(NBHEURE as NUMBER(20)) as NBHEURE,
       cast(NBJOUR as NUMBER(20)) as NBJOUR,
       TYPEQUAIS,
       cast(surface as NUMBER(20,2)) as surface,
       cast(nb5jours as NUMBER(10)) as nb5jours,
       QUAI,
       flotte,
       categorie_flotte
from (
         SELECT *
         FROM ACTIVITECOMPLETFORMULE_I
         UNION ALL
         SELECT *
         FROM ACTIVITECOMPLETFORMULE_II a);
		 

  CREATE OR REPLACE VIEW PREVISIONFICHE (ID, NOMNAVIRE, VALCONSIGNATAIRE,
      VALCARGAISON, VALPILOTE, VALQUAISPROVENANCE, VALPAYSPROVENANCE, VALQUAISDESTINATION,
      VALPAYSDESTINATION, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, ETAT,
      TYPE, ESCALE, NOVOYAGE,idnavire) AS
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
     , NOVOYAGE,
         NAVIRE as idnavire
from previsionLibComplet;



UPDATE DETFORMUFACT SET compte = '70670' WHERE id = 'DFF00000000300009';
UPDATE DETFORMUFACT SET compte = '70670' WHERE id = 'DFF00000000300010';
UPDATE DETFORMUFACT SET compte = '70682' WHERE id = 'DFFC00000000300010';
UPDATE DETFORMUFACT SET compte = '70682' WHERE id = 'DFFC00000000300011';
commit;

alter table AS_BONDECOMMANDE_FILLE add remise number(30,2);


  CREATE OR REPLACE VIEW UNION_BCF_SPAT_CEMEDI
      (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA,remise) AS
  select bcf.ID,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       UNITE,
       TVA,
       REMISE
from AS_BONDECOMMANDE_FILLE bcf
union
select id,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       UNITE,
       tva,
       cast(0 as NUMBER(30,2))
from bcf_cemedi_vue;


CREATE OR REPLACE VIEW BC_BL_LIVRE
            (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, QUANTITELIVRE, QUANTITERESTE,
             MONTANTBL, MONTANTBLRESTE, UNITE, TVA,remise,montantRemise)
AS
SELECT BCF.ID,
       CASE WHEN BCF.PRODUIT IS NULL THEN BCF.REMARQUE ELSE ap.Nom END
                                                   AS PRODUIT,
       BCF.IDBC,
       BCF.QUANTITE,
       BCF.PU,
       BCF.QUANTITEPARPACK,
       BCF.MONTANT,
       BCF.REMARQUE,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitelivre,
       CAST(BCF.QUANTITE - NVL(BFG.qtelivre, 0) AS NUMBER(25, 2))
                                                   AS quantitereste,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU
                                                   AS MontantBL,
       (bcf.quantite * bcf.pu)
           - CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU
                                                   AS MontantBLreste,
       u.DESCE                                     AS UNITE,
       bcf.TVA,
       bcf.REMISE,
       cast((BCF.REMISE * bcf.PU*bcf.QUANTITE) / 100 as NUMBER(30,2)) as montantRemise
FROM union_bcf_spat_cemedi BCF
         LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG
                   ON BFG.IDBONDECOMMANDE = BCF.ID
         LEFT JOIN union_produit_tbd_cemedi ap ON BCF.produit = ap.id
         LEFT JOIN union_unite_tbd_cemedi u ON bcf.UNITE = u.id;

		 
CREATE OR REPLACE VIEW AS_BONDECOMMANDE_FILLE_MONTANT
            (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK,
             MONTANT, REMARQUE, UNITE, TVA,REMISE, MONTANTHT, MONTANTTVA, MONTANTTTC, montantremise,ETAT)
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
       (bcf.QUANTITE * bcf.pu) * (REMISE / 100) as montantremise,
       bc.ETAT
from union_bcf_spat_cemedi bcf
         join union_bc_spat_cemedi bc on bc.id = bcf.IDBC
         LEFT JOIN UNITECHANTIER u ON U.ID = BCF.UNITE;
		 
	CREATE OR REPLACE VIEW AS_BONDECOMMANDE_FILLE_GROUPER (IDBC, MONTANTHT, MONTANTTVA, MONTANTTTC,montantremise) AS
SELECT IDBC,
       sum(montantht)  as montantht,
       sum(montanttva) as montanttva,
       sum(montantttc) as montantttc,
       sum(montantremise) as montantremise
FROM AS_BONDECOMMANDE_FILLE_MONTANT
--WHERE ETAT >= 11
group by IDBC;
CREATE OR REPLACE VIEW AS_BONDECOMMANDE_FILLE_GROUPER (IDBC, MONTANTHT, MONTANTTVA, MONTANTTTC,montantremise) AS
SELECT IDBC,
       sum(montantht)  as montantht,
       sum(montanttva) as montanttva,
       sum(montantttc)+nvl(sum(montantremise),0) as montantttc,
       nvl(sum(montantremise),0) as montantremise
FROM AS_BONDECOMMANDE_FILLE_MONTANT
--WHERE ETAT >= 11
group by IDBC;



CREATE OR REPLACE VIEW AS_BONDECOMMANDE_LIBELLE_LIB
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB,MONTANTREMISE)
AS
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                             as fournisseur,
       bc.tva,
       bc.NUMBC,
       nvl(c.montantht, 0),
       nvl(c.montanttva, 0),
       nvl(c.montantttc, 0),
       ''                                                 as idfacture,
       nvl(lfac.montantpayer, 0)                          as montant_paye_reel,
       nvl(c.montantttc, 0) - nvl((bl.MONTANTTTC), 0)     as resteapayegeneral,
       nvl(c.montantttc, 0) - nvl((lfac.montantpayer), 0) as resteapayerreel,
       nvl(bl.montantttc, 0)                              as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       lfac.montantttc                                    as montantfacture,
       case
           when bcf.RESTELIVRE > 0 then 'VISE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE(E)'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) != 0
               THEN 'FACTURE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'EN ATTENTE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYE(E)'
           else 'CREE(E)'
           END                                            as etatlib,
       MONTANTREMISE
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
         left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
         LEFT JOIN BONDELIVRAISONPARBC bl ON bl.IDBC = bc.ID
         left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur;
		 
CREATE OR REPLACE VIEW AS_BONDECOMMANDE_FILLE_PRD
            (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA, DESIGNATION, PRODUITLIB,
             REMISE) AS
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
       BCF.REMISE
FROM AS_BONDECOMMANDE_FILLE BCF
         left join union_produit_tbd_cemedi pr on pr.id = bcf.PRODUIT;