CREATE OR REPLACE VIEW ETATPROVISIONVRAI
(
   ID,
   MONTANTFACTURE,
   MONTANTPROVISION,
   MONTANTPAYE,
   ECART,
   TIERS,
   TIERSLIB,
   DATY,
   TIERSPROVISION,
   TIERSLIBPROVISION,
   MONTANTRESTE,
   IDPROVISION
)
AS
     SELECT fu.id,
            SUM (NVL (FCUV.MONTANTTTC, 0)) AS montantfacture,
            SUM (fu.MONTANTTTC) AS montantprovision,
            SUM (fu.MONTANTPAYE) AS MONTANTPAYE,
            SUM (fu.MONTANTPAYE) - SUM (NVL (FCUV.MONTANTTTC, 0)) AS ecart, --RAP
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0)
               AS MONTANTRESTE,
            ''
       FROM FACTURE_CLIENT_UNION fu
            --left JOIN FACTURE_CLIENT_UNION fac ON fa.id = fac.IDPROVISION
            LEFT JOIN FACTURE_CLIENT_UNION_VISE FCUV
               ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib;
CREATE OR REPLACE VIEW FACTURE_fourn_VISE_gp
        (
           MONTANT,
           MONTANTTVA,
           MONTANTAVOIR,
           MONTANTPAYE,
           MONTANTTTC,
           IDPROVISION
        )
        AS
         SELECT SUM (MONTANT) AS montant,
                SUM (MONTANTTVA) AS MONTANTTVA,
                SUM (MONTANTAVOIR) AS MONTANTAVOIR,
                SUM (MONTANTPAYE) AS MONTANTPAYE,
                SUM (MONTANTTTC) AS MONTANTTTC,
                IDPROVISION
           FROM factfourn_msum_lib
          WHERE ETAT >= 11
        GROUP BY IDPROVISION;			
CREATE OR REPLACE VIEW ETATBPVRAI
(
   ID,
   MONTANTFACTURE,
   MONTANTPROVISION,
   MONTANTPAYE,
   ECART,
   TIERS,
   TIERSLIB,
   DATY,
   TIERSPROVISION,
   TIERSLIBPROVISION,
   MONTANTRESTE,
   IDPROVISION
)
AS
     SELECT fu.id,
            SUM (NVL (FCUV.MONTANTTTC, 0)) AS montantfacture,
            SUM (fu.MONTANTTTC) AS montantprovision,
            SUM (fu.MONTANTPAYE) AS MONTANTPAYE,
            SUM (fu.MONTANTPAYE) - SUM (NVL (FCUV.MONTANTTTC, 0)) AS ecart, --RAP
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0)
               AS MONTANTRESTE,
            ''
       FROM factfourn_msum_lib fu
            LEFT JOIN FACTURE_fourn_VISE_gp FCUV ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib;		

CREATE OR REPLACE  VIEW FACTURE_fournisseur_FILLEHT
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          CAST (ff.quantite * ff.pu AS NUMBER (30, 3)) AS montantHTSimple
     FROM FACTURE_fournisseur_FILLE ff;		

CREATE OR REPLACE VIEW FACTURE_fournisseur_FILLEMR
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE,
   MONTANTMAJ,
   MONTANTRED
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          ff."MONTANTHTSIMPLE",
          CAST ( (montantHTSimple * majoration) / 100 AS NUMBER (30, 3))
             AS montantMaj,
          CAST ( (montantHTSimple * reduction) / 100 AS NUMBER (30, 3))
             AS montantRed
     FROM facture_fournisseur_filleHT ff;	 
	 
CREATE OR REPLACE VIEW FACTURE_fournisseur_FILLENET
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE,
   MONTANTMAJ,
   MONTANTRED,
   MONTANTNET
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          ff."MONTANTHTSIMPLE",
          ff."MONTANTMAJ",
          ff."MONTANTRED",
          CAST (montantHTSimple + montantMaj - montantRed AS NUMBER (30, 3))
             AS montantNET
     FROM facture_fournisseur_filleMR ff;	

CREATE OR REPLACE VIEW FACTURE_fourn_FILLEWITHTVA
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE,
   MONTANTMAJ,
   MONTANTRED,
   MONTANTNET,
   MONTANTTVA
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          ff."MONTANTHTSIMPLE",
          ff."MONTANTMAJ",
          ff."MONTANTRED",
          ff."MONTANTNET",
          CAST ( (montantNET * tva) / 100 AS NUMBER (30, 3)) AS montantTVA
     FROM facture_fournisseur_filleNet ff;	 
	 
CREATE OR REPLACE VIEW FACTURE_fourn_FILLETTC
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE,
   MONTANTMAJ,
   MONTANTRED,
   MONTANTNET,
   MONTANTTVA,
   MONTANTTTC
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          ff."MONTANTHTSIMPLE",
          ff."MONTANTMAJ",
          ff."MONTANTRED",
          ff."MONTANTNET",
          ff."MONTANTTVA",
          CAST (montantNET + montantTVA AS NUMBER (30, 3)) AS montantTTC
     FROM facture_fourn_filleWithTVA ff;	 