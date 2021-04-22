
INSERT INTO  MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND00003000','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/transfert-caisse.jsp',1,3,'MEND00002002');
UPDATE  MENUDYNAMIQUE x
	SET x.HREF=''
	WHERE x.ID='MEND00002002';
INSERT INTO  MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND00003001','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/transfert-caisse-liste.jsp',2,3,'MEND00002002');
