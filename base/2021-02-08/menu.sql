INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEN002157F','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=fin/coursdevise-saisie.jsp',1,4,'MEN002156E');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEN002157G','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=fin/coursdevise-liste.jsp',2,4,'MEN002156E');
UPDATE MENUDYNAMIQUE x
	SET x.HREF=''
	WHERE x.ID='MEN002156E';
