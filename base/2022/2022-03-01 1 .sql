CREATE OR REPLACE FORCE VIEW LIGNECREDITDEPENSEGRP
(
   IDPROJET,
   IDCODEETABLISSEMENT,
   MONTANT,
   FACTURE,
   PAYE,
   ARECOUVRIR,
   RESTEBUDGET
)
AS
     SELECT idprojet,
            idcodeEtablissement,
            CAST(SUM (montant) as number(30,3)) AS montant,
            cast(SUM (facture) as number(30,3)) AS facture,
            cast(SUM (paye) as number(30,3)) AS paye,
            cast(SUM (arecouvrir) as number(30,3)) AS arecouvrir,
            cast(SUM (restebudget)as number(30,3)) AS restebudget
       FROM SITUATIONLCDEPENSEVSD
   GROUP BY idcodeEtablissement, idprojet;