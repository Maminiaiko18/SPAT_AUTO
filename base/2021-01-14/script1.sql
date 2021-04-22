ALTER TABLE ORDONNERPAYEMENT ADD iduser VARCHAR2(100) ;
update ORDONNERPAYEMENT set iduser='1060' where 1<2;
ALTER TABLE bon_provisoire ADD beneficiaire VARCHAR2(100) ;


create  or replace view BON_PROVISOIRE_RST as
select bp.*,
       bp.debit - bp.credit - nvl(rf.montant, 0) - nvl(rb.montant, 0) as reste
from bon_provisoire bp
         left join regulfacture_mtt_gp rf on rf.idbon = bp.id
         left join regulbpvise rb on bp.id = rb.idbon
/

create or replace view BON_PROVISOIRE_LIBCOMPLET as
SELECT bnp.*,
       c.VAL AS valcaisse,
       DESCE AS descecaisse
FROM bon_provisoire_rst bnp
         JOIN caisse c ON bnp.CAISSE = c.ID
/



create or replace view BON_PROVISOIRE_LIB as
select id,
       datesaisie,
       dateeffet,
       folio,
       valcaisse as caisse,
       numpiece,
       libelle,
       debit,
       credit,
       remarque,
       etat
from bon_provisoire_libcomplet
/

create or replace view BON_PROVISOIRE_LIB_CREE as
select *
from bon_provisoire_libcomplet
where etat = 1
/


create or replace view BON_PROVISOIRE_LIB_VALIDE as
select *
from bon_provisoire_libcomplet
where etat = 11
/

create or replace view BON_PROVISOIRE_LIB_REGULARISE as
select *
from bon_provisoire_libcomplet
where etat = 12
/

