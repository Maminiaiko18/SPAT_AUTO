CREATE OR REPLACE VIEW "FACTURECLIENTMSUM" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDPREVISION", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "ESCALE", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "ESTDDPMICTSL", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "MONTANTTTCVRAI", "NAVIRE", "ARMATEURLIB", "EXERCICE", "IDAVOIR", "POURCOMPTE", "POURCOMPTELIB", "ESTANCIENNE", "ARMATEUR", "PAIEMENT", "LHT", "LM", "TE", "JNT", "DATEDEPART", "HEUREDEPART", "DATEARRIVEE", "HEUREARRIVEE", "BATEAU", "PROVENANCE", "DESTINATION", "PAVILLON","PAVILLONLIB","BATEAULIB") AS 
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
      nvl(pr.escale, fc.escale) as escale ,
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
         case when fc.lht IS NULL OR fc.lht=0 THEN nvl(nv.lht,nvc.lht)  else fc.lht end  as  lht ,
         case when fc.lm is null OR fc.lm=0 then nvl(nv.lm,nvc.lm) else fc.lm end  as  lm ,
         case when fc.te is null OR fc.te=0 then nvl(nv.te,nvc.te) else fc.te end  as  te ,
         case when fc.jnt is null OR fc.jnt=0 then nvl(nv.jnt,nvc.jnt) else fc.jnt end  as  jnt , 
         nvl(pr.date_depart,fc.datedepart) as datedepart , 
        nvl(heure_depart,fc.heuredepart) as heuredepart , 
        nvl(pr.date_arrivee,fc.datearrivee) as datearrivee , 
        nvl(pr.heure_arrivee,fc.heurearrivee) as heurearrivee , 
        nvl(pr.navire,fc.bateau) as bateau , 
        nvl(pr.provenance,fc.provenance) as provenance , 
        nvl(pr.destination,fc. destination) as destination , 
        nvl(nv.pavillon,nvc.pavillon) as pavillon,
        nvl(nv.valpavillon,nvc.valpavillon) as pavillonlib,
        nvl(nv.nom,nvc.nom) as bateaulib
FROM FACTURECLIENT fc
         LEFT JOIN CAFCFILLECOMPLET_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
         LEFT JOIN CODE_PRESTATION cp ON fc.codePrestation = cp.id
         LEFT JOIN NAVIRELIBCOMPLET nv ON pr.NAVIRE = nv.id
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = fc.POURCOMPTE
         LEFT JOIN armateur_tbd  a ON a.id = fc.armateur 
         left join navirelibcomplet nvc on nvc.id=fc.bateau
        left join postedestinataire pd on pd.id=fc.provenance
        left join postedestinataire pd2 on pd2.id=fc.destination;

CREATE OR REPLACE  VIEW "FACTURECLIENTMSUM_LIB" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDPREVISION", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "MONTANTPAYE", "MONTANTRESTE", "TIERSLIB", "CONTACT", "ADRESSE", "ESCALE", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "ESTDDPMICTSL", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "MONTANTTTCVRAI", "NAVIRE", "ARMATEURLIB", "EXERCICE", "IDAVOIR", "POURCOMPTE", "POURCOMPTELIB", "ESTANCIENNE", "ARMATEUR", "PAIEMENT", "PAIEMENTLIB", "LHT", "LM", "TE", "JNT","PAVILLON","PAVILLONLIB","PROVENANCE","PROVENANCELIB","DESTINATION","DESTINATIONLIB","BATEAU","BATEAULIB","DATEDEPART","HEUREDEPART","DATEARRIVEE","HEUREARRIVEE") AS 
  SELECT m.ID,
       m.DATY,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       '--' || m.remarque                          AS remarque,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.idprevision,
       CAST(m.MONTANT AS NUMBER(32, 3)),
       CAST(M.MONTANTTVA AS NUMBER(32, 3)),
       CAST(M.MONTANTAVOIR AS NUMBER(32, 3)),
       CAST(M.MONTANTTTC AS NUMBER(32, 3)),
       -- CAST (LEAST (NVL (pf.montant, 0),(m.montant-m.montantavoir)) AS NUMBER (32, 3)) AS montantpaye,
       CAST((NVL(pf.montant, 0)) AS NUMBER(32, 3)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(pf.montant, 0) AS NUMBER(32, 3))
                                                   AS montantreste,
       fup.NOM                                     AS tierslib,
       fup.CONTACT,
       fup.ADRESSE,
       M.ESCALE,
       TYPELIB,
       m.IDCATEGORIE,
       m.CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       m.ESTDDPMICTSL,
       m.devisemere,
       m.codePrestation,
       m.codePrestationlib,
       m.CODE,
       m.ESTMICTSL,
       codeprovision,
       CAST(m.MONTANTTTCVRAI AS NUMBER(32, 3)),
       m.NAVIRE,
       m.ARMATEURLIB,
       m.EXERCICE,
       IDAVOIR,
       pourcompte,
       pourcomptelib,
       ESTANCIENNE,
       m.armateur,
       d.id,
       d.val,
       m.lht,
       m.lm,
       m.te,
       m.jnt,
       m.pavillon,
       m.pavillonlib,
       m.provenance,
       p1.valquais as provenancelib,
        m.destination,
        p2.valquais as destinationlib,
        m.bateau,
        m.bateaulib,
        m.datedepart,
        m.heuredepart,
        m.datearrivee,
        m.heurearrivee
FROM factureclientMSum m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id
         LEFT JOIN devise d ON d.id = m.paiement
         left join postedestinatairelibcomplet p1 on p1.id=m.provenance
         left join postedestinatairelibcomplet p2 on p2.id=m.destination;



