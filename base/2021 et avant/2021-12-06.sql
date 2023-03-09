INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA1', 'Capitainerie', 'fa fa-ship', '#', 1, 1, NULL);

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA11', 'Tableau de bord', 'fa fa-tachometer', '#', 1, 2, 'MENUDSIA1');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA111', 'Tableau d''affichage', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=capitainerie/tableau-affichage-synthetise.jsp', 1, 3, 'MENUDSIA11');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA112', 'Tonnage marchandise', 'fa fa-balance-scale', '/spat/pages/globalnegoce.jsp?but=capitainerie/quais/marchandise-analyse.jsp', 2, 3, 'MENUDSIA11');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA113', 'Touchée de navire', 'fa fa-ship', '/spat/pages/globalnegoce.jsp?but=capitainerie/analyse-mouvement.jsp', 3, 3, 'MENUDSIA11');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA12', 'Détails', 'fa fa-ship', '#', 2, 2, 'MENUDSIA1');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA121', 'Gestion des quais', 'fa fa-ship', '#', 1, 3, 'MENUDSIA12');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA1211', 'Prévision', 'fa fa-ship', '/spat/pages/globalnegoce.jsp?but=capitainerie/quais/quais-prevision-liste-resume.jsp', 1, 4, 'MENUDSIA121');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA1212', 'Occupation', 'fa fa-ship', '/spat/pages/globalnegoce.jsp?but=capitainerie/mouvement-liste-resume.jsp', 2, 4, 'MENUDSIA121');


INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA122', 'Gestion des prestations', 'fa fa-ship', '#', 2, 3, 'MENUDSIA12');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA1221', 'Prestations', 'fa fa-ship', '/spat/pages/globalnegoce.jsp?but=capitainerie/occupationMaterielNaval-liste-resume.jsp', 1, 4, 'MENUDSIA122');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA1222', 'Analyse', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=capitainerie/analyse-occupationmaterielnaval.jsp', 2, 4, 'MENUDSIA122');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA1223', 'Tableau d''affichage détaillé', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=capitainerie/tableau-affichage.jsp', 3, 4, 'MENUDSIA122');




INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA2', 'Exploitants', 'fa fa-plus', '#', 2, 1, NULL);

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA21', 'Tableau de bord', 'fa fa-tachometer', '#', 1, 2, 'MENUDSIA2');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA211', 'Analyse croisée TC', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=exploitants/activites-analyse-tc-resume.jsp', 1, 3, 'MENUDSIA21');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA212', 'Analyse TC', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=exploitants/activite-analyse-simple-resume.jsp', 2, 3, 'MENUDSIA21');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA22', 'Détails ', 'fa fa-ship', '#', 2, 2, 'MENUDSIA2');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA221', 'Activités ', 'fa fa-pie-chart', '/spat/pages/globalnegoce.jsp?but=exploitants/activites-liste-resume.jsp', 1, 3, 'MENUDSIA22');




INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA3', 'Finance', 'fa fa-money', '#', 3, 1, NULL);

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA31', 'Trésorerie', 'fa fa-money', '#', 1, 2, 'MENUDSIA3');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA311', 'Situation des comptes courants', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=caisse/situation-comptes.jsp', 1, 3, 'MENUDSIA31');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA312', 'Placement', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=placement/analyse-placement.jsp&colGroupe1=valentite&colGroupe2=valbanque', 2, 3, 'MENUDSIA31');


INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA32', 'Facturation', 'fa fa-money', '#', 2, 2, 'MENUDSIA3');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA321', 'Analyse simple', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=facture/factureclient-analyse.jsp', 1, 3, 'MENUDSIA32');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA322', 'Analyse croisée', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=facture/analyse-facture-client-vaovao.jsp', 2, 3, 'MENUDSIA32');


INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA33', 'Engagement', 'fa fa-check-square', '#', 3, 2, 'MENUDSIA3');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA331', 'Bon de commande', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=stock/bc/bondecommande-analyse.jsp', 1, 3, 'MENUDSIA33');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA332', 'Facture fournisseur', 'fa fa-money', '#', 2, 3, 'MENUDSIA33');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA3321', 'Analyse simple', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=facture/facture-fournisseur-analyse.jsp', 1, 4, 'MENUDSIA332');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA3322', 'Analyse croisée', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=facture/analyse-facture-fournisseur-vaovao.jsp', 2, 4, 'MENUDSIA332');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA333', 'BED', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=ded/bordereauxFF-analyse.jsp', 3, 3, 'MENUDSIA33');


INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA34', 'Etats Financiers', 'fa fa-area-chart', '#', 4, 2, 'MENUDSIA3');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA341', 'Bilan', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=compta/compta-bilan-actif-passif.jsp', 1, 3, 'MENUDSIA34');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA342', 'Compte de résultat', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=compta/compta-bilan-produits-charges.jsp', 2, 3, 'MENUDSIA34');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA343', 'Écritures', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=compta/analyse-ecriture.jsp', 3, 3, 'MENUDSIA34');



INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA35', 'Budget', 'fa fa-line-chart', '#', 5, 2, 'MENUDSIA3');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA351', 'Recette', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=ligneCredit/situation-ligneCreditRecette.jsp', 1, 3, 'MENUDSIA35');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENUDSIA352', 'Dépenses ', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=ligneCredit/situation-ligneCreditDepense.jsp', 2, 3, 'MENUDSIA35');




INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMDSIA1', NULL, 'MENUDSIA1', 'ROL001301', NULL, NULL, 0);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMDSIA2', NULL, 'MENUDSIA2', 'ROL001301', NULL, NULL, 0);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMDSIA3', NULL, 'MENUDSIA3', 'ROL001301', NULL, NULL, 0);