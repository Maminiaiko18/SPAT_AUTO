INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND00002000','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=facture/facture-fournisseur-saisie-multiple.jsp'||'&'||'type=TFF0001',1,4,'MEN00500');
UPDATE MENUDYNAMIQUE x
	SET x.HREF='/spat/pages/globalnegoce.jsp?but=facture/facture-fournisseur-liste.jsp'||'&'||'type=TFF0001'
	WHERE x.ID='MEN00500L';

UPDATE MENUDYNAMIQUE x
	SET x.ID_PERE='MEN0021a'
	WHERE x.ID='MEND0020';

INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND00002001','Factures client','fa fa-list','/spat/pages/globalnegoce.jsp?but=facture/factureclient-liste.jsp',4,5,'MEN00174');


INSERT INTO MODEPAIEMENT (ID,VAL,DESCE)
	VALUES ('pay4','Effets &agrave; recevoir','Paiement par Effets');

INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND00002002','Transfert','fa fa-money','/spat/pages/globalnegoce.jsp?but=treso/transfert-caisse.jsp',7,2,'MEN0006');

INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND00002003','Facture Client','fa fa-list','/spat/pages/globalnegoce.jsp?but=facture/factureclient-liste.jsp',8,4,'MEN00153');

INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND00002004','Report','fa fa-check-square','#',4,4,'MEN00174P');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND00002005','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/report-liste.jsp',1,5,'MEND00002004');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND00002006','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/report-saisie.jsp',2,5,'MEND00002004');
