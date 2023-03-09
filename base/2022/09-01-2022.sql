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
