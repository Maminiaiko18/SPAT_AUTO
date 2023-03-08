alter table regulfacture add etat number(10);

CREATE OR REPLACE FORCE VIEW REGULFACTURE_MTT_GP
AS
     SELECT rf.idbon, SUM (NVL (rf.montant, 0)) AS montant
       FROM regulfacture rf where rf.etat>=11
   GROUP BY rf.idbon;
   