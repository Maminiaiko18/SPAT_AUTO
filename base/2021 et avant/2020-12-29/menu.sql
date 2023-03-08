-- Auto-generated SQL script #202012290928
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND0000100','Projet','fa fa-home',5,3,'MEN00505');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND0000101','Code établissement','fa fa-home','/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=CodeEtablissement',6,3,'MEN00505');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND0000102','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=budget/projet-saisie.jsp',1,4,'MEND0000100');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND0000103','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=budget/projet-liste.jsp',2,4,'MEND0000100');
-- Auto-generated SQL script #202012290935
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND0000104','Contrat','fa fa-home','',9,2,'MEN0005');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND0000105','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=travaux/contrat-saisie.jsp',1,3,'MEND0000104');
-- Auto-generated SQL script #202012291020
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND0000106','Analyse','fa fa-list','/spat/pages/globalnegoce.jsp?but=facture/analyse-facturefournisseur.jsp',3,4,'MEN00500');
