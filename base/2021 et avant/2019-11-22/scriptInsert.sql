
update menudynamique set HREF='#' where id='MEN0047';
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0069', 'Liste','fa fa-list', '/spat/pages/globalnegoce.jsp?but=capitainerie/quais/quais-liste.jsp', '1', '5', 'MEN0047');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0070', 'Saisie','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=capitainerie/quais/quais-saisie.jsp', '2', '5', 'MEN0047');

INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0075', 'Liason Placement','fa fa-check-square', '#', '8', '4', 'MEN0046');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0076', 'Liste','fa fa-list', '/spat/pages/globalnegoce.jsp?but=placement/liaison-placement-liste.jsp', '1', '5', 'MEN0075');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0077', 'Saisie','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=placement/liaison-placement-saisie.jsp', '2', '5', 'MEN0075');
