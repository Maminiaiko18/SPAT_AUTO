-- Auto-generated SQL script #202012151729
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND000001','Materiel naval','fa fa-cog',3,3,'MEN00740');
-- Auto-generated SQL script #202012151732
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND000002','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=capitainerie/materiel/materiel-naval-saisie.jsp',1,4,'MEND000001');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND000003','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=capitainerie/materiel/materiel-naval-liste.jsp',2,4,'MEND000001');
