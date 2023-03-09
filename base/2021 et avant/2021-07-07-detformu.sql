/*Math.min([nbJour],5)<=5
Math.min([nbJour],10)>=6 && Math.min([nbJour],10)<=10
Math.max([nbJour],11)>=11*/

insert into categoriefacturation values('CATFCI009','Reparation navale','Reparation navale');
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170450', 'Mise a sec et remise a l eau calcule', 'CATFCI009', 'REDV001', 'Eur', 
    'UA006', 0, 'DIR00006');
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170551', 'Mise a sec et remise a l eau Poids<=25t', '70670', 1, 1, '1037.78', 'UA006', 
    'RB0000000021170450', '[plt]<=25', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170552', 'Mise a sec et remise a l eau 25t<Poids<=50t', '70670', 1, 1, '1135', 'UA006', 
    'RB0000000021170450', '[plt]>25&&[plt]<=50', '1');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170553', 'Mise a sec et remise a l eau 51t<Poids<=75t', '70670', 1, 1, '1196.5', 'UA006', 
    'RB0000000021170450', '[plt]>51&&[plt]<=75', '1');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170554', 'Mise a sec et remise a l eau 76t<Poids<=100t', '70670', 1, 1, '1281.97', 'UA006', 
    'RB0000000021170450', '[plt]>76&&[plt]<=100', '1');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170555', 'Mise a sec et remise a l eau 101t<Poids<=150t', '70670', 1, 1, '1404.06', 'UA006', 
    'RB0000000021170450', '[plt]>101&&[plt]<=150', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170556', 'Mise a sec et remise a l eau Poids>150t', '70670', 1, 1, '1526.15', 'UA006', 
    'RB0000000021170450', '[plt]>150', '1');	
	
/*Occupation de surface*/	
insert into unite_activite values('UNI0021','M2/5J','M2/5J');
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170451', 'Occupation de surface', 'CATFCI009', 'REDV001', 'Eur', 
    'UNI0021', 0, 'DIR00006');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170557', 'Occupation de surface', '70670', 1, 1, '0.256', 'UNI0021', 
    'RB0000000021170451', null, '[surface]*[nb5jours]');

/*Enlèvement ordures*/	
insert into unite_activite values('UNI0022','bateau','bateau');
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION,PU)
 Values
   ('RB0000000021170452', 'Enlevement ordures', 'CATFCI009', 'REDV001', 'Eur', 
    'UNI0022', 0, 'DIR00006','19.23');

/*Nettoyage du site*/	
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION,PU)
 Values
   ('RB0000000021170453', 'Nettoyage du site', 'CATFCI009', 'REDV001', 'Eur', 
    'UNI0022', 0, 'DIR00006','38.46');	
	
/*Securite incendie*/	
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION,PU)
 Values
   ('RB0000000021170454', 'Securite incendie', 'CATFCI009', 'REDV001', 'Eur', 
    'UNI0022', 0, 'DIR00006','19.23');
	
/*Redevance pour les travaux*/	
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170455', 'Redevance pour les travaux', 'CATFCI009', 'REDV001', 'Eur', 
    'UA004', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170558', 'Redevance pour les travaux', '70670', 1, 1, '5', 'UA004', 
    'RB0000000021170455', null, '[nbjour]');	
	
/*Provision avant mise a sec du navire*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION,PU)
 Values
   ('RB0000000021170456', 'Provision avant mise a sec du navire', 'CATFCI009', 'REDV001', 'Ar', 
    'UNI0022', 0, 'DIR00006','3000000');

/*Mise a sec hors site*/	
insert into unite_activite values('UNI0023','millilitre','millilitre');
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION,PU)
 Values
   ('RB0000000021170457', 'Mise a sec hors site', 'CATFCI009', 'REDV001', 'Ar', 
    'UNI0023', 0, 'DIR00006','17300');
	
/*Remise a l eau*/	
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION,PU)
 Values
   ('RB0000000021170458', 'Remise a l eau hors site', 'CATFCI009', 'REDV001', 'Ar', 
    'UNI0023', 0, 'DIR00006','17300');
	
/*Stationnement*/		
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170459', 'Remise a l eau hors site', 'CATFCI009', 'REDV001', 'Ar', 
    'UA044', 0, 'DIR00006');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170559', 'Remise a l eau hors site', '70670', 1, 1, '2300', 'UA004', 
    'RB0000000021170459', null, '[lht]*[nbjour]');	

/*Location de materiels*/	
insert into categoriefacturation values('CATFCI010','Location de materiels','Location de materiels');	

/*Transport par vedette*/

Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170460', 'Transport par vedette', 'CATFCI010', 'REDV001', 'Eur', 
    'UA006', 0, 'DIR00006');	

/*Transport par vedette jour normal TG*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170560', 'Transport par vedette national TG', '70689', 1, 1, '16.799', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([quais]==''QUA000010'')', '1');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170561', 'Transport par vedette international TG', '70689', 1, 1, '39.919', 'UA006', 
    'RB0000000021170460', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([quais]==''QUA000010'')', '1');	

/*Transport par vedette jour férié et nuit TG*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170562', 'Transport par vedette national ferie TG', '70689', 1, 1, '25.199', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&([quais]==''QUA000010'')', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170563', 'Transport par vedette international ferie TG', '70689', 1, 1, '47.879', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&([quais]==''QUA000010'')', '1');	

/*Transport par vedette jour normal Sherritt*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170564', 'Transport par vedette national Sherritt', '70689', 1, 1, '33.599', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([quais]==''QUA000086122119''||[quais]==''QUA000013''||[quais]==''QUA000014''||[quais]==''QUA000029''||[quais]==''QUA000087172643'')', '1');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170565', 'Transport par vedette international Sherritt', '70689', 1, 1, '63.839', 'UA006', 
    'RB0000000021170460', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([quais]==''QUA000086122119''||[quais]==''QUA000013''||[quais]==''QUA000014''||[quais]==''QUA000029''||[quais]==''QUA000087172643'')', '1');	

/*Transport par vedette jour férié et nuit Sherritt*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170566', 'Transport par vedette national ferie Sherritt', '70689', 1, 1, '50.399', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&([quais]==''QUA000086122119''||[quais]==''QUA000013''||[quais]==''QUA000014''||[quais]==''QUA000029''||[quais]==''QUA000087172643'')', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170567', 'Transport par vedette international ferie Sherritt', '70689', 1, 1, '95.759', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&([quais]==''QUA000086122119''||[quais]==''QUA000013''||[quais]==''QUA000014''||[quais]==''QUA000029''||[quais]==''QUA000087172643'')', '1');	

/*Transport par vedette jour normal Rade*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170568', 'Transport par vedette national Rade', '70689', 1, 1, '67.198', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([quais]==''QUA000030''||[quais]==''QUA000035'')', '1');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170569', 'Transport par vedette international Rade', '70689', 1, 1, '127.676', 'UA006', 
    'RB0000000021170460', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([quais]==''QUA000030''||[quais]==''QUA000035'')', '1');	

/*Transport par vedette jour ferie et nuit Rade*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170570', 'Transport par vedette national Rade ferie', '70689', 1, 1, '100.797', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&([quais]==''QUA000030''||[quais]==''QUA000035'')', '1');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170571', 'Transport par vedette international Rade ferie', '70689', 1, 1, '191.514', 'UA006', 
    'RB0000000021170460', '[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&([quais]==''QUA000030''||[quais]==''QUA000035'')', '1');	
	
	
/*Vedette de servitude*/

Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170461', 'Vedette de servitude', 'CATFCI010', 'REDV001', 'Eur', 
    'UA002', 0, 'DIR00006');	
/*Vedette de servitude jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170571', 'Vedette de servitude national', '70686', 1, 1, '67.198', 'UA002', 
    'RB0000000021170461', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '[nbheure]');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170572', 'Vedette de servitude international', '70686', 1, 1, '127.676', 'UA002', 
    'RB0000000021170461', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '[nbheure]');	
 
/*Vedette de servitude jour ferie et nuit*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170573', 'Vedette de servitude national ferie', '70686', 1, 1, '80.638', 'UA002', 
    'RB0000000021170461', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '[nbheure]');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170574', 'Vedette de servitude international ferie', '70686', 1, 1, '153.211', 'UA002', 
    'RB0000000021170461', '[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '[nbheure]');	
  
/*Remorqueur*/

Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170462', 'Remorqueur arme', 'CATFCI010', 'REDV001', 'Eur', 
    'UA002', 0, 'DIR00006');  

/*Remorqueur armé jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170575', 'Remorqueur arme national', '70685', 1, 1, '262.684', 'UA002', 
    'RB0000000021170462', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[categorie_flotte]=''CM001''', '[nbheure]');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170576', 'Remorqueur arme international', '70685', 1, 1, '499.100', 'UA002', 
    'RB0000000021170462', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[categorie_flotte]=''CM001''', '[nbheure]');	
 	
/*Remorqueur armé jour ferie et nuit*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170577', 'Remorqueur arme national ferie', '70685', 1, 1, '315.221', 'UA002', 
    'RB0000000021170462', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[categorie_flotte]=''CM001''', '[nbheure]');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170578', 'Remorqueur arme international ferie', '70685', 1, 1, '598.920', 'UA002', 
    'RB0000000021170462', '[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[categorie_flotte]=''CM001''', '[nbheure]');	
 	
/*Remorqueur servitude jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170579', 'Remorqueur de servitude national', '70684', 1, 1, '91.634', 'UA002', 
    'RB0000000021170462', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[categorie_flotte]=''CM002''', '[nbheure]');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170580', 'Remorqueur de servitude international', '70684', 1, 1, '174.105', 'UA002', 
    'RB0000000021170462', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[categorie_flotte]=''CM002''', '[nbheure]');	
 
 /*Remorqueur servitude jour ferie et nuit*/
 Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170581', 'Remorqueur de servitude national ferie', '70684', 1, 1, '109.961', 'UA002', 
    'RB0000000021170462', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[categorie_flotte]=''CM002''', '[nbheure]');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170582', 'Remorqueur de servitude international ferie', '70684', 1, 1, '208.926', 'UA002', 
    'RB0000000021170462', '[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[categorie_flotte]=''CM002''', '[nbheure]');	
 
/*Materiels divers*/	
/*Compteur d eau*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170463', 'Compteur d eau', 'CATFCI010', 'REDV001', 'Eur', 
    'UA002', 0, 'DIR00006'); 
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170582', 'Compteur d eau', '-', 1, 1, '0.033', 'UA002', 
    'RB0000000021170463', null, '[nbheure]');
	
/*Moto pompe*/	
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170464', 'Moto pompe', 'CATFCI010', 'REDV001', 'Eur', 
    'UA002', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170583', 'Moto pompe', '-', 1, 1, '3.885', 'UA002', 
    'RB0000000021170464', null, '[nbheure]'); 	
	
/*Tuyau de 20m*/	
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170465', 'Tuyau de 20m', 'CATFCI010', 'REDV001', 'Eur', 
    'UA002', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170584', 'Tuyau de 20m', '-', 1, 1, '0.283', 'UA002', 
    'RB0000000021170465', null, '[nbheure]'); 
	
/*Vide cave*/	
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170466', 'Vide cave', 'CATFCI010', 'REDV001', 'Eur', 
    'UA002', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170585', 'Vide cave', '-', 1, 1, '1.136', 'UA002', 
    'RB0000000021170466', null, '[nbheure]'); 
 	
/*Camion incendie*/	
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170467', 'Camion incendie', 'CATFCI010', 'REDV001', 'Eur', 
    'UA002', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170586', 'Camion incendie', '70651', 1, 1, '60.225', 'UA002', 
    'RB0000000021170467', null, '[nbheure]');
	
/*Prestation diverses*/
insert into categoriefacturation values('CATFCI011','Prestation diverses','Prestation diverses');	

/*Consommation eau*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU,UNITE)
 Values
   ('RB0000000021170468', 'Consommation eau en Litres', 'CATFCI011', 'REDV001', 'Ar', 
    'UNIT0000000000130553', 0,'[conf::JIRAMAEAU]');
	
/*Consommation electricite*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170468', 'Consommation electricite en Heures', 'CATFCI011', 'REDV001', 'Ar','UA002', 0,'[conf::JIRAMAELEC]');	
