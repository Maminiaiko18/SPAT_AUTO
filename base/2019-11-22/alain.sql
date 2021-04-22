Insert into MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) values ('MENP009','Historiques','fa fa-plus','#','2','2','MENP007');
Insert into MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) values ('MENP0091','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=parametre/historique-liste.jsp','2','3','MENP009');

Insert into MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) values ('MENP010','Menu','fa fa-home','#','3','2','MENP007');
Insert into MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) values ('MENP011','Rôles','fa fa-home','#','4','2','MENP007');
Insert into MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) values ('MENP007','Paramètres','fa fa-cog','#','7','1',null);
Insert into MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) values ('MENP008','Utilisateurs','fa fa-home','#','1','2','MENP007');
Insert into MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) values ('MENP0082','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=parametre/utilisateur-liste.jsp','2','3','MENP008');
Insert into MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) values ('MENP0081','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=parametre/utilisateur-saisie.jsp','1','3','MENP008');
Insert into MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) values ('MENP0111','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=parametre/role-saisie.jsp','3','3','MENP011');
Insert into MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) values ('MENP0112','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=parametre/role-liste.jsp','2','3','MENP011');
Insert into MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) values ('MENP0101','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=parametre/menu-utilisateur-saisie.jsp','1','3','MENP010');
Insert into MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) values ('MENP0102','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=parametre/menu-utilisateur-liste.jsp','2','3','MENP010');

Insert into USERMENU (ID,REFUSER,IDMENU,IDROLE,CODESERVICE,CODEDIR,INTERDIT) values ('USRM007','1060','MENP007','dg',null,null,null);