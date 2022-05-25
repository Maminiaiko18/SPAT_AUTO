  CREATE OR REPLACE  VIEW PROFORMA_MERE_ORDRE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDCATEGORIE, IDPROVISION, DEVISEMERE, ESTDDPMICTSL, CODEPRESTATION, CODE, ESTMICTSL, EXERCICE, IDAVOIR, ESTAUTO, TYPEENGAGEMENT, POURCOMPTE, ESTANCIENNE, DATEARRIVEE, HEUREARRIVEE, DATEDEPART, HEUREDEPART, BATEAU, PROVENANCE, DESTINATION, ESCALE, VOLUME100, VOLUME) AS 
  SELECT PROFORMA_MERE.ID,
       PROFORMA_MERE.DATY,
       PROFORMA_MERE.TIERS,
       PROFORMA_MERE.DESIGNATION,
       PROFORMA_MERE.TYPE,
       PROFORMA_MERE.TVA,
       PROFORMA_MERE.REMARQUE,
       PROFORMA_MERE.IDUSER,
       PROFORMA_MERE.DATE_ECHEANCE,
       PROFORMA_MERE.ETAT,
       PROFORMA_MERE.IDPREVISION,
       PROFORMA_MERE.IDCATEGORIE,
       PROFORMA_MERE.IDPROVISION,
       PROFORMA_MERE.DEVISEMERE,
       PROFORMA_MERE.ESTDDPMICTSL,
       PROFORMA_MERE.CODEPRESTATION,
       PROFORMA_MERE.CODE,
       PROFORMA_MERE.ESTMICTSL,
       PROFORMA_MERE.EXERCICE,
       PROFORMA_MERE.IDAVOIR,
       PROFORMA_MERE.ESTAUTO,
       PROFORMA_MERE.TYPEENGAGEMENT,
       PROFORMA_MERE.POURCOMPTE,
       PROFORMA_MERE.ESTANCIENNE,
       PROFORMA_MERE.DATEARRIVEE,
       PROFORMA_MERE.HEUREARRIVEE,
       PROFORMA_MERE.DATEDEPART,
       PROFORMA_MERE.HEUREDEPART,
       PROFORMA_MERE.BATEAU,
       PROFORMA_MERE.PROVENANCE,
       PROFORMA_MERE.DESTINATION,
       PROFORMA_MERE.ESCALE,
       PROFORMA_MERE.volume100,
       cast(navirelibcomplet.VOLUME as number(10, 3)) as volume
FROM PROFORMA_MERE
    left join navirelibcomplet on navirelibcomplet.id=PROFORMA_MERE.BATEAU
;

CREATE OR REPLACE VIEW "FACTURECLIENTMSUM" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDPREVISION", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "ESCALE", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "ESTDDPMICTSL", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "MONTANTTTCVRAI", "NAVIRE", "ARMATEURLIB", "EXERCICE", "IDAVOIR", "POURCOMPTE", "POURCOMPTELIB", "ESTANCIENNE", "ARMATEUR", "PAIEMENT", "LHT", "LM", "TE", "JNT") AS 
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
       CAST(NVL(grp.montant, 0) AS NUMBER(30, 3))                                    AS montant, --montanttaux
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3))                                 AS montanttva,
       CAST(NVL(grp.montantavTTCavecTaux, 0) AS NUMBER(32, 3))                      AS montantavoir,
       CAST(NVL(MONTANTTTC, 0) - NVL( grp.montantavTTCavecTaux, 0) AS NUMBER(30, 3)) AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                                                       AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                                                     AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                                               AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                                                        AS codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                                                      AS codeprovision,
       CAST(
               NVL(NVL(grp.MONTANTTVA, 0) + grp.MONTANT, 0) AS NUMBER(30, 3))
                                                                                     AS MONTANTTTCVRAI,
       pr.NAVIRE,
      a.val AS armateurlib ,
       fc.exercice,
       fc.IDAVOIR,
       fc.pourcompte,
       fup.NOM                                                                       as pourcomptelib,
       fc.ESTANCIENNE ,
      	fc.armateur ,
      	fc.paiement ,
         case when fc.lht is null then nv.lht else fc.lht end  as  lht ,
         case when fc.lm is null then nv.lm else fc.lm end  as  lm ,
         case when fc.te is null then nv.te else fc.te end  as  te ,
         case when fc.jnt is null then nv.jnt else fc.jnt end  as  jnt
FROM FACTURECLIENT fc
         LEFT JOIN CAFCFILLECOMPLET_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
         LEFT JOIN CODE_PRESTATION cp ON fc.codePrestation = cp.id
         LEFT JOIN NAVIRELIBCOMPLET nv ON pr.NAVIRE = nv.id
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = fc.POURCOMPTE
         LEFT JOIN armateur_tbd  a ON a.id = fc.armateur;
DELETE FROM MENUDYNAMIQUE
WHERE ID='MEN00157';

DELETE FROM MENUDYNAMIQUE
WHERE ID='MEN0000023';

UPDATE MENUDYNAMIQUE
SET LIBELLE='Analyse Produits Financiers', ICONE='fa fa-line-chart', HREF='/spat/pages/globalnegoce.jsp?but=placement/placement-analyse-croisee.jsp', RANG=5, NIVEAU=4, ID_PERE='MEN0000123'
WHERE ID='MEN0000060';
