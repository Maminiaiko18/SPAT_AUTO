INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM01', 'Configuration', 'fa fa-cog', '#', 1, 2, 'MEN0002');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM02', 'Type mesure', '', 'configuration/idvaldesce.jsp' || '&' || 'ciblename=typemesure', 1, 3, 'MENM01');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM03', 'Type marchandise', '', 'configuration/idvaldesce.jsp' || '&' || 'ciblename=typemarchandise', 2, 3, 'MENM01');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM04', 'Type manipulation', '', 'configuration/idvaldesce.jsp' || '&' || 'ciblename=typemanipulation', 3, 3, 'MENM01');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM05', 'Société', '', 'configuration/idvaldesce.jsp' || '&' || 'ciblename=nomsociete', 4, 3, 'MENM01');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM06', 'Type Action conteneur', '', 'configuration/idvaldesce.jsp' || '&' || 'ciblename=typeactionconteneur', 5, 3, 'MENM01');
