delete from contrat where 1=1;
delete from chantier where 1=1;
delete from travaux where 1=1;
delete from patrimoine where 1=1;
-------------etatpatrimoine
UPDATE ETATPATRIMOINE X
SET
    X.DESCE='Mauvais',
    X.VAL='Mauvais'
WHERE
    X.ID='ETAT000003';

INSERT INTO ETATPATRIMOINE (
    ID,
    VAL,
    DESCE
) VALUES (
    'ETATS0005',
    'Moyen',
    'Moyen'
);

INSERT INTO ETATPATRIMOINE (
    ID,
    VAL,
    DESCE
) VALUES (
    'ETATS0006',
    'HORS d''usage',
    'HORS d''usage'
);

INSERT INTO ETATPATRIMOINE (
    ID,
    VAL,
    DESCE
) VALUES (
    'ETATS0007',
    'Tres Bon',
    'Tres Bon'
);

-------LOGEMENT-BATIMENTS

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/001',
    'Bureau siège social de la S.P.A.T. (B.U.P)_Enceinte portuaire'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/002',
    'Bureau Mole A (avec magasin)_Mole A'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/003',
    'Bureau PORTALINO _Mole C'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/004',
    'Bureau commercial_A côté de la chaudronnerie'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/005',
    'Bureau atelier chaudronnerie_A côté du bureau commercial '
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/006',
    'Bureau Département Appui_Ex-magasin général'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/007',
    'Bureau d`enlèvement des véhicules_TP Ex-hangar 9bis'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/008',
    'Bureau sécurité Ambodifilao_A côté du bureau commercial '
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/009',
    'Bureau contrôle ZP                         (Porte n°2)_Porte n°2'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/010',
    'Bureau gendarme + logement Commandant de compagnie_Près porte n°2'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/011',
    'Bureau Douane (Porte n°2)_Porte n°2'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/012',
    'Bureau Douane (Visite plage)_Enceinte portuaire'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/013',
    'Bureau contrôle des documents_Porte n°1'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/014',
    'Bureau des Douanes_Porte n°1, enceinte port'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/015',
    'Bâtiment Ex-AFCONS_Près parking MANAMBINA II'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/016',
    'Bureau OTIV_Près porte n°2'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/017',
    'Bâtiment servant de MUSEE_Enceinte portuaire'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/018',
    'Bâtiment HOLCIM_Mole C'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/019',
    'Poste de contrôle entrée/sortie   (porte n°2)_Porte n°2'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/020',
    'Poste de contrôle central (porte n°2)_Porte n°2'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/021',
    'Poste de contrôle des marchandises conventionnelles_Près du Paking MANAMBINA II'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/022',
    'Poste de contrôle entrée/sortie du parking MANAMBINA_Parking MANAMBINA II'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/023',
    'Poste de contrôle pour pont bascule_Zone MANAMBINA I'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/024',
    'Poste de contrôle pour pont bascule_Zone MANAMBINA II'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/025',
    'Bureau S.M.M.C (Opération)_En face de la chaudronnerie'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/026',
    'Bâtiment CEMEDI et Commissariat de police_A côté du bureau OTIV'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/027',
    'CEMEDI_Près de l`hôtel de police Bazary kely'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/028',
    'Bâtiment TRANS 7_Rue du commerce'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUA/029',
    'Bureau main-d`œuvre_Blvd Ratsimilaho '
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/MAG/001',
    'Magasin A1_Derrière Mole B'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/MAG/002',
    'Magasin A2_Derrière Mole B'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/MAG/003',
    'Magasin B1_Mole B'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/MAG/004',
    'Magasin B2_Zone TIKO MANA'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/MAG/005',
    'Magasin C1_Mole C1'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/MAG/006',
    'Magasin CODAL_Cité Canada Blvd de l`Ivondro'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/HAN/001',
    'Hangar 6_Coté Darse 2B'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/HAN/002',
    'Hangar 7_Coté Darse 2B'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/HAN/003',
    'Hangar DH1_Entre porte n°1 et n°2'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/HAN/004',
    'Hangar DH2_Entre porte n°1 et n°2'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/HAN/005',
    'Hangar DH3_Entre porte n°1 et n°2'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/HAN/006',
    'Hangar DH4_Entre porte n°1 et n°2'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/HAN/007',
    'Hangar séchage bois_Côté Darse 1B'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/HAN/008',
    'Hangar n°1 domaine TIKO_Enceinte TIKO'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/HAN/009',
    'Hangar n°2 domaine TIKO_Enceinte TIKO'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/ATE/001',
    'Ateliers Chaudronnerie_Côté SLIPWAY'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/ATE/002',
    'Atelier de maintenance_Près de la Chaudronnerie'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/ATE/003',
    'Atelier mécanique général et ouvrages bois_Entre Darse 1B et 2B'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/ATE/004',
    'Atelier de réparation_Côté Sud DARSE 2B'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/GAT/001',
    'GATE_Porte n°1'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/CHE/001',
    'Château d`eau_Près du bureau pompier'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/POB/001',
    'Pont bascule_MANAMBINA I'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/POB/002',
    'Pont bascule_MANAMBINA II'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/POB/003',
    'Pont bascule_Zone Silo en béton'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/POT/001',
    'Poste transformateur_A côté du site KRAOMA'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/POT/002',
    'Poste transformateur_TP Mahasarika'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/POT/003',
    'Poste transformateur_Près de HOLCIM'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/POT/004',
    'Poste transformateur_Près du SILO'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BLS/001',
    'Bloc sanitaire_Zone bureau des Douanes'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BLS/002',
    'Bloc sanitaire_Zone Chambre de commerce'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BLS/003',
    'Bloc sanitaire_Zone MANAMBINA I'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BLS/004',
    'Bloc sanitaire_Zone MANAMBINA II'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BLS/005',
    'Bloc sanitaire_Entre HOLCIM et PORTALINO'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/POE/001',
    'Poste 40 Electricité_En face du site KRAOMA'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/SEB/001',
    'SILO en béton_Côté usine TIKO MANA'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/ABC/001',
    'Abri chaudière_Côté Sud DARSE 2B'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/AGP/001',
    'Abri groupe de pompage_Côté Sud DARSE 2B'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/AGV/001',
    'Abri véhicule_Côté Sud DARSE 2B'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/001',
    'Centre CNAM_Rue du commerce'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/002',
    'Centre Socioculturel et sportif_Cité Canada Blvd de l`Ivondro'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/033',
    'P.A.C.T._Près du Stade Municipal'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/003',
    'MUSEE Universitaire CICOR_Près Stade Municipal'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/090',
    'Lavoirs et WC  Cité Canada_Cité Canada Blvd de l`Ivondro'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/004',
    'Cité Hastie logement n°01_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/005',
    'Cité Hastie logement n°02_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/006',
    'Cité Hastie logement n°03_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/007',
    'Cité Hastie logement n°499_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/008',
    'Cité Hastie logement n°500_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/009',
    'Cité Hastie logement n°501_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/010',
    'Cité Hastie logement n°502_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/011',
    'Cité Hastie logement n°503_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/012',
    'Cité Hastie logement n°504_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/013',
    'Cité Hastie logement n°505_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/014',
    'Cité Hastie logement n°506_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/015',
    'Cité Hastie logement n°507_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/016',
    'Cité Hastie logement n°508_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/017',
    'Cité Hastie logement n°509_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/018',
    'Cité Hastie logement n°510_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/019',
    'Cité Hastie logement n°511_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/020',
    'Cité Hastie logement n°551_Enceinte portuaire'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/021',
    'Cité Hastie logement n°552_Enceinte portuaire'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/022',
    'Cité Météo logement n°01_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/023',
    'Cité Météo logement n°02_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/024',
    'Cité Météo logement n°T.P. 5_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/025',
    'Cité Météo logement n° T.P. 6_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/026',
    'Cité Météo logement n° T.P. 7_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/027',
    'Cité Météo logement n° T.P. 8_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/028',
    'Cité Météo logement n° 530_Ampasimazava'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/029',
    'Cité Camps des Manguiers  logement n°T.P. 2_Près du Stade Municipal'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/030',
    'Cité Camps des Manguiers logement n°T.P. 3_Près du Stade Municipal'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/031',
    'Cité Camps des Manguiers  logement n°T.P. 40_Près du Stade Municipal'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/032',
    'Cité Camps des Manguiers  logement n°T.P. 41_Près du Stade Municipal'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/034',
    'Cité Marabout logement n°401_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/035',
    'Cité Marabout logement n°402_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/036',
    'Cité Marabout logement n°403_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/037',
    'Cité Marabout logement n°404_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/038',
    'Cité Marabout logement n°405_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/039',
    'Cité Marabout logement n°406_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/040',
    'Cité Marabout logement n°407_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/041',
    'Cité Marabout logement n°408_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/042',
    'Cité Marabout logement n°409_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/043',
    'Cité Marabout logement n°410_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/044',
    'Cité Marabout logement n°411_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/045',
    'Cité Marabout logement n°412_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/046',
    'Cité Marabout logement n°413_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/047',
    'Cité Marabout logement n°414_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/048',
    'Cité Marabout logement n°415_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/049',
    'Cité Marabout logement n°416_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/050',
    'Cité Marabout logement n°417_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/051',
    'Cité Marabout logement n°418_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/052',
    'Cité Marabout logement n°419_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/053',
    'Cité Marabout logement n°420_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/054',
    'Cité Marabout logement n°421_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/055',
    'Cité Marabout logement n°422_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/056',
    'Cité Marabout logement n°423_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/057',
    'Cité Marabout logement n°424_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/058',
    'Cité Marabout logement n°425_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/059',
    'Cité Marabout logement n°426_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/060',
    'Cité Marabout logement n°427_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/061',
    'Cité Marabout logement n°428_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/062',
    'Cité Marabout logement n°429_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/063',
    'Cité Marabout logement n°430_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/064',
    'Cité Marabout logement n°431_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/065',
    'Cité Marabout logement n°432_Près du pompier C.U.T.'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/066',
    'Cité Canada logement n°201_Boulevard de l`Ivondro'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/067',
    'Cité Canada logement n°202_Boulevard de l`Ivondro'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/068',
    'Cité Canada logement n°203_Boulevard de l`Ivondro'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/069',
    'Cité Canada logement n°204_Boulevard de l`Ivondro'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/070',
    'Cité Canada logement n°205_Boulevard de l`Ivondro'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/071',
    'Cité Canada logement n°206_Boulevard de l`Ivondro'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/072',
    'Cité Canada logement n°207_Boulevard de l`Ivondro'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/073',
    'Cité Canada logement n°208_Boulevard de l`Ivondro'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/074',
    'Cité Canada logement n°209_Boulevard de l`Ivondro'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/075',
    'Villa TSARAVINTANA_Blvd Ratsimilaho '
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/076',
    'Villa THERESINETTE_Rue de l`indépendance'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/077',
    'EX-SONACO_Ampasimazava, près de DZAMA'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/078',
    'Ex-dispensaire Androranga_Androranga'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/079',
    'Logement pour Médecin Androranga_Androranga'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/080',
    'Ex-dispensaire Morarano_Morarano'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/081',
    'Logement pour Médecin Morarano_Morarano'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/082',
    'Ex-dispensaire Mangarivotra Sud_Managarivotra '
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/083',
    'Logement pour Médecin  Mangarivotra Sud_Managarivotra '
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/084',
    'Ex-dispensaire Tanambao V_Tanambao V'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/085',
    'Logement pour Médecin   Tanambao V_Tanambao V'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/086',
    'Ex-dispensaire Ankirihiry_Ankirihiry'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/087',
    'Logement pour Médecin Ankirihiry_Ankirihiry'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/088',
    'Villa G-15_Ex-Village des jeux Ankorondrano'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000006',
    'A/BUS/089',
    'Logement et Bungalow_Antanambe Mananara Nord'
);

---------TERRAINS-TERRE-PLEINE
INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/001',
    'Terre-plein Mole C1_Mole C_6000'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/002',
    'Terre-plein pointe Mole B_Mole B_985'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/003',
    'Terre-plein B1_Mole B_4365'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/004',
    'Terre-plein Mole A_Mole A_1716'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/005',
    'Terre-plein A1_Devant magasin A1_1305'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/006',
    'Terre-plein A2_Devant magasin A2_'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/007',
    'Terre-plein MAHASARIKA_Devant B.U.P_20894'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/008',
    'Terre-plein SLIPWAY_Devant chaudronnerie_'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/009',
    'Terre-plein LOHAVANONA + Ateliers_A côté château d`eau_9393'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/010',
    'Site Opération building_Face Chaudronnerie_'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/011',
    'Site KRAOMA_Ex-Site guichet unique_9300'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/012',
    'Terre-plein SANTATRA_Derrière Darse 1B_5264'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/013',
    'Terre-plein MANAMBINA I_MANAMBINA I_5748'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/014',
    'Terre-plein MANAMBINA II_MANAMBINA II_10800'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/015',
    'Terre-plein Ex-poste médical_Ex-bureau poste médical_5800'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/016',
    'Terre-plein Centre de formation_Devant bureau Ex-magasin général_'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/017',
    'Terre-plein H.I.TA II_Entre SILO en béton et Ex-Commissariat de police_2534,83'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/018',
    'Terrain H.I.TA I_Derrière Silo en Béton_1308'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/019',
    'Terre-plein à TC additionnel_Nord MOCO_50000'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/020',
    'Terre-plein H6_Devant Hangar 6_801,97'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/021',
    'Terre-plein H7_Devant Hangar 7_844,36'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/022',
    'Terre-plein Pergola_En face bâtiment CEMEDI_4465'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/023',
    'Terre-plein à conteneurs_Mole C_95191'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/024',
    'Terre-plein à conteneurs_Zone Ex Hangar 16_21825'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/025',
    'Terre-plein à conteneurs_Zone Raymond Bang_42184'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/026',
    'Terrain Mole B_A proximité quai Mole B_881,72'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/027',
    'Terrain pour exploitation d`outillage de pêche_Côté quai plage_8183'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/028',
    'Terrain pour exploitation d`outillage privé_Côté quai darse_1122'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/029',
    'Terrain pour exploitation d`outillage privé_Côté TP C1_2255'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/030',
    'Terrain pour exploitation d`outillage privé_Côté TP C1_802'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/031',
    'Terrain pour exploitation d`outillage privé_Côté quai C1 et C2_1814,7'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/032',
    'Terrain pour exploitation d`outillage privé_Entre magasin A1 et A2_1550'
);


INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/022',
    'Parking Cité Canada_Cité Canada_'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/023',
    'Terrain de basket-ball_Cité Canada_'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/024',
    'Terrain de foot_Cité Canada_'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/025',
    'Terrain de hand-ball_Cité Canada_'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/026',
    'Terrain de tennis_Cité Canada_'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000001',
    'A/TEP/027',
    'Terrain de basket-ball_Cité Vohitsara_'
);

-----Materiels roulants
INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'F/REM/001',
    'NOE_DAMEN STANTUG_TM 10 004',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'F/REM/002',
    'VOLAZARA_DAMEN STANTUG_TM 01 011',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'F/REM/003',
    'ANTSIKA_CATERPILLAR_TM 93 001',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'F/REM/004',
    'FIHAVANANA_CATERPILLAR_TM 94 051',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'F/VED/001',
    'FANANTENANA_CATERPILLAR_TM 95 007',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'F/VED/002',
    'KINGA_YAMAHA_TM 10 009',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/004',
    'TOYOTA HILUX_Plateau_5533 AE',
    'ETATS0005'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/006',
    'TOYOTA HILUX_Plateau_7250 AF',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/007',
    'TOYOTA HILUX_Plateau_7252 AF',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/009',
    'TOYOTA HILUX_Plateau_8665 AF',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/010',
    'TOYOTA HILUX_MINI BUS_0040 AH',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/011',
    'TOYOTA HILUX_Plateau_5174AH',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/012',
    'FORTUNER_Fourgon_5647AH',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/014',
    'TOYOTA PRADO_BREAK_6517 TAJ',
    NULL
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/015',
    'TOYOTA LAND CRUISER_BREAK_3046 TBH',
    NULL
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/016',
    'VOLKSWAGEN TOUAREG_CIAP_5892 TAL',
    'ETATS0005'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/017',
    'MERCEDES_ML 350_37396 WWT',
    NULL
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/018',
    'TOYOTA LAND CRUISER_BREAK_4459 TBG',
    NULL
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/019',
    'VY TAOBAVY_AGRICOLE_8869 AB',
    'ETATS0005'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/020',
    'TRACTEUR_TA_2536 AE',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/021',
    'TRACTEUR_TA_2535 AE',
    'ETATS0005'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/022',
    'RENAULT KERAX_BENNES A ORDURES_9774 AE',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/023',
    'RENAULT KERAX_CITERNE_9775 AE',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/024',
    'CATERPILLAR_CAMION CHARGEUR_966G',
    'ETATS0005'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/025',
    'NISSAN_BENNE BASCULANTE_7542 AE',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/026',
    'CATERPILLAR_CHARGEUSE_272C',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/027',
    'TRACTEUR_BALAYEUSE_',
    'ETAT000003'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/028',
    'AUTO POMPE_HAKA_',
    'ETAT000003'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/029',
    'AUTO POMPE_SIDES_',
    'ETAT000003'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/030',
    'DAF_BENNE A ORDURES_4409AC',
    'ETATS0005'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/032',
    'ELEVATEUR_HYSTER_9693AB',
    'ETATS0006'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/033',
    'ELEVATEUR_HYSTER_9793AB',
    'ETATS0005'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/034',
    'TOYOTA FORTUNER_Fourgon_11836WWT',
    'ETATS0007'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/035',
    'TOYOTA FORTUNER_Fourgon_42334WWT',
    'ETATS0007'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/036',
    'TOYOTA FORTUNER_Fourgon_46348WWT',
    'ETATS0007'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/037',
    'TOYOTA HILUX_Plateau_23756WWT',
    'ETATS0007'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/038',
    'TOYOTA HILUX_Plateau_29174WWT',
    'ETATS0007'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/039',
    'MERCEDES AROCS 3345_CAMION INCENDIE-',
    'ETATS0007'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000005',
    'B/VEH/040',
    'TOYOTA LAND CRUISER 200TDSL__',
    'ETATS0007'
);

-------patrimoine Foncier
INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/BAC/001',
    'Balance de circuit_BUHLER_Silo en béton 3e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'C/CLI/025',
    'Climatiseur_TCL_Silo en béton Salle de moniteur',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'C/CLI/026',
    'Climatiseur_TCL_Bureau du chef de service',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'C/CLI/027',
    'Climatiseur_TCL_Bureau du Chef de service',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'C/CLI/028',
    'Climatiseur_TCL_Pont bascule',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COM/001',
    'Colonne magnétique_BUHLER_Silo en béton 6e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COM/002',
    'Compresseur d’air_ATLAS COPCO_Silo en béton Rez-de- chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COA/001',
    'Compresseur d’air _AERZEN_Silo en béton 8e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/ECH/001',
    'Echantillonneur _BUHLER_Silo en béton 2e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/ECL/001',
    'Ecluse_Getriebebau Nord_Silo en béton 7e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Extincteur _SICLI_Silo en béton 6e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Extincteur _SICLI_Silo en béton 4e étage',
    ''
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Extincteur _SICLI_Silo en béton 3e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Extincteur _SICLI_Silo en béton 2e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Extincteur _SICLI_Silo en béton 1er étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Extincteur _SICLI_Silo en béton Rez-de- chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/FIC/001',
    'Filtre et cyclone_BUHLER_Silo en béton 8e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/LAK/001',
    'LAKA_BUHLER_Silo en béton 5e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MOD/001',
    'Moduflex_BUHLER_Silo en béton 1er étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MOD/002',
    'Moduflex_BUHLER_Silo en béton 1er étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MOE/001',
    'Moteur élévateur I (M : 1080)_SIEMENS_Silo en béton 7e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MOE/003',
    'Moteur élévateur II (1084)_SIEMENS_Silo en béton 8e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MOE/002',
    'Moteur élévateur III (M1214)_SIEMENS_Silo en béton 8e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MOR/001',
    'Motoréducteur_SIEMENS_Silo en béton Rez-de- chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/POS/001',
    'Pompe surpresseur_Pentax_Silo en béton 3e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Robinet d’incendie armé (R.I.A)_SICLI_Silo en béton 7e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Robinet d’incendie armé (R.I.A)_SICLI_Silo en béton 6e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Robinet d’incendie armé (R.I.A)_SICLI_Silo en béton 5e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Robinet d’incendie armé (R.I.A)_SICLI_Silo en béton 2e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Robinet d’incendie armé (R.I.A)_SICLI_Silo en béton 1er étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/001',
    'Transporteur à chaine 1212_Getriebebau Nord_Silo en béton Rez-de- chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/002',
    'Transporteur à chaine 1213_Getriebebau Nord_Silo en béton Rez-de- chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/003',
    'Transporteur à chaine 1210_Getriebebau Nord_Silo en béton Rez-de- chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/004',
    'Transporteur à chaine 1211_Getriebebau Nord_Silo en béton Rez-de- chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/005',
    'Transporteur à chaine PER 1102_Getriebebau Nord_Silo en béton 6e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/006',
    'Transporteur à chaine IMP 1116_Getriebebau Nord_Silo en béton 6e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/VEA/001',
    'Ventilateur d’aspiration_LAMMERS_Silo en béton 8e étage',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/BAC/002',
    'Balance de circuit__Silo métallique 3e étage 4e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/BOE/001',
    'Bouche d’ensachage_BUHLER_Silo métallique 1er étage 2e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COM/003',
    'Compresseur d’air_Atlas copco_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/001',
    'Cône vibrant_BUHLER_Silo métallique 2e étage 3e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/002',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/003',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/004',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/005',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/006',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/007',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/008',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/009',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/010',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/011',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/012',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/013',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/014',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/015',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/016',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/017',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/018',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/019',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/020',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/021',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/022',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/023',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/024',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/COV/025',
    'Cône vibrant_BUHLER_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/CAC/001',
    'Couseuse à colonne_FISCHBEIN_Silo métallique 1er étage 2e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/DEB/001',
    'Delta blower_AERZEN_Silo métallique 5e étage 6e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/ECL/002',
    'Ecluse_Getriebebau Nord_Silo métallique 6e étage 7e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/ECL/003',
    'Ecluse_BUHLER_Silo métallique 4e étage 5e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/ELE/001',
    'Elévateur_Getriebebau Nord_Silo métallique 7e étage 8e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Extincteur__Silo métallique 7e étage 8e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Extincteur_SICLI_Silo métallique 6e étage 7e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Extincteur_SICLI_Silo métallique 5e étage 6e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Extincteur__Silo métallique 4e étage 5e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Extincteur__Silo métallique 2e étage 3e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Extincteur__Silo métallique 1er étage 2e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/FIC/001',
    'Filtre d’aspiration avec ventilateur et cyclone_BUHLER_Silo métallique 7e étage 8e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/FIC/002',
    'Filtre d’aspiration avec cyclone_BUHLER_Silo métallique 5e étage 6e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/FIC/003',
    'Filtre d’aspiration avec cyclone_BUHLER_Silo métallique 4e étage 5e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MOD/003',
    'Moduflex_BUHLER_Silo métallique 1er étage extérieur',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAB/001',
    'Transporteur à bande_BUHLER_Silo métallique 1er étage 2e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/007',
    'Transporteur à chaine 1010_Getriebebau Nord_Silo métallique 7e étage 8e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/008',
    'Transporteur à chaine 1012_Getriebebau Nord_Silo métallique 7e étage 8e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/009',
    'Transporteur à chaine 1026_BUHLER_Silo métallique 6e étage 7e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/010',
    'Transporteur à chaine 1020_BUHLER_Silo métallique 6e étage 7e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/011',
    'Transporteur à chaine A-6086_BUHLER_Silo métallique 2e étage 3e porte extérieur',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/012',
    'Transporteur à chaine _BUHLER_Silo métallique 2e étage 3e porte extérieur',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/013',
    'Transporteur à chaine A-6073_Getriebebau Nord_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/014',
    'Transporteur à chaine A-6074_Getriebebau Nord_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/015',
    'Transporteur à chaine A-6075_Getriebebau Nord_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/016',
    'Transporteur à chaine A-6076_Getriebebau Nord_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAC/017',
    'Transporteur à chaine A-6077 _Getriebebau Nord_Silo métallique Rez-de-chaussée',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/VEA/003',
    'Ventilateur d`aspiration générale_Stäfa Wirz_Silo métallique 6e étage 7e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/VEA/002',
    'Ventilateur d’aspiration 1014_BUHLER_Silo métallique 6e étage 7e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/VID/001',
    'Vis doseur_BUHLER_Silo métallique 2e étage 3e porte',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/POR/001',
    'Portalino__Mole C1',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/ELE/002',
    'Elévateur_Getriebebau Nord_Mole C1',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAB/002',
    'Transporteur à bande I_SEW EURODRIVE_Mole C1',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/TAB/003',
    'Transporteur à bande II A1256_BUHLER_Mole C1',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/GRD/001',
    'GRUE DE BATEAU_ASCOM_Site de réparation navale',
    'ETAT000003'
);

-------------AUTRES
INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/QUA/001',
    'Quai Darse 1B_Darse 1B',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/QUA/002',
    'Quai Darse 2B_Darse 2B',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/QUA/003',
    'Quai n°1F_Mole A Ouest',
    'ETATS0005'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/QUA/004',
    'Quai n°2F_Tableau A',
    'ETATS0005'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/QUA/005',
    'Quai n°3F_Mole A Est',
    'ETATS0005'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/QUA/006',
    'Quai n°4F_Mole B',
    'ETATS0005'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/QUA/007',
    'Quai SHERRIT_Extension Mole B',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/QUA/008',
    'Quai C1_Mole C',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/QUA/009',
    'Quai C2_Mole C',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/QUA/010',
    'Quai C3_Mole C',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/QUA/011',
    'Quai 6B Bis_Darse 2B ',
    'ETATS0007'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/QUA/012',
    'Quai Refrigépêche_Débarcadère',
    'ETAT000003'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/JEP/001',
    'Jetée pétrolière_Extension Mole B',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/CAI/001',
    'Cale inclinée siège social_A côté du B.U.P.',
    'ETAT000003'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/CAI/002',
    'SLIPWAY_Devant chaudronnerie',
    'ETAT000003'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'A/DIP/001',
    'Digue de protection_Devant Mole C2 et C3',
    NULL
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/PHA/001',
    'Phare de l`immeuble portuaire_B.U.P',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/PHA/002',
    'Phare Pointe Tanio_Pointe Tanio',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Feu de débarcadère devant Réfrigépêche _Devant Réfrigépêche',
    NULL
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Feu de Château d`eau_Château d`eau',
    NULL
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Balisage du coin de quai Mole C3_Mole C',
    NULL
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    '',
    'Balisage du coin de quai Mole B_Mole B',
    NULL
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/BLV/001',
    'Bouée latérale verte tribord_Rade Tanio',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/BLV/002',
    'Bouée latérale verte tribord_Rade Tanio',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/BLR/001',
    'Bouée latérale rouge bâbord_Rade Tanio',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/BLR/002',
    'Bouée latérale rouge bâbord_Rade Tanio',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/BCN/001',
    'Bouée cardinale_Rade Salazamay',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/PHA/003',
    'Balise Salazamay antérieure_Sur la plage de Salazamay',
    'ETATS0006'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/PHA/004',
    'Balise Salazamay postérieure_Ambalamanasy',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/001',
    'Mât  d’éclairage M1-S.P.A.T._Quai 1B',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/002',
    'Mât  d’éclairage M2- S.P.A.T._Quai 2B',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/003',
    'Mât  d’éclairage M3- S.P.A.T._Quai 3B',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/004',
    'Mât  d’éclairage M4- S.P.A.T._Quai 4B',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/005',
    'Mât  d’éclairage M5- S.P.A.T._Quai 6B Bis',
    'ETATS0007'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/006',
    'Mât d’éclairage  M6- S.P.A.T._T.P. scanner',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/007',
    'Mât d’éclairage M7- S.P.A.T.T_Pont bascule T.P. scanner',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/008',
    'Mât d’éclairage  M8- S.P.A.T._Môle B',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/009',
    'Mât d’éclairage  M9- S.P.A.T._Môle C1',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/010',
    'Mât d’éclairage  M10- S.P.A.T._Terre-plein Ex CAG',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/011',
    'Mât d’éclairage  M1-MICTSL_Porte d’entrée principale MICTSL',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/012',
    'Mât d’éclairage  M2-MICTSL_Vérification de conteneurs ',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/013',
    'Mât d’éclairage  M3-MICTSL_Porte de sortie',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/014',
    'Mât d’éclairage  M4-MICTSL_En face du bloc 3 C',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/015',
    'Mât d’éclairage  M5-MICTSL_Bloc 3 D',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/016',
    'Mât d’éclairage  M6-MICTSL_Bloc 4 C',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/017',
    'Mât d’éclairage  M7-MICTSL_Parking G4S',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/018',
    'Mât d’éclairage  M8-MICTSL_Bureau engineering',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/019',
    'Mât d’éclairage  M9-MICTSL_Station Jovena MICTSL',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/020',
    'Mât d’éclairage  M10-MICTSL_Bureau Operation center',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/021',
    'Mât d’éclairage  M11-MICTSL_Center Operation',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/022',
    'Mât d’éclairage  M12-MICTSL_Bloc 7 C',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/023',
    'Mât d’éclairage  M13-MICTSL_Fonds de quai au site d’extension du port',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/024',
    'Mât d’éclairage  M14-MICTSL_T.P. 5Ha',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/025',
    'Mât d’éclairage  M15-MICTSL_T.P. 5Ha',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/026',
    'Mât d’éclairage  M16-MICTSL_T.P. 5Ha',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/027',
    'Mât d’éclairage  M1-S.M.M.C._Parc véhicule MAHASARIKA',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/028',
    'Mât d’éclairage  M2-S.M.M.C._Parc véhicule MAHASARIKA',
    'ETAT000001'
);

INSERT INTO PATRIMOINE(
    ID,
    IDTYPEPATRIMOINE,
    LIBELLE,
    DESCRIPTION,
    ETAT
) VALUES(
    'PATSE000'
    ||GETSEQ_PATRIMOINE,
    'TYPE000003',
    'F/MAT/029',
    'Mât d’éclairage  M3-S.M.M.C._Parc véhicule MAHASARIKA',
    'ETAT000001'
);

INSERT INTO TYPEPATRIMOINE (
    ID,
    VAL,
    DESCE
) VALUES (
    'TYPPATS0001',
    'BATIMENT ET CONSTRUCTION (CONSTRUCTION ET REHABILITATION DES FORMATIONS SANITAIRES)',
    'BATIMENT ET CONSTRUCTION (CONSTRUCTION ET REHABILITATION DES FORMATIONS SANITAIRES)'
);

INSERT INTO TYPEPATRIMOINE (
    ID,
    VAL,
    DESCE
) VALUES (
    'TYPPATS0002',
    'MATERIELS ROULANTS AVEC IMMATRICULATION OFFICIELLE INDIVIDUALISE',
    'MATERIELS ROULANTS AVEC IMMATRICULATION OFFICIELLE INDIVIDUALISE'
);

INSERT INTO TYPEPATRIMOINE (
    ID,
    VAL,
    DESCE
) VALUES (
    'TYPPATS0003',
    'MATERIELS ET MOBILIERS DE BUREAU',
    'MATERIELS ET MOBILIERS DE BUREAU'
);

INSERT INTO TYPEPATRIMOINE (
    ID,
    VAL,
    DESCE
) VALUES (
    'TYPPATS0004',
    'MATERIELS INFORMATIQUES
',
    'MATERIELS INFORMATIQUES
'
);

INSERT INTO TYPEPATRIMOINE (
    ID,
    VAL,
    DESCE
) VALUES (
    'TYPPATS0005',
    'MATERIELS ET MOBILIERS HOSPITALIER
',
    'MATERIELS ET MOBILIERS HOSPITALIER
'
);

INSERT INTO TYPEPATRIMOINE (
    ID,
    VAL,
    DESCE
) VALUES (
    'TYPPATS0006',
    'AUTRES MATERIELS ET EQUIPEMENT Y COMPRIS AMENAGEMENT, AGENCEMENT ET INSTALLATION QUI N''ONT PAS CARACTERE DE TRAVAUX
',
    'AUTRES MATERIELS ET EQUIPEMENT Y COMPRIS AMENAGEMENT, AGENCEMENT ET INSTALLATION QUI N''ONT PAS CARACTERE DE TRAVAUX
'
);

UPDATE PATRIMOINE
SET
    IDTYPEPATRIMOINE='TYPPATS0001'
WHERE
    LIBELLE LIKE 'A%';

UPDATE PATRIMOINE
SET
    IDTYPEPATRIMOINE='TYPPATS0002'
WHERE
    LIBELLE LIKE 'B%';

UPDATE PATRIMOINE
SET
    IDTYPEPATRIMOINE='TYPPATS0003'
WHERE
    LIBELLE LIKE 'C%';

UPDATE PATRIMOINE
SET
    IDTYPEPATRIMOINE='TYPPATS0004'
WHERE
    LIBELLE LIKE 'D%';

UPDATE PATRIMOINE
SET
    IDTYPEPATRIMOINE='TYPPATS0005'
WHERE
    LIBELLE LIKE 'E%';

UPDATE PATRIMOINE
SET
    IDTYPEPATRIMOINE='TYPPATS0006'
WHERE
    LIBELLE LIKE 'F%';

UPDATE PATRIMOINE
SET
    IDTYPEPATRIMOINE='TYPPATS0003'
WHERE
    LIBELLE LIKE 'G%';

script travaux (manova anlay val ftsn reto)


UPDATE
	TYPEPATRIMOINE
SET
	VAL = 'BATIMENT ET CONSTRUCTION',
	DESCE = 'BATIMENT ET CONSTRUCTION (CONSTRUCTION ET REHABILITATION DES FORMATIONS SANITAIRES)'
WHERE
	ID = 'TYPPATS0001';

UPDATE
	TYPEPATRIMOINE
SET
	VAL = 'MATERIELS ROULANTS',
	DESCE = 'MATERIELS ROULANTS AVEC IMMATRICULATION OFFICIELLE INDIVIDUALISE'
WHERE
	ID = 'TYPPATS0002';

UPDATE
	TYPEPATRIMOINE
SET
	VAL = 'MATERIELS ET MOBILIERS DE BUREAU',
	DESCE = 'MATERIELS ET MOBILIERS DE BUREAU'
WHERE
	ID = 'TYPPATS0003';

UPDATE
	TYPEPATRIMOINE
SET
	VAL = 'MATERIELS INFORMATIQUES',
	DESCE = 'MATERIELS INFORMATIQUES'
WHERE
	ID = 'TYPPATS0004';

UPDATE
	TYPEPATRIMOINE
SET
	VAL = 'MATERIELS ET MOBILIERS HOSPITALIER',
	DESCE = 'MATERIELS ET MOBILIERS HOSPITALIER'
WHERE
	ID = 'TYPPATS0005';

UPDATE
	TYPEPATRIMOINE
SET
	VAL = 'AUTRES MATERIELS ET EQUIPEMENT',
	DESCE = 'AUTRES MATERIELS ET EQUIPEMENT Y COMPRIS AMENAGEMENT, AGENCEMENT ET INSTALLATION QUI N''ONT PAS CARACTERE DE TRAVAUX'
WHERE
	ID = 'TYPPATS0006';
UPDATE PATRIMOINE SET IDTYPEPATRIMOINE = NULL WHERE IDTYPEPATRIMOINE ='TYPE000003';



