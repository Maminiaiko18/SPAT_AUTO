CREATE OR REPLACE  VIEW FACTURE_CLIENT_FILLE_LIBELLE AS 
  SELECT fi.ID,
          fi.IDMERE,
           fi.RUBRIQUE,
          fi.DESIGNATION,
          fi.QUANTITE,
          fi.PU,
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