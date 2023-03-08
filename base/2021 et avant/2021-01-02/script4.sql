CREATE OR REPLACE FORCE VIEW SPAT_CAPITAINERIE.FACTUREFOURNISSEUR_ANALYSE AS
   SELECT ff."ID",
          ff."DATY",
          ff."IDFOURNISSEUR",
          ff."NOMFOURNISSEUR",
          ff."IDTVA",
          ff."REMARQUE",
          ff."DATEEMISSION",
          ff."DESIGNATION",
          ff."IDDEVISE",
          ff."NUMFACT",
          ff."DATYECHEANCE",
          ff."ETAT",
          ff."MONTANTPAYE",
          ff."RESTE",
          ff."ENTITE",
          ff."MONTANTTTDEVISE",
          ff."BUDGET",
          ff."RETENUE",
          ff."NUMID",
          ff."TIERSLIB",
          ff."TVA",
          ff."MONTANT",
          ff."MONTANTAVOIR",
          ff."MONTANTADDITIF",
          ff."MONTANTNET",
          ff."MONTANTTVA",
          ff."MONTANTTTC",
          ff."MONTANTTOTALAPAYER",
          ff."TYPE",
          CASE
             WHEN ff.REMARQUE LIKE '%CC%' THEN 'CONTRAT'
             WHEN ff.REMARQUE LIKE '%BL%' THEN 'BC'
             WHEN (ff.REMARQUE IS NULL AND TYPE LIKE 'TPFF002') THEN TY.VAL
             else 'SIMPLE'
          END
             AS TYPEFACTURE
     FROM ETATFACTUREMONTANTDATY ff JOIN TYPEFF TY ON TY.ID = fF.TYPE;