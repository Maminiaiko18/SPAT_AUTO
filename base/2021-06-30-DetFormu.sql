/*Unite*/
Insert into UNITE_ACTIVITE
   (ID, VAL, DESCE)
 Values
   ('UNIT0000000000164621', '100M3', '100M3');
   
/*Droit de port*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170444', 'Droit de port calcule', 'CATFC001', 'REDV001', 'Eur', 
    'UNIT0000000000164621', 0, 'DIR00006');

/*Droit de port inférieur à 3000 national */	
Insert into DETFORMUFACT
   (ID, REM,MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170444', 'Droit de port V<3000 national',1, 1, '1.833', 'UA006', 
    'RB0000000021170444', '[estNational]==''National''&&[volume]<3000', '1');	
	
/*Droit de port entre 3000 à 9000 national */	
Insert into DETFORMUFACT
   (ID, REM,MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170445', 'Droit de port 3000<=V<9000 national', 1, 1, '0.47', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''National''&&[volume]>=3000&&[volume]<9000', '[volumeArrondi]');

/*Droit de port supérieur à 9000 national */
Insert into DETFORMUFACT
   (ID, REM,MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170446', 'Droit de port V>9000 national', 1, 1, '0.74', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''National''&&[volume]>=9000&&[cargaison]!=''CGM00001''', '[volumeArrondi]');

/*Droit de port supérieur à 9000 national pétrolier */
Insert into DETFORMUFACT
   (ID,REM,MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170447', 'Droit de port V>9000 petrolier national', 1, 1, '0.74', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''National''&&[volume]>=9000&&[cargaison]==''CGM00001''', '[volumeArrondi]');

/*Droit de port inférieur à 3000 international */		
Insert into DETFORMUFACT
   (ID, REM,MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170448', 'Droit de port V<3000 international', 1, 1, '3.483', 'UA006', 
    'RB0000000021170444', '[estNational]==''International''&&[volume]<3000', '1');

/*Droit de port entre 3000 à 9000 international */
Insert into DETFORMUFACT
   (ID, REM,MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170449', 'Droit de port 3000<=V<9000 international', 1, 1, '0.893', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''International''&&[volume]>=3000&&[volume]<9000', '[volumeArrondi]');
/*Droit de port supérieur à 9000 international */	
Insert into DETFORMUFACT
   (ID, REM,MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170450', 'Droit de port V>9000 international', 1, 1, '1.405', 'UNIT0000000000164621', 
    'RB0000000021170444', '[estNational]==''International''&&[volume]>=9000&&[cargaison]!=''CGM00001''', '[volumeArrondi]');

/*Droit de port supérieur à 9000 international pétrolier */
Insert into DETFORMUFACT
   (ID, REM,MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170451', 'Droit de port V>=9000 international petrolier', 1, 1, '1.546', 'UNIT0000000000164621', 
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
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170453', 'Min. percept. pilotage national',1, 1, '174.105', 'UA016', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]<15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '1');    
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170452', 'Min. percept. pilotage international',1, 1, '91.634', 'UA016', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]<15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '1');  
/*Minimum de perception nuit et férié*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170454', 'Min. percept. pilotage national ferie',1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]<15000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170455','Min. percept. pilotage international ferie', 1, 1, '2.298', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]<15000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '[volumeArrondi]');	

/*Manoeuvre entrée et sortie jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170456', 'Pilotage Entree/Sortie national',1, 1, '0.537', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170457', 'Pilotage Entree/Sortie international', 1, 1, '1.532', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');
	
/*Manoeuvre entrée et sortie nuit et férié */		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170458', 'Pilotage Entree/Sortie national ferie', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170459', 'Pilotage Entree/Sortie international ferie', 1, 1, '2.298', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	

/*Mouvement jour normal */		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170460', 'Pilotage Mouvement national', 1, 1, '0.47', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0004''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170461', 'Pilotage Mouvement international', 1, 1, '0.899', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0004''', '[volumeArrondi]');

/*Mouvement jour normal nuit et férié*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170462', 'Pilotage Mouvement national ferie', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0004''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170463', 'Pilotage Mouvement international ferie', 1, 1, '1.349', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0004''', '[volumeArrondi]');	

/*Sortie Pétrolier jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170464', 'Pilotage Sortie petrolier national', 1, 1, '0.537', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0005''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170465', 'Pilotage Sortie petrolier international', 1, 1, '1.532', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0005''&&[cargaison]==''CGM00001''', '[volumeArrondi]');

/*Sortie Pétrolier jour férié et nuit*/		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170466', 'Pilotage Sortie petrolier national ferie', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0005''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170467', 'Pilotage Sortie petrolier international ferie', 1, 1, '2.298', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0005''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
	
/*Entrée Pétrolier jour normal*/		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170468', 'Pilotage Entrée petrolier national', 1, 1, '0.537', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0003''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170469', 'Pilotage Entrée petrolier international', 1, 1, '1.685', 'UA041', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0003''&&[cargaison]==''CGM00001''', '[volumeArrondi]');
	
/*Entrée Pétrolier jour férié et nuit*/		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170470', 'Pilotage Entrée petrolier national ferie', 1, 1, '0.806', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''National''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0003''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170471', 'Pilotage Entrée petrolier international ferie', 1, 1, '2.527', 'UA048', 
    'RB0000000021170445', '[natureoperation]==''NAT0009''&&[estNational]==''International''&&[volume]>=15000&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0003''&&[cargaison]==''CGM00001''', '[volumeArrondi]');	

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
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170472', 'Min. percept. Remorquage national', 1, 1, '91.634', 'UA016', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]<3000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '1');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170473', 'Min. percept. Remorquage international', 1, 1, '174.105', 'UA016', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]<3000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''', '1');	
		
/*Minimum de perception remorquage nuit et jour ferié*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170474', 'Min. percept. Remorquage national ferie', 1, 1, '0.806', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]<3000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '1');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170475', 'Min. percept. Remorquage international ferie', 1, 1, '2.298', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]<3000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))', '1');	
	
/*Remorquage Entre 3000 et 5000M3 jour normal cargo*/		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170476', 'Remorquage 3.000<=V<5.000 national', 1, 1, '2.187', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170477', 'Remorquage 3.000<=V<5.000 international', 1, 1, '4.154', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
	
/*Remorquage Entre 3000 et 5000M3 nuit et jour férié  cargo*/		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170478', 'Remorquage 3.000<=V<5.000 national ferie', 1, 1, '3.281', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170479', 'Remorquage 3.000<=V<5.000 international ferie', 1, 1, '6.231', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	

/*Remorquage Supérieur à 5000M3 jour normal  cargo*/			
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170480', 'Remorquage V>=5.000 national', 1, 1, '2.824', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF00000000231704781', 'Remorquage V>=5.000 international', 1, 1, '5.363', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	

/*Remorquage Supérieur à 5000M3 nuit et jour férié  cargo*/		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170482', 'Remorquage V>=5.000 national ferie', 1, 1, '4.236', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170483', 'Remorquage V>=5.000 international ferie', 1, 1, '8.045', 'UA048', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
/*Majoration Remorquage entre 3.000 et 5.000 jour normal cargo*/ --manomboka 535
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170535', 'Maj. Remorq. 3000<=V<5.000 national', 1, 1, '65.67', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF00000000231704536', 'Maj. Remorq. 3000<=V<5.000 international', 1, 1, '124.775', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
/*Majoration Remorquage entre 3.000 et 5.000 jour normal férié et nuit cargo*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170537', 'Maj. Remorq. 3000<=V<5.000 national ferie', 1, 1, '98.505', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170538', 'Maj. Remorq. 3000<=V<5.000 international ferie', 1, 1, '187.163', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
/*Majoration Remorquage supérieur à 5.000 jour normal cargo*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170539', 'Maj. Remorq. V>=5.000 national', 1, 1, '126.385', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF00000000231704540', 'Maj. Remorq. V>=5.000 international', 1, 1, '198.765', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
/*Majoration Remorquage supérieur à 5.000 jour férié et nuit cargo*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170541', 'Maj. Remorq. V>=5.000 national ferie', 1, 1, '98.505', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170542', 'Maj. Remorq. V>=5.000 international ferie', 1, 1, '187.163', 'UA043', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0', '[nbQuartHeure]');	

/*Remorquage sortie pétrolier Entre 3000 et 20.000 jour normal*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170484', 'Remorquage 3000<=V<20.000 petrolier national', 1, 1, '2.187', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170485', 'Remorquage 3000<=V<20.000 petrolier international', 1, 1, '4.154', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	

/*Remorquage sortie pétrolier Entre 3000 et 20.000 jour férié et nuit*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170486', 'Remorquage 3000<=V<20.000 petrolier national ferie', 1, 1, '3.281', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170487', 'Remorquage 3000<=V<20.000 petrolier international ferie', 1, 1, '6.231', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
/*Remorquage sortie pétrolier Entre 20.000 et 50.000 jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170488', 'Remorquage sortie 20.000<=V<50.000 petrolier national', 1, 1, '4.582', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170489', 'Remorquage sortie 20.000<=V<50.000 petrolier international', 1, 1, '8.704', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	

/*Remorquage sortie pétrolier entre 20.000 et 50.000 jour férié et nuit*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170490', 'Remorquage sortie 20.000<=V<50.000 petrolier national ferie', 1, 1, '6.873', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170491', 'Remorquage sortie 20.000<=V<50.000 petrolier international ferie', 1, 1, '13.05', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	

/*Remorquage sortie pétrolier Entre 50.000 et 100.000 jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170492', 'Remorquage sortie 50.000<=V<100.000 petrolier national', 1, 1, '6.216', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170493', 'Remorquage sortie 50.000<=V<100.000 petrolier international', 1, 1, '11.809', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	

/*Remorquage sortie pétrolier Entre 50.000 et 100.000 jour férié et nuit*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170494', 'Remorquage sortie 50.000<=V<100.000 petrolier national ferie', 1, 1, '9.324', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170495', 'Remorquage sortie 50.000<=V<100.000 petrolier international ferie', 1, 1, '17.71', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	

/*Remorquage sortie pétrolier supérieur à 100.000 jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170496', 'Remorquage sortie V>=100.000 petrolier national', 1, 1, '8.014', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170497', 'Remorquage sortie V>=100.000 petrolier international', 1, 1, '15.226', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	

/*Remorquage sortie pétrolier supérieur à 100.000 jour férié et nuit*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170498', 'Remorquage sortie V>=100.000 petrolier national ferie', 1, 1, '12.021', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170499', 'Remorquage sortie V>=100.000 petrolier international ferie', 1, 1, '22.839', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	

/*Veille de sécurité sortie pétrolier*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170500', 'Veille de sécurité sortie pétrolier national', 1, 1, '28.647', 'UA002', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[nbHeure]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170501', 'Veille de sécurité sortie pétrolier national', 1, 1, '54.429', 'UA002', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[nbHeure]');	


/*Remorquage entrée pétrolier entre 3.000 et 20.000 jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170502', 'Remorquage entrée 3.000<=V<20.000 petrolier national', 1, 1, '2.187', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170503', 'Remorquage entrée 3.000<=V<20.000 petrolier international', 1, 1, '4.569', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	

/*Remorquage entrée pétrolier entre 3.000 et 20.000 jour férié et nuit*/		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170504', 'Remorquage entrée 3.000<=V<20.000 petrolier national ferie', 1, 1, '3.281', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170505', 'Remorquage entrée 3.000<=V<20.000 petrolier international ferie', 1, 1, '6.854', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	

/*Remorquage entrée pétrolier entre 20.000 et 50.000 jour normal*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170506', 'Remorquage entrée 20.000<=V<50.000 petrolier national', 1, 1, '4.582', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170507', 'Remorquage entrée 20.000<=V<50.000 petrolier international', 1, 1, '9.574', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	

/*Remorquage entrée pétrolier entre 20.000 et 50.000 jour férié et nuit*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170508', 'Remorquage entrée 20.000<=V<50.000 petrolier national ferie', 1, 1, '6.873', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170509', 'Remorquage entrée 20.000<=V<50.000 petrolier international ferie', 1, 1, '14.362', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	

/*Remorquage entrée pétrolier entre 50.000 et 100.000 jour normal*/		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170510', 'Remorquage entrée 50.000<=V<100.000 petrolier national', 1, 1, '6.216', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170511', 'Remorquage entrée 50.000<=V<100.000 petrolier international', 1, 1, '12.99', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
	
/*Remorquage entrée pétrolier entre 50.000 et 100.000 jour ferie et nuit*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170512', 'Remorquage entrée 50.000<=V<100.000 petrolier national ferie', 1, 1, '9.324', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170513', 'Remorquage entrée 50.000<=V<100.000 petrolier international ferie', 1, 1, '19.485', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	

/*Remorquage entrée pétrolier supérieur à 100.000 jour normal*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170514', 'Remorquage entrée V>=100.000 petrolier national', 1, 1, '8.014', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170515', 'Remorquage entrée V>=100.000 petrolier international', 1, 1, '16.749', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
	
/*Remorquage entrée pétrolier supérieur à 100.000 jour ferie et nuit*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170516', 'Remorquage entrée V>=100.000 petrolier national ferie', 1, 1, '12.021', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170517', 'Remorquage entrée V>=100.000 petrolier international ferie', 1, 1, '25.123', 'UA041', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	

/*Veille de sécurité entrée pétrolier*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170518', 'Veille de sécurité entrée pétrolier national', 1, 1, '28.647', 'UA002', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[nbHeure]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170519', 'Veille de sécurité entrée pétrolier international', 1, 1, '59.872', 'UA002', 
    'RB0000000021170446', '[natureoperation]==''NAT0005''&&[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[nbHeure]');	

/*Lamanage cargo jour normal*/
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170447', 'Lamanage calcule', 'CATFC001', 'REDV001', 'Eur', 
    'UA048', 0, 'DIR00006');

Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170520', 'Amarr. et desamarr. cargo national' , 1, 1, '0.537', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170521', 'Amarr. et desamarr. cargo international', 1, 1, '1.021', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
	
/*Lamanage cargo jour ferie et nuit*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170522', 'Amarr. et desamarr. cargo national ferie', 1, 1, '0.805', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170523', 'Amarr. et desamarr. cargo national ferie', 1, 1, '1.531', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''', '[volumeArrondi]');	
	
/*Lamanage sortie pétrolier jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170524', 'Amarr. et desamarr. petrolier national' , 1, 1, '0.807', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170525', 'Amarr. et desamarr. petrolier international', 1, 1, '1.532', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
	
/*Lamanage sortie pétrolier jour férié*/		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170526', 'Amarr. et desamarr. sortie petrolier national ferie ', 1, 1, '1.211', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170527', 'Amarr. et desamarr. sortie petrolier international ferie', 1, 1, '2.298', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', '[volumeArrondi]');	
	
/*Lamanage entrée pétrolier jour normal*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170528', 'Amarr. et desamarr. entrée petrolier national' , 1, 1, '0.807', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''National''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170529', 'Amarr. et desamarr. entrée petrolier international', 1, 1, '1.685', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''International''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
		
/*Lamanage entrée pétrolier jour ferie*/		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170530', 'Amarr. et desamarr. sortie petrolier national ferie', 1, 1, '1.211', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170531', 'Amarr. et desamarr. sortie petrolier international ferie', 1, 1, '2.527', 'UA048', 
    'RB0000000021170447', '[natureoperation]==''NAT0008''&&[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''', '[volumeArrondi]');	
		
	
/*Redevance communale*/	
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CATEGORIE, REDEVANCE, DEVISE, 
    UNITE, TVA, DIRECTION)
 Values
   ('RB0000000021170448', 'Redevance communale calcule', 'CATFC001', 'REDV001', 'Ar', 
    'UA006', 0, 'DIR00006');

/*Redevance LC étranger */	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170532', 'Redevance communale LC international', 1, 1, '400000', 'UA006', 
    'RB0000000021170448', '[estNational]==''International''&&[cargaison]!=''CGM00001''', '1');	
	
/*Redevance pétrolier étranger */		
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170533', 'Redevance communale pour pétrolier international', 1, 1, '400000', 'UA006', 
    'RB0000000021170448', '[estNational]==''International''&&[cargaison]==''CGM00001''', '1');		
	
/*Redevance LC national */	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170534', 'Redevance communale cabotage national', 1, 1, '30000', 'UA006', 
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
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170543', 'Stationnement poste ordinaire nav. national', 1, 1, '0.033', 'UA045', 
    'RB0000000021170448', '[estNational]==''National''&&[typequais]==''TYPE000003''', '[longueur]*[nbheure]');		
	
	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170544', 'Stationnement poste ordinaire nav. international', 1, 1, '0.063', 'UA045', 
    'RB0000000021170448', '[estNational]==''International''&&[typequais]==''TYPE000003''', '[longueur]*[nbheure]');	

/*Stationnement à quais spécialisé*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170545', 'Stationnement poste spec. nav. national', 1, 1, '0.048', 'UA045', 
    'RB0000000021170448', '[estNational]==''National''&&[typequais]==''TQ001''', '[longueur]*[nbheure]');		
	
	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170546', 'Stationnement poste spec. nav. international', 1, 1, '0.091', 'UA045', 
    'RB0000000021170448', '[estNational]==''International''&&[typequais]==''TQ001''', '[longueur]*[nbheure]');	
	
/*Stationnement poste pétrolier*/
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170547', 'Stationnement poste petrolier nav. national', 1, 1, '3.971', 'UA045', 
    'RB0000000021170448', '[estNational]==''National''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');		
	
	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170548', 'Stationnement poste petrolier nav. international', 1, 1, '7.545', 'UA045', 
    'RB0000000021170448', '[estNational]==''International''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');	

/*Stationnement en rade*/	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170549', 'Stationnement poste de mouillage nav. national', 1, 1, '0.025', 'UA045', 
    'RB0000000021170448', '[estNational]==''National''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');		
	
	
Insert into DETFORMUFACT
   (ID,REM, MIN, MAX, FORMULE, UNITE, 
    MERE, CONDITION, FORMULEQTE)
 Values
   ('DFF0000000023170550', 'Stationnement poste de mouillage nav. international', 1, 1, '0.048', 'UA045', 
    'RB0000000021170448', '[estNational]==''International''&&[typequais]==''TYPE000001''', '[longueur]*[nbheure]');	

/*Stationnement sans operation commerciale*/		

	
	
	
	
	
	
	