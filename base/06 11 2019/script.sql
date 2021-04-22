    CREATE SEQUENCE  SEQ_CAISSE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
   
   create or replace FUNCTION getseqcaisse
	  RETURN NUMBER IS
	  retour NUMBER;
	BEGIN
	  SELECT SEQ_CAISSE.nextval INTO retour FROM dual;
	  return retour;
	END;
	
	CREATE SEQUENCE  SEQ_JCAISSE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
   
   create or replace FUNCTION getseqjcaisse
	  RETURN NUMBER IS
	  retour NUMBER;
	BEGIN
	  SELECT SEQ_JCAISSE.nextval INTO retour FROM dual;
	  return retour;
	END;
	
	create table caisse(
		id varchar(50) primary key,
		val varchar(150),
		desce varchar(150)
	);
	
	create table JournalCaisse(
		id varchar(50) primary key,
		dateSaisie date,
		dateEffet date,
		folio varchar(50),
		caisse varchar(50),
		numPiece varchar(50),
		libelle varchar(200),
		debit number(20,2),
		credit number(20,2),
		remarque varchar(100),
		foreign key(caisse) references caisse(id)
	);
	
	insert into caisse values('CAISS001','Caisse physique','Caisse physique');
	insert into caisse values('CAISS002','Banque','Banque');
	
	create table cloturer(
		id varchar(50) primary key,
		daty date,
		caisse varchar(50),
		solde number(20,2),
		remarque varchar(50),
		foreign key(caisse) references caisse(id)
	);
	
	
		CREATE SEQUENCE  SEQ_CLOTURE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
   
   create or replace FUNCTION getseqcloture
	  RETURN NUMBER IS
	  retour NUMBER;
	BEGIN
	  SELECT SEQ_CLOTURE.nextval INTO retour FROM dual;
	  return retour;
	END;
	
	  create or replace view soldeCaisse as
	select dateEffet, caisse, sum(debit)-sum(credit) as solde from journalCaisse group by dateEffet,caisse;
	
	
	create or replace view cloturelib as
	select 
		c.id,
		c.daty,
		ca.val as caisse,
		c.solde,
		c.remarque
	from cloturer c
	join caisse ca
	on c.caisse=ca.id;
	
	
	CREATE SEQUENCE  SEQ_HISTOVALEUR  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
   
   create or replace FUNCTION getseqhistovaleur
	  RETURN NUMBER IS
	  retour NUMBER;
	BEGIN
	  SELECT SEQ_HISTOVALEUR.nextval INTO retour FROM dual;
	  return retour;
	END;
	

 
	
	
	