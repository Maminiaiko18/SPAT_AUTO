CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANTTC
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX,
             MONTANTAVOIRAVECTAUX, MONTANTTVA, MONTANTTAXE, MONTANTTC, IDACTIVITE, DATEFACT, RUBRIQUE, DATYACTIVITE,
             HEUREDEBUT, HEUREFIN, MOIS, ANNEE, RANG, DUREE,MAJORATION, REDUCTION)
AS
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       fc.IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATIONMERE,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       CAST(fc.MONTANT AS NUMBER(32, 3))     AS MONTANT,
       CAST(fc.MONTANTTAUX AS NUMBER(32, 3)) AS MONTANTTAUX,
       CAST(fc.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3))
                                             AS MONTANTAVOIRSANSTAUX,
       CAST(fc.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3))
                                             AS MONTANTAVOIRAVECTAUX,
       CAST((fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                             AS montanttva,
       CAST((fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                             AS montanttaxe,
       CAST(
               (fc.pu * QUANTITE) + (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                             AS montanttc,
       fc.IDACTIVITE,
       fc.DATEFACT,
       fc.RUBRIQUE,
       ac.DATY                               AS datyactivite,
       ac.HEUREDEBUT,
       ac.HEUREFIN,
       fc.mois,
       fc.annee,
       fc.rang,
       fc.duree,
       cast(fc.MAJORATION as NUMBER(30, 3))  as MAJORATION,
       cast(fc.REDUCTION as NUMBER(30, 3))   as REDUCTION
FROM facture_client_montant fc
         LEFT JOIN ACTIVITE ac ON ac.ID = fc.IDACTIVITE;


create view liaisonOPFF as
select
       ff.*,li.id2
from liaisonintratable li
         join FACTUREFOURNVALIDE_TOUS ff
              on ff.id = li.id1;


 

