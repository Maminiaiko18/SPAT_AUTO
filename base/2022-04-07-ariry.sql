
ALTER TABLE proforma_mere ADD escale varchar(100); 


CREATE OR REPLACE  VIEW PROFORMA_MERE_ORDRE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER,
DATE_ECHEANCE, ETAT, IDPREVISION, IDCATEGORIE, IDPROVISION, DEVISEMERE, ESTDDPMICTSL, CODEPRESTATION, CODE, ESTMICTSL, 
EXERCICE, IDAVOIR, ESTAUTO, TYPEENGAGEMENT, POURCOMPTE, ESTANCIENNE, DATEARRIVEE, HEUREARRIVEE, DATEDEPART, HEUREDEPART, 
BATEAU, PROVENANCE, DESTINATION ,ESCALE) AS 
  SELECT 
ID, 
	DATY , 
	TIERS , 
	DESIGNATION , 
	TYPE , 
	TVA , 
	REMARQUE , 
	IDUSER , 
	DATE_ECHEANCE , 
	ETAT, 
	IDPREVISION , 
	IDCATEGORIE , 
	IDPROVISION, 
	DEVISEMERE , 
	ESTDDPMICTSL , 
	CODEPRESTATION , 
	CODE , 
	ESTMICTSL, 
	EXERCICE , 
	IDAVOIR, 
	ESTAUTO , 
	TYPEENGAGEMENT , 
	POURCOMPTE , 
	ESTANCIENNE , 
	DATEARRIVEE , 
	HEUREARRIVEE,
	DATEDEPART , 
	HEUREDEPART , 
	BATEAU, 
	PROVENANCE , 
	DESTINATION , 
	ESCALE
	
	FROM PROFORMA_MERE   ;



CREATE OR REPLACE  VIEW PROFORMAMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE,
ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, 
IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, 
ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB, PROVENANCE, DESTINATION, DATEDEPART, DATEARRIVEE, HEUREDEPART, 
HEUREARRIVEE, BATEAU, BATEAULIB ) AS 
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
           when pr.ESCALE IS NOT NULL then pr.ESCALE
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




CREATE OR REPLACE  VIEW PROFORMA_MERE_MSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT,
IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, 
CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, 
NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB, PROVENANCE, PROVENANCELIB, DESTINATION, DESTINATIONLIB, DATEDEPART, DATEARRIVEE, 
HEUREDEPART, HEUREARRIVEE, BATEAU, BATEAULIB ) AS 
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
         -- CAST (LEAST (NVL (pf.montant, 0),(m.montant-m.montantavoir)) AS NUMBER (32, 3)) AS montantpaye,
          CAST (0 AS NUMBER (32, 3)) AS montantpaye,
          CAST (M.MONTANTTTC - NVL (pf.montant, 0) AS NUMBER (32, 3))
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
          m.devisemere,
          m.codePrestation,
          m.codePrestationlib,
          m.CODE,
          m.ESTMICTSL,
          codeprovision,
          CAST (m.MONTANTTTCVRAI AS NUMBER (32, 3)),
          m.NAVIRE,
          m.ARMATEURLIB,
          m.EXERCICE,
          IDAVOIR,
         pourcompte,pourcomptelib , 
         	m.PROVENANCE , 
         	p1.PAYS AS provenancelib  , 
         	m.destination , 
         	p2.PAYS AS destinationlib , 
         	m.DATEDEPART , 
          m.DATEARRIVEE , 
          m.HEUREDEPART , 
          m.HEUREARRIVEE , 
          m.BATEAU , 
          m.bateaulib
     FROM PROFORMAMSUM m 
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
          LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id 
         LEFT JOIN postedestinataire p1 ON p1.id = m.provenance 
        LEFT JOIN postedestinataire p2 ON p2.id = m.destination;