
------create table PaiementOP
create table PaiementOP(
id varchar(100) CONSTRAINT paiementop_pk PRIMARY KEY,
idop varchar(100) CONSTRAINT paiementop_op_fk REFERENCES ORDONNERPAYEMENT(id),
idmvt varchar(100) CONSTRAINT paiementop_jc_fk REFERENCES journalcaisse(id),
montant Number(30,2)
);


--------seqPaiementOP
create sequence seqPaiementOP
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
     
-------getseqPaiementOP
  CREATE OR REPLACE FUNCTION getseqPaiementOP
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqPaiementOP.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;



CREATE OR REPLACE  VIEW MONTANT_TRAITE_FC (ID, IDTRAITE, MONTANTTRAITE) AS 
  select
	ID,IDTRAITE,
	sum(montant) AS montanttraite
	from TRAITE_FC 
	GROUP BY ID,IDTRAITE ;