
	CREATE OR REPLACE FORCE VIEW soldebilletage AS 
	select 
		daty,
		caisse, 
		sum(montant) as montant 
	from billetage
	group by daty,caisse;
	
 
	
	CREATE SEQUENCE  SEQ_CLOTUREBILLET  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
   
   create or replace FUNCTION getseqclotureBillet
	  RETURN NUMBER IS
	  retour NUMBER;
	BEGIN
	  SELECT SEQ_CLOTUREBILLET.nextval INTO retour FROM dual;
	  return retour;
	END;
	
	
	