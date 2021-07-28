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



