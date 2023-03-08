Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170444', 'Droit de port calcule', 'CATFC001', 'REDV001', 'Eur', 
    'UNIT0000000000164621', 0, 'DIR00006');
/*Droit de port inférieur à 3000 national */	
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170444', 'Droit de port V<3000 national', '70601',1, 1, '1.833', 'UA006', 
    'RB0000000021170444', '[estNational]==''National''&&[volume]>=500&&[volume]<3000', '1');	
	/*Droit de port entre 3000 à 9000 national */	
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170445', 'Droit de port 3000<=V<9000 national', '70601', 1, 1, '0.47', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''National''&&[volume]>=3000&&[volume]<9000', '[volumeArrondi]');
/*Droit de port supérieur à 9000 national */
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170446', 'Droit de port V>9000 national', '70601', 1, 1, '0.74', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''National''&&[volume]>=9000&&[cargaison]!=''CGM00001''', '[volumeArrondi]');
/*Droit de port supérieur à 9000 national pétrolier */
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170447', 'Droit de port V>9000 petrolier national', '70601', 1, 1, '0.74', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''National''&&[volume]>=9000&&[cargaison]==''CGM00001''', '[volumeArrondi]');
/*Droit de port inférieur à 3000 international */		
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170448', 'Droit de port V<3000 international', '70601', 1, 1, '3.483', 'UA006', 
    'RB0000000021170444', '[estNational]==''International''&&[volume]>=500&&[volume]<3000', '1');
/*Droit de port entre 3000 à 9000 international */
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170449', 'Droit de port 3000<=V<9000 international', '70601', 1, 1, '0.893', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''International''&&[volume]>=3000&&[volume]<9000', '[volumeArrondi]');
/*Droit de port supérieur à 9000 international */	
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170450', 'Droit de port V>9000 international', '70601', 1, 1, '1.405', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''International''&&[volume]>=9000&&[cargaison]!=''CGM00001''', '[volumeArrondi]');
/*Droit de port supérieur à 9000 international pétrolier */
Insert into DETFORMUFACT
   (ID, REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170451', 'Droit de port V>=9000 international petrolier', '70601', 1, 1, '1.546', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''International''&&[volume]>=9000&&[cargaison]==''CGM00001''', '[volumeArrondi]');
		
	
/*conteneur sy passagers navela aloha*/
/*PILOTAGE*/
/*Minimum de perception jour normal*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170445', 'Pilotage calcule', 'CATFC001', 'REDV001', 'Eur', 
    'UNIT0000000000164621', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170453', 'Min. percept. pilotage national', '70631', 1, 1, '174.105', 'UA016', 
    'RB0000000021170445', '[estNational]==''International''&&[volume]<15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '1');    
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170452', 'Min. percept. pilotage international', '70631',1, 1, '91.634', 'UA016', 
    'RB0000000021170445', '[estNational]==''National''&&[volume]<15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '1');  
/*Minimum de perception nuit et férié*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170454', 'Min. percept. pilotage national ferie', '70631', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[estNational]==''National''&&[volume]<15000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170455','Min. percept. pilotage international ferie', '70631', 1, 1, '2.298', 'UA048', 
    'RB0000000021170445', '[estNational]==''International''&&[volume]<15000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '[volumeArrondi]');	
/*Manoeuvre entrée et sortie jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170456', 'Pilotage Entree/Sortie national', '70631',1, 1, '0.537', 'UA041', 
    'RB0000000021170445', '[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170457', 'Pilotage Entree/Sortie international', '70631', 1, 1, '1.532', 'UA041', 
    'RB0000000021170445', '[estNational]==''International''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');
/*Manoeuvre entrée et sortie nuit et férié */		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170458', 'Pilotage Entree/Sortie national ferie', '70631', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[estNational]==''National''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170459', 'Pilotage Entree/Sortie international ferie', '70631', 1, 1, '2.298', 'UA048', 
    'RB0000000021170445', '[estNational]==''International''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
/*Mouvement jour normal */		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170460', 'Pilotage Mouvement national', '70631', 1, 1, '0.47', 'UA041', 
    'RB0000000021170445', '[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0004''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170461', 'Pilotage Mouvement international', '70631', 1, 1, '0.899', 'UA041', 
    'RB0000000021170445', '[estNational]==''International''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0004''', '[volumeArrondi]');
/*Mouvement jour normal nuit et férié*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170462', 'Pilotage Mouvement national ferie', '70631', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[estNational]==''National''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0004''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170463', 'Pilotage Mouvement international ferie', '70631', 1, 1, '1.349', 'UA048', 
    'RB0000000021170445', '[estNational]==''International''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0004''', '[volumeArrondi]');	
/*Sortie Pétrolier jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170464', 'Pilotage Sortie petrolier national', '70631', 1, 1, '0.537', 'UA041', 
    'RB0000000021170445', '[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0005''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170465', 'Pilotage Sortie petrolier international', '70631', 1, 1, '1.532', 'UA041', 
    'RB0000000021170445', '[estNational]==''International''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0005''&&[cargaison]==''CGM00001''', '[volumeArrondi]');
/*Sortie Pétrolier jour férié et nuit*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170466', 'Pilotage Sortie petrolier national ferie', '70631', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[estNational]==''National''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0005''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170467', 'Pilotage Sortie petrolier international ferie', '70631', 1, 1, '2.298', 'UA048', 
    'RB0000000021170445', '[estNational]==''International''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0005''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
	/*Entrée Pétrolier jour normal*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170468', 'Pilotage Entrée petrolier national', '70631', 1, 1, '0.537', 'UA041', 
    'RB0000000021170445', '[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0003''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170469', 'Pilotage Entrée petrolier international', '70631', 1, 1, '1.685', 'UA041', 
    'RB0000000021170445', '[estNational]==''International''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0003''&&[cargaison]==''CGM00001''', '[volumeArrondi]');
	/*Entrée Pétrolier jour férié et nuit*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170470', 'Pilotage Entrée petrolier national ferie', '70631', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[estNational]==''National''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0003''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170471', 'Pilotage Entrée petrolier international ferie', '70631', 1, 1, '2.527', 'UA048', 
    'RB0000000021170445', '[estNational]==''International''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0003''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
/*25-06-2021*/	
/*REMORQUAGE*/	
/*Minimum de perception remorquage jour normal*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170446', 'Remorquage calcule', 'CATFC001', 'REDV001', 'Eur', 
    'UNIT0000000000164621', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170472', 'Min. percept. Remorquage national', '70632', 1, 1, '91.634', 'UA016', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]<3000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170473', 'Min. percept. Remorquage international', '70632', 1, 1, '174.105', 'UA016', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]<3000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '1');	
/*Minimum de perception remorquage nuit et jour ferié*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170474', 'Min. percept. Remorquage national ferie', '70632', 1, 1, '0.806', 'UA048', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]<3000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170475', 'Min. percept. Remorquage international ferie', '70632', 1, 1, '2.298', 'UA048', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]<3000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '1');	
	/*Remorquage Entre 3000 et 5000M3 jour normal cargo*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170476', 'Remorquage 3.000<=V<5.000 national', '70632', 1, 1, '2.187', 'UA048', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170477', 'Remorquage 3.000<=V<5.000 international', '70632', 1, 1, '4.154', 'UA048', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
	/*Remorquage Entre 3000 et 5000M3 nuit et jour férié  cargo*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170478', 'Remorquage 3.000<=V<5.000 national ferie', '70632', 1, 1, '3.281', 'UA048', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170479', 'Remorquage 3.000<=V<5.000 international ferie', '70632', 1, 1, '6.231', 'UA048', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
/*Remorquage Supérieur à 5000M3 jour normal  cargo*/			
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170480', 'Remorquage V>=5.000 national', '70632', 1, 1, '2.824', 'UA048', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF00000000231704781', 'Remorquage V>=5.000 international', '70632', 1, 1, '5.363', 'UA048', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
/*Remorquage Supérieur à 5000M3 nuit et jour férié  cargo*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170482', 'Remorquage V>=5.000 national ferie', '70632', 1, 1, '4.236', 'UA048', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170483', 'Remorquage V>=5.000 international ferie', '70632', 1, 1, '8.045', 'UA048', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
/*Majoration Remorquage entre 3.000 et 5.000 jour normal cargo*/ --manomboka 535
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170535', 'Maj. Remorq. 3000<=V<5.000 national', '70632', 1, 1, '65.67', 'UA043', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF00000000231704536', 'Maj. Remorq. 3000<=V<5.000 international', '70632', 1, 1, '124.775', 'UA043', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
/*Majoration Remorquage entre 3.000 et 5.000 jour normal férié et nuit cargo*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170537', 'Maj. Remorq. 3000<=V<5.000 national ferie', '70632', 1, 1, '98.505', 'UA043', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170538', 'Maj. Remorq. 3000<=V<5.000 international ferie', '70632', 1, 1, '187.163', 'UA043', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
/*Majoration Remorquage supérieur à 5.000 jour normal cargo*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170539', 'Maj. Remorq. V>=5.000 national', '70632', 1, 1, '126.385', 'UA043', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF00000000231704540', 'Maj. Remorq. V>=5.000 international', '70632', 1, 1, '198.765', 'UA043', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
/*Majoration Remorquage supérieur à 5.000 jour férié et nuit cargo*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170541', 'Maj. Remorq. V>=5.000 national ferie', '70632', 1, 1, '98.505', 'UA043', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170542', 'Maj. Remorq. V>=5.000 international ferie', '70632', 1, 1, '187.163', 'UA043', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
/*Remorquage sortie pétrolier Entre 3000 et 20.000 jour normal*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170484', 'Remorquage 3000<=V<20.000 petrolier national', '70632', 1, 1, '2.187', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170485', 'Remorquage 3000<=V<20.000 petrolier international', '70632', 1, 1, '4.154', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier Entre 3000 et 20.000 jour férié et nuit*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170486', 'Remorquage 3000<=V<20.000 petrolier national ferie', '70632', 1, 1, '3.281', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170487', 'Remorquage 3000<=V<20.000 petrolier international ferie', '70632', 1, 1, '6.231', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier Entre 20.000 et 50.000 jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170488', 'Remorquage sortie 20.000<=V<50.000 petrolier national', '70632', 1, 1, '4.582', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170489', 'Remorquage sortie 20.000<=V<50.000 petrolier international', '70632', 1, 1, '8.704', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier entre 20.000 et 50.000 jour férié et nuit*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170490', 'Remorquage sortie 20.000<=V<50.000 petrolier national ferie', '70632', 1, 1, '6.873', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170491', 'Remorquage sortie 20.000<=V<50.000 petrolier international ferie', '70632', 1, 1, '13.05', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier Entre 50.000 et 100.000 jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170492', 'Remorquage sortie 50.000<=V<100.000 petrolier national', '70632', 1, 1, '6.216', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170493', 'Remorquage sortie 50.000<=V<100.000 petrolier international', '70632', 1, 1, '11.809', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier Entre 50.000 et 100.000 jour férié et nuit*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170494', 'Remorquage sortie 50.000<=V<100.000 petrolier national ferie', '70632', 1, 1, '9.324', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170495', 'Remorquage sortie 50.000<=V<100.000 petrolier international ferie', '70632', 1, 1, '17.71', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier supérieur à 100.000 jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170496', 'Remorquage sortie V>=100.000 petrolier national', '70632', 1, 1, '8.014', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170497', 'Remorquage sortie V>=100.000 petrolier international', '70632', 1, 1, '15.226', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier supérieur à 100.000 jour férié et nuit*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170498', 'Remorquage sortie V>=100.000 petrolier national ferie', '70632', 1, 1, '12.021', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170499', 'Remorquage sortie V>=100.000 petrolier international ferie', '70632', 1, 1, '22.839', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Veille de sécurité sortie pétrolier*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170500', 'Veille de sécurité sortie pétrolier national', '70636', 1, 1, '28.647', 'UA002', 
    'RB0000000021170446', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[nbHeure]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170501', 'Veille de sécurité sortie pétrolier national', '70636', 1, 1, '54.429', 'UA002', 
    'RB0000000021170446', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[nbHeure]');	
/*Remorquage entrée pétrolier entre 3.000 et 20.000 jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170502', 'Remorquage entrée 3.000<=V<20.000 petrolier national', '70632', 1, 1, '2.187', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170503', 'Remorquage entrée 3.000<=V<20.000 petrolier international', '70632', 1, 1, '4.569', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
/*Remorquage entrée pétrolier entre 3.000 et 20.000 jour férié et nuit*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170504', 'Remorquage entrée 3.000<=V<20.000 petrolier national ferie', '70632', 1, 1, '3.281', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170505', 'Remorquage entrée 3.000<=V<20.000 petrolier international ferie', '70632', 1, 1, '6.854', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
/*Remorquage entrée pétrolier entre 20.000 et 50.000 jour normal*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170506', 'Remorquage entrée 20.000<=V<50.000 petrolier national', '70632', 1, 1, '4.582', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170507', 'Remorquage entrée 20.000<=V<50.000 petrolier international', '70632', 1, 1, '9.574', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
/*Remorquage entrée pétrolier entre 20.000 et 50.000 jour férié et nuit*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170508', 'Remorquage entrée 20.000<=V<50.000 petrolier national ferie', '70632', 1, 1, '6.873', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170509', 'Remorquage entrée 20.000<=V<50.000 petrolier international ferie', '70632', 1, 1, '14.362', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
/*Remorquage entrée pétrolier entre 50.000 et 100.000 jour normal*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170510', 'Remorquage entrée 50.000<=V<100.000 petrolier national', '70632', 1, 1, '6.216', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170511', 'Remorquage entrée 50.000<=V<100.000 petrolier international', '70632', 1, 1, '12.99', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
	/*Remorquage entrée pétrolier entre 50.000 et 100.000 jour ferie et nuit*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170512', 'Remorquage entrée 50.000<=V<100.000 petrolier national ferie', '70632', 1, 1, '9.324', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170513', 'Remorquage entrée 50.000<=V<100.000 petrolier international ferie', '70632', 1, 1, '19.485', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
/*Remorquage entrée pétrolier supérieur à 100.000 jour normal*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170514', 'Remorquage entrée V>=100.000 petrolier national', '70632', 1, 1, '8.014', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170515', 'Remorquage entrée V>=100.000 petrolier international', '70632', 1, 1, '16.749', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
	/*Remorquage entrée pétrolier supérieur à 100.000 jour ferie et nuit*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170516', 'Remorquage entrée V>=100.000 petrolier national ferie', '70632', 1, 1, '12.021', 'UA041', 
    'RB0000000021170446', '[estNational]==''National''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170517', 'Remorquage entrée V>=100.000 petrolier international ferie', '70632', 1, 1, '25.123', 'UA041', 
    'RB0000000021170446', '[estNational]==''International''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
/*Veille de sécurité entrée pétrolier*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170518', 'Veille de sécurité entrée pétrolier national', '70636', 1, 1, '28.647', 'UA002', 
    'RB0000000021170446', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[nbHeure]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170519', 'Veille de sécurité entrée pétrolier international', '70636', 1, 1, '59.872', 'UA002', 
    'RB0000000021170446', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[nbHeure]');	

/*Lamanage cargo jour normal*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170447', 'Lamanage calcule', 'CATFC001', 'REDV001', 'Eur', 
    'UA048', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170520', 'Amarr. et desamarr. cargo national', '70633', 1, 1, '0.537', 'UA048', 
    'RB0000000021170447', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170521', 'Amarr. et desamarr. cargo international', '70633', 1, 1, '1.021', 'UA048', 
    'RB0000000021170447', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
	/*Lamanage cargo jour ferie et nuit*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170522', 'Amarr. et desamarr. cargo national ferie', '70633', 1, 1, '0.805', 'UA048', 
    'RB0000000021170447', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170523', 'Amarr. et desamarr. cargo national ferie', '70633', 1, 1, '1.531', 'UA048', 
    'RB0000000021170447', '[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
	/*Lamanage sortie pétrolier jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170524', 'Amarr. et desamarr. petrolier national', '70633', 1, 1, '0.807', 'UA048', 
    'RB0000000021170447', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170525', 'Amarr. et desamarr. petrolier international', '70633', 1, 1, '1.532', 'UA048', 
    'RB0000000021170447', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
	/*Lamanage sortie pétrolier jour férié*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170526', 'Amarr. et desamarr. sortie petrolier national ferie ', '70633', 1, 1, '1.211', 'UA048', 
    'RB0000000021170447', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170527', 'Amarr. et desamarr. sortie petrolier international ferie', '70633', 1, 1, '2.298', 'UA048', 
    'RB0000000021170447', '[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
	/*Lamanage entrée pétrolier jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170528', 'Amarr. et desamarr. entrée petrolier national', '70633', 1, 1, '0.807', 'UA048', 
    'RB0000000021170447', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170529', 'Amarr. et desamarr. entrée petrolier international', '70633', 1, 1, '1.685', 'UA048', 
    'RB0000000021170447', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
		/*Lamanage entrée pétrolier jour ferie*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170530', 'Amarr. et desamarr. sortie petrolier national ferie', '70633', 1, 1, '1.211', 'UA048', 
    'RB0000000021170447', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170531', 'Amarr. et desamarr. sortie petrolier international ferie', '70633', 1, 1, '2.527', 'UA048', 
    'RB0000000021170447', '[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
	/*Redevance communale*/	
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170448', 'Redevance communale calcule', 'CATFC001', 'REDV001', 'Ar', 
    'UA006', 0, 'DIR00006');
/*Redevance LC étranger */	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170532', 'Redevance communale LC international', '46733', 1, 1, '400000', 'UA006', 
    'RB0000000021170448', '[estNational]==''International''&&[cargaison]!=''CGM00001''', '1');	
	/*Redevance pétrolier étranger */		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170533', 'Redevance communale pour pétrolier international', '46733', 1, 1, '400000', 'UA006', 
    'RB0000000021170448', '[estNational]==''International''&&[cargaison]==''CGM00001''', '1');		
	/*Redevance LC national */	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170534', 'Redevance communale cabotage national', '46733', 1, 1, '30000', 'UA006', 
    'RB0000000021170448', '[estNational]==''National''', '1');	
/*Manomboka 543*/	
/*Stationnement à quais ordinaire*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170449', 'Stationnement calcule', 'CATFC001', 'REDV001', 'Eur', 
    'UA045', 0, 'DIR00006');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170543', 'Stationnement poste ordinaire nav. national', '70634', 1, 1, '0.033', 'UA045', 
    'RB0000000021170448', '[estNational]==''National''&&[typequais]==''TYPE000003''', '[longueur]*[nbheure]');		
	Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170544', 'Stationnement poste ordinaire nav. international', '70634', 1, 1, '0.063', 'UA045', 
    'RB0000000021170448', '[estNational]==''International''&&[typequais]==''TYPE000003''', '[longueur]*[nbheure]');	
/*Stationnement à quais spécialisé*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170545', 'Stationnement poste spec. nav. national', '70634', 1, 1, '0.048', 'UA045', 
    'RB0000000021170448', '[estNational]==''National''&&[typequais]==''TQ001''', '[longueur]*[nbheure]');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170546', 'Stationnement poste spec. nav. international', '70634', 1, 1, '0.091', 'UA045', 
    'RB0000000021170448', '[estNational]==''International''&&[typequais]==''TQ001''', '[longueur]*[nbheure]');	
	/*Stationnement poste pétrolier*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170547', 'Stationnement poste petrolier nav. national', '70634', 1, 1, '3.971', 'UA045', 
    'RB0000000021170448', '[estNational]==''National''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');		
	Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170548', 'Stationnement poste petrolier nav. international', '70634', 1, 1, '7.545', 'UA045', 
    'RB0000000021170448', '[estNational]==''International''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');	
/*Stationnement en rade*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170549', 'Stationnement poste de mouillage nav. national', '70634', 1, 1, '0.025', 'UA045', 
    'RB0000000021170448', '[estNational]==''National''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');		
	Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170550', 'Stationnement poste de mouillage nav. international', '70634', 1, 1, '0.048', 'UA045', 
    'RB0000000021170448', '[estNational]==''International''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');	
	
INSERT INTO NATUREOPERATION (ID, VAL, DESCE) VALUES('NATM0001', 'Cession eau douce', 'Cession eau douce');
INSERT INTO NATUREOPERATION (ID, VAL, DESCE) VALUES('NATM0002', 'Service en haute mer', 'Service en haute mer');
INSERT INTO NATUREOPERATION (ID, VAL, DESCE) VALUES('NATM0003', 'Autorisation piquage de rouille et peinture coque', 'Autorisation piquage de rouille et peinture coque');
INSERT INTO NATUREOPERATION (ID, VAL, DESCE) VALUES('NATM0004', 'Autorisation immobilisation', 'Autorisation immobilisation');
INSERT INTO NATUREOPERATION (ID, VAL, DESCE) VALUES('NATM0005', 'Enlevement ordure', 'Enlevement ordure');
INSERT INTO UNITE_ACTIVITE (ID, VAL, DESCE) VALUES('UA049', 'TM', 'Tonne metrique');
INSERT INTO UNITE_ACTIVITE (ID, VAL, DESCE) VALUES('UA050', 'EVP', 'EVP');
INSERT INTO UNITE_ACTIVITE (ID, VAL, DESCE) VALUES('UA051', 'JOUR INDIVISBLE', 'JOUR INDIVISBLE');
INSERT INTO CATEGORIEFACTURATION (ID, VAL, DESCE) VALUES('CATFC009', 'Assistance aux navires', 'Assistance aux navires');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0101', 'Hydrocarbures embarquement','CATFC003','0.5','Eur','UA049');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0102', 'Hydrocarbures debarquement','CATFC003','1.6','Eur','UA049');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0103', 'Marchandise conventionnelles embarquement','CATFC004','1.628','Eur','U1');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0104', 'Marchandise conventionnelles debarquement','CATFC004','2.4','Eur','U1');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0105', 'Conteneur plein 20 pieds plein embarquement','CATFC002','4','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0106', 'Conteneur plein 20 pieds vide embarquement','CATFC002','0.55','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0107', 'Conteneur plein 20 pieds plein debarquement','CATFC002','12.8','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0108', 'Conteneur plein 20 pieds vide debarquement','CATFC002','1.76','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0109', 'Conteneur plein 40 pieds plein embarquement','CATFC002','8','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0110', 'Conteneur plein 40 pieds vide embarquement','CATFC002','1.1','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0111', 'Conteneur plein 40 pieds plein debarquement','CATFC002','20.8','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0112', 'Conteneur plein 40 pieds vide debarquement','CATFC002','3.52','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0113', 'Conteneur plein 45 pieds plein embarquement','CATFC002','9','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0114', 'Conteneur plein 45 pieds vide embarquement','CATFC002','1.24','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0115', 'Conteneur plein 45 pieds plein debarquement','CATFC002','28.8','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0116', 'Conteneur plein 45 pieds vide debarquement','CATFC002','3.96','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0117', 'Conteneur plein 20 pieds plein transbordement','CATFC002','8.4','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0118', 'Conteneur plein 20 pieds vide transbordement','CATFC002','1.16','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0119', 'Conteneur plein 40 pieds plein transbordement','CATFC002','13.65','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0120', 'Conteneur plein 40 pieds vide transbordement','CATFC002','2.31','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0121', 'Conteneur plein 45 pieds plein transbordement','CATFC002','18.9','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0122', 'Conteneur plein 45 pieds vide transbordement','CATFC002','2.6','Eur','UA050');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0123', 'Port Malagasy','CATFC002','1','Eur','UA001');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0124', 'Port situe dans un etat membre de la COI','CATFC008','4','Eur','UA001');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0125', 'Autres ports','CATFC008','5','Eur','UA001');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0126', 'Cession d''eau douce calcule','CATFC009','','Eur','UA003');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0127', 'Services en haute mer calcule','CATFC009','','Eur','UA002');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0128', 'Autorisation piquage de rouille et peinture coque calcule','CATFC009','','Eur','UA051');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0129', 'Autorisation d''immobilisation calcule','CATFC009','','Eur','UA051');
INSERT INTO RUBRIQUE_ACTIVITE (ID, DESIGNATION, CATEGORIE, PU, DEVISE, UNITE) VALUES('RBR0130', 'Enlevement d''ordures calcule','CATFC009','','Eur','');

alter table detformufact add compte varchar2(500);
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300001', 'Cession d''eau douce cabotage national', 1, 1, '1.263', 'UA003', 
    'RBR0126', '[estNational]==''National''', '[volume]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300002', 'Cession d''eau douce cabotage international/Long', 1, 1, '2.399', 'UA003', 
    'RBR0126', '[estNational]==''International''', '[volume]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300003', 'Autorisation piquage de rouille et peinture coque cabotage national', 1, 1, '11', 'UA051', 
    'RBR0128', '[estNational]==''National''', '[nbJour]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300004', 'Autorisation piquage de rouille et peinture coque cabotage international/Long', 1, 1, '24.852', 'UA051', 
    'RBR0128', '[estNational]==''International''', '[nbJour]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300005', 'Autorisation d''immobilisation cabotage national', 1, 1, '13.08', 'UA051', 
    'RBR0129', '[estNational]==''National''', '[nbJour]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300006', 'Autorisation d''immobilisation cabotage international/Long', 1, 1, '24.852', 'UA051', 
    'RBR0129', '[estNational]==''International''', '[nbJour]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300007', 'Services en haute mer cabotage national', 1, 1, '79.944', 'UA002', 
    'RBR0127', '[estNational]==''National''', '[nbHeure]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300008', 'Services en haute mer cabotage international/Long', 1, 1, '79.944', 'UA051', 
    'RBR0127', '[estNational]==''International''', '[nbHeure]');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300009', 'Enlevement d''ordures 1er au 5e jour cabotage national', 1, 1, '50.607', 'UA006', 
    'RBR0130', '[estNational]==''National''', '1');
Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300010', 'Enlevement d''ordures 1er au 5e jour cabotage international/Long', 1, 1, '96.154', 'UA006', 
    'RBR0130', '[estNational]==''International''', '1');


delete from detformufact where id in ('DFF0000000023170543','DFF0000000023170544','DFF0000000023170545','DFF0000000023170546','DFF0000000023170547','DFF0000000023170548','DFF0000000023170549','DFF0000000023170550')
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170543', 'Stationnement poste ordinaire nav. national', '70634', 1, 1, '0.033', 'UA045', 
    'RB0000000021170449', '[estNational]==''National''&&[typequais]==''TYPE000003''', '[longueur]*[nbheure]');        
    
    
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170544', 'Stationnement poste ordinaire nav. international', '70634', 1, 1, '0.063', 'UA045', 
    'RB0000000021170449', '[estNational]==''International''&&[typequais]==''TYPE000003''', '[longueur]*[nbheure]');    

/*Stationnement à quais spécialisé*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170545', 'Stationnement poste spec. nav. national', '70634', 1, 1, '0.048', 'UA045', 
    'RB0000000021170449', '[estNational]==''National''&&[typequais]==''TQ001''', '[longueur]*[nbheure]');        
    
    
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170546', 'Stationnement poste spec. nav. international', '70634', 1, 1, '0.091', 'UA045', 
    'RB0000000021170449', '[estNational]==''International''&&[typequais]==''TQ001''', '[longueur]*[nbheure]');    
    
/*Stationnement poste pétrolier*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170547', 'Stationnement poste petrolier nav. national', '70634', 1, 1, '3.971', 'UA045', 
    'RB0000000021170449', '[estNational]==''National''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');        
    
    
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170548', 'Stationnement poste petrolier nav. international', '70634', 1, 1, '7.545', 'UA045', 
    'RB0000000021170449', '[estNational]==''International''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');    

/*Stationnement en rade*/    
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170549', 'Stationnement poste de mouillage nav. national', '70634', 1, 1, '0.025', 'UA045', 
    'RB0000000021170449', '[estNational]==''National''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');        
    
    
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170550', 'Stationnement poste de mouillage nav. international', '70634', 1, 1, '0.048', 'UA045', 
    'RB0000000021170449', '[estNational]==''International''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');

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
   ('DFF0000000023170551', 'Mise a sec et remise a l eau Poids<=25t', '-', 1, 1, '1037.78', 'UA006', 
    'RB0000000021170450', '[plt]<=25', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170552', 'Mise a sec et remise a l eau 25t<Poids<=50t', '-', 1, 1, '1135', 'UA006', 
    'RB0000000021170450', '[plt]>25&&[plt]<=50', '1');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170553', 'Mise a sec et remise a l eau 51t<Poids<=75t', '-', 1, 1, '1196.5', 'UA006', 
    'RB0000000021170450', '[plt]>51&&[plt]<=75', '1');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170554', 'Mise a sec et remise a l eau 76t<Poids<=100t', '-', 1, 1, '1281.97', 'UA006', 
    'RB0000000021170450', '[plt]>76&&[plt]<=100', '1');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170555', 'Mise a sec et remise a l eau 101t<Poids<=150t', '-', 1, 1, '1404.06', 'UA006', 
    'RB0000000021170450', '[plt]>101&&[plt]<=150', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170556', 'Mise a sec et remise a l eau Poids>150t', '-', 1, 1, '1526.15', 'UA006', 
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
   ('DFF0000000023170557', 'Occupation de surface', '-', 1, 1, '0.256', 'UNI0021', 
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
   ('DFF0000000023170558', 'Redevance pour les travaux', '-', 1, 1, '5', 'UA004', 
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
   ('DFF0000000023170559', 'Remise a l eau hors site', '-', 1, 1, '2300', 'UA004', 
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
   ('DFF0000000023170560', 'Transport par vedette national TG', '-', 1, 1, '16.799', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([quais]==''QUA000010'')', '1');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170561', 'Transport par vedette international TG', '-', 1, 1, '39.919', 'UA006', 
    'RB0000000021170460', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([quais]==''QUA000010'')', '1');	

/*Transport par vedette jour férié et nuit TG*/		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170562', 'Transport par vedette national ferie TG', '-', 1, 1, '25.199', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&([quais]==''QUA000010'')', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170563', 'Transport par vedette international ferie TG', '-', 1, 1, '47.879', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&([quais]==''QUA000010'')', '1');	

/*Transport par vedette jour normal Sherritt*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170564', 'Transport par vedette national Sherritt', '-', 1, 1, '33.599', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([quais]==''QUA000086122119''||[quais]==''QUA000013''||[quais]==''QUA000014''||[quais]==''QUA000029''||[quais]==''QUA000087172643'')', '1');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170565', 'Transport par vedette international Sherritt', '-', 1, 1, '63.839', 'UA006', 
    'RB0000000021170460', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([quais]==''QUA000086122119''||[quais]==''QUA000013''||[quais]==''QUA000014''||[quais]==''QUA000029''||[quais]==''QUA000087172643'')', '1');	

/*Transport par vedette jour férié et nuit Sherritt*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170566', 'Transport par vedette national ferie Sherritt', '-', 1, 1, '50.399', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&([quais]==''QUA000086122119''||[quais]==''QUA000013''||[quais]==''QUA000014''||[quais]==''QUA000029''||[quais]==''QUA000087172643'')', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170567', 'Transport par vedette international ferie Sherritt', '-', 1, 1, '95.759', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&([quais]==''QUA000086122119''||[quais]==''QUA000013''||[quais]==''QUA000014''||[quais]==''QUA000029''||[quais]==''QUA000087172643'')', '1');	

/*Transport par vedette jour normal Rade*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170568', 'Transport par vedette national Rade', '-', 1, 1, '67.198', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([quais]==''QUA000030''||[quais]==''QUA000035'')', '1');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170569', 'Transport par vedette international Rade', '-', 1, 1, '127.676', 'UA006', 
    'RB0000000021170460', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([quais]==''QUA000030''||[quais]==''QUA000035'')', '1');	

/*Transport par vedette jour ferie et nuit Rade*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170570', 'Transport par vedette national Rade ferie', '-', 1, 1, '100.797', 'UA006', 
    'RB0000000021170460', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&([quais]==''QUA000030''||[quais]==''QUA000035'')', '1');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170571', 'Transport par vedette international Rade ferie', '-', 1, 1, '191.514', 'UA006', 
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
   ('DFF0000000023170571', 'Vedette de servitude national', '-', 1, 1, '67.198', 'UA002', 
    'RB0000000021170461', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '[nbheure]');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170572', 'Vedette de servitude international', '-', 1, 1, '127.676', 'UA002', 
    'RB0000000021170461', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '[nbheure]');	
 
/*Vedette de servitude jour ferie et nuit*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170573', 'Vedette de servitude national ferie', '-', 1, 1, '80.638', 'UA002', 
    'RB0000000021170461', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '[nbheure]');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170574', 'Vedette de servitude international ferie', '-', 1, 1, '153.211', 'UA002', 
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
   ('DFF0000000023170575', 'Remorqueur arme national', '-', 1, 1, '262.684', 'UA002', 
    'RB0000000021170462', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[categorie_flotte]=''CM001''', '[nbheure]');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170576', 'Remorqueur arme international', '-', 1, 1, '499.100', 'UA002', 
    'RB0000000021170462', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[categorie_flotte]=''CM001''', '[nbheure]');	
 	
/*Remorqueur armé jour ferie et nuit*/
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170577', 'Remorqueur arme national ferie', '-', 1, 1, '315.221', 'UA002', 
    'RB0000000021170462', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[categorie_flotte]=''CM001''', '[nbheure]');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170578', 'Remorqueur arme international ferie', '-', 1, 1, '598.920', 'UA002', 
    'RB0000000021170462', '[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[categorie_flotte]=''CM001''', '[nbheure]');	
 	
/*Remorqueur servitude jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170579', 'Remorqueur de servitude national', '-', 1, 1, '91.634', 'UA002', 
    'RB0000000021170462', '[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[categorie_flotte]=''CM002''', '[nbheure]');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170580', 'Remorqueur de servitude international', '-', 1, 1, '174.105', 'UA002', 
    'RB0000000021170462', '[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[categorie_flotte]=''CM002''', '[nbheure]');	
 
 /*Remorqueur servitude jour ferie et nuit*/
 Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170581', 'Remorqueur de servitude national ferie', '-', 1, 1, '109.961', 'UA002', 
    'RB0000000021170462', '[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[categorie_flotte]=''CM002''', '[nbheure]');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170582', 'Remorqueur de servitude international ferie', '-', 1, 1, '208.926', 'UA002', 
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
   ('DFF0000000023170586', 'Camion incendie', '-', 1, 1, '60.225', 'UA002', 
    'RB0000000021170467', null, '[nbheure]');
	
/*Prestation diverses*/
/*insert into categoriefacturation values('CATFCI011','Prestation diverses','Prestation diverses');	

Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170468', 'Consommation eau en Litres', 'CATFCI011', 'REDV001', 'Ar', 
    'UNIT0000000000130553', 0,'[conf::JIRAMAEAU]');
*/    
/*Consommation electricite*/
/*Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170469', 'Consommation electricite en Heures', 'CATFCI011', 'REDV001', 'Ar','UA002', 0,'[conf::JIRAMAELEC]'); 
*/


/*redevances d exploitation portuaire*/	
/*Redevance domaniale*/
/*Dans l enceinte portuaire*/

insert into categoriefacturation values('CATFCI012','Redevance domaniale','Redevance domaniale');

Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170470', 'Redevance terrain non bitume dans enceinte portuaire', 'CATFCI012', 'REDV001', 'Eur','UA019', 0,'0.9'); 

Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170471', 'Redevance terrain bitume normal lourd dans enceinte portuaire', 'CATFCI012', 'REDV001', 'Eur','UA019', 0,'1.535'); 
 
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170472', 'Redevance terrain en beton arme dans enceinte portuaire', 'CATFCI012', 'REDV001', 'Eur','UA019', 0,'1.584'); 
   
/*A l exterieur de l enceinte portuaire*/ 
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170473', 'Redevance terrain non bitume exterieur enceinte portuaire', 'CATFCI012', 'REDV001', 'Eur','UA031', 0,'0.9'); 
 
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170474', 'Redevance terrain bitume normal lourd exterieur enceinte portuaire', 'CATFCI012', 'REDV001', 'Eur','UA031', 0,'1.935'); 
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170475', 'Redevance terrain en beton arme exterieur enceinte portuaire', 'CATFCI012', 'REDV001', 'Eur','UA031', 0,'1.44'); 
   
/*A proximité des quais*/   
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170476', 'Redevance terrain non bitume a proximite des quais', 'CATFCI012', 'REDV001', 'Eur','UA019', 0,'1.17'); 
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170477', 'Redevance terrain bitume normal lourd a proximite des quais', 'CATFCI012', 'REDV001', 'Eur','UA019', 0,'1.814');    
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170478', 'Redevance terrain en beton arme a proximite des quais', 'CATFCI012', 'REDV001', 'Eur','UA019', 0,'0.8');    
     
/*Péage pipeline*/   
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170479', 'Redevance Peage pipeline', 'CATFCI012', 'REDV001', 'Eur','UA019', 0,'0.8');   

/*OCCUPATION DE LOCAUX*/
insert into categoriefacturation values('CATFCI013','Redevance locative','Redevance locative');

/*Location magasins et hangars*/   
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170480', 'Redevance pour location magasins et hangars dans enceinte portuaire', 'CATFCI013', 'REDV001', 'Eur','UA019', 0,'2.43');   
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170481', 'Redevance pour location magasins et hangars hors enceinte portuaire', 'CATFCI013', 'REDV001', 'Eur','UA019', 0,'2.209');   
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170482', 'Redevance pour location magasins et hangars a proximite des quais', 'CATFCI013', 'REDV001', 'Eur','UA019', 0,'2.872');   

/*Location batiments à usage administratif*/   
 Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170483', 'Redevance pour location batiments à usage administratif dans enceinte portuaire', 'CATFCI013', 'REDV001', 'Eur','UA019', 0,'15.625');   
  
 Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170484', 'Redevance pour location batiments à usage administratif hors enceinte portuaire', 'CATFCI013', 'REDV001', 'Eur','UA019', 0,'6.25');   

Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170485', 'Redevance pour location batiments a usage de logement hors enceinte portuaire', 'CATFCI013', 'REDV001', 'Eur','UA019', 0,'9.375');   
        
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170486', 'Redevance pour logements sociaux Cite Hastie', 'CATFCI013', 'REDV001', 'Ar','UA017', 0,'200000');   
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170487', 'Redevance pour logements sociaux Cite Meteo', 'CATFCI013', 'REDV001', 'Ar','UA017', 0,'160000');   
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170488', 'Redevance pour logements sociaux Cite Marabout', 'CATFCI013', 'REDV001', 'Ar','UA017', 0,'160000');   
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170489', 'Redevance pour logements sociaux Cite Canada', 'CATFCI013', 'REDV001', 'Ar','UA017', 0,'160000');   
                   
/*OCCUPATION DE LOCAUX*/
insert into categoriefacturation values('CATFCI014','Redevance variable','Redevance variable'); 
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170490', 'Tarif de base Embarquement/Debarquement', 'CATFCI014', 'REDV001', 'Eur','UA022', 0,'2');   
      
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170491', 'Produits salissants Embarquement/Debarquement', 'CATFCI014', 'REDV001', 'Eur','UA022', 0,'2.4');   
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, PU)
 Values
   ('RB0000000021170492', 'Produits dangereux Embarquement/Debarquement', 'CATFCI014', 'REDV001', 'Eur','UA022', 0,'2.5');       
   
/*Droit de port*/   
/*Droit de port bornage et peche*/ 

insert into categoriefacturation values('CATFCI015','Bornage et peche','Bornage et peche');

Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA)
 Values
   ('RB0000000021170493', 'Droit de port bornage et peche', 'CATFCI015', 'REDV001', 'Ar','UA036', 0);       
   
   --DFF0000000023170586
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170587', 'Droit de port bornage et peche national V<250', '-', 1, 1, '900', 'UA036', 
    'RB0000000021170493', '[estNational]==''National''&&[volume]<250', '1');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170588', 'Droit de port bornage et peche international V<250', '-', 1, 1, '1710', 'UA036', 
    'RB0000000021170493', '[estNational]==''International''&&[volume]<250', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170589', 'Droit de port bornage et peche national 250<=V<500', '-', 1, 1, '1000', 'UA036', 
    'RB0000000021170493', '[estNational]==''National''&&[volume]>=250&&[volume]<500', '1');	  
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170590', 'Droit de port bornage et peche international 250<=V<500', '-', 1, 1, '1900', 'UA036', 
    'RB0000000021170493', '[estNational]==''International''&&[volume]>=250&&[volume]<500', '1');	 	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170591', 'Droit de port bornage et peche national V>=500', '-', 1, 1, '1900', 'UA036', 
    'RB0000000021170493', '[estNational]==''National''&&[volume]>=500', '1');	 
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170592', 'Droit de port bornage et peche international V>=500', '-', 1, 1, '2090', 'UA036', 
    'RB0000000021170493', '[estNational]==''National''&&[volume]>=500', '1');		
 
 /*Droit de port passagers bornage et peche*/  
 Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA)
 Values
   ('RB0000000021170494', 'Droit de port Passagers bornage et peche', 'CATFCI015', 'REDV001', 'Eur','UA036', 0);       

Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170593', 'Droit de port passager bornage et peche  national', '-', 1, 1, '1', 'UA001', 
    'RB0000000021170494', '[estNational]==''National''', '1');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170594', 'Droit de port passager bornage et peche  international', '-', 1, 1, '0', 'UA001', 
    'RB0000000021170494', '[estNational]==''International''', '1');		
	
/*Droit de stationnement bornage et peche*/	
 Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA)
 Values
   ('RB0000000021170495', 'Droit de stationnement bornage et peche', 'CATFCI015', 'REDV001', 'Ar','UA044', 0); 
   
/*Droit de stationnement bornage et peche V<500*/   
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170595', 'Droit de stationnement bornage et peche  national V<500 1er au 3e jour', '-', 1, 1, '252', 'UA044', 
    'RB0000000021170495', '[estNational]==''National''&&[volume]<500&&(Math.min([nbjour],3)<=3)', '[longueur]*Math.min([nbjour],3)');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170596', 'Droit de stationnement bornage et peche  national V<500 4e au 6e jour', '-', 1, 1, '416', 'UA044', 
    'RB0000000021170495', '[estNational]==''National''&&[volume]<500&&(Math.min([nbJour],6)>=4)', '[longueur]*(Math.min([nbjour],6)-3)');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170597', 'Droit de stationnement bornage et peche  national V<500 7e jour et plus', '-', 1, 1, '578', 'UA044', 
    'RB0000000021170495', '[estNational]==''National''&&[volume]<500&&(Math.max([nbJour],6)>=7)', '[longueur]*(Math.max([nbjour],7)-6)');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170598', 'Droit de stationnement bornage et peche  International V<500 1er au 3e jour', '-', 1, 1, '460.8', 'UA044', 
    'RB0000000021170495', '[estNational]==''International''&&[volume]<500&&(Math.min([nbjour],3)<=3)', '[longueur]*Math.min([nbjour],3)');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170599', 'Droit de stationnement bornage et peche  international V<500 4e au 6e jour', '-', 1, 1, '790.4', 'UA044', 
    'RB0000000021170495', '[estNational]==''International''&&[volume]<500&&(Math.min([nbJour],6)>=4)', '[longueur]*(Math.min([nbjour],6)-3)');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170600', 'Droit de stationnement bornage et peche  international V<500 7e jour et plus', '-', 1, 1, '1098.2', 'UA044', 
    'RB0000000021170495', '[estNational]==''International''&&[volume]<500&&(Math.max([nbJour],6)>=7)', '[longueur]*(Math.max([nbjour],7)-6)');	

/*Droit de stationnement bornage et peche V>=500 && V<1000*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170601', 'Droit de stationnement bornage et peche  national 500<=V<1000 1er au 3e jour', '-', 1, 1, '314', 'UA044', 
    'RB0000000021170495', '[estNational]==''National''&&[volume]>=500&&[volume]<1000&&(Math.min([nbjour],3)<=3)', '[longueur]*Math.min([nbjour],3)');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170602', 'Droit de stationnement bornage et peche  national 500<=V<1000 4e au 6e jour', '-', 1, 1, '518', 'UA044', 
    'RB0000000021170495', '[estNational]==''National''&&[volume]>=500&&[volume]<1000&&(Math.min([nbJour],6)>=4)', '[longueur]*(Math.min([nbjour],6)-3)');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170603', 'Droit de stationnement bornage et peche  national 500<=V<1000 7e jour et plus', '-', 1, 1, '720', 'UA044', 
    'RB0000000021170495', '[estNational]==''National''&&[volume]>=500&&[volume]<1000&&(Math.max([nbJour],6)>=7)', '[longueur]*(Math.max([nbjour],7)-6)');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170604', 'Droit de stationnement bornage et peche  International 500<=V<1000 1er au 3e jour', '-', 1, 1, '596.6', 'UA044', 
    'RB0000000021170495', '[estNational]==''International''&&[volume]>=500&&[volume]<1000&&(Math.min([nbjour],3)<=3)', '[longueur]*Math.min([nbjour],3)');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170605', 'Droit de stationnement bornage et peche  international 500<=V<1000 4e au 6e jour', '-', 1, 1, '984.2', 'UA044', 
    'RB0000000021170495', '[estNational]==''International''&&[volume]>=500&&[volume]<1000&&(Math.min([nbJour],6)>=4)', '[longueur]*(Math.min([nbjour],6)-3)');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170606', 'Droit de stationnement bornage et peche  international 500<=V<1000 7e jour et plus', '-', 1, 1, '1368', 'UA044', 
    'RB0000000021170495', '[estNational]==''International''&&[volume]>=500&&[volume]<1000&&(Math.max([nbJour],6)>=7)', '[longueur]*(Math.max([nbjour],7)-6)');	

/* Droit de stationnement bornage et peche 1000<=V<1500*/	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170607', 'Droit de stationnement bornage et peche  national 1000<=V<1500 1er au 3e jour', '-', 1, 1, '378', 'UA044', 
    'RB0000000021170495', '[estNational]==''National''&&[volume]>=1000&&[volume]<1500&&(Math.min([nbjour],3)<=3)', '[longueur]*Math.min([nbjour],3)');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170608', 'Droit de stationnement bornage et peche  national 1000<=V<1500 4e au 6e jour', '-', 1, 1, '624', 'UA044', 
    'RB0000000021170495', '[estNational]==''National''&&[volume]>=1000&&[volume]<1500&&(Math.min([nbJour],6)>=4)', '[longueur]*(Math.min([nbjour],6)-3)');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170609', 'Droit de stationnement bornage et peche  national 1000<=V<1500 7e jour et plus', '-', 1, 1, '870', 'UA044', 
    'RB0000000021170495', '[estNational]==''National''&&[volume]>=1000&&[volume]<1500&&(Math.max([nbJour],6)>=7)', '[longueur]*(Math.max([nbjour],7)-6)');	
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170610', 'Droit de stationnement bornage et peche  International 1000<=V<1500 1er au 3e jour', '-', 1, 1, '718.2', 'UA044', 
    'RB0000000021170495', '[estNational]==''International''&&[volume]>=1000&&[volume]<1500&&(Math.min([nbjour],3)<=3)', '[longueur]*Math.min([nbjour],3)');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170611', 'Droit de stationnement bornage et peche  international 1000<=V<1500 4e au 6e jour', '-', 1, 1, '1185.6', 'UA044', 
    'RB0000000021170495', '[estNational]==''International''&&[volume]>=1000&&[volume]<1500&&(Math.min([nbJour],6)>=4)', '[longueur]*(Math.min([nbjour],6)-3)');
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170612', 'Droit de stationnement bornage et peche  international 1000<=V<1500 7e jour et plus', '-', 1, 1, '1653', 'UA044', 
    'RB0000000021170495', '[estNational]==''International''&&[volume]>=1000&&[volume]<1500&&(Math.max([nbJour],6)>=7)', '[longueur]*(Math.max([nbjour],7)-6)');	
	
/*rectif enlevement ordures*/	
delete from detformufact where mere='RBR0130';

Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170613', 'Enlevement ordures national 1er au 5e jour', '-', 1, 1, '50.607', 'UA006', 
    'RBR0130', '[estNational]==''National''&&(Math.min([nbjour],5)<=5)', '1');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170614', 'Enlevement ordures national 6e au 10e jour', '-', 1, 1, '33.738', 'UA006', 
    'RBR0130', '[estNational]==''National''&&(Math.min([nbJour],10)>=6)', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170615', 'Enlevement ordures national 11e jour et plus', '-', 1, 1, '22.492', 'UA006', 
    'RBR0130', '[estNational]==''National''&&(Math.max([nbJour],10)>=11)', '1');
	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170616', 'Enlevement ordures international 1er au 5e jour', '-', 1, 1, '96.154', 'UA006', 
    'RBR0130', '[estNational]==''International''&&(Math.min([nbjour],5)<=5)', '1');		
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170617', 'Enlevement ordures international 6e au 10e jour', '-', 1, 1, '64.102', 'UA006', 
    'RBR0130', '[estNational]==''International''&&(Math.min([nbJour],10)>=6)', '1');	
Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170618', 'Enlevement ordures international 11e jour et plus', '-', 1, 1, '42.735', 'UA006', 
    'RBR0130', '[estNational]==''International''&&(Math.max([nbJour],10)>=11)', '1');	

	--CATFCI015
	insert into unite_activite values('UA052','T ou M3','T ou M3');
/*Peage marchandises et bagages bornage et peche*/	
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA,PU)
 Values
   ('RB0000000021170496', 'Peage marchandises et bagages bornage et peche national', 'CATFCI015', 'REDV001', 'Ar','UA052', 0,'1400'); 
   Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA,PU)
 Values
   ('RB0000000021170497', 'Peage marchandises et bagages bornage et peche international', 'CATFCI015', 'REDV001', 'Ar','UA052', 0,'2660');
/*Bagages bornages et peche*/   
   Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA)
 Values
   ('RB0000000021170498', 'Bagages bornage et peche', 'CATFCI015', 'REDV001', 'Ar','UA015', 0);
   Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170619', 'Bagages bornage et peche national >100kg', '-', 1, 1, '50', 'UA015', 
    'RB0000000021170498', '[estNational]==''National''&&[qte]>100', '[qte]');	
	Insert into DETFORMUFACT
   (ID,REM, COMPTE, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170620', 'Bagages bornage et peche international >100kg', '-', 1, 1, '95', 'UA015', 
    'RB0000000021170498', '[estNational]==''International''&&[qte]>100', '[qte]');

/*Perception pour annulation de facture emise au comptant*/	
insert into categoriefacturation values('CATFCI016','Perception pour annulation de facture emise au comptant','Perception pour annulation de facture emise au comptant');

Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA,PU)
 Values
   ('RB0000000021170499', 'Annulation facture cause provenant du client M<1.000.000Ar', 'CATFCI016', 'REDV001', 'Ar','UA006', 0,'20000');
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA,PU)
 Values
   ('RB0000000021170500', 'Annulation facture cause provenant du client 1.000.000<=M<2.000.000Ar', 'CATFCI016', 'REDV001', 'Ar','UA006', 0,'50000');
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA,PU)
 Values
   ('RB0000000021170501', 'Annulation facture cause provenant du client M>=2.000.000Ar', 'CATFCI016', 'REDV001', 'Ar','UA006', 0,'1000000');
     
/*Defaut de déclaration*/   
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA,PU)
 Values
   ('RB0000000021170502', 'Annulation facture Defaut de declaration', 'CATFCI016', 'REDV001', 'Eur','UA006', 0,'7500');
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA,PU)
 Values
   ('RB0000000021170503', 'Annulation facture Destruction volontaire', 'CATFCI016', 'REDV001', 'Eur','UA006', 0,'45000');     
   
   
   
   
   
   
   
   
   
   