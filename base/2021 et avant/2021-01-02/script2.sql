alter table regulfacture add montant number(20,2);

create or replace view regulfacture_mtt_gp as
select 
    rf.idbon,
    sum(nvl(rf.montant,0)) as montant
from regulfacture rf
group by rf.idbon;

create or replace view regulbpvise as
select * from regulbp where etat>=11;

create or replace view bon_provisoire_rst as
select 
    bp.* ,
    bp.debit-bp.credit-nvl(rf.montant,0)-nvl(rb.montant,0) as reste
from bon_provisoire bp
left join regulfacture_mtt_gp rf on rf.idbon=bp.id
left join regulbpvise rb on bp.id=rb.idbon;

CREATE OR REPLACE FORCE VIEW BON_PROVISOIRE_LIBCOMPLET AS
   SELECT bnp."ID",
          bnp."DATESAISIE",
          bnp."DATEEFFET",
          bnp."FOLIO",
          bnp."CAISSE",
          bnp."NUMPIECE",
          bnp."LIBELLE",
          bnp."DEBIT",
          bnp."CREDIT",
          bnp."REMARQUE",
          bnp."ETAT",
          c.VAL AS valcaisse,
          DESCE AS descecaisse,
		  bnp.reste
     FROM bon_provisoire_rst bnp JOIN caisse c ON bnp.CAISSE = c.ID;