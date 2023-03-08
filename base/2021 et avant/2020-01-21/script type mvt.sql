update typemvt set val='Arriv'||'&'||'eacute;e en rade', desce='Arriv'||'&'||'eacute;e en rade' where id='TPMM00001';
insert into typemvt values('TPMM00004','Arriv'||'&'||'eacute;e à quais','Arriv'||'&'||'eacute;e en rade');


update menudynamique set href="#" where id = 'MEN0060';
insert into menudynamique values('MEN0089','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=capitainerie/mouvementArrivee-saisie.jsp','1','4','MEN0060');
insert into menudynamique values('MEN0090','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=capitainerie/mouvement-liste.jsp','2','4','MEN0060');

delete menudynamique where id = 'MEN00178';

alter table historiquesyndicat drop constraint FK_PERSONNELINF;

insert into menudynamique values('MEN0091','Analyse','fa fa-area-chart','/spat/pages/globalnegoce.jsp?but=rh/analyse-conge.jsp','3','3','MEN00129');
insert into menudynamique values('MEN0092','Analyse','fa fa-area-chart','/spat/pages/globalnegoce.jsp?but=rh/analyse-permission.jsp','3','3','MEN00141');
insert into menudynamique values('MEN0093','Liste Personnel ','fa fa-plus','/spat/pages/globalnegoce.jsp?but=rh/personnel-liste.jsp','12','2','MEN0004');
insert into menudynamique values('MEN0094','Analyse','fa fa-area-chart','/spat/pages/globalnegoce.jsp?but=rh/analyse-effectif-syndicat.jsp'||'&'||'colGroupe1=syndicat'||'&'||'colGroupe2=genre','3','3','MEN00194');

insert into menudynamique values('MEN0095','Mouvement effectif','fa fa-list','/spat/pages/globalnegoce.jsp?but=rh/mouvement-effectif-liste.jsp','12','2','MEN0004');

