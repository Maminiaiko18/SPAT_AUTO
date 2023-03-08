
CREATE OR REPLACE  VIEW CAFCFILLECOMPLET_AVOIR (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MERECA, CODE,ETATLIB) AS 
  SELECT ff.ID,
          IDMERE,
          DESIGNATION,
          QUANTITE,
          PU,
          COMPTE,
          IDPRODUIT,
          DEVISE,
          TAUX,
          IDACTIVITE,
          TVA,
          DATEFACT,
          RUBRIQUE,
         cast(MOIS as NUMBER(10)),
         cast(ANNEE as NUMBER(10)),
          HEUREDEBUT,
          HEUREFIN,
          REDUCTION,
          MAJORATION,
          TEST,
          RANG,
          DUREE,
         cast(MONTANTAV as NUMBER(30,3)),
          RUBRIQUECPL,
          DATY,
          TIERS,
          IDCATEGORIE,
          ff.TYPE,
          DEVISEMERE,
          EXERCICE,
          IDAVOIR,
          ff.ETAT,
         cast(MTAVOIR as NUMBER(30,2)),
         cast(MONTANTREDUCTION as NUMBER(30,2)),
         cast(MONTANTMAJORATION as NUMBER(30,2)),
         cast(MONTANT-nvl(ff.MONTANTAVOIRAVECTSAUX,0)  as NUMBER(30,2)),
         cast(ff.MONTANTTVA-nvl(ff.montantavTVAavecTaux,0) as NUMBER(30,2)),
         cast(ff.MONTANTTTC-nvl(ff.MONTANTAVTTCAVECTAUX,0) as number(30,2)),
          moislib,
         cast(ff.MONTANTHTSIMPLE-nvl(ff.MONTANTAVOIRAVECTSAUX,0) as NUMBER(30,2)),
          ff.client,
          cptM.id,
          ff.code,
            case
           when ff.ETAT = 1 then 'CREE'
           when ff.ETAT >= 11 then 'VISE'
           else '' end                           as etatlib
     FROM fcfillecomplet ff
     LEFT JOIN compteCA cptCA ON cptCA.val=ff.COMPTE
     LEFT join mereCA cptM ON cptM.id=cptCA.desce
     WHERE FF.IDCATEGORIE <> 'CATFCO2' AND FF.IDCATEGORIE <> 'CATFCO1'  and etat>=11;
     
    
    CREATE VIEW CAFCFILLECOMPLET_AVOIRC
    as select * from CAFCFILLECOMPLET_AVOIR where etat = 1;
    
   CREATE VIEW CAFCFILLECOMPLET_AVOIRV AS SELECT *
   FROM  CAFCFILLECOMPLET_AVOIR where etat =11;
   
  
  INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MDO00007234', 'Liste avec numpiece', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=facture/facture-fournisseur-liste-numpiece.jsp', 6, 4, 'MEN00500');




CREATE VIEW FACTURECLIENTPAYEESNP AS

SELECT f.*, j.numpiece

FROM FACTURECLIENTPAYEES  f 
LEFT JOIN  PAIEMENTFACTURE  p ON p.IDFACT = f.ID  
LEFT JOIN JOURNALCAISSE j ON j.ID = p.IDMVT ;

CREATE VIEW FACTUREFOURNVALIDE_PNP AS 
SELECT 
f.*,
j.numpiece
FROM FACTUREFOURNVALIDE_P f
LEFT JOIN  PAIEMENTFACTUREF  p ON p.IDFACT = f.ID  
LEFT JOIN JOURNALCAISSE j ON j.ID = p.IDMVT ;

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00N101', 'Liste FC avec numpiece', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=facture/factureclient-liste-vaovao.jsp', 3, 5, 'MEN0097');


