CREATE OR REPLACE  VIEW ACTIVITELIBCOMPLET
(
   ID,
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
   PU,
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
   VOLUME,
   CARGAISON,
   datedebut,
   heuredebut,
   idprestation,
   estnational,
   estJour,
   estFerie,
   manoeuvre,
   estWeekend
)
AS
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
          NV.PAVILLON,
          nv.lm  nv.lht  nv.te AS volume,
          pre.cargaison,
          occ.daty as datedebut,
          occ.heuredebut,
          occ.id as idprestation,
          CASE
            when nv.pavillon='PAYS000054' or nv.pavillon='PAYS000010' or nv.pavillon='PAYS000057' THEN 'National'
            when nv.pavillon!='PAYS000054' or nv.pavillon!='PAYS000010' or nv.pavillon!='PAYS000057' THEN 'International'
          END   
          as estNational,
          CASE 
            WHEN occ.heuredebut between '05:00:00' and '19:00:00' THEN 'JOUR'
            ELSE 'NUIT' 
          END as estJour,
          CASE
            WHEN occ.daty in (select daty from jour_ferie) THEN 'FERIE'
            ELSE 'NONFERIE'
          END as estFerie,
          occ.idmanoeuvrebord as manoeuvre,
          CASE    
            WHEN TO_CHAR(occ.daty, 'DAY')='DIMANCHE' or TO_CHAR(occ.daty, 'DAY')='SAMEDI' THEN 'weekend'
            else 'normal'
          END as estWeekend
     FROM ACTIVITE ac
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
          LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
          LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
          LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
          LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
          LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
          LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
          left join occupationmaterielnaval occ on occ.idprevision=pre.id;
		  
alter table detformufact modify  condition varchar2(4000);

CREATE OR REPLACE FORCE VIEW ACTIVITELIBCOMPLET
(
   ID,
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
   PU,
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
   VOLUME,
   CARGAISON,
   datedebut,
   heuredebut,
   idprestation,
   estnational,
   estJour,
   estFerie,
   manoeuvre,
   estWeekend,
   poste,
   postelib
)
AS
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
          NV.PAVILLON,
          nv.lm  nv.lht  nv.te AS volume,
          pre.cargaison,
          occ.daty as datedebut,
          occ.heuredebut,
          occ.id as idprestation,
          CASE
            when nv.pavillon='PAYS000054' or nv.pavillon='PAYS000010' or nv.pavillon='PAYS000057' THEN 'National'
            when nv.pavillon!='PAYS000054' or nv.pavillon!='PAYS000010' or nv.pavillon!='PAYS000057' THEN 'International'
          END   
          as estNational,
          CASE 
            WHEN occ.heuredebut between '05:00:00' and '19:00:00' THEN 'JOUR'
            ELSE 'NUIT' 
          END as estJour,
          CASE
            WHEN occ.daty in (select daty from jour_ferie) THEN 'FERIE'
            ELSE 'NONFERIE'
          END as estFerie,
          occ.idmanoeuvrebord as manoeuvre,
          CASE    
            WHEN TO_CHAR(occ.daty, 'DAY')='DIMANCHE' or TO_CHAR(occ.daty, 'DAY')='SAMEDI' THEN 'weekend'
            else 'normal'
          END as estWeekend,
          ac.POSTE,
          pd.VALQUAIS as postelib
     FROM ACTIVITE ac
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
          LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
          LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
          LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
          LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
          LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
          LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
          left join occupationmaterielnaval occ on occ.idprevision=pre.id
          left join POSTEDESTINATAIRELIBCOMPLET pd on pd.ID=ac.POSTE ;