
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MD00000001', 'Configurations', 'fa fa-cog', '#', 8, 2, 'MEN0005');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MD00000002', 'Prestataire', 'fa fa-wrench', '#', 1, 3, 'MD00000001');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MD00000003', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=travaux/tiers-saisie.jsp&currentMenu=MEN00186#?currentMenu=MEN00181', 1, 4, 'MD00000002');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MD00000004', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=travaux/tiers-liste.jsp', 2, 4, 'MD00000002');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MD00000005', 'Elément Chantier', 'fa fa-wrench', '#', 2, 3, 'MD00000001');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MD00000006', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=travaux/element-chantier-saisie.jsp', 1, 4, 'MD00000005');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MD00000007', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=travaux/element-chantier-liste.jsp', 2, 4, 'MD00000005');



UPDATE MENUDYNAMIQUE t SET t.HREF = '/spat/pages/globalnegoce.jsp?but=accueil/concessionnaire-accueil.jsp' WHERE t.ID LIKE 'MEN0002' ;
UPDATE MENUDYNAMIQUE t SET t.ID_PERE = 'MEN0005a' WHERE t.ID LIKE 'MEN00181' ;

UPDATE MENUDYNAMIQUE t SET t.RANG = 1 WHERE t.ID LIKE 'MEN0093' ;
UPDATE MENUDYNAMIQUE t SET t.ID_PERE = 'MEN0004a' WHERE t.ID LIKE 'MENP093' ;

UPDATE MENUDYNAMIQUE t SET t.RANG = 3 WHERE t.ID LIKE 'MEN00193' ;
UPDATE MENUDYNAMIQUE t SET t.RANG = 2 WHERE t.ID LIKE 'MEN00208' ;
UPDATE MENUDYNAMIQUE t SET t.RANG = 4 WHERE t.ID LIKE 'MEN00200' ;

INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MD00000008', 'Engagement ', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=facture/analyse-facture-fournisseur.jsp', 8, 3, 'MEN0041');

