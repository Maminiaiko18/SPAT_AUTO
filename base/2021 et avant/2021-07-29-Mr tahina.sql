delete from avoirfcfille;
ALTER TABLE AVOIRFCFILLE MODIFY(MONTANT NUMBER(30,3));
update factureclient set type='TFC001' where type='TFC003';
delete from typefc where id='TFC003';

CREATE OR REPLACE FORCE VIEW AVOIRFCAVECTAUX_GRP
(
   IDDETAILFACTURE,
   MONTANTSANSTAUX,
   MONTANTAVECTSAUX
)
AS
     SELECT ac.IDDETAILFACTURE,
            CAST (SUM (MONTANT) as number(30,3)) AS montantsanstaux,
            CAST (SUM (montantavectsaux)as number(30,3)) AS montantavectsaux
       FROM avoirfcavectaux ac
      WHERE etat >= 11
   GROUP BY ac.IDDETAILFACTURE;
   
CREATE OR REPLACE FORCE VIEW FACTURE_CLIENT_MONTANT
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   DATY,
   TIERS,
   DESIGNATIONMERE,
   TYPE,
   TVA,
   REMARQUE,
   IDUSER,
   DATE_ECHEANCE,
   ETAT,
   IDPREVISION,
   IDPROVISION,
   IDCATEGORIE,
   MONTANT,
   MONTANTTAUX,
   MONTANTAVOIRSANSTAUX,
   MONTANTAVOIRAVECTAUX
)
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
          CAST (fm.pu * fm.quantite AS NUMBER (30, 3)) AS Montant,
          CAST ( (fm.pu * fm.quantite) * fm.taux AS NUMBER (30, 3))
             AS montanttaux,
          NVL (montantsanstaux, 0) AS montantavoirsanstaux,
          CAST (NVL ( (montantsanstaux * fm.TAUX), 0) AS NUMBER (30, 3))
             AS montantavoiravectaux
     FROM facture_client_Mere_fille fm
          LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;

   
CREATE OR REPLACE FORCE VIEW FACTURE_CLIENT_GRP
(
   MONTANT,
   MONTANTTAUX,
   MONTANTAVOIRSANSTAUX,
   MONTANTAVOIRAVECTAUX,
   MONTANTTVA,
   IDMERE
)
AS
     SELECT CAST (SUM (fm.MONTANT) as number(30,3)) AS montant,
            cast(SUM (fm.montanttaux) as number(30,3)) AS montanttaux,
            cast(SUM (fm.MONTANTAVOIRSANSTAUX) as number(30,3)) AS MONTANTAVOIRSANSTAUX,
            cast(SUM (fm.montantavoiravectaux) as number(30,3)) AS montantavoiravectaux,
            CAST (SUM (fm.montanttaux * fm.tva / 100) AS NUMBER (30, 3))
               AS montantTva,
            fm.idmere
       FROM facture_client_montant fm
   GROUP BY fm.idmere;

CREATE OR REPLACE FORCE VIEW FACTURECLIENTMSUM
(
   ID,
   DATY,
   TIERS,
   DESIGNATION,
   TYPE,
   TVA,
   REMARQUE,
   IDUSER,
   DATE_ECHEANCE,
   ETAT,
   IDPREVISION,
   MONTANT,
   MONTANTTVA,
   MONTANTAVOIR,
   MONTANTTTC,
   ESCALE,
   TYPELIB,
   IDCATEGORIE,
   CATEGORIELIB,
   IDPROVISION,
   IDPROVISIONLIB
)
AS
   SELECT fc.ID,
          fc.DATY,
          fc.TIERS,
          fc.DESIGNATION,
          fc.TYPE,
          fc.TVA,
          fc.REMARQUE,
          fc.IDUSER,
          fc.DATE_ECHEANCE,
          fc.ETAT,
          fc.idprevision,
          CAST (NVL (grp.montanttaux, 0) AS NUMBER (30, 3)) AS montant,
          CAST (NVL (grp.MONTANTTVA, 0) AS NUMBER (30, 3)) AS montanttva,
          NVL (grp.montantavoiravectaux, 0) AS montantavoir,
          CAST (
               NVL (NVL (grp.MONTANTTVA, 0) + grp.montanttaux, 0)
             - NVL (grp.montantavoiravectaux, 0) AS NUMBER (30, 3))
             AS MONTANTTTC,
          pr.ESCALE,
          tfc.VAL AS typelib,
          fc.IDCATEGORIE,
          catfc.VAL AS CATEGORIELIB,
          fc.IDPROVISION,
          fcf.DESIGNATION AS IDPROVISIONlib
     FROM FACTURECLIENT fc
          LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id
          LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
          LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
          LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
          LEFT JOIN factureclient fcf ON fcf.IDPROVISION = fc.IDPROVISION;
          

CREATE OR REPLACE FORCE VIEW FACTURECLIENTMSUM_LIB
(
   ID,
   DATY,
   TIERS,
   DESIGNATION,
   TYPE,
   TVA,
   REMARQUE,
   IDUSER,
   DATE_ECHEANCE,
   ETAT,
   IDPREVISION,
   MONTANT,
   MONTANTTVA,
   MONTANTAVOIR,
   MONTANTTTC,
   MONTANTPAYE,
   MONTANTRESTE,
   TIERSLIB,
   CONTACT,
   ADRESSE,
   ESCALE,
   TYPELIB,
   IDCATEGORIE,
   CATEGORIELIB,
   IDPROVISION,
   IDPROVISIONLIB
)
AS
   SELECT m.ID,
          m.DATY,
          m.TIERS,
          m.DESIGNATION,
          m.TYPE,
          m.TVA,
          '--' || m.remarque AS remarque,
          m.IDUSER,
          m.DATE_ECHEANCE,
          m.ETAT,
          m.idprevision,
          CAST (m.MONTANT AS NUMBER (32, 3)),
          CAST (M.MONTANTTVA AS NUMBER (32, 3)),
          CAST (M.MONTANTAVOIR AS NUMBER (32, 3)),
          CAST (M.MONTANTTTC AS NUMBER (32, 3)),
          CAST (NVL (jc.montant, 0) AS NUMBER (32, 3)) AS montantpaye,
          CAST (M.MONTANTTTC - NVL (jc.montant, 0) AS NUMBER (32, 3))
             AS montantreste,
          fup.NOM AS tierslib,
          fup.CONTACT,
          fup.ADRESSE,
          M.ESCALE,
          TYPELIB,
          m.IDCATEGORIE,
          m.CATEGORIELIB,
          IDPROVISION,
          IDPROVISIONLIB
     FROM factureclientMSum m
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
          LEFT JOIN JOURNALCAISSELIB_VISE_SUM jc ON jc.IDPLACEMENT = m.id;


CREATE OR REPLACE FORCE VIEW FACTURE_CLIENT_UNION
(
   ID,
   DATY,
   TIERS,
   DESIGNATION,
   TYPE,
   TVA,
   REMARQUE,
   IDUSER,
   DATE_ECHEANCE,
   ETAT,
   MONTANT,
   MONTANTTVA,
   MONTANTAVOIR,
   MONTANTTTC,
   MONTANTPAYE,
   MONTANTRESTE,
   TIERSLIB,
   CONTACT,
   ADRESSE,
   IDPREVISION,
   ESCALE,
   ETATLIB,
   TYPELIB,
   IDCATEGORIE,
   CATEGORIELIB,
   IDPROVISION,
   IDPROVISIONLIB
)
AS
   SELECT ID,
          DATY,
          TIERS,
          DESIGNATION,
          TYPE,
          CAST (TVA AS NUMBER (20, 3)) AS tva,
          REMARQUE,
          IDUSER,
          DATE_ECHEANCE,
          CAST (ETAT AS NUMBER (10)) AS etat,
          CAST (MONTANT AS NUMBER (32, 3)),
          CAST (MONTANTTVA AS NUMBER (32, 3)),
          CAST (MONTANTAVOIR AS NUMBER (32, 3)),
          CAST (MONTANTTTC AS NUMBER (32, 3)),
          CAST (MONTANTPAYE AS NUMBER (32, 3)),
          CAST (MONTANTRESTE AS NUMBER (32, 3)),
          TIERSLIB,
          CONTACT,
          ADRESSE,
          IDPREVISION,
          ESCALE,
          CASE WHEN ETAT = 1 THEN 'CREE(E)' WHEN ETAT = 11 THEN 'VISE(E)' END
             AS ETATLIB,
          TYPELIB,
          IDCATEGORIE,
          CATEGORIELIB,
          IDPROVISION,
          IDPROVISIONLIB
     FROM (SELECT ID,
                  DATY,
                  TIERS,
                  DESIGNATION,
                  TYPE,
                  CAST (TVA AS NUMBER (20, 3)) AS TVA,
                  REMARQUE,
                  IDUSER,
                  DATE_ECHEANCE,
                  CAST (ETAT AS NUMBER (10)) AS etat,
                  CAST (MONTANT AS NUMBER (32, 3)) AS MONTANT,
                  CAST (MONTANTTVA AS NUMBER (32, 3)) AS MONTANTTVA,
                  CAST (MONTANTAVOIR AS NUMBER (32, 3)) AS MONTANTAVOIR,
                  CAST (MONTANTTTC AS NUMBER (32, 3)) AS MONTANTTTC,
                  CAST (MONTANTPAYE AS NUMBER (32, 3)) AS MONTANTPAYE,
                  CAST (MONTANTRESTE AS NUMBER (32, 3)) AS MONTANTRESTE,
                  TIERSLIB,
                  CONTACT,
                  ADRESSE,
                  IDPREVISION,
                  ESCALE,
                  TYPELIB,
                  IDCATEGORIE,
                  CATEGORIELIB,
                  IDPROVISION,
                  IDPROVISIONLIB
             FROM FACTURECLIENTMSUM_LIB
           UNION ALL
           SELECT ID,
                  DATY,
                  TIERS,
                  DESIGNATION,
                  TYPE,
                  CAST (TVA AS NUMBER (20, 3)) AS TVA,
                  REMARQUE,
                  IDUSER,
                  DATE_ECHEANCE,
                  CAST (ETAT AS NUMBER (10)) AS etat,
                  CAST (MONTANT AS NUMBER (32, 3)) AS MONTANT,
                  CAST (MONTANTTVA AS NUMBER (32, 3)) AS MONTANTTVA,
                  CAST (MONTANTAVOIR AS NUMBER (32, 3)) AS MONTANTAVOIR,
                  CAST (MONTANTTTC AS NUMBER (32, 3)) AS MONTANTTTC,
                  CAST (MONTANTPAYE AS NUMBER (32, 3)) AS MONTANTPAYE,
                  CAST (MONTANTRESTE AS NUMBER (32, 3)) AS MONTANTRESTE,
                  TIERSLIB,
                  CONTACT,
                  ADRESSE,
                  '-' AS PREVISION,
                  '-' AS ESCALE,
                  TYPE AS typelib,
                  '-' AS IDCATEGORIE,
                  '-' AS CATEGORIELIB,
                  '-' AS IDPROVISION,
                  '-' AS IDPROVISIONLIB
             FROM analyseglobaleantsika);


ALTER TABLE FACTURECLIENT
ADD (deviseMere VARCHAR2(100 BYTE) DEFAULT 'Ar');

ALTER TABLE FACTURECLIENT ADD 
 FOREIGN KEY (DEVISEmere)
 REFERENCES DEVISE (ID)
 ENABLE
 VALIDATE;

ALTER TABLE RUBRIQUE_ACTIVITE
ADD (volume NUMBER(20,2));

update rubrique_activite set volume=20 where designation like '%20%' and categorie='CATFC002';
update rubrique_activite set volume=40 where designation like '%40%' and categorie='CATFC002';
update rubrique_activite set volume=45 where designation like '%45%' and categorie='CATFC002';

CREATE OR REPLACE FORCE VIEW ACTIVITELIBCOMPLET
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
   volumeRubrique
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
          CAST (nv.lm * nv.lht * nv.te AS NUMBER (10, 3)) AS volume,
          CAST (ROUND ( (nv.lm * nv.lht * nv.te) / 100) AS NUMBER (10, 3))
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
             WHEN    TO_CHAR (ac.daty, 'DAY') = 'DIMANCHE'
                  OR TO_CHAR (ac.daty, 'DAY') = 'SAMEDI'
             THEN
                'weekend'
             ELSE
                'normal'
          END
             AS estWeekend,
          occ.IDNATUREOPERATION AS natureoperation,
          CASE
             WHEN   (  (  60
                        * 24
                        * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss')))
                     - 60)
                  / 15 < 0
             THEN
                0
             ELSE
                ROUND (
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
                ROUND (
                     24
                   * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                 'dd-mm-yy hh24:mi:ss')
                      - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                 'dd-mm-yy hh24:mi:ss')))
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
                CASE
                   WHEN ROUND (
                             TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss')) <
                           ROUND (
                              (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                          'dd-mm-yy hh24:mi:ss')
                               - TO_DATE (
                                    ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                    'dd-mm-yy hh24:mi:ss')),
                              1)
                   THEN
                        ROUND (
                             TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss'))
                      + 1
                   ELSE
                      ROUND (
                           TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                    'dd-mm-yy hh24:mi:ss')
                         - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                    'dd-mm-yy hh24:mi:ss'))
                END
          END
             AS nbJour,
          q.typequais,
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
                      ROUND (
                           TRUNC (
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
          RA.VOLUME as volumeRubrique
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
          LEFT JOIN MATERIEL_NAVAL cm ON cm.id = occ.IDMATERIEL_NAVAL;
		  
CREATE OR REPLACE FORCE VIEW ACTIVITELIBCOMPLET_V
AS
   SELECT *
     FROM ACTIVITELIBCOMPLET
    WHERE ETAT >= 11;

create or replace view ActiviteLibCompletVConteneur as select * from ACTIVITELIBCOMPLET_V where categorie='CATFC002';



create or replace view ActiviteLibComContGPMA as 
select rubrique,rubriqueLib,mois,annee,moislib,compte,clientlib,cast(sum(qte) as NUMBER(30,3)) as qte,pu,volumerubrique,devise from ActiviteLibCompletVConteneur
where clientLib like 'MICTSL' group by rubriqueLib,mois,annee,moislib,compte,clientlib,pu,volumerubrique,devise,rubrique;

update rubrique_activite set compte='70627' where designation like '%transbordement%' and categorie='CATFC002';	

