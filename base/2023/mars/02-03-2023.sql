
   -------cast PU
   CREATE OR REPLACE  VIEW FACTURE_CLIENT_MONTANTTC (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MONTANTTVA, MONTANTTAXE, MONTANTTC, IDACTIVITE, DATEFACT, RUBRIQUE, DATYACTIVITE, HEUREDEBUT, HEUREFIN, MOIS, ANNEE, RANG, DUREE, MAJORATION, REDUCTION) AS 
  SELECT fc.ID,
          fc.IDMERE,
          fc.DESIGNATION,
          fc.QUANTITE,
          CAST(fc.PU AS NUMBER(30,2)),
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
          CAST (fc.MONTANT AS NUMBER (32, 3)) AS MONTANT,
          CAST (fc.MONTANTTAUX AS NUMBER (32, 3)) AS MONTANTTAUX,
          CAST (fc.MONTANTAVOIRSANSTAUX AS NUMBER (32, 3))
             AS MONTANTAVOIRSANSTAUX,
          CAST (fc.MONTANTAVOIRAVECTAUX AS NUMBER (32, 3))
             AS MONTANTAVOIRAVECTAUX,
          CAST ( (fc.pu * QUANTITE * fc.TVA*nvl(FC.DUREE,1)) / 100 AS NUMBER (20, 3))
             AS montanttva,
          CAST ( (fc.pu * QUANTITE * fc.TVA*nvl(FC.DUREE,1)) / 100 AS NUMBER (20, 3))
             AS montanttaxe,
          CAST (
             (fc.pu * QUANTITE) + (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER (20, 3))
             AS montanttc,
          fc.IDACTIVITE,
          fc.DATEFACT,
          fc.RUBRIQUE,
          fc.DATYACTIVITE AS datyactivite,
          fc.HEUREDEBUT,
          fc.HEUREFIN,
          fc.mois,
          fc.annee,
          fc.rang,
          fc.duree,
          CAST (fc.MAJORATION AS NUMBER (30, 3)) AS MAJORATION,
          CAST (fc.REDUCTION AS NUMBER (30, 3)) AS REDUCTION
     FROM facture_client_montant fc
          LEFT JOIN ACTIVITE ac ON ac.ID = fc.IDACTIVITE;
         
         
         
         
    -------cast PU     
         CREATE OR REPLACE  VIEW AVOIRFCFILLE_PLUS (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, MONTANTDF, DESIGNATION, DEVISE, REMISE, TVADF, TVAAV, TVA, QTE, PU, MAJ, RED, DUREE) AS 
  select

         fc.ID,

       fc.IDMERE,

       fc.IDDETAILFACTURE,

       fc.MONTANT,

       fc.COMPTE,

       cast(MONTANTHTSIMPLE as NUMBER(30, 2)) as montantdf,

       ca.designation as designation,

       ca.devise as devise,

       fc.REMISE ,

       ca.tva AS tvaDf ,

       fc.tva AS tvaAv,

       fc.tva,

       fc.QTE ,

       CAST(fc.PU AS number(30,2)) ,

       cast(0 as number(10,2)) as maj ,

       cast(0 as number(10,2)) as red ,

       fc.DUREE

from AvoirFCFille fc

        left join fcfillecomplet ca on ca.id=fc.IDDETAILFACTURE;
		
		
		
	 -------cast PU
       CREATE OR REPLACE  VIEW FACTURE_CLIENT_FILLETTC (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE, MONTANTMAJ, MONTANTRED, MONTANTNET, MONTANTTVA, MONTANTTTC, DUREE) AS 
  select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       CAST(ff.PU AS NUMBER(30,2)),
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.MONTANTMAJ,
       ff.MONTANTRED,
       ff.MONTANTNET,
       ff.MONTANTTVA,
       cast(montantNET + montantTVA as number(30, 3)) as montantTTC,
       ff.DUREE
from facture_client_filleWithTVA ff;