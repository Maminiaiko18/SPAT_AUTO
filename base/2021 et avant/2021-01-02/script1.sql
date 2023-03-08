CREATE OR REPLACE FORCE VIEW ADDITIF_VISEPARLIGNE AS
     SELECT 
			ID,
            idfacture,
			montant,
            etat,
            TYPE,
            CASE
               WHEN av.TYPE = '1'
               THEN
                 av.montant
               ELSE
                  CAST (av.montant / (1 + ((NVL (av.TVA, 0)) / 100)) AS NUMBER (10, 2))
            END
               AS montantadditifht,
            CASE
               WHEN av.TYPE = '1'
               THEN
                  0
               ELSE
                    CAST (av.montant / (1 + ((NVL (av.TVA, 0)) / 100)) AS NUMBER (10, 2))* av.TVA/ 100
            END
               AS montantadditiftva,
            
            av.montant  AS montantadditifttc
       FROM ADDITIF av WHERE ETAT >= 11;
	   
	   
CREATE OR REPLACE FORCE VIEW AVOIR_VISEPARLIGNE AS
     SELECT 
			ID,
            idfacture,
			montant,
            etat,
            TYPE,
            CASE
               WHEN av.TYPE = '1'
               THEN
                 av.montant
               ELSE
                  CAST (av.montant / (1 + ((NVL (av.TVA, 0)) / 100)) AS NUMBER (10, 2))
            END
               AS montantavoirht,
            CASE
               WHEN av.TYPE = '1'
               THEN
                  0
               ELSE
                    CAST (av.montant / (1 + ((NVL (av.TVA, 0)) / 100)) AS NUMBER (10, 2))* av.TVA/ 100
            END
               AS montantavoirtva,
            
            av.montant  AS montantavoirttc
       FROM avoir av WHERE ETAT >= 11;

CREATE OR REPLACE FORCE VIEW ADDITIF_VISESM AS
     SELECT 
			IDFACTURE AS idfacture,
            sum(MONTANT) AS montant,
            etat,
            TYPE,
            sum(montantadditifht) as montantadditifht,
            sum(montantadditiftva) as montantadditiftva,
            sum(montantadditifttc)  AS montantadditifttc
       FROM ADDITIF_VISEPARLIGNE 
	   group by idfacture;
	   
	   
CREATE OR REPLACE FORCE VIEW AVOIR_VISESM AS
     SELECT 
			IDFACTURE AS idfacture,
            sum(MONTANT) AS montant,
            etat,
            TYPE,
            sum(montantavoirht) as montantavoirht,
            sum(montantavoirtva) as montantavoirtva,
            sum(montantavoirttc)  AS montantavoirttc
       FROM ADDITIF_VISEPARLIGNE 
	   group by idfacture;
----------------------------------------------------------------------------

CREATE OR REPLACE FORCE VIEW FACTUREFOURNISSEURMONTANT AS
   SELECT 
		  ff.id,
		  ff.daty,
		  ff.idfournisseur,
		  ff.idtva,
		  de.montanttva,
		  de.montantHt,
		  de.montantttc,
		  ff.remarque,
		  ff.dateemission,
		  ff.designation,
		  ff.iddevise,
		  ff.numfact,
		  ff.resp,
		  ff.datyecheance,
		  ff.etat,
		  ff.idfacturefournisseur,
		  ff.budget,
		  de.TVA AS tvadetails,
		  av.MONTANTAVOIRHT,
		  av.MONTANTAVOIRTVA,
		  av.MONTANTAVOIRTTC,
			ad.montantadditifht,
			ad.montantadditiftva,
			ad.montantadditifttc
     FROM facturefournisseur ff
          JOIN details_ff_sum de ON de.idmere = ff.id
          LEFT JOIN AVOIR_VISESM_GROUPER av ON av.idfacture = ff.id
          LEFT JOIN ADDITIF_VISESM_GROUPER ad ON ad.idfacture = ff.id;
	   
----------------------------------------------------------------------------
CREATE OR REPLACE FORCE VIEW FACTUREFOURNISSEURLETTREMTT AS
    SELECT ff.id,
          ff.daty,
          ff.idfournisseur AS idfournisseur,
          ff.idtva,
          ff.montantHt,
          ff.montanttva,
          ff.montantttc-nvl(ff.MONTANTAVOIRTTC,0)+nvl(ff.montantadditifttc,0) as montantttc,
          ff.remarque,
          ff.dateemission,
          ff.designation,
          ff.iddevise,
          ff.numfact,
          ff.datyecheance,
          '' AS entite,
          CASE
             WHEN ff.etat = 1 THEN 'CREE(E)'
             WHEN ff.etat = 11 THEN 'VALIDE(E)'
             ELSE 'AUTRE'
          END
             AS etat,
          ff.budget
     FROM facturefournisseurmontant ff
          LEFT JOIN TIERS c ON c.id = ff.idfournisseur;
----------------------------------------------------------------------------
CREATE OR REPLACE FORCE VIEW ETATFACTUREMONTANTDATY AS
   SELECT et.id,
          et.daty,
          et.idfournisseur,
          et.nomfournisseur,
          et.idtva,
          et.remarque,
          et.dateemission,
          et.designation,
          et.iddevise,
          et.numfact,
          et.datyecheance,
          CASE
             WHEN et.etat = 'VALIDE(E)' THEN '11'
             WHEN et.etat = 'CREE(E)' THEN '1'
             ELSE '0'
          END
             AS etat,
          NVL (et.montantpaye, 0) AS montantpaye,
          RESTE AS reste,
          et.entite,
          et.montantttdevise,
          et.budget,
          et.retenue,
          et.NUMID,
          t.NOM AS tierslib,
          et.IDTVA AS tva,
          et.montantht + et.montantadditifht - et.montantavoirht AS montant,
          (et.montantavoir),
          (et.montantadditif),
          (et.montantnet),
          et.montanttva + et.montantadditiftva - et.montantavoirtva
             AS montanttva,
          et.montantttc ,
          reste AS montantTotalApayer,
          ff.TYPE
     FROM etatfacturemontantdatyretenu et
          JOIN facturefournisseur_SumMtt ff ON ff.id = et.id
          LEFT JOIN TIERS t ON t.id = et.idfournisseur;
-----------------------------------------------------------------------
   CREATE OR REPLACE FORCE VIEW FACTUREFOURNISSEUR_SUMMTTGRP AS
     SELECT fct.idtva, SUM (fct.montantttc) AS montant, fct.remarque
       FROM etatfacturemontantdaty fct
     WHERE etat>=11
   GROUP BY fct.remarque, fct.idtva;
   -------------------------------------------------------------------
			 
	CREATE OR REPLACE FORCE VIEW LIASIONINTRATABLE_FACTURE AS
   SELECT ff.remarque as IDBL,
          ff.id as IDFACTURE,
          ff.montant as MONTANTHT,
          ff.MONTANTTVA,
          ff.MONTANTTTC,
          NVL (p.MONTANT, 0) AS montantpayer,
          ff.montantttc - NVL (p.MONTANT, 0) AS reste
     FROM ORDONNERPAYEMENTGROUPEFACT P
          RIGHT JOIN etatfacturemontantdaty FF
             ON FF.id = P.DED_ID ;
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
