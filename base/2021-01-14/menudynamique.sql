UPDATE MENUDYNAMIQUE x
	SET x.HREF='/spat/pages/globalnegoce.jsp?but=treso/depense-liste.jsp'
	WHERE x.ID='MEN00172';

INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
VALUES ('MEND0020','Recette','fa fa-money','',9,3,'MEN0021');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
VALUES ('MEND0021','Factures client','fa fa-money','/spat/pages/globalnegoce.jsp?but=facture/factureclient-liste.jsp',1,4,'MEND0020');