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




Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300001', 'Cession d''eau douce cabotage national', 1, 1, '1.263', 'UA003', 
    'RBR0126', '[natureoperation]==''NATM0001''&&[estNational]==''National''', '[volume]');

Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300002', 'Cession d''eau douce cabotage international/Long', 1, 1, '2.399', 'UA003', 
    'RBR0126', '[natureoperation]==''NATM0001''&&[estNational]==''International''', '[volume]');

Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300003', 'Autorisation piquage de rouille et peinture coque cabotage national', 1, 1, '11', 'UA051', 
    'RBR0128', '[natureoperation]==''NATM0003''&&[estNational]==''National''', '[nbJour]');

Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300004', 'Autorisation piquage de rouille et peinture coque cabotage international/Long', 1, 1, '24.852', 'UA051', 
    'RBR0128', '[natureoperation]==''NATM0003''&&[estNational]==''International''', '[nbJour]');

Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300005', 'Autorisation d''immobilisation cabotage national', 1, 1, '13.08', 'UA051', 
    'RBR0129', '[natureoperation]==''NATM0004''&&[estNational]==''National''', '[nbJour]');

Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300006', 'Autorisation d''immobilisation cabotage international/Long', 1, 1, '24.852', 'UA051', 
    'RBR0129', '[natureoperation]==''NATM0004''&&[estNational]==''International''', '[nbJour]');

Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300007', 'Services en haute mer cabotage national', 1, 1, '79.944', 'UA002', 
    'RBR0127', '[natureoperation]==''NATM0002''&&[estNational]==''National''', '[nbHeure]');

Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300008', 'Services en haute mer cabotage international/Long', 1, 1, '79.944', 'UA051', 
    'RBR0127', '[natureoperation]==''NATM0002''&&[estNational]==''International''', '[nbHeure]');

Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300009', 'Enlevement d''ordures 1er au 5e jour cabotage national', 1, 1, '50.607', 'UA006', 
    'RBR0130', '[natureoperation]==''NATM0005''&&[estNational]==''National''', '1');

Insert into DETFORMUFACT (ID, REM,MIN, MAX, FORMULE, UNITE, MERE, CONDITION, FORMULEQTE) Values 
('DFF00000000300010', 'Enlevement d''ordures 1er au 5e jour cabotage international/Long', 1, 1, '96.154', 'UA006', 
    'RBR0130', '[natureoperation]==''NATM0005''&&[estNational]==''International''', '1');


