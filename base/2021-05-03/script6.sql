DELETE FROM MENUDYNAMIQUE m WHERE ID_PERE = 'MEN00144';

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00001000', 'Prévision', 'fa fa-home', '#', 1, 3, 'MEN00144');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0000999', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=statistique/prevision-statistique-saisie.jsp', 1, 4, 'MEN00001000');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0000998', 'Liste prévision conteneur', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=statistique/prevision-statistique-liste.jsp', 2, 4, 'MEN00001000');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0000997', 'Liste prévision société', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=statistique/prevision-statistique-societe-liste.jsp', 3, 4, 'MEN00001000');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0000996', 'Statistiques', 'fa fa-home', '#', 2, 3, 'MEN00144');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0000993', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=statistique/statistique-saisie.jsp', 1, 4, 'MEN0000996');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0000995', 'Liste statistique conteneur', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=statistique/statistique-liste.jsp', 2, 4, 'MEN0000996');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0000994', 'Liste statistique société', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=statistique/statistique-societe-liste.jsp', 3, 4, 'MEN0000996');

