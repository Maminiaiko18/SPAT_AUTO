UPDATE MENUDYNAMIQUE
SET LIBELLE='Liste bordereaux OP'
WHERE ID='MEND00002009';

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEND00002010', 'Liste bordereaux facture', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=ded/bordereauxFF-liste.jsp', 9, 3, 'MEN00211');