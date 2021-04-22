update menudynamique set HREF='#' where id='MEN00192';

INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00202', 'Terrains','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=patrimoine/patrimoine-saisie.jsp' || '&' || 'idPat=TYPE000001', '1', '4', 'MEN00192');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00203', 'Matériels navals','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=patrimoine/patrimoine-saisie.jsp' || '&' || 'idPat=TYPE000004', '2', '4', 'MEN00192');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00204', 'Matériels roulants','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=patrimoine/patrimoine-saisie.jsp' || '&' || 'idPat=TYPE000005', '3', '4', 'MEN00192');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00205', 'Logements / Bâtiments','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=patrimoine/patrimoine-saisie.jsp' || '&' || 'idPat=TYPE000006', '4', '4', 'MEN00192');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00206', 'Patrimoine foncier','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=patrimoine/patrimoine-saisie.jsp' || '&' || 'idPat=TYPE000003', '5', '4', 'MEN00192');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00207', 'Magasins et Hangars','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=patrimoine/patrimoine-saisie.jsp' || '&' || 'idPat=TYPE000002', '6', '4', 'MEN00192');

INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00208', 'Details Patrimoines','fa fa-check-square', '#', '4', '2', 'MEN0003');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00209', 'Liste','fa fa-list', '/spat/pages/globalnegoce.jsp?but=patrimoine/detailspatrimoine-liste.jsp', '1', '3', 'MEN00208');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00210', 'Saisie','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=patrimoine/detailspatrimoine-saisie.jsp', '2', '3', 'MEN00208');

INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00211', 'Engagement','fa fa-check-square', '#', '5', '2', 'MEN0001');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00212', 'Bon Commande','fa fa-money', '#', '1', '3', 'MEN00211');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00213', 'Liste','fa fa-list', '/spat/pages/globalnegoce.jsp?but=capitainerie/bon-commande/bon-commande-liste.jsp', '1', '4', 'MEN00212');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00214', 'Saisie','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=capitainerie/bon-commande/bon-commande-saisie.jsp', '2', '4', 'MEN00212');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00215', 'Fournisseur','fa fa-money', '#', '2', '3', 'MEN00211');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00216', 'Liste','fa fa-list', '/spat/pages/globalnegoce.jsp?but=capitainerie/bon-commande/contrat-fournisseur-list.jsp', '1', '4', 'MEN00215');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00217', 'Saisie','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=capitainerie/bon-commande/contract-fournisseur-saisie.jsp', '2', '4', 'MEN00215');