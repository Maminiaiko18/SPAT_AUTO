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
   pavillon,
   volume,
   cargaison
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
          nv.lm*nv.lht*nv.te  as volume,
          pre.cargaison
     FROM ACTIVITE ac
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
          LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
          LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
          LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
          LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
          LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
          LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE;