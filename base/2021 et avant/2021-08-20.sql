alter table Journalcaisse add temp_debit Number(30,3);
alter table Journalcaisse add temp_credit Number(30,3);

update JOURNALCAISSE set temp_credit = credit, JOURNALCAISSE.temp_debit = debit where id = id;

update JOURNALCAISSE set credit = '', debit = '';

alter table Journalcaisse modify debit Number(30,3);
alter table Journalcaisse modify credit Number(30,3);

update JOURNALCAISSE set credit = temp_credit, debit = temp_debit where id = id;

alter table JOURNALCAISSE drop column temp_debit;
alter table JOURNALCAISSE drop column temp_credit;


alter view JOURNALBANQUELIB compile;
alter view JOURNALBANQUELIBCOMPLET compile;
alter view JOURNALCAISSEBANQUELIB compile;
alter view JOURNALCAISSEBANQUELIBCREE compile;
alter view JOURNALCAISSEBANQUELIBVALIDE compile;
alter view JOURNALCAISSEBANQUELIB_ANALYSE compile;
alter view JOURNALCAISSELIB compile;
alter view JOURNALCAISSELIBCOMPLET compile;
alter view JOURNALCAISSELIBMIV compile;
alter view JOURNALCAISSELIB_ANALYSE compile;
alter view JOURNALCAISSELIB_ANNULE compile;
alter view JOURNALCAISSELIB_CREE compile;
alter view JOURNALCAISSELIB_CREE_MIV compile;
alter view JOURNALCAISSELIB_VISE compile;
alter view JOURNALCAISSELIB_VISE_MIV compile;
alter view JOURNALCAISSELIB_VISE_SUM compile;
alter view JOURNALCAISSEOP compile;
alter view JOURNALCAISSE_ANALYSE compile;
alter view JOURNALCAISSE_BANQUE compile;
alter view JOURNALCAISSE_INFO compile;
alter view JOURNALCAISSE_LIB compile;
alter view JOURNALCAISSE_SOMMECREDIT compile;
alter view LIAISONINTRATABLE_OP_JOURNAL compile;

CREATE OR REPLACE VIEW FACTURE_CLIENT_UNIONC  AS 
  select *
from facture_client_union
where etat = 1;


CREATE OR REPLACE FORCE VIEW FACTURE_CLIENT_UNIONV as 
select * from facture_client_union
where etat = 11;


CREATE OR REPLACE FORCE VIEW FACTURECLIENTAPAYER AS 
SELECT * from facture_client_union
where MONTANTRESTE > 0;