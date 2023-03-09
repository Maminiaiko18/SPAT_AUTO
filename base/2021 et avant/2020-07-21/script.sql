
drop view JOURNALCAISSELIBCOMPLET;


CREATE OR REPLACE  VIEW JOURNALCAISSELIBCOMPLET  AS 
   select
	j."ID",j."DATESAISIE",j."DATEEFFET",j."FOLIO",j."CAISSE",j."NUMPIECE",j."LIBELLE",j."DEBIT",j."CREDIT",j."REMARQUE",j."ETAT",j."TIERS",j."IDTYPECHEQUE",
	c.ID as idcaisse, c.val as valcaisse, c.desce as descecaisse,
	tc.val as valtypecheque, tc.desce as descetypecheque
from Journalcaisse j
	join CAISSE C on j.CAISSE = C.ID
	left join TYPECHEQUE tc on tc.id = j.idtypecheque;
	

create table regulBonProvisoire(
	id varchar(50) primary key,
	idBonProvisoire varchar(50),
	daty date,
	idUser number(10,0),
	remarque varchar(250),
	montant number(20,2),
	etat number(10,0),
	foreign key(idBonProvisoire) references bon_provisoire(id),
	foreign key(idUser) references utilisateur(refuser)
);


CREATE SEQUENCE  SEQ_regulbonprovisoire  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 166 NOCACHE  NOORDER  NOCYCLE ;
 
 create or replace FUNCTION getseq_regulBonProvisoire
	  RETURN NUMBER IS
	  retour NUMBER;
	BEGIN
	  SELECT SEQ_regulbonprovisoire.nextval INTO retour FROM dual;
	  return retour;
	END;
