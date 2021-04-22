update menudynamique set href='#' where id='MEN0025';

/*insert into menudynamique values('MEN0034','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/cloture-liste.jsp','1','4','MEN0025');*/
insert into menudynamique values('MEN0035','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/cloture-saisie.jsp','2','4','MEN0025');

insert into menudynamique values('MEN0036','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/cloture-billetage-saisie.jsp','2','4','MEN0022');

insert into menudynamique values('MEN0037','test','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/cloture-billetage-saisie.jsp','8','1',null);

delete from menudynamique where id='MEN0033';
delete from menudynamique where id='MEN0037';

insert into menudynamique values('MEN0037','test','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/cloture-billetage-saisie.jsp','3','4','MEN0025');

delete from menudynamique where id='MEN0037';

insert into menudynamique values('MEN0037','Analyse quais','fa fa-line-chart','/spat/pages/globalnegoce.jsp?but=capitainerie/analyse-mouvement.jsp','5','2','MEN0007');
