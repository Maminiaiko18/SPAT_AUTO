--rectif calcul volumeVir
CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET
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
   POSTE,
   POSTELIB,
   DATEDEBUT,
   HEUREDEBUT,
   DATEFIN,
   HEUREFIN,
   VOLUME,
   VOLUMEARRONDI,
   CARGAISON,
   IDPRESTATION,
   ESTNATIONAL,
   ESTJOUR,
   ESTFERIE,
   MANOEUVRE,
   ESTWEEKEND,
   NATUREOPERATION,
   NBQUARTHEURE,
   NBHEURE,
   NBJOUR,
   TYPEQUAIS,
   SURFACE,
   NB5JOURS,
   QUAI,
   FLOTTE,
   CATEGORIE_FLOTTE,
   UNITELIB,
   ESTPETROLIER,
   VOLUMERUBRIQUE,
   TAUX,
   TIRANT,
   VOLUMEVIR,
   NBHEUREPREV,
   DEPART,
   ARRIVE,
   NBJOURSTATPETR
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
          ac.POSTE,
          pd.VALQUAIS AS postelib,
          ac.DATEDEBUT,
          ac.HEUREDEBUT,
          ac.DATEFIN,
          ac.HEUREFIN,
          CAST (
             TRUNC (nv.lm, 2) * TRUNC (nv.lht, 2) * TRUNC (nv.te, 2) AS NUMBER (10, 3))
             AS volume,
          CAST (
             ROUND (
                  (TRUNC (nv.lm, 2) * TRUNC (nv.lht, 2) * TRUNC (nv.te, 2))
                / 100) AS NUMBER (10, 3))
             AS volumeArrondi,
          NVL (pre.cargaison, '-') AS cargaison,
          pre.id AS idprestation,
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
             WHEN ac.heuredebut BETWEEN '05:00:00' AND '19:00:00' THEN 'JOUR'
             ELSE 'NUIT'
          END
             AS estJour,
          CASE
             WHEN ac.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
             ELSE 'NONFERIE'
          END
             AS estFerie,
          occ.idmanoeuvrebord AS manoeuvre,
          CASE
             WHEN    TO_CHAR (ac.daty, 'DAY') LIKE '%DIMANCHE%'
                  OR TO_CHAR (ac.daty, 'DAY') LIKE '%SAMEDI%'
             THEN
                'weekend'
             ELSE
                'normal'
          END
             AS estWeekend,
          occ.IDNATUREOPERATION AS natureoperation,
          CASE
             WHEN (  (  60
                      * 24
                      * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                    'dd-mm-yy hh24:mi:ss')
                         - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                    'dd-mm-yy hh24:mi:ss')))
                   - 60) < 0
             THEN
                0
             WHEN (  (  60
                      * 24
                      * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                    'dd-mm-yy hh24:mi:ss')
                         - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                    'dd-mm-yy hh24:mi:ss')))
                   - 60) <= 1
             THEN
                0
             ELSE
                CEIL (
                     (  (  60
                         * 24
                         * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                       'dd-mm-yy hh24:mi:ss')
                            - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                       'dd-mm-yy hh24:mi:ss')))
                      - 60)
                   / 15)
          END
             AS nbQuartHeure,
          CASE
             WHEN   24
                  * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                'dd-mm-yy hh24:mi:ss')
                     - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                'dd-mm-yy hh24:mi:ss')) < 0
             THEN
                0
             ELSE
                (CEIL (
                      24
                    * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                  'dd-mm-yy hh24:mi:ss')
                       - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                  'dd-mm-yy hh24:mi:ss'))))
          END
             AS nbHeure,
          CASE
             WHEN (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                              'dd-mm-yy hh24:mi:ss')
                   - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                              'dd-mm-yy hh24:mi:ss')) < 0
             THEN
                0
             WHEN ROUND (
                     (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                 'dd-mm-yy hh24:mi:ss')
                      - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                 'dd-mm-yy hh24:mi:ss'))) = 0
             THEN
                1
             ELSE
                  ( (  TO_DATE (ac.DATEFIN, 'dd-mm-yy')
                     - TO_DATE (ac.DATEDEBUT, 'dd-mm-yy')))
                + 1
          END
             AS nbJour,
          CASE WHEN TYPESOURCE IS NULL THEN q.typequais ELSE ty.TYPEQUAIS END
             AS typequais,
          --type not postedestinaire
          CAST (nv.LHT * nv.lm AS NUMBER (20, 2)) AS surface,
          CASE
             WHEN (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                              'dd-mm-yy hh24:mi:ss')
                   - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                              'dd-mm-yy hh24:mi:ss')) < 0
             THEN
                0
             ELSE
                CASE
                   WHEN ROUND (
                           (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                       'dd-mm-yy hh24:mi:ss')
                            - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                       'dd-mm-yy hh24:mi:ss'))) BETWEEN 0
                                                                    AND 5
                   THEN
                      1
                   ELSE
                      (  TRUNC (
                              (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                          'dd-mm-yy hh24:mi:ss')
                               - TO_DATE (
                                    ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                    'dd-mm-yy hh24:mi:ss'))
                            / 5)
                       + 1)
                END
          END
             AS nb5jours,
          pd2.QUAI,
          occ.IDMATERIEL_NAVAL AS flotte,
          cm.IDCATEGORIE AS categorie_flotte,
          ua.VAL AS unitelib,
          CASE WHEN nv.TYPE = 'TP0001' THEN 'TRUE' ELSE 'FALSE' END
             AS estPetrolier,
          RA.VOLUME AS volumeRubrique,
          ac.TAUX,
          nv.te AS tirant,
          CAST ( (nv.lm * nv.lht * nv.te) / 100 AS NUMBER (10, 2))
             AS volumeVir,
          CASE
             WHEN    pre.DATE_DEPART IS NULL
                  OR pre.DATE_ARRIVEE IS NULL
                  OR HEURE_DEPART IS NULL
                  OR HEURE_ARRIVEE IS NULL
                  OR (  24
                      * (  TO_DATE (
                              pre.DATE_DEPART || ' ' || pre.HEURE_DEPART,
                              'dd-mm-yy hh24:mi:ss')
                         - TO_DATE (
                              pre.DATE_ARRIVEE || ' ' || pre.HEURE_ARRIVEE,
                              'dd-mm-yy hh24:mi:ss')) < 0)
             THEN
                0
             ELSE
                (CEIL (
                      24
                    * (  TO_DATE (pre.DATE_DEPART || ' ' || pre.HEURE_DEPART,
                                  'dd-mm-yy hh24:mi:ss')
                       - TO_DATE (
                            pre.DATE_ARRIVEE || ' ' || pre.HEURE_ARRIVEE,
                            'dd-mm-yy hh24:mi:ss'))))
          END
             AS nbHeurePrev,
          CASE
             WHEN    pre.DATE_DEPART IS NULL
                  OR pre.DATE_ARRIVEE IS NULL
                  OR HEURE_DEPART IS NULL
                  OR HEURE_ARRIVEE IS NULL
             THEN
                NULL
             ELSE
                TO_DATE (pre.DATE_DEPART || ' ' || pre.HEURE_DEPART,
                         'dd-mm-yy hh24:mi:ss')
          END
             AS depart,
          CASE
             WHEN    pre.DATE_DEPART IS NULL
                  OR pre.DATE_ARRIVEE IS NULL
                  OR HEURE_DEPART IS NULL
                  OR HEURE_ARRIVEE IS NULL
             THEN
                NULL
             ELSE
                TO_DATE (pre.DATE_ARRIVEE || ' ' || pre.HEURE_ARRIVEE,
                         'dd-mm-yy hh24:mi:ss')
          END
             AS arrive
     FROM ACTIVITE ac
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
          LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
          LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
          LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
          LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
          LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
          LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
          LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
          LEFT JOIN UNITE_ACTIVITE ua ON ua.ID = ra.UNITE
          LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
          LEFT JOIN quais q ON q.id = pd2.quai
          LEFT JOIN occupationmaterielnaval occ ON occ.id = ac.REFOBJET
          LEFT JOIN MATERIEL_NAVAL cm ON cm.id = occ.IDMATERIEL_NAVAL
          LEFT JOIN POSTEDESTINATAIRELIBCOMPLET ty ON ty.id = ac.TYPESOURCE;

--Ajout colonne duree		  
CREATE OR REPLACE FORCE VIEW FACTURE_CLIENT_MONTANT
AS
   SELECT fm.ID,
          fm.IDMERE,
          fm.DESIGNATION,
          fm.QUANTITE,
          fm.PU,
          fm.COMPTE,
          fm.IDPRODUIT,
          fm.DEVISE,
          fm.TAUX,
          fm.DATY,
          fm.TIERS,
          fm.DESIGNATIONMERE,
          fm.TYPE,
          fm.TVA,
          fm.REMARQUE,
          fm.IDUSER,
          fm.DATE_ECHEANCE,
          fm.ETAT,
          IDPREVISION,
          IDPROVISION,
          IDCATEGORIE,
          CAST (fm.pu * fm.quantite * NVL (duree, 1) AS NUMBER (30, 3))
             AS Montant,
          CAST (
               ( (fm.pu * fm.quantite) * fm.taux)
             - NVL (
                    ( (fm.pu * fm.quantite * NVL (duree, 1)) * fm.taux)
                  * fm.REDUCTION
                  / 100,
                  0)
             + NVL (
                    ( (fm.pu * fm.quantite * NVL (duree, 1)) * fm.taux)
                  * fm.MAJORATION
                  / 100,
                  0) AS NUMBER (30, 3))
             AS montanttaux,
          NVL (montantsanstaux, 0) AS montantavoirsanstaux,
          CAST (NVL ( (montantsanstaux * fm.TAUX), 0) AS NUMBER (30, 3))
             AS montantavoiravectaux,
          NVL (fm.MAJORATION, 0) AS MAJORATION,
          NVL (fm.REDUCTION, 0) AS REDUCTION,
          CAST (
             NVL (
                  ( (fm.pu * fm.quantite * NVL (duree, 1)) * fm.taux)
                * fm.MAJORATION
                / 100,
                0) AS NUMBER (30, 3))
             AS montantMajoration,
          CAST (
             NVL (
                  ( (fm.pu * fm.quantite * NVL (duree, 1)) * fm.taux)
                * fm.REDUCTION
                / 100,
                0) AS NUMBER (30, 3))
             AS montantReduction,
          fm.IDACTIVITE,
          fm.DATEFACT,
          fm.RUBRIQUE,
          IDAVOIR,
            CAST (
                 ( (fm.pu * fm.quantite) * fm.taux)
               - NVL (
                      ( (fm.pu * fm.quantite * NVL (duree, 1)) * fm.taux)
                    * fm.REDUCTION
                    / 100,
                    0)
               + NVL (
                      ( (fm.pu * fm.quantite * NVL (duree, 1)) * fm.taux)
                    * fm.MAJORATION
                    / 100,
                    0) AS NUMBER (30, 3))
          * fm.tva
          / 100
             AS montanttauxtva,
          fm.RANG,
          fm.mois,
          fm.annee,
          fm.duree
          FROM facture_client_Mere_fille fm
          LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;		
		  
--Ajout colonne duree	
CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANTTC
AS
   SELECT fc.ID,
          fc.IDMERE,
          fc.DESIGNATION,
          fc.QUANTITE,
          fc.PU,
          fc.COMPTE,
          fc.IDPRODUIT,
          fc.DEVISE,
          fc.TAUX,
          fc.DATY,
          fc.TIERS,
          fc.DESIGNATIONMERE,
          fc.TYPE,
          fc.TVA,
          fc.REMARQUE,
          fc.IDUSER,
          fc.DATE_ECHEANCE,
          fc.ETAT,
          CAST (fc.MONTANT AS NUMBER (32, 3)) AS MONTANT,
          CAST (fc.MONTANTTAUX AS NUMBER (32, 3)) AS MONTANTTAUX,
          CAST (fc.MONTANTAVOIRSANSTAUX AS NUMBER (32, 3))
             AS MONTANTAVOIRSANSTAUX,
          CAST (fc.MONTANTAVOIRAVECTAUX AS NUMBER (32, 3))
             AS MONTANTAVOIRAVECTAUX,
          CAST ( (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER (20, 3))
             AS montanttva,
          CAST ( (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER (20, 3))
             AS montanttaxe,
          CAST (
             (fc.pu * QUANTITE) + (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER (20, 3))
             AS montanttc,
          fc.IDACTIVITE,
          fc.DATEFACT,
          fc.RUBRIQUE,
          ac.DATY AS datyactivite,
          ac.HEUREDEBUT,
          ac.HEUREFIN,
          fc.mois,
          fc.annee,
          fc.rang,
          fc.duree
     FROM facture_client_montant fc
          LEFT JOIN ACTIVITE ac ON ac.ID = fc.IDACTIVITE;		  

--Ajout nbHeurePrev pour calcul Veille de Sécurité
update detformufact set formuleqte='[nbHeurePrev]' where id in ('DFF0000000023170518','DFF0000000023170519');

--Ajout nbJourStatPetr pour calcul stationnement pétrolier
	--update detformufact set formuleqte='[volumeVir]*[nbjourStatPetr]' where id in ('DFF0000000023170547','DFF0000000023170548');
update detformufact set formuleqte='[volumeVir]*[nbjour]' where id in ('DFF0000000023170547','DFF0000000023170548');

-- Ajout condition pour pilotage PFI LC férié
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&([estPetrolier]==''TRUE''|| [cargaison]==''CGM00001'')&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170471';

--Rectif condition pour pilotage sortie pétrolier ferié
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&([estFerie]==''FERIE''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')||[estWeekend]==''weekend'')&&([estPetrolier]==''TRUE''|| [cargaison]==''CGM00001'')&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170467';

--Rectif condition pour pilotage sortie pétrolier jour
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([estPetrolier]==''TRUE''|| [cargaison]==''CGM00001'')&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170465';

--Rectif condition pour pilotage entrée pétrolier jour
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&([estPetrolier]==''TRUE''|| [cargaison]==''CGM00001'')&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170469';

--Rectif PU min perception caboteur
update detformufact set formule='91.634' where id='DFF0000000023170452M';

























