
  CREATE OR REPLACE VIEW FACTURECLIENTMSUM
      (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT,
          IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB,
          IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL,DEVISEMERE) AS
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
          fcf.DESIGNATION AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
         fc.DEVISEMERE
     FROM FACTURECLIENT fc
          LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id
          LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
          LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
          LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
          LEFT JOIN factureclient fcf ON fcf.IDPROVISION = fc.IDPROVISION;
		  

  CREATE OR REPLACE VIEW FACTURECLIENTMSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA,
MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE,
      CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL,devisemere) AS
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
          IDPROVISIONLIB,
       m.ESTDDPMICTSL,
      m.devisemere
     FROM factureclientMSum m
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
          LEFT JOIN JOURNALCAISSELIB_VISE_SUM jc ON jc.IDPLACEMENT = m.id;
		  

create or replace view FACTURE_CLIENT_UNION
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB,DEVISEMERE)
as
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
          IDPROVISIONLIB,
       DEVISEMERE
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
                  IDPROVISIONLIB,
                  DEVISEMERE
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
                  '-' AS IDPROVISIONLIB,
                  '-' AS DEVISEMERE
             FROM analyseglobaleantsika);
		create or replace view FACTURECLIENTVALIDE as
SELECT *
     FROM facture_client_union fc
    WHERE id NOT IN (SELECT id FROM ProvisionFactureDefinitive);