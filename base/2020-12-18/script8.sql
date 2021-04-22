CREATE OR REPLACE
FORCE VIEW PREVISIONFICHE AS
SELECT
	id ,
	nomnavire ,
	valconsignataire ,
	valcargaison ,
	valpilote ,
	valquaisprovenance ,
	valpaysprovenance ,
	valquaisdestination ,
	valpaysdestination ,
	date_arrivee ,
	heure_arrivee ,
	date_depart ,
	heure_depart ,
	etat
FROM
	previsionLibComplet;

-- Auto-generated SQL script #202012180920
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND0000003','Unité ','fa fa-money','/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=unitechantier',2,3,'MEN00505');


UPDATE MENUDYNAMIQUE x
	SET x.HREF='/spat/pages/globalnegoce.jsp?but=facture/facture-fournisseur-saisie-multiple.jsp&type=TFF0001'
	WHERE x.ID='MEN00500S';
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND0000004','Type avoir ','fa fa-money','/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=typeavoir',3,3,'MEN00505');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND0000005','Type additif ','fa fa-money','/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=typeadditif',4,3,'MEN00505');
