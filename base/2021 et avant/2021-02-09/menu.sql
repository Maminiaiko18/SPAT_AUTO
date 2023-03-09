INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND00112200','Produits','fa fa-home',9,3,'MEN00505');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND00112201','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=produit/produit-saisie.jsp',1,4,'MEND00112200');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND00112202','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=produit/produit-saisie.jsp',2,4,'MEND00112200');
UPDATE MENUDYNAMIQUE x
	SET x.HREF='/spat/pages/globalnegoce.jsp?but=produit/produit-liste.jsp'
	WHERE x.ID='MEND00112202';
