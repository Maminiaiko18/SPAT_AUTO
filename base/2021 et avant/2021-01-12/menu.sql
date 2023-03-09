INSERT
	INTO
	MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MENU0167', 'Type navire', 'fa fa-ship', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=typenavire', 10, 4, 'MEN0046');

INSERT
	INTO
	MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MEN000160', 'Etat de caisse global', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=treso/etat-caisse-global.jsp', 7, 4, 'MEN00153');

UPDATE
	MENUDYNAMIQUE x
SET
	x.HREF = '/spat/pages/globalnegoce.jsp?but=placement/liaison-placement-liste.jsp'
WHERE
	x.ID = 'MEN00164';

UPDATE
	MENUDYNAMIQUE x
SET
	x.HREF = '/spat/pages/globalnegoce.jsp?but=placement/liaison-placement-saisie.jsp'
WHERE
	x.ID = 'MEN00165';

INSERT
	INTO
	MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MEN10163', 'Situation des comptes courants', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=caisse/situation-comptes.jsp', 8, 3, 'MEN0021');