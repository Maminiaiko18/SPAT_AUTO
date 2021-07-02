
CREATE OR REPLACE  VIEW ACTIVITECOMPLETFORMULE_I
(
   ID,
   DESIGNATION,
   CLIENT,
   RUBRIQUE,
   QTE,
   MOIS,
   MOISLIB,
   ANNEE,
   DATY,
   BATEAU,
   ETAT,
   RUBRIQUELIB,
   NAVIRE,
   BATEAULIB,
   POIDS,
   LONGUEUR,
   LARGEUR,
   AUTRES,
   PU,
   DEVISE,
   COMPTE,
   UNITE,
   DIRECTION,
   CONDITION,
   TVA,
   OBJET,
   REDEVANCE,
   CLIENTLIB,
   REDEVANCELIB,
   DIRECTIONLIB,
   ETATLIB,
   CATEGORIE,
   CATEGORIELIB,
   REFOBJET,
   TYPESOURCE,
   DATEFACT,
   PAVILLON,
   VOLUME,
   VOLUMEARRONDI,
   CARGAISON,
   DATEDEBUT,
   HEUREDEBUT,
   DATEFIN,
   HEUREFIN,
   IDPRESTATION,
   ESTNATIONAL,
   ESTJOUR,
   ESTFERIE,
   MANOEUVRE,
   ESTWEEKEND,
   POSTE,
   POSTELIB,
   NATUREOPERATION,
   NBHEURE,
   NBQUARTHEURE,
   NBJOUR,
   TYPEQUAIS
)
AS
   SELECT ac.ID AS id,
          ac.DESIGNATION,
          ac.CLIENT,
          ac.RUBRIQUE,
          ac.QTE,
          ac.MOIS,
          MOIS.VAL AS MOISLIB,
          ac.ANNEE,
          ac.DATY,
          ac.BATEAU,
          ac.ETAT,
          ra.DESIGNATION AS rubriquelib,
          nv.id AS navire,
          nv.NOM AS bateaulib,
          nv.PLT AS poids,
          nv.LHT AS longueur,
          nv.LM AS largeur,
          CAST ('-' AS VARCHAR2 (100)) AS autres,
          ra.pu,
          ra.devise,
          ra.compte,
          ra.unite,
          ra.direction,
          ra.condition,
          ra.tva,
          ra.objet,
          ra.redevance,
          fup.NOM AS clientlib,
          re.VAL AS redevancelib,
          di.LIBELLEDIR AS directionlib,
          CASE
             WHEN ac.etat = 1 THEN 'CREE(E)'
             WHEN AC.ETAT = 11 THEN 'VISE(E)'
             WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
          END
             AS ETATLIB,
          ra.CATEGORIE,
          cf.val AS categorieLib,
          ac.REFOBJET,
          ac.TYPESOURCE,
          pre.DATE_DEPART AS DATEFACT,
          NV.PAVILLON,
          CAST (nv.lm * nv.lht * nv.te AS NUMBER (10, 3)) AS volume,
          CAST (ROUND ( (nv.lm * nv.lht * nv.te) / 100) AS NUMBER (10, 3))
             AS volumeArrondi,
          pre.cargaison,
          SYSDATE AS datedebut,
          '00:00:00' AS heuredebut,
          SYSDATE AS datefin,
          '00:00:00' AS HEUREFIN,
          '-' AS idprestation,
          CASE
             WHEN    nv.pavillon = 'PAYS000054'
                  OR nv.pavillon = 'PAYS000010'
                  OR nv.pavillon = 'PAYS000057'
             THEN
                'National'
             WHEN    nv.pavillon != 'PAYS000054'
                  OR nv.pavillon != 'PAYS000010'
                  OR nv.pavillon != 'PAYS000057'
             THEN
                'International'
          END
             AS estNational,
          'NUIT' AS estJour,
          'FERIE' estFerie,
          '-' AS manoeuvre,
          'weekend' AS estWeekend,
          ac.POSTE,
          pd.VALQUAIS AS postelib,
          CAST ('-' AS VARCHAR2 (500)) AS natureoperation,
          CAST (3 AS INTEGER) AS nbHeure,
          CAST (5 AS INTEGER) AS nbQuartHeure,
          CAST (1 AS NUMBER (10)) AS nbjour,
          q.typequais
     FROM ACTIVITE ac
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
          LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
          LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
          LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
          LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
          LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
          LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
          --  LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
          LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
          -- LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
          LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
          LEFT JOIN quais q ON q.id = pd2.quai
    WHERE ac.RUBRIQUE not IN ('RBR0127','RBR0128','RBR0129','RBR0130','RB0000000021170447','RB0000000021170445','RB0000000021170446');
	
CREATE OR REPLACE  VIEW ACTIVITECOMPLETFORMULE_II
(
   ID,
   DESIGNATION,
   CLIENT,
   RUBRIQUE,
   QTE,
   MOIS,
   MOISLIB,
   ANNEE,
   DATY,
   BATEAU,
   ETAT,
   RUBRIQUELIB,
   NAVIRE,
   BATEAULIB,
   POIDS,
   LONGUEUR,
   LARGEUR,
   AUTRES,
   PU,
   DEVISE,
   COMPTE,
   UNITE,
   DIRECTION,
   CONDITION,
   TVA,
   OBJET,
   REDEVANCE,
   CLIENTLIB,
   REDEVANCELIB,
   DIRECTIONLIB,
   ETATLIB,
   CATEGORIE,
   CATEGORIELIB,
   REFOBJET,
   TYPESOURCE,
   DATEFACT,
   PAVILLON,
   VOLUME,
   VOLUMEARRONDI,
   CARGAISON,
   DATEDEBUT,
   HEUREDEBUT,
   DATEFIN,
   HEUREFIN,
   IDPRESTATION,
   ESTNATIONAL,
   ESTJOUR,
   ESTFERIE,
   MANOEUVRE,
   ESTWEEKEND,
   POSTE,
   POSTELIB,
   NATUREOPERATION,
   NBQUARTHEURE,
   NBHEURE,
   NBJOUR,
   TYPEQUAIS
)
AS
   SELECT ac.ID,
          ac.DESIGNATION,
          ac.CLIENT,
          ac.RUBRIQUE,
          ac.QTE,
          ac.MOIS,
          MOIS.VAL AS MOISLIB,
          ac.ANNEE,
          ac.DATY,
          ac.BATEAU,
          ac.ETAT,
          ra.DESIGNATION AS rubriquelib,
          nv.id AS navire,
          nv.NOM AS bateaulib,
          nv.PLT AS poids,
          nv.LHT AS longueur,
          nv.LM AS largeur,
          CAST ('-' AS VARCHAR2 (100)) AS autres,
          ra.pu,
          ra.devise,
          ra.compte,
          ra.unite,
          ra.direction,
          ra.condition,
          ra.tva,
          ra.objet,
          ra.redevance,
          fup.NOM AS clientlib,
          re.VAL AS redevancelib,
          di.LIBELLEDIR AS directionlib,
          CASE
             WHEN ac.etat = 1 THEN 'CREE(E)'
             WHEN AC.ETAT = 11 THEN 'VISE(E)'
             WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
          END
             AS ETATLIB,
          ra.CATEGORIE,
          cf.val AS categorieLib,
          ac.REFOBJET,
          ac.TYPESOURCE,
          pre.DATE_DEPART AS DATEFACT,
          NV.PAVILLON,
          CAST (nv.lm * nv.lht * nv.te AS NUMBER (10, 3)) AS volume,
          CAST (ROUND ( (nv.lm * nv.lht * nv.te) / 100) AS NUMBER (10, 3))
             AS volumeArrondi,
          pre.cargaison,
          occ.daty AS datedebut,
          occ.heuredebut,
          OCC.DATEFIN AS datefin,
          OCC.HEUREFIN AS heurefin,
          occ.id AS idprestation,
          CASE
             WHEN    nv.pavillon = 'PAYS000054'
                  OR nv.pavillon = 'PAYS000010'
                  OR nv.pavillon = 'PAYS000057'
             THEN
                'National'
             WHEN    nv.pavillon != 'PAYS000054'
                  OR nv.pavillon != 'PAYS000010'
                  OR nv.pavillon != 'PAYS000057'
             THEN
                'International'
          END
             AS estNational,
          CASE
             WHEN occ.heuredebut BETWEEN '05:00:00' AND '19:00:00'
             THEN
                'JOUR'
             ELSE
                'NUIT'
          END
             AS estJour,
          CASE
             WHEN occ.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
             ELSE 'NONFERIE'
          END
             AS estFerie,
          occ.idmanoeuvrebord AS manoeuvre,
          CASE
             WHEN    TO_CHAR (occ.daty, 'DAY') = 'DIMANCHE'
                  OR TO_CHAR (occ.daty, 'DAY') = 'SAMEDI'
             THEN
                'weekend'
             ELSE
                'normal'
          END
             AS estWeekend,
          ac.POSTE,
          pd.VALQUAIS AS postelib,
          nat.id AS natureoperation,
          CASE
             WHEN ( (60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15 < 0
             THEN
                0
             ELSE
                ROUND ( ( (60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15)
          END
             AS nbQuartHeure,
          CASE
             WHEN 24 * (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
             ELSE ROUND ( (24 * (na.DATYFIN - na.DATYDEBUT)))
          END
             AS nbHeure,
          CASE
             WHEN 24 * (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
             ELSE ROUND (na.DATYFIN - na.DATYDEBUT)
          END
             AS nbJour,
          q.typequais
     FROM ACTIVITE ac
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
          LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
          LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
          LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
          LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
          LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
          LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
          LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
          LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
          LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
          LEFT JOIN OCCUPATIONMATERIELNAVAL_daty na ON na.id = occ.id
          LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
          LEFT JOIN quais q ON q.id = pd2.quai
    WHERE Ra.ID IN ('RBR0127','RBR0128','RBR0129','RBR0130','RB0000000021170447','RB0000000021170445','RB0000000021170446');
	
CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE
AS
   SELECT *
     FROM ACTIVITECOMPLETFORMULE_I
   UNION ALL
   SELECT *
     FROM ACTIVITECOMPLETFORMULE_II a;	
	 
/*manadio données*/	
delete from activite where rubrique='rub2';
delete from activite where rubrique='rub1';
delete from activite where rubrique='RBR001';
delete from activite where rubrique='RBR002';
delete from activite where rubrique='RBR003';
delete from activite where rubrique='RBR004';
delete from activite where rubrique='RBR005';
delete from activite where rubrique='RBR006';
delete from activite where rubrique='RBR007';
delete from activite where rubrique='RBR008';
delete from activite where rubrique='RBR009';
delete from activite where rubrique='RBR010';
delete from activite where rubrique='RBR011';
delete from activite where rubrique='RBR012';
delete from activite where rubrique='rub4';
delete from activite where rubrique='rub3';
delete from activite where rubrique='RBR013';
delete from activite where rubrique='RBR014';
delete from activite where rubrique='RBR015';
delete from activite where rubrique='RBR016';
delete from activite where rubrique='RBR017';
delete from activite where rubrique='RBR018';
delete from activite where rubrique='RBR019';
delete from activite where rubrique='RBR020';
delete from activite where rubrique='RBR021';
delete from activite where rubrique='RBR022';
delete from activite where rubrique='RBR023';
delete from activite where rubrique='RBR024';
delete from activite where rubrique='RBR025';
delete from activite where rubrique='RBR026';
delete from activite where rubrique='RBR027';
delete from activite where rubrique='RBR028';
delete from activite where rubrique='RBR029';
delete from activite where rubrique='RBR030';
delete from activite where rubrique='RBR072';
delete from activite where rubrique='RBR073';
delete from activite where rubrique='RBR074';
delete from activite where rubrique='RBR075';
delete from activite where rubrique='RBR031';
delete from activite where rubrique='RBR032';
delete from activite where rubrique='RBR033';
delete from activite where rubrique='RBR034';
delete from activite where rubrique='RBR035';
delete from activite where rubrique='RBR036';
delete from activite where rubrique='RBR037';
delete from activite where rubrique='RBR038';
delete from activite where rubrique='RBR039';
delete from activite where rubrique='RBR040';
delete from activite where rubrique='RBR041';
delete from activite where rubrique='RBR042';
delete from activite where rubrique='RBR043';
delete from activite where rubrique='RBR044';
delete from activite where rubrique='RBR045';
delete from activite where rubrique='RBR046';
delete from activite where rubrique='RBR047';
delete from activite where rubrique='RBR048';
delete from activite where rubrique='RBR049';
delete from activite where rubrique='RBR050';
delete from activite where rubrique='RBR051';
delete from activite where rubrique='RBR052';
delete from activite where rubrique='RBR053';
delete from activite where rubrique='RBR054';
delete from activite where rubrique='RBR055';
delete from activite where rubrique='RBR056';
delete from activite where rubrique='RBR057';
delete from activite where rubrique='RBR058';
delete from activite where rubrique='RBR059';
delete from activite where rubrique='RBR060';
delete from activite where rubrique='RBR061';
delete from activite where rubrique='RBR062';
delete from activite where rubrique='RBR063';
delete from activite where rubrique='RBR064';
delete from activite where rubrique='RBR065';
delete from activite where rubrique='RBR066';
delete from activite where rubrique='RBR067';
delete from activite where rubrique='RBR068';
delete from activite where rubrique='RBR069';
delete from activite where rubrique='RBR070';
delete from activite where rubrique='RBR071';
delete from activite where rubrique='RB0000000001105829';

delete from detformufact where mere='rub2';
delete from detformufact where mere='rub1';
delete from detformufact where mere='RBR001';
delete from detformufact where mere='RBR002';
delete from detformufact where mere='RBR003';
delete from detformufact where mere='RBR004';
delete from detformufact where mere='RBR005';
delete from detformufact where mere='RBR006';
delete from detformufact where mere='RBR007';
delete from detformufact where mere='RBR008';
delete from detformufact where mere='RBR009';
delete from detformufact where mere='RBR010';
delete from detformufact where mere='RBR011';
delete from detformufact where mere='RBR012';
delete from detformufact where mere='rub4';
delete from detformufact where mere='rub3';
delete from detformufact where mere='RBR013';
delete from detformufact where mere='RBR014';
delete from detformufact where mere='RBR015';
delete from detformufact where mere='RBR016';
delete from detformufact where mere='RBR017';
delete from detformufact where mere='RBR018';
delete from detformufact where mere='RBR019';
delete from detformufact where mere='RBR020';
delete from detformufact where mere='RBR021';
delete from detformufact where mere='RBR022';
delete from detformufact where mere='RBR023';
delete from detformufact where mere='RBR024';
delete from detformufact where mere='RBR025';
delete from detformufact where mere='RBR026';
delete from detformufact where mere='RBR027';
delete from detformufact where mere='RBR028';
delete from detformufact where mere='RBR029';
delete from detformufact where mere='RBR030';
delete from detformufact where mere='RBR072';
delete from detformufact where mere='RBR073';
delete from detformufact where mere='RBR074';
delete from detformufact where mere='RBR075';
delete from detformufact where mere='RBR031';
delete from detformufact where mere='RBR032';
delete from detformufact where mere='RBR033';
delete from detformufact where mere='RBR034';
delete from detformufact where mere='RBR035';
delete from detformufact where mere='RBR036';
delete from detformufact where mere='RBR037';
delete from detformufact where mere='RBR038';
delete from detformufact where mere='RBR039';
delete from detformufact where mere='RBR040';
delete from detformufact where mere='RBR041';
delete from detformufact where mere='RBR042';
delete from detformufact where mere='RBR043';
delete from detformufact where mere='RBR044';
delete from detformufact where mere='RBR045';
delete from detformufact where mere='RBR046';
delete from detformufact where mere='RBR047';
delete from detformufact where mere='RBR048';
delete from detformufact where mere='RBR049';
delete from detformufact where mere='RBR050';
delete from detformufact where mere='RBR051';
delete from detformufact where mere='RBR052';
delete from detformufact where mere='RBR053';
delete from detformufact where mere='RBR054';
delete from detformufact where mere='RBR055';
delete from detformufact where mere='RBR056';
delete from detformufact where mere='RBR057';
delete from detformufact where mere='RBR058';
delete from detformufact where mere='RBR059';
delete from detformufact where mere='RBR060';
delete from detformufact where mere='RBR061';
delete from detformufact where mere='RBR062';
delete from detformufact where mere='RBR063';
delete from detformufact where mere='RBR064';
delete from detformufact where mere='RBR065';
delete from detformufact where mere='RBR066';
delete from detformufact where mere='RBR067';
delete from detformufact where mere='RBR068';
delete from detformufact where mere='RBR069';
delete from detformufact where mere='RBR070';
delete from detformufact where mere='RBR071';
delete from detformufact where mere='RB0000000001105829';

delete from rubrique_activite where id='rub2';
delete from rubrique_activite where id='rub1';
delete from rubrique_activite where id='RBR001';
delete from rubrique_activite where id='RBR002';
delete from rubrique_activite where id='RBR003';
delete from rubrique_activite where id='RBR004';
delete from rubrique_activite where id='RBR005';
delete from rubrique_activite where id='RBR006';
delete from rubrique_activite where id='RBR007';
delete from rubrique_activite where id='RBR008';
delete from rubrique_activite where id='RBR009';
delete from rubrique_activite where id='RBR010';
delete from rubrique_activite where id='RBR011';
delete from rubrique_activite where id='RBR012';
delete from rubrique_activite where id='rub4';
delete from rubrique_activite where id='rub3';
delete from rubrique_activite where id='RBR013';
delete from rubrique_activite where id='RBR014';
delete from rubrique_activite where id='RBR015';
delete from rubrique_activite where id='RBR016';
delete from rubrique_activite where id='RBR017';
delete from rubrique_activite where id='RBR018';
delete from rubrique_activite where id='RBR019';
delete from rubrique_activite where id='RBR020';
delete from rubrique_activite where id='RBR021';
delete from rubrique_activite where id='RBR022';
delete from rubrique_activite where id='RBR023';
delete from rubrique_activite where id='RBR024';
delete from rubrique_activite where id='RBR025';
delete from rubrique_activite where id='RBR026';
delete from rubrique_activite where id='RBR027';
delete from rubrique_activite where id='RBR028';
delete from rubrique_activite where id='RBR029';
delete from rubrique_activite where id='RBR030';
delete from rubrique_activite where id='RBR072';
delete from rubrique_activite where id='RBR073';
delete from rubrique_activite where id='RBR074';
delete from rubrique_activite where id='RBR075';
delete from rubrique_activite where id='RBR031';
delete from rubrique_activite where id='RBR032';
delete from rubrique_activite where id='RBR033';
delete from rubrique_activite where id='RBR034';
delete from rubrique_activite where id='RBR035';
delete from rubrique_activite where id='RBR036';
delete from rubrique_activite where id='RBR037';
delete from rubrique_activite where id='RBR038';
delete from rubrique_activite where id='RBR039';
delete from rubrique_activite where id='RBR040';
delete from rubrique_activite where id='RBR041';
delete from rubrique_activite where id='RBR042';
delete from rubrique_activite where id='RBR043';
delete from rubrique_activite where id='RBR044';
delete from rubrique_activite where id='RBR045';
delete from rubrique_activite where id='RBR046';
delete from rubrique_activite where id='RBR047';
delete from rubrique_activite where id='RBR048';
delete from rubrique_activite where id='RBR049';
delete from rubrique_activite where id='RBR050';
delete from rubrique_activite where id='RBR051';
delete from rubrique_activite where id='RBR052';
delete from rubrique_activite where id='RBR053';
delete from rubrique_activite where id='RBR054';
delete from rubrique_activite where id='RBR055';
delete from rubrique_activite where id='RBR056';
delete from rubrique_activite where id='RBR057';
delete from rubrique_activite where id='RBR058';
delete from rubrique_activite where id='RBR059';
delete from rubrique_activite where id='RBR060';
delete from rubrique_activite where id='RBR061';
delete from rubrique_activite where id='RBR062';
delete from rubrique_activite where id='RBR063';
delete from rubrique_activite where id='RBR064';
delete from rubrique_activite where id='RBR065';
delete from rubrique_activite where id='RBR066';
delete from rubrique_activite where id='RBR067';
delete from rubrique_activite where id='RBR068';
delete from rubrique_activite where id='RBR069';
delete from rubrique_activite where id='RBR070';
delete from rubrique_activite where id='RBR071';
delete from rubrique_activite where id='RB0000000001105829';

delete from natureoperation where id in ('NAT0002',
'NAT0003',
'NAT0004',
'NAT0006',
'NAT0007',
'NATU000001')

update occupationmaterielnaval set idcommandant='CM001' where idcommandant in ('COMM000002','COM001');
delete from commandant where id in ('COMM000002','COM001');

delete from journalcaisse where idplacement in ('FCL0000000043025111','FCL0000000044030219','FCL0000000045030551','FCL0000000021145038','FCL0000000022145909','FCL0000000023151134');
delete from facture_client_fille where idactivite is not null;
delete from factureclient where id in ('FCL0000000043025111','FCL0000000044030219','FCL0000000045030551','FCL0000000021145038','FCL0000000022145909','FCL0000000023151134');

delete from activite;