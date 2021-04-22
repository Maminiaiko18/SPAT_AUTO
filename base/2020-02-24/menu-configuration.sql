insert into menudynamique values('MEN00740', 'Configuration', 'fa fa-cog', '#','8', '1', null);
    insert into menudynamique values('MEN00741', 'Commandant', 'fa fa-cog', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=commandant','1', '2', 'MEN00740');
    insert into menudynamique values('MEN00742', 'Manoeuvre de bord', 'fa fa-cog', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=manoeuvrebord','2', '2', 'MEN00740');

insert into USERMENU(ID, REFUSER, IDMENU, INTERDIT) values('USR0008', '1060', 'MEN00740', 0);
