UPDATE MENUDYNAMIQUE
SET LIBELLE='Contrat', ICONE='fa fa-home', HREF=NULL, RANG=9, NIVEAU=2, ID_PERE='MEN0005'
WHERE ID='MEND0000104';
UPDATE MENUDYNAMIQUE
SET LIBELLE='Saisie', ICONE='fa fa-plus', HREF='/spat/pages/globalnegoce.jsp?but=travaux/contrat-saisie-nouveau.jsp', RANG=1, NIVEAU=3, ID_PERE='MEND0000104'
WHERE ID='MEND0000105';
UPDATE MENUDYNAMIQUE
SET LIBELLE='Liste', ICONE='fa fa-list', HREF='/spat/pages/globalnegoce.jsp?but=travaux/contrat-liste-nouveau.jsp', RANG=2, NIVEAU=3, ID_PERE='MEND0000104'
WHERE ID='MEND0000116';
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENDY00032', 'Import', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=ligneCredit/import-ligneCreditDepense.jsp', 5, 4, 'MENBDG00021');
   INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('UMENU100120269', '*', 'MEND0000105', NULL, NULL, NULL, 1);
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00D999', 'Analyse détails', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=facture/facture-fournisseur-details-analyse.jsp', 10, 3, 'MEN00211');

update menudynamique set LIBELLE='Engagement' where ID='MEND0000104';
update menudynamique set HREF='/spat/pages/globalnegoce.jsp?but=depense/engagement-saisie.jsp&currentMenu=MEND0000104' where ID='MEND0000105';

update menudynamique set HREF='/spat/pages/globalnegoce.jsp?but=depense/engagement-liste.jsp&currentMenu=MEND0000104' where ID='MEND0000106';
UPDATE MENUDYNAMIQUE SET LIBELLE ='Analyse projet' WHERE id='MENP013';