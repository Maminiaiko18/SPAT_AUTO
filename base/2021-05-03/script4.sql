
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM01', 'Configuration', 'fa fa-cog', '#', 4, 2, 'MEN0002');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM02', 'Type mesure', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp'||'&'||'ciblename=typemesure', 1, 3, 'MENM01');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM03', 'Type marchandise', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp'||'&'||'ciblename=typemarchandise', 2, 3, 'MENM01');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM04', 'Type manipulation', 'fa fa-file', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp'||'&'||'ciblename=typemanipulation', 3, 3, 'MENM01');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM05', 'Soci?t?', 'fa fa-home', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp'||'&'||'ciblename=nomsociete', 4, 3, 'MENM01');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENM06', 'Type Action conteneur', 'fa fa-check-square-o', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp'||'&'||'ciblename=typeactionconteneur', 5, 3, 'MENM01');


DELETE FROM MENUDYNAMIQUE WHERE ID='MEN0065';
