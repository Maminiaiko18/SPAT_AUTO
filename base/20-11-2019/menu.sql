truncate table menudynamique;
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0001','Capitainerie','fa fa-ship','#','1','1',null);
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0002','Concessionnaires','fa fa-plus','#','2','1',null);
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0003','Gestion des patrimoines','fa fa-list','#','3','1',null);
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0004','Ressources Humaines','fa fa-pie-chart','#','4','1',null);
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0005','Travaux','fa fa-list','#','5','1',null);
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0006','Finance','fa fa-money','#','6','1',null);

insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0007','Gestion des quais','fa fa-ship','#','1','2','MEN0001');

insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0008','Navire','fa fa-ship','#','4','3','MEN0007');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0009','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=capitainerie/navire-liste.jsp','1','4','MEN0008');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0010','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=capitainerie/navire/navire-saisie.jsp','2','4','MEN0008');

insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0011','Poste destinataire','fa fa-map-marker','#','2','3','MEN0007');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0012','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=capitainerie/postedestinataire-liste.jsp','2','4','MEN0011');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0013','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=capitainerie/poste/postedestinataire-saisie.jsp','3','4','MEN0011');

insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0014','Mouvements','fa fa-location-arrow','#','3','3','MEN0007');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0016','Saisie arrivée','fa fa-plus','/spat/pages/globalnegoce.jsp?but=capitainerie/mouvementArrivee-saisie.jsp','2','4','MEN0014');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0017','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=capitainerie/mouvement-liste.jsp','3','4','MEN0014');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0018','Visa','fa fa-check-square','/spat/pages/globalnegoce.jsp?but=capitainerie/mouvement-visa.jsp','4','4','MEN0014');

insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0019','Gestion des matériels navals','fa fa-ship','#','2','2','MEN0001');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0020','Statistiques/Prévisions','fa fa-line-chart','/spat/pages/globalnegoce.jsp?but=capitainerie/analyse-mouvement.jsp','3','2','MEN0001');

insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0021','Trésorerie','fa fa-money','#','1','2','MEN0006');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0022','Billetage','fa fa-money','#','1','3','MEN0021');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0023','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/billetage-liste.jsp','1','4','MEN0022');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0024','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/billetage-saisie.jsp','2','4','MEN0022');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0028','Cloture','fa fa-lock','#','3','4','MEN0022');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0029','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/cloturer-billetage-liste.jsp','1','5','MEN0028');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0030','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/cloture-billetage-saisie.jsp','2','5','MEN0028');

--insert into menudynamique values('MEN0040','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/cloturer-billetage-liste.jsp','3','5','MEN0028');

insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0031','Journal caisse','fa fa-history','#','2','3','MEN0021');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0032','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/journalcaisse-liste.jsp','1','4','MEN0031');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0033','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/journalcaisse-saisie.jsp','2','4','MEN0031');


insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0034','Cloture','fa fa-lock','#','4','4','MEN0031');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0035','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/cloture-liste.jsp','3','5','MEN0034');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0036','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/cloture-saisie.jsp','2','5','MEN0034');

insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0037','Etats','fa fa-money','#','2','2','MEN0006');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0038','Analyse concessionnaire','fa fa-line-chart','/spat/pages/globalnegoce.jsp?but=facturation/analyse-concessionnaire.jsp','1','2','MEN0037');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0039','Analyse conventionnel','fa fa-pie-chart','/spat/pages/globalnegoce.jsp?but=facturation/analyse-conventionnel.jsp','2','2','MEN0037');


insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0041','Etats financiers','fa fa-money','#','3','2','MEN0006');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0042','Analyse concessionnaire','fa fa-line-chart','/spat/pages/globalnegoce.jsp?but=facturation/analyse-concessionnaire.jsp','1','3','MEN0041');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0043','Analyse conventionnel','fa fa-pie-chart','/spat/pages/globalnegoce.jsp?but=facturation/analyse-conventionnel.jsp','2','3','MEN0041');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0044','Analyse globale','fa fa-area-chart','/spat/pages/globalnegoce.jsp?but=facturation/analyse-globale.jsp','3','3','MEN0041');

insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0045','Etat de caisse','fa fa-money','/spat/pages/globalnegoce.jsp?but=facturation/analyse-globale.jsp','3','3','MEN0021');

insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0046','Configuration','fa fa-history','#','3','3','MEN0007');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0047','Quais','fa fa-ship','/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=quais','1','4','MEN0046');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0048','Consignataire','fa fa-check-square','/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=consignataire','2','4','MEN0046');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0049','Pays','fa fa-list','/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=pays','3','4','MEN0046');


--insert into menudynamique values('MEN0050','ListePost2','fa fa-list','/spat/pages/globalnegoce.jsp?but=capitainerie/postedestinataire-liste.jsp','1','4','MEN0011');

insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0051','Compta','fa fa-area-chart','#','4','2','MEN0006');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0052','Generer Etat','fa fa-plus','/spat/pages/globalnegoce.jsp?but=compta/balance-filtre.jsp','2','3','MEN0051');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0053','Analyse Ecriture','fa fa-line-chart','spat/pages/globalnegoce.jsp?but=compta/analyse-ecriture.jsp','3','3','MEN0051');

insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0054','Depense','fa fa-history','#','5','2','MEN0006');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0055','Fonctionnement','fa fa-list','#','1','3','MEN0054');
insert into menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) values('MEN0056','Engagement','fa fa-lock','/spat/pages/globalnegoce.jsp?but=facturation/analyse-bon-commande.jsp','2','4','MEN0055');

INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0057', 'Prevision quai', 'fa fa-plus', '#', '5', '3', 'MEN0007')
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0058', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=capitainerie/quais/quais-prevision-liste.jsp', '1', '4', 'MEN0057')
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0059', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=capitainerie/saisie-prevision.jsp', '2', '4', 'MEN0057')
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0060', 'Occupation', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=capitainerie/mouvement-liste.jsp', '6', '3', 'MEN0007')
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0061', 'Prevision','fa fa-line-chart','#', '1', '3', 'MEN0019')
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0062', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=capitainerie/previsionMaterielNaval-saisie.jsp', '1', '4', 'MEN0061')
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0063', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=capitainerie/previsionMaterielNaval-liste.jsp', '2', '4', 'MEN0061')
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0064', 'Occupation','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=capitainerie/occupationMaterielNaval-saisie.jsp', '2', '3', 'MEN0019')

INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0065', 'saisie','fa fa-plus', '/spat/pages/globalnegoce.jsp?but=capitainerie/occupationMaterielNaval-saisie.jsp', '1', '2', 'MEN0002')

update menudynamique set LIBELLE='Factures' where id='MEN0041';