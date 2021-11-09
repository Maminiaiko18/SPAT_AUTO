
  CREATE OR REPLACE VIEW ORDONNERPAYEMENT_PDF (ID, DED_ID, IDLIGNE, DATY, MONTANT, REMARQUE, ETAT,
      NUMEROOP, DESTINATION, MODEPAIEMENT, BENEFICIAIRE, ADRESSE, DEVISE, NUMFACT,DESTINATIONlib) AS
  select op.ID,
       op.DED_ID,
       op.IDLIGNE,
       op.DATY,
       op.MONTANT,
       op.REMARQUE,
       op.ETAT,
       op.NUMEROOP,
       op.DESTINATION,
       op.MODEPAIEMENT,
       op.TIERS               as beneficiaire,
       op.adresse,
       nvl(ff.IDDEVISE, 'Ar') as devise,
       f.NUMFACT,
        de.VAL as DESTINATIONlib
from ordonnerpayement_lib op
         left join LIAISONINTRATABLE_OP_PARFACT_f f on f.DED_ID = op.DED_ID
         left join etatfacturemontantdaty ff on ff.id = op.DED_ID
         left join DESTINATION de on de.id = op.DESTINATION
where op.ETAT >= 11
group by op.ID, op.DED_ID, op.IDLIGNE, op.DATY, op.MONTANT, op.REMARQUE, op.ETAT, op.NUMEROOP,
         op.DESTINATION, op.MODEPAIEMENT, op.TIERS, op.adresse, nvl(ff.IDDEVISE, 'Ar'), f.NUMFACT,de.VAL;
		 
CREATE OR REPLACE VIEW ETATBPVRAI (ID, MONTANTFACTURE, MONTANTPROVISION, MONTANTPAYE, ECART, TIERS, TIERSLIB, DATY, TIERSPROVISION, TIERSLIBPROVISION, MONTANTRESTE, IDPROVISION) AS 
  SELECT fu.id,
            CAST(SUM (NVL (FCUV.MONTANTTTC, 0)) AS number(33,3)) AS montantfacture,
            CAST(SUM (fu.MONTANTTTC) AS number(33,3)) AS montantprovision,
            CAST(SUM (fu.MONTANTPAYE) AS number(33,3)) AS MONTANTPAYE,
            CAST(SUM (fu.MONTANTPAYE) - SUM (NVL (FCUV.MONTANTTTC, 0)) AS number(33,3)) AS ecart, --RAP
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            CAST(SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0) AS number(33,3))
               AS MONTANTRESTE,
            ''
       FROM factfourn_msum_lib fu
            LEFT JOIN FACTURE_fourn_VISE_gp FCUV ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib		
;