CREATE OR REPLACE VIEW LIAISONBORDEREAUFF_LIBCOMPLET
(ID, IDBORDEREAU, IDOP, REMARQUE, IDFACTURE, IDBORDEREAULIB, MONTANT,CODE_ETABLISSEMENT) AS
select li.ID,
       li.IDBORDEREAU,
       li.IDOP,
       op.DESIGNATION,
       op.id          as idfacture,
       b2.designation as idbordereaulib,
       op.MONTANTTTC  as montant,
       op.CODE_ETABLISSEMENT
from liaisonbordereauff li
         left join bordereauFF_libcomplet b2 on li.idBordereau = b2.id
         left join ETATFACTUREMONTANTDATY op on op.id = li.idOP;
		 
ALTER TABLE ACTIVITE
    ADD poste VARCHAR2(100)
        CONSTRAINT fk_postedestinataire_ACT REFERENCES POSTEDESTINATAIRE;

  CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET
      (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU,
          ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES,
          PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
          CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB,
          REFOBJET, TYPESOURCE, DATEFACT,POSTE,POSTELIB) AS
  SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                   AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION             AS rubriquelib,
       nv.id                      as navire,
       nv.NOM                     AS bateaulib,
       nv.PLT                     AS poids,
       nv.LHT                     AS longueur,
       nv.LM                      AS largeur,
       CAST('-' AS VARCHAR2(100)) AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                    AS clientlib,
       re.VAL                     AS redevancelib,
       di.LIBELLEDIR              AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                  AS ETATLIB,

       ra.CATEGORIE,
       cf.val                     as categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART            as DATEFACT,
       ac.POSTE,
        pd.VALQUAIS as postelib
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE

         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf on ra.categorie = cf.id
         left join PREVISION pre on pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         left join POSTEDESTINATAIRELIBCOMPLET pd on pd.ID=ac.POSTE ;
CREATE OR REPLACE VIEW ACTIVITECOMPLETVIEW (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, ANNEE, DATY, BATEAU, ETAT, CLIENTLIB, RUBRIQUELIB, BATEAULIB, POSTE, POSTELIB) AS 
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
          fup.NOM AS clientlib,
          ra.DESIGNATION AS rubriquelib,
          nv.NOM AS bateaulib,
          ac.POSTE,
          pd.VALQUAIS AS postelib
     FROM activite ac
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
          LEFT JOIN NAVIRE nv ON nv.ID = ac.BATEAU
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
          LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
          LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
          LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
          LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
          left join POSTEDESTINATAIRELIBCOMPLET pd on pd.ID=ac.POSTE;