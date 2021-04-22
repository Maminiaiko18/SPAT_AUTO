
insert into menudynamique values('MEN0001','Navire','fa fa-ship','#','1','1',null);
insert into menudynamique values('MEN0002','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=capitainerie/navire-liste.jsp','1','2','MEN0001');
insert into menudynamique values('MEN0003','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=capitainerie/navire/navire-saisie.jsp','2','2','MEN0001');
insert into menudynamique values('MEN0004','Poste destinataire','fa fa-map-marker','#','2','1',null);
insert into menudynamique values('MEN0005','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=capitainerie/postedestinataire-liste.jsp','1','2','MEN0004');
insert into menudynamique values('MEN0006','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=capitainerie/poste/postedestinataire-saisie.jsp','2','2','MEN0004');
insert into menudynamique values('MEN0007','Mouvements','fa fa-location-arrow','#','3','1',null);
insert into menudynamique values('MEN0008','Saisie départ','fa fa-plus','/spat/pages/globalnegoce.jsp?but=capitainerie/mouvementDepart-saisie.jsp','1','2','MEN0007');
insert into menudynamique values('MEN0009','Saisie arrivée','fa fa-plus','/spat/pages/globalnegoce.jsp?but=capitainerie/mouvementArrivee-saisie.jsp','2','2','MEN0007');
insert into menudynamique values('MEN0010','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=capitainerie/mouvement-liste.jsp','3','2','MEN0007');
insert into menudynamique values('MEN0011','Visa','fa fa-check-square','/spat/pages/globalnegoce.jsp?but=capitainerie/mouvement-visa.jsp','4','2','MEN0007');
insert into menudynamique values('MEN0012','Trésorerie','fa fa-money','#','4','1',null);
insert into menudynamique values('MEN0013','Billetage','fa fa-money','#','1','2','MEN0012');
insert into menudynamique values('MEN0014','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/billetage-liste.jsp','1','3','MEN0013');
insert into menudynamique values('MEN0015','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/billetage-saisie.jsp','2','3','MEN0013');
insert into menudynamique values('MEN0019','Journal caisse','fa fa-history','#','2','2','MEN0012');
insert into menudynamique values('MEN0020','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/journalcaisse-liste.jsp','1','3','MEN0019');
insert into menudynamique values('MEN0021','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/journalcaisse-saisie.jsp','2','3','MEN0019');
insert into menudynamique values('MEN0022','Cloture','fa fa-lock','#','3','3','MEN0013');
insert into menudynamique values('MEN0023','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/cloturer-billetage-liste.jsp','1','4','MEN0022');
insert into menudynamique values('MEN0025','Cloture','fa fa-lock','#','4','3','MEN0019');
insert into menudynamique values('MEN0026','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/cloture-liste.jsp','1','4','MEN0025');
insert into menudynamique values('MEN0027','Test','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/cloture-liste.jsp','6','1',null);



insert into usermenu(id,refuser,idmenu,idrole) values('USRM001','1060','MEN0001','dg');
insert into usermenu(id,refuser,idmenu,idrole) values('USRM002','1060','MEN0004','dg');
insert into usermenu(id,refuser,idmenu,idrole) values('USRM003','1060','MEN0007','dg');
insert into usermenu(id,refuser,idmenu,idrole) values('USRM004','1060','MEN0012','dg');
insert into usermenu(id,refuser,idmenu,idrole) values('USRM005','1060','MEN0016','dg');

insert into menudynamique values('MEN0028','Analyse facturation','fa fa-bar-chart','#','6','1',null);
insert into menudynamique values('MEN0029','Analyse concessionnaire','fa fa-line-chart','/spat/pages/globalnegoce.jsp?but=facturation/analyse-concessionnaire.jsp','1','2','MEN0028');
insert into menudynamique values('MEN0030','Analyse conventionnel','fa fa-pie-chart','/spat/pages/globalnegoce.jsp?but=facturation/analyse-conventionnel.jsp','2','2','MEN0028');

insert into usermenu(id,refuser,idmenu,idrole) values('USRM006','1060','MEN0028','dg');

delete from menudynamique where id='MEN0027';

insert into menudynamique values('MEN0031','Test','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/cloture-liste.jsp','7','1',null);

delete from menudynamique where id='MEN0031';

insert into menudynamique values('MEN0032','Analyse globale','fa fa-area-chart','/spat/pages/globalnegoce.jsp?but=facturation/analyse-globale.jsp','3','2','MEN0028');

insert into menudynamique values('MEN0033','Test','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/cloture-liste.jsp','7','1',null);

update menudynamique set href='/spat/pages/globalnegoce.jsp?but=treso/cloture-liste.jsp' where id='MEN0025';