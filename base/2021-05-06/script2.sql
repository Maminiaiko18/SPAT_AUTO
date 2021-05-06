
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MENUM01', 'Bordereaux', 'fa fa-dashboard', '#', 5, 3, 'MEN00211');
UPDATE MENUDYNAMIQUE SET LIBELLE='Liste bordereaux OP', ICONE='fa fa-list', HREF='/spat/pages/globalnegoce.jsp?but=ded/bordereaux-liste.jsp', RANG=1, NIVEAU=4, ID_PERE='MENUM01' WHERE ID='MEND00002009';
UPDATE MENUDYNAMIQUE SET LIBELLE='Liste bordereaux facture', ICONE='fa fa-list', HREF='/spat/pages/globalnegoce.jsp?but=ded/bordereauxFF-liste.jsp', RANG=2, NIVEAU=4, ID_PERE='MENUM01' WHERE ID='MEND00002010';
