
ALTER TABLE avoirFCfille ADD tva number(10,3) ; 

CREATE OR REPLACE  VIEW AVOIRFCFILLE_PLUS (ID, IDMERE, IDDETAILFACTURE, MONTANT,  tvaAv , 
COMPTE, MONTANTDF,tvaDf , DESIGNATION, DEVISE, REMISE ) AS 
  select fc.ID,
       fc.IDMERE,
       fc.IDDETAILFACTURE,
       fc.MONTANT, 
        fc.tva AS tvaAv , 
       fc.COMPTE,
       cast(MONTANTHTSIMPLE as NUMBER(30, 2)) as montantdf, 
        ca.tva AS tvaDf , 
       ca.designation as designation,
       ca.devise as devise,
       fc.REMISE 
      
      
       
from AvoirFCFille fc
        left join CAFCFILLECOMPLET ca on ca.id=fc.IDDETAILFACTURE; 
       
       
       
   CREATE OR REPLACE  VIEW AVOIRFCAVECTAUX (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, TAUX, 
       DEVISE, MONTANTAVECTSAUX, ETAT ,tva , montantTva , montantTTC) AS 
  select ac.ID ,ac.IDMERE,ac.IDDETAILFACTURE,ac.MONTANT,ac.COMPTE,
       cast(nvl(fc.TAUX, 1) as number(30, 3))              as taux,
       nvl(fc.DEVISE, 'Ar')                                as devise,
       cast(ac.MONTANT * nvl(fc.TAUX, 1) as number(30, 3)) as montantavectsaux,
       a.ETAT , 
       ac.tva , 
       cast((ac.montant*nvl(fc.taux,1)* nvl(ac.tva,0) )/100 as number(30, 3)) as montantTva , 
       cast(ac.montant*nvl(taux,1)*(1+ nvl(ac.tva,0) /100)as number(30, 3)) as montantTTC
from AVOIRFCFILLE ac
         left join FACTURE_CLIENT_FILLE fc on fc.ID = ac.IDDETAILFACTURE
         left join avoirfc a on ac.IDMERE = a.ID;

        
     
   CREATE OR REPLACE  VIEW AVOIRFCAVECTAUX_GRP_MERE (IDMERE, MONTANT , montanttva , montantttc) AS --correction : tsy mety ilay cast
select 
       at.IDMERE,
       cast(sum(at.MONTANTAVECTSAUX) as NUMBER(30,2)) as montant , 
       cast(sum(montanttva) AS NUMBER(30,2)) as montanttva ,
       cast(sum(montantttc) AS NUMBER(30,2)) as montantttc
    from avoirfcavectaux at
group by at.IDMERE;





CREATE OR REPLACE  VIEW AVOIRFC_MONTANT (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, --correction : tsy mamaky consigne tsara amin'ilay montantreste sady adino nicast
MONTANTPAYE, MONTANTRESTE, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION , 
montanttva , montantttc) AS 
  SELECT fc.ID,
          fc.DATY,
          fc.IDFACTURE,
          fc.ETAT,
          CAST (NVL (mr.montant, 0.0) AS NUMBER (30, 3)) AS montant,
          f.TIERS,
          f.tierslib,
          CAST (NVL (op.DEBIT, 0) AS NUMBER (30, 3)) AS montantpaye,
          CAST (NVL (mr.montantttc, 0.0) - NVL (op.DEBIT, 0) AS NUMBER (30, 3)) AS montantreste,
          fc.CATEGORIE,
          c.VAL AS categorielib,
          fc.MOTIF,
          mo.val AS motiflib,
          fc.CODE,
          fc.TYPE,
          CASE
             WHEN fc.TYPE = '1' THEN 'interne'
             WHEN fc.TYPE = '2' THEN 'externe'
          END
             AS typelib,
          fc.DESIGNATION , 
          CAST (mr.montanttva AS NUMBER (30, 3)) as montanttva, 
          CAST (mr.montantttc AS NUMBER (30, 3)) as montanttc
     FROM AVOIRFC fc
          LEFT JOIN CATEGORIEAVOIRFC c ON fc.CATEGORIE = c.id
          LEFT JOIN MOTIFAVOIRFC mo ON fc.MOTIF = mo.id
          LEFT JOIN avoirfcavectaux_grp_mere mr ON mr.IDMERE = fc.ID
          LEFT JOIN FACTURECLIENT_libcomplet f ON fc.IDFACTURE = f.ID
          LEFT JOIN ordonnerpayement_jc_vise op ON op.ded_id = fc.ID;





         CREATE OR REPLACE  VIEW AVOIRFC_MONTANT_C (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, 
         TIERSLIB, MONTANTPAYE, MONTANTRESTE, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION ,montanttva,montantttc ) AS 
  
         	select ID,DATY,IDFACTURE,ETAT,MONTANT,TIERS,TIERSLIB,MONTANTPAYE,MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,
  			MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION , montanttva , montantttc
   from avoirFC_montant
  where etat=1;
 
 CREATE OR REPLACE  VIEW AVOIRFC_MONTANT_V (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, MONTANTPAYE, MONTANTRESTE, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION , montanttva , montantttc) AS 
  select ID,DATY,IDFACTURE,ETAT,MONTANT,TIERS,TIERSLIB,MONTANTPAYE,MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION , montanttva , montantttc
from avoirFC_montant
where etat>=11;






CREATE OR REPLACE  VIEW AVOIRFCFILLEVALIDEGROUPE(ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, REMISE, MONTANTAVOIRAVECTSAUX , montantavTTCavecTaux) AS 
  select max(AF.ID)     as id,
       af.idmere,
       AF.IDDETAILFACTURE,
       sum(montant)   as montant,
       max(af.compte) as compte,
       avg(remise)    as remise,
       cast(sum(montant * nvl(fc.TAUX, 1)) as number(30, 3))
      as montantavoiravectsaux ,
                      
       CAST(sum(montant*nvl(fc.taux , 1)*(1+(fc.tva/100)) ) AS NUMBER (30, 3)) as montantavTTCavecTaux

from avoirfcfille af
         join avoirfc a on a.id = AF.IDMERE
         left join FACTURE_CLIENT_FILLE fc on fc.ID = af.IDDETAILFACTURE
where A.ETAT >= 11
group by af.idmere, AF.IDDETAILFACTURE; 



CREATE OR REPLACE  VIEW FCFILLECOMPLET (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, 
IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, 
DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, 
MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MONTANTAVOIRAVECTSAUX , montantavTTCavecTaux) AS 
  SELECT fcf.ID,
       fcf.IDMERE,
       fcf.DESIGNATION,
       fcf.QUANTITE,
       fcf.PU,
       fcf.COMPTE,
       fcf.IDPRODUIT,
       fcf.DEVISE,
       fcf.TAUX,
       fcf.IDACTIVITE,
       fcf.TVA,
       fcf.DATEFACT,
       fcf.RUBRIQUE,
       EXTRACT(MONTH FROM fc.DATY)                          AS mois,
       EXTRACT(YEAR FROM fc.DATY)                           AS annee,
       fcf.HEUREDEBUT,
       fcf.HEUREFIN,
       fcf.REDUCTION,
       fcf.MAJORATION,
       fcf.TEST,
       fcf.RANG,
       fcf.DUREE,
       fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) AS montantAV,
       DECODE(fcf.rubrique, NULL, a.rubrique, fcf.rubrique)
                                                            AS rubriquecpl,
       fc.daty,
       fc.tiers,
       fc.idcategorie,
       fc.TYPE,
       fc.devisemere,
       fc.exercice,
       FC.IDAVOIr,
       fc.etat,
       NVL(AV.MONTANT, 0)                                   AS mtavoir,
       fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.REDUCTION, 0)
           / 100
                                                            AS montantReduction,
       fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.MAJORATION, 0)
           / 100
                                                            AS montantMajoration,
       fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1)
           + (fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.MAJORATION, 0))
           / 100
           - (fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.REDUCTION, 0))
           / 100
                                                            AS montant,
       (fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1)
            + (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.MAJORATION, 0))
            / 100
           - (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.REDUCTION, 0))
            / 100)
           * NVL(fcf.tva / 100, 0)
                                                            AS montanttva,
       (fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1)
            + (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.MAJORATION, 0))
            / 100
           - (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.REDUCTION, 0))
            / 100)
           * (1 + NVL(fcf.tva / 100, 0))
                                                            AS montantttc,
       m.VAL                                                AS moislib,
       f.MONTANTHTSIMPLE,
       t.nomclt,
       CAST(nvl(av.montantavoiravectsaux, 0) AS  NUMBER (30, 3)) AS  montantavoiravectsaux , 
       CAST(nvl(av.montantavTTCavecTaux, 0) AS NUMBER (30, 3)) as montantavTTCavecTaux
FROM facture_client_fille fcf
         JOIN factureclient fc ON fcf.idmere = fc.id
         LEFT JOIN activite a ON a.id = fcf.idactivite
         LEFT JOIN avoirfcFilleValideGroupe av
                   ON AV.IDDETAILFACTURE = fcf.id
         LEFT JOIN mois m ON m.ID = EXTRACT(MONTH FROM fc.DATY)
         LEFT JOIN facture_client_filleTTC f ON f.ID = fcf.ID
         left join client_union t on fc.TIERS = t.cdclt;


        CREATE OR REPLACE  VIEW CAFCFILLECOMPLET_GRP (IDMERE, MONTANTAV, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC,
        MONTANTHTSIMPLE, MONTANTAVOIRAVECTSAUX , montantavTTCavecTaux) AS 
  select idmere,
       sum(montantav)             as montantav,
       sum(mtavoir)               as mtavoir,
       sum(montantreduction)      as montantreduction,
       sum(montantmajoration)     as montantmajoration,
       sum(montant)               as montant,
       sum(montanttva)            as montanttva,
       sum(montantttc)            as montantttc,
       sum(montanthtsimple)       as montanthtsimple,
       sum(MONTANTAVOIRAVECTSAUX) as MONTANTAVOIRAVECTSAUX , 
       sum(montantavTTCavecTaux)  as montantavTTCavecTaux
from FCFILLECOMPLET
group by idmere;



CREATE OR REPLACE FORCE VIEW FACTURECLIENTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, 
MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL,DEVISEMERE, CODEPRESTATION,
 CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB,
 ESTANCIENNE) AS 
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
       CAST(NVL(grp.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER(32, 3))                      AS montantavoir,
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
       nv.armateurlib,
       fc.exercice,
       fc.IDAVOIR,
       fc.pourcompte,
       fup.NOM                                                                       as pourcomptelib,
       fc.ESTANCIENNE
FROM FACTURECLIENT fc
         LEFT JOIN CAFCFILLECOMPLET_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
         LEFT JOIN CODE_PRESTATION cp ON fc.codePrestation = cp.id
         LEFT JOIN NAVIRELIBCOMPLET nv ON pr.NAVIRE = nv.id
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = fc.POURCOMPTE;
		 
		 

CREATE OR REPLACE  VIEW AVOIRFC_MONTANT (ID, DATY, IDFACTURE, ETAT,  TIERS, TIERSLIB, 
 CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION , MONTANT,
montanttva , montantttc , MONTANTPAYE, MONTANTRESTE) AS 
  SELECT fc.ID,
          fc.DATY,
          fc.IDFACTURE,
          fc.ETAT,
          
          f.TIERS,
          f.tierslib,
          
          fc.CATEGORIE,
          c.VAL AS categorielib,
          fc.MOTIF,
          mo.val AS motiflib,
          fc.CODE,
          fc.TYPE,
          CASE
             WHEN fc.TYPE = '1' THEN 'interne'
             WHEN fc.TYPE = '2' THEN 'externe'
          END
             AS typelib,
          fc.DESIGNATION , 
		  CAST (NVL (mr.montant, 0.0) AS NUMBER (30, 3)) AS montant,
          CAST (mr.montanttva AS NUMBER (30, 3)) as montanttva, 
          CAST (mr.montantttc AS NUMBER (30, 3)) as montanttc ,  
		  CAST (NVL (op.DEBIT, 0) AS NUMBER (30, 3)) AS montantpaye,
          CAST (NVL (mr.montantttc, 0.0) - NVL (op.DEBIT, 0) AS NUMBER (30, 3)) AS montantreste
		  
     FROM AVOIRFC fc
          LEFT JOIN CATEGORIEAVOIRFC c ON fc.CATEGORIE = c.id
          LEFT JOIN MOTIFAVOIRFC mo ON fc.MOTIF = mo.id
          LEFT JOIN avoirfcavectaux_grp_mere mr ON mr.IDMERE = fc.ID
          LEFT JOIN FACTURECLIENT_libcomplet f ON fc.IDFACTURE = f.ID
          LEFT JOIN ordonnerpayement_jc_vise op ON op.ded_id = fc.ID; 