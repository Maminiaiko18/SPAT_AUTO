--------------------09-01-2022---------------------------------------------
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,RANG,NIVEAU,ID_PERE)
	VALUES ('MENLA001','Escompte','fa fa-list-alt',17,3,'MEN00068');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MENLA002','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=facture/escompte-saisie.jsp',1,4,'MENLA001');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MENLA003','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=facture/escompte-liste.jsp',2,4,'MENLA001');
	INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MDO0000056', 'Traite', 'fa fa-list-alt', '#', 16, 3, 'MEN00068');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN000690', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=facture/traite-saisie.jsp', 1, 4, 'MDO0000056');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN000691', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=facture/traite-liste.jsp', 2, 4, 'MDO0000056');

	
CREATE VIEW TRAITE_LIBV as 
select * from TRAITE_LIB where etat = 11;

CREATE VIEW TRAITE_LIBC AS
SELECT *  from TRAITE_LIB where etat = 1;


ALTER TABLE FCTRAITE 
ADD  idjc varchar(100) CONSTRAINT FCTRAITEjournalcaisse_fk references journalcaisse(id);

CREATE VIEW TRAITE_LIBESC AS
select * from TRAITE_LIB where id in (select idtraite from escompte where etat = 11);


-----------------------------------10-01-2022-----------------------------
create or replace view caissetraite as 
select * from caisse where id = 'CAIS00000T00016';

create or replace view modetraite as
select * from modepaiement where id='pay6';

alter table mvtintracaisse 
add idtraite varchar(100) constraint mvtintracaisse_traite_fk references Traite(id);

CREATE OR REPLACE VIEW TRAITE_LIBVER
AS select * from traite_lib where id in (select idtraite from mvtintracaisse);


CREATE TABLE FCDEFPR( 
id  varchar(100) CONSTRAINT 	FCDEFPR_pk PRIMARY KEY,
id1 varchar(100) CONSTRAINT 	FCDEFPR_factclient_fk REFERENCES factureclient(id),
id2 varchar(100) CONSTRAINT  	FCDEFPR_prevision_fk REFERENCES prevision(id)
);


CREATE SEQUENCE   seqFCDEFPR
 	INCREMENT  BY  1 
    MINVALUE 1 
    MAXVALUE 999999999999999
    START  WITH  1  
    CACHE 20  ;
    
   
CREATE OR REPLACE FUNCTION getseqFCDEFPR    		
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqFCDEFPR.nextval INTO retour FROM dual;
  return retour;	
END;  


