CREATE OR REPLACE FORCE VIEW AVOIRFC_MONTANTLIBETAT
(
   ID,
   CODE,
   DATY,
   IDFACTURE,
   ETAT,
   MONTANT,
   TIERS,
   TIERSLIB,
   MONTANTPAYE,
   MONTANTRESTE,
   ETATLIB
)
AS
   SELECT op."ID",
		  op."CODE",
          op."DATY",
          op."IDFACTURE",
          op."ETAT",
          cast(op."MONTANT" as number(30,3)) as MONTANT,
          op."TIERS",
          op."TIERSLIB",
          cast(op."MONTANTPAYE" as number(30,3)) as MONTANTPAYE,
          cast(op."MONTANTRESTE" as number(30,3)) as MONTANTRESTE,
          CASE
             WHEN op.etat = 0 THEN 'annule'
             WHEN op.etat = 1 THEN 'cree'
             WHEN op.etat = 11 THEN 'vise'
          END
             AS etatlib
     FROM AVOIRFC_MONTANT op;