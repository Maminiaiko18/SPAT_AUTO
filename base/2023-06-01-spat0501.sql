INSERT INTO MODEPAIEMENT
(ID, VAL, DESCE)
VALUES('pay6', 'traite', 'traite');

INSERT INTO CAISSE
(ID, VAL, DESCE, NUMERO, "TYPE")
VALUES('CAIS00000T00016', 'Traite', 'Banque', NULL , NULL);

create table Traite (
    id varchar(100) constraint traite_pk primary key,
    daty date,
    tiers varchar(100) constraint traite_tiers_fk references tiers(id) ,
    banque varchar(100) constraint traite_banque_fk references banque(id),
    dateEcheance date,
    reference varchar(100),
    etat number,
    montant number
);


create sequence seqtraite
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
      
      

CREATE OR REPLACE FUNCTION getseqtraite()
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqtraite.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 


create table Escompte (
    id varchar(100) constraint escompte_pk primary key,
    idtraite varchar(100) constraint escompte_traite_fk references traite(id),
    frais number,
    etat number
);


create sequence seqescompte
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
      
      

CREATE OR REPLACE FUNCTION getseqescompte()
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqescompte.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 


create table FcTraite (
    id varchar(100) constraint fctraite_pk primary key,
    idtraite varchar(100) constraint fctraite_traite_fk references traite(id),
    idfc varchar(500) constraint fctraite_fc_fk references factureclient(id),
    montant number,
    daty date,
    etat number
);


create sequence seqfctraite
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
      
      

CREATE OR REPLACE FUNCTION getseqfctraite()
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqfctraite.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 


create or replace view traite_lib as
	select 
	tr.id,
	tr.daty,
	ti.nom as tiers,
	ba.val as banque,
	tr.dateEcheance,
	tr.etat,
	tr.montant
	
	from traite tr
	left join tiers ti on tr.tiers = ti.id
	left join banque ba on tr.banque = ba.id ;



   -------------------------------------------------------------- fctraite_cplt
   
create or replace view fctraite_cplt as 
	select
	fct.*,
	tl.tiers,
	tl.banque,
	fc.designation as factureclientlib
	
	from fctraite fct 
	left join traite_lib tl on fct.idtraite = tl.id
	left join factureclient fc on fct.idfc = fc.id;

--------------------------------------------------------- escompte_lib


    create or replace view escompte_lib as 
	select
	esc.id,
	tr.tiers,
	tr.banque,
	esc.frais,
	esc.etat
	
	from escompte esc 
	left join traite_lib tr on esc.idtraite = tr.id;