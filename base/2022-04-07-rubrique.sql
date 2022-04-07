update rubrique_activite set designation='EMBARQT TC P 20''' where id='RBR0105';
update rubrique_activite set designation='EMBARQT TC V 20''' where id='RBR0106';
update rubrique_activite set designation='DEBARQT TC P 20''' where id='RBR0107';
update rubrique_activite set designation='DEBARQT TC V 20''' where id='RBR0108';

update rubrique_activite set designation='EMBARQT TC P 40''' where id='RBR0109';
update rubrique_activite set designation='EMBARQT TC V 40''' where id='RBR0110';
update rubrique_activite set designation='DEBARQT TC P 40''' where id='RBR0111';
update rubrique_activite set designation='DEBARQT TC V 40''' where id='RBR0112';

update rubrique_activite set designation='EMBARQT TC P 45''' where id='RBR0113';
update rubrique_activite set designation='EMBARQT TC V 45''' where id='RBR0114';
update rubrique_activite set designation='DEBARQT TC P 45''' where id='RBR0115';
update rubrique_activite set designation='DEBARQT TC V 45''' where id='RBR0116';

update rubrique_activite set designation='TRANSBO TC P 20''' where id='RBR0117';
update rubrique_activite set designation='TRANSBO TC V 20''' where id='RBR0118';
update rubrique_activite set designation='TRANSBO TC P 40''' where id='RBR0119';
update rubrique_activite set designation='TRANSBO TC V 40''' where id='RBR0120';
update rubrique_activite set designation='TRANSBO TC P 45''' where id='RBR0121';
update rubrique_activite set designation='TRANSBO TC V 45''' where id='RBR0122';


CREATE OR REPLACE VIEW "PROFORMAMSUM" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDPREVISION", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "ESCALE", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "ESTDDPMICTSL", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "MONTANTTTCVRAI", "NAVIRE", "ARMATEURLIB", "EXERCICE", "IDAVOIR", "POURCOMPTE", "POURCOMPTELIB", "PROVENANCE", "DESTINATION", "DATEDEPART", "DATEARRIVEE", "HEUREDEPART", "HEUREARRIVEE", "BATEAU", "BATEAULIB") AS 
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
          CAST (NVL (grp.montant, 0) AS NUMBER (30, 3)) AS montant, --montanttaux
          CAST (NVL (grp.MONTANTTVA, 0) AS NUMBER (30, 3)) AS montanttva,
          CAST (NVL (grp.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER (32, 3)) AS montantavoir,
          CAST (NVL (MONTANTTTC, 0)-NVL (grp.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER (30, 3)) AS MONTANTTTC,
          
           case
           when fc.IDPREVISION IS NOT NULL then pr.ESCALE
           else  fc.ESCALE end                           as ESCALE , 
         
          tfc.VAL AS typelib,
          fc.IDCATEGORIE,
          catfc.VAL AS CATEGORIELIB,
          fc.IDPROVISION,
          fcf.DESIGNATION AS IDPROVISIONlib,
          fc.ESTDDPMICTSL,
          fc.DEVISEMERE,
          fc.codePrestation,
          cp.VAL AS codePrestationlib,
          fc.code,
          fc.ESTMICTSL,
          fcf.CODE AS codeprovision,
          CAST (
             NVL (NVL (grp.MONTANTTVA, 0) + grp.MONTANT, 0) AS NUMBER (30, 3))
             AS MONTANTTTCVRAI,
          pr.NAVIRE,
          nv.armateurlib,
          fc.exercice,
          fc.IDAVOIR,
          fc.pourcompte,
          fup.NOM as pourcomptelib , 
          fc.provenance , 
          fc.destination , 
          fc.DATEDEPART , 
          fc.DATEARRIVEE , 
          fc.HEUREDEPART , 
          fc.HEUREARRIVEE , 
          fc.BATEAU , 
          n.nom AS bateaulib   
          
     FROM PROFORMA_MERE fc
          LEFT JOIN proforma_fille_lib grp ON grp.idmere = fc.id
          LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
          LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
          LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
          LEFT JOIN PROFORMA_MERE fcf ON fcf.id = fc.IDPROVISION
          LEFT JOIN CODE_PRESTATION cp ON fc.codePrestation = cp.id
          LEFT JOIN NAVIRELIBCOMPLET nv ON pr.NAVIRE = nv.id
          left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID=fc.POURCOMPTE
         LEFT JOIN NAVIRE n ON n.id = fc.BATEAU ;