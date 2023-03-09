INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN000100', 'Pourcentage réalisation','fa fa-check-square', '#', '7', '2', 'MEN0005');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN000101', 'Liste pourcentage réalisation','fa fa-list', '/spat/pages/globalnegoce.jsp?but=travaux/pourcentage-realisation-liste.jsp', '1', '3', 'MEN000100');
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN000102', 'saisie pourcentage réalisation','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=travaux/pourcentage-realisation-saisie.jsp', '2', '3', 'MEN000100');



update menudynamique set RANG='1' where id='MEN000012';

update menudynamique set id='MEN01158' where id='MEN000012';

update menudynamique set RANG='2' where id='MEN01159';

update menudynamique set id='MEN01160' where id='MEN01159';

update menudynamique set RANG='7' where id='MEN0096';

update menudynamique set id='MEN000012' where id='MEN0096';
 
update menudynamique set ID_PERE='MEN000012' where ID_PERE='MEN0096';




  
  









update menudynamique set libelle='Etats financiers' where id='MEN0051';

