/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  nyamp
 * Created: 14 mai 2021
 */


UPDATE MENUDYNAMIQUE SET libelle='TB facturation' WHERE id='MEN0041';
UPDATE MENUDYNAMIQUE SET ID_PERE =null WHERE id='MEND00002100';
DELETE USERMENU WHERE IDMENU ='MEN00214';
INSERT INTO MENUDYNAMIQUE values('MEN00068','Facture client','fa fa-user','#',8,2,'MEN0006');	
INSERT INTO MENUDYNAMIQUE values('MEN000681','Saisie','fa fa-user','/spat/pages/globalnegoce.jsp?but=facture/factureclient-saisie.jsp',1,3,'MEN00068');	
INSERT INTO MENUDYNAMIQUE values('MEN000682','Liste','fa fa-user','/spat/pages/globalnegoce.jsp?but=facture/factureclient-liste-vaovao.jsp',2,3,'MEN00068');	
INSERT INTO MENUDYNAMIQUE values('MEN000683','Analyse','fa fa-user','/spat/pages/globalnegoce.jsp?but=facture/analyse-facture-client.jsp',3,3,'MEN00068');	
