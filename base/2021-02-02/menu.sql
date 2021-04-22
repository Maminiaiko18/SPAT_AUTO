
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) VALUES ('MEND00002100','Facture client','fa fa-user',NULL,8,2,'MEN0006');

INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) VALUES ('MEND00002101','Analyse facture-client','fa fa-circle-o','/spat/pages/globalnegoce.jsp?but=factureamadia/paiement/analyse-factureclient.jsp',8,3,'MEND00002100');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) VALUES ('MEND00002102','Liste des factures clients','fa fa-list','/spat/pages/globalnegoce.jsp?but=factureamadia/client/facture-client-liste.jsp',1,3,'MEND00002100');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) VALUES ('MEND00002103','Saisie des factures clients','fa fa-plus','/spat/pages/globalnegoce.jsp?but=factureamadia/client/facture-client-saisie-multiple.jsp',2,3,'MEND00002100');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) VALUES ('MEND00002104','Detail facture client liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=factureamadia/client/details-facture-client-liste.jsp',9,3,'MEND00002100');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) VALUES ('MEND00002105','Analyse des factures clients 2','fa fa-plus','/spat/pages/globalnegoce.jsp?but=factureamadia/client/analyse-facture-client.jsp',4,3,'MEND00002100');

INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEN002156E','Cours devise','fa fa-money','/spat/pages/globalnegoce.jsp?but=fin/coursdevise-saisie.jsp',8,3,'MEN00505');
