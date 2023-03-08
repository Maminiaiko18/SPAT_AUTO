alter table placement modify montant number(20,2);
alter table report modify montant number(20,2);

insert into menudynamique values('MEN000142A','Report','fa fa-list','#',3,4,'MEN00174P');
insert into menudynamique values('MEN000142L','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=treso/report-liste.jsp',1,5,'MEN000142A');
insert into menudynamique values('MEN000142S','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=treso/report-saisie.jsp',2,5,'MEN000142A');