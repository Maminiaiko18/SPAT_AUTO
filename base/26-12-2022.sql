
CREATE OR REPLACE  VIEW CAFCFILLECOMPLET_AVOIRNP (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MERECA, CODE, ETATLIB,numpiece) AS 
  SELECT ff.ID,
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
         cast(MOIS as NUMBER(10)),
         cast(ANNEE as NUMBER(10)),
          HEUREDEBUT,
          HEUREFIN,
          REDUCTION,
          MAJORATION,
          TEST,
          RANG,
          DUREE,
         cast(MONTANTAV as NUMBER(30,3)),
          RUBRIQUECPL,
          DATY,
          TIERS,
          IDCATEGORIE,
          ff.TYPE,
          DEVISEMERE,
          EXERCICE,
          IDAVOIR,
          ff.ETAT,
         cast(MTAVOIR as NUMBER(30,2)),
         cast(MONTANTREDUCTION as NUMBER(30,2)),
         cast(MONTANTMAJORATION as NUMBER(30,2)),
         cast(MONTANT-nvl(ff.MONTANTAVOIRAVECTSAUX,0)  as NUMBER(30,2)),
         cast(ff.MONTANTTVA-nvl(ff.montantavTVAavecTaux,0) as NUMBER(30,2)),
         cast(ff.MONTANTTTC-nvl(ff.MONTANTAVTTCAVECTAUX,0) as number(30,2)),
          moislib,
         cast(ff.MONTANTHTSIMPLE-nvl(ff.MONTANTAVOIRAVECTSAUX,0) as NUMBER(30,2)),
          ff.client,
          cptM.id,
          ff.code,
            case
           when ff.ETAT = 1 then 'CREE'
           when ff.ETAT >= 11 then 'VISE'
           else '' end                           as etatlib,
           ff.numpiece
     FROM fcfillecompletNP ff
     LEFT JOIN compteCA cptCA ON cptCA.val=ff.COMPTE
     LEFT join mereCA cptM ON cptM.id=cptCA.desce
     WHERE FF.IDCATEGORIE <> 'CATFCO2' AND FF.IDCATEGORIE <> 'CATFCO1'  and etat>=11;


CREATE OR REPLACE  VIEW AVOIRFC_MONTANT (ID, DATY, IDFACTURE, ETAT, TIERS, TIERSLIB, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION, MONTANT, MONTANTTVA, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, CODEFACTURE,datefacture) AS 
  SELECT fc.ID,
          fc.DATY,
          fc.IDFACTURE,
          fc.ETAT,

          f.TIERS,
          f.tierslib,

          fc.CATEGORIE,
          c.VAL AS categorielib,
          fc.MOTIF,
          mo.val AS motiflib,
          fc.CODE,
          fc.TYPE,
          CASE
             WHEN fc.TYPE = '1' THEN 'interne'
             WHEN fc.TYPE = '2' THEN 'externe'
          END
             AS typelib,
          fc.DESIGNATION ,
		  CAST (NVL (mr.montant, 0.0) AS NUMBER (30, 3)) AS montant,
          CAST (mr.montanttva AS NUMBER (30, 3)) as montanttva,
          CAST (mr.montantttc AS NUMBER (30, 3)) as montanttc ,
		  CAST (NVL (op.DEBIT, 0) AS NUMBER (30, 3)) AS montantpaye,
          CAST (NVL (mr.montantttc, 0.0) - NVL (op.DEBIT, 0) AS NUMBER (30, 3)) AS montantreste ,
		  f.code AS codeFacture,
		  f.DATY AS datefacture
     FROM AVOIRFC fc
          LEFT JOIN CATEGORIEAVOIRFC c ON fc.CATEGORIE = c.id
          LEFT JOIN MOTIFAVOIRFC mo ON fc.MOTIF = mo.id
          LEFT JOIN avoirfcavectaux_grp_mere mr ON mr.IDMERE = fc.ID
          LEFT JOIN FACTURECLIENT_libcomplet f ON fc.IDFACTURE = f.ID
          LEFT JOIN ordonnerpayement_jc_vise op ON op.ded_id = fc.ID;
         
         
         CREATE OR REPLACE  VIEW AVOIRFC_MONTANT_C (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, MONTANTPAYE, MONTANTRESTE, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION, MONTANTTVA, MONTANTTTC, CODEFACTURE,datefacture) AS 
  select ID,DATY,IDFACTURE,ETAT,MONTANT,TIERS,TIERSLIB,MONTANTPAYE,MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,
  			MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION , montanttva , montantttc ,codeFacture,datefacture
   from avoirFC_montant
  where etat=1;
    
 
 CREATE OR REPLACE  VIEW AVOIRFC_MONTANT_V (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, MONTANTPAYE, MONTANTRESTE, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION, MONTANTTVA, MONTANTTTC,codefacture,datefacture) AS 
  select ID,DATY,IDFACTURE,ETAT,MONTANT,TIERS,TIERSLIB,MONTANTPAYE,MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION , montanttva , montantttc,CODEFACTURE,datefacture
from avoirFC_montant
where etat>=11;
    
    