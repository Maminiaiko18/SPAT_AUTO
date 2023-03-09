     
Create OR REPLACE view avoirfcfille_PDF AS SELECT 
av.ID,
av.IDMERE,
av.IDDETAILFACTURE,
av.MONTANT,
av.COMPTE,
av.remise,
ca.designation as designation,
ca.taux,
ca.devise,
av.tva,
av.qte,
av.pu,
av.duree , 
CAST(av.montant/ca.taux AS NUMBER(30 , 3)) as montantHTDevise , 
ca.majoration AS maj, 
ca.reduction AS red

from AvoirFCFille av
left join CAFCFILLECOMPLET ca on ca.id=av.IDDETAILFACTURE ;   


CREATE OR REPLACE  VIEW BC_BL_LIVRE (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, QUANTITELIVRE, QUANTITERESTE, MONTANTBL, MONTANTBLRESTE, 
UNITE, TVA, REMISE, MONTANTREMISE , montantHTSansRemise ) AS 
  SELECT BCF.ID,
       CASE WHEN BCF.PRODUIT IS NULL THEN BCF.REMARQUE ELSE ap.Nom END
                                                   AS PRODUIT,
       BCF.IDBC,
       BCF.QUANTITE,
       BCF.PU,
       BCF.QUANTITEPARPACK,
       BCF.MONTANT,
       BCF.REMARQUE,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitelivre,
       CAST(BCF.QUANTITE - NVL(BFG.qtelivre, 0) AS NUMBER(25, 2))
                                                   AS quantitereste,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU
                                                   AS MontantBL,
       (bcf.quantite * bcf.pu)
           - CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU
                                                   AS MontantBLreste,
       u.DESCE                                     AS UNITE,
       bcf.TVA,
       bcf.REMISE,
       cast((BCF.REMISE * bcf.PU*bcf.QUANTITE) / 100 as NUMBER(30,2)) as montantRemise , 
       CAST((bcf.quantite*bcf.pu) AS NUMBER(30,2)) AS montantHTSansRemise
FROM union_bcf_spat_cemedi BCF
         LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG
                   ON BFG.IDBONDECOMMANDE = BCF.ID
         LEFT JOIN union_produit_tbd_cemedi ap ON BCF.produit = ap.id
         LEFT JOIN union_unite_tbd_cemedi u ON bcf.UNITE = u.id;

        
CREATE OR REPLACE  VIEW AS_BONDECOMMANDE_LIBELLE_LIB (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, 
MONTANT, MONTANTTVA, MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET, CODE_ETAB, 
MONTANTFACTURE, ETATLIB, MONTANTREMISE, IDENGAGEMENTLIB, IDENGAGEMENT, CODEETABLISSEMENT, COMPTEBDG , montantHTSansRemise) AS 
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                                                      as fournisseur,
       cast(bc.tva as NUMBER(10)),
       bc.NUMBC,
       cast(nvl(c.montantht, 0) as number(32, 2)),
       cast(nvl(c.montanttva, 0) as number(32, 2)),
       cast(nvl(c.montantttc, 0) as NUMBER(32, 2)),
       ''                                                                          as idfacture,
       cast(nvl(lfac.montantpayer, 0) as number(32, 2))                            as montant_paye_reel,
       cast((nvl(c.montantttc, 0) - nvl((bl.MONTANTTTC), 0)) as NUMBER(32, 2))     as resteapayegeneral,
       cast((nvl(c.montantttc, 0) - nvl((lfac.montantpayer), 0)) as NUMBER(32, 2)) as resteapayerreel,
       cast(nvl(bl.montantttc, 0) as NUMBER(32, 2))                                as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       cast(lfac.montantttc as NUMBER(32, 2))                                      as montantfacture,
       case
           when bcf.RESTELIVRE > 0 then 'VISE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE(E)'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and
                (lfac.montantttc - nvl(lfac.montantpayer, 0) is not null)
               THEN 'FACTURE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) > 0
               THEN 'EN ATTENTE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYE(E)'
           else 'CREE(E)'
           END                                                                     as etatlib,
       cast(MONTANTREMISE as NUMBER(32, 2)),
       idengagementlib,
       IDENGAGEMENT,
       CODEETABLISSEMENT,
       CODE_ETAB || PROJET                                                       as comptebdg    , 
       CAST((c.montantht - montantremise) AS number(30 , 3)) AS montantHTSansRemise
from AS_BONDECOMMANDE_LIBELLE bc
     left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
     left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
     left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
     LEFT JOIN AS_BONDELIVRAISON_BC bl on bl.id_bc=bc.id
     left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur ;                  
               
    
    
    
    CREATE OR REPLACE  VIEW UNION_BCF_SPAT_CEMEDI (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA, REMISE , observation ) AS 
  select bcf.ID,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       UNITE,
       TVA,
       REMISE , 
       bcf.observation 
	   
from AS_BONDECOMMANDE_FILLE bcf
union
select id,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       UNITE,
       tva,
       cast(0 as NUMBER(30,2)) , 
       cast ('-' as varchar(10))
from bcf_cemedi_vue;

CREATE OR REPLACE  VIEW BC_BL_LIVRE (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, QUANTITELIVRE, QUANTITERESTE, 
MONTANTBL, MONTANTBLRESTE, UNITE, TVA, REMISE, MONTANTREMISE , observation) AS 
  SELECT BCF.ID,
       CASE WHEN BCF.PRODUIT IS NULL THEN BCF.REMARQUE ELSE ap.Nom END
                                                   AS PRODUIT,
       BCF.IDBC,
       BCF.QUANTITE,
       BCF.PU,
       BCF.QUANTITEPARPACK,
       BCF.MONTANT,
       BCF.REMARQUE,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitelivre,
       CAST(BCF.QUANTITE - NVL(BFG.qtelivre, 0) AS NUMBER(25, 2))
                                                   AS quantitereste,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU
                                                   AS MontantBL,
       (bcf.quantite * bcf.pu)
           - CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU
                                                   AS MontantBLreste,
       u.DESCE                                     AS UNITE,
       bcf.TVA,
       bcf.REMISE,
       cast((BCF.REMISE * bcf.PU*bcf.QUANTITE) / 100 as NUMBER(30,2)) as montantRemise , 
       bcf.observation
FROM union_bcf_spat_cemedi BCF
         LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG
                   ON BFG.IDBONDECOMMANDE = BCF.ID
         LEFT JOIN union_produit_tbd_cemedi ap ON BCF.produit = ap.id
         LEFT JOIN union_unite_tbd_cemedi u ON bcf.UNITE = u.id;

        
        
        
        
        CREATE OR REPLACE  VIEW AVOIRFCFILLE_PDF (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, REMISE, DESIGNATION, TAUX, DEVISE,
        TVA, QTE, PU, DUREE, MONTANTHTDEVISE, MAJ, RED) AS 
  SELECT 
av.ID,
av.IDMERE,
av.IDDETAILFACTURE,
av.MONTANT,
av.COMPTE,
av.remise,
ca.designation as designation,
ca.taux,
ca.devise,
av.tva,
av.qte,
av.pu,
av.duree , 
CASE WHEN devise='Ar' then CAST((av.montant/ca.taux) AS NUMBER(30 , 3))
else CAST(av.montant AS number(30 , 3))  END 
as montantHTDevise , 
ca.majoration AS maj, 
ca.reduction AS red

from AvoirFCFille av
left join CAFCFILLECOMPLET ca on ca.id=av.IDDETAILFACTURE  ;
        
        



CREATE OR REPLACE  VIEW AVOIRFCFILLE_PDF (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, REMISE, DESIGNATION, TAUX, DEVISE, TVA, QTE, PU, 
DUREE, MONTANTHTDEVISE, MAJ, RED) AS 
  SELECT 
av.ID,
av.IDMERE,
av.IDDETAILFACTURE,
av.MONTANT,
av.COMPTE,
av.remise,
ca.designation as designation,
ca.taux,
ca.devise,
av.tva,
av.qte,
av.pu,
av.duree , 
CASE WHEN devise='Ar' then av.montant/ca.taux
else av.montant END  as montantHTDevise , 
ca.majoration AS maj, 
ca.reduction AS red

from AvoirFCFille av
left join CAFCFILLECOMPLET ca on ca.id=av.IDDETAILFACTURE  ;
/*fy*/
CREATE OR REPLACE VIEW AS_BONDECOMMANDE_LIBELLE_LIB AS 
  select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                                                      as fournisseur,
       cast(bc.tva as NUMBER(10)) AS TVA ,
       bc.NUMBC,
       cast(nvl(c.montantht, 0) as number(32, 2)) AS montantht ,
       cast(nvl(c.montanttva, 0) as number(32, 2)) AS montanttva ,
       cast(nvl(c.montantttc, 0) as NUMBER(32, 2)) AS montantttc ,
       ''                                                                          as idfacture,
       cast(nvl(lfac.montantpayer, 0) as number(32, 2))                            as montant_paye_reel,
       cast((nvl(c.montantttc, 0) - nvl((bl.MONTANTTTC), 0)) as NUMBER(32, 2))     as resteapayegeneral,
       cast((nvl(c.montantttc, 0) - nvl((lfac.montantpayer), 0)) as NUMBER(32, 2)) as resteapayerreel,
       cast(nvl(bl.montantttc, 0) as NUMBER(32, 2))                                as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       cast(lfac.montantttc as NUMBER(32, 2))                                      as montantfacture,
       CASE
       	WHEN bc.etat = 0 THEN 'ANNULE(E)'
           when bcf.RESTELIVRE > 0 then 'VISE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE(E)'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and
                (lfac.montantttc - nvl(lfac.montantpayer, 0) is not null)
               THEN 'FACTURE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) > 0
               THEN 'EN ATTENTE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYE(E)'
           else 'CREE(E)'
           END                                                                     as etatlib,
       cast(MONTANTREMISE as NUMBER(32, 2)) AS montantremise,
       idengagementlib,
       IDENGAGEMENT,
       CODEETABLISSEMENT,
       CODE_ETAB || PROJET                                                         as comptebdg
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
         left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
         LEFT JOIN BONDELIVRAISONPARBC bl ON bl.IDBC = bc.ID
         left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur;

/*ariry*/
ALTER TABLE FACTURECLIENT ADD paiement varchar(100) CONSTRAINT FACTURECLIENT_devise_id_fk REFERENCES devise(id) ; 


CREATE OR REPLACE  VIEW FACTURECLIENTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE,
CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB,
ESTANCIENNE, ARMATEUR , paiement) AS 
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
      	fc.paiement 
FROM FACTURECLIENT fc
         LEFT JOIN CAFCFILLECOMPLET_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
         LEFT JOIN CODE_PRESTATION cp ON fc.codePrestation = cp.id
         LEFT JOIN NAVIRELIBCOMPLET nv ON pr.NAVIRE = nv.id
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = fc.POURCOMPTE
         LEFT JOIN armateur_tbd  a ON a.id = fc.armateur  ;


        
        
        CREATE OR REPLACE  VIEW FACTURECLIENTMSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION,
        MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB,
        IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE,
        ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB, ESTANCIENNE, ARMATEUR , paiement , paiementlib) AS 
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
       ESTANCIENNE , 
       m.armateur , 
       d.id , 
       d.val
FROM factureclientMSum m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id      
        LEFT JOIN devise d ON d.id = m.paiement;


CREATE OR REPLACE  VIEW FACTURE_CLIENT_UNION (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB,
IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE,
IDAVOIR, POURCOMPTE, POURCOMPTELIB, ARMATEUR , paiement , paiementlib) AS 
  SELECT ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       CAST(TVA AS NUMBER(20, 3)) AS tva,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       CAST(ETAT AS NUMBER(10))   AS etat,
       CAST(MONTANT AS NUMBER(32, 3)),
       CAST(MONTANTTVA AS NUMBER(32, 3)),
       CAST(MONTANTAVOIR AS NUMBER(32, 3)),
       CAST(MONTANTTTC AS NUMBER(32, 3)),
       CAST(MONTANTPAYE AS NUMBER(32, 3)),
       CAST(MONTANTRESTE AS NUMBER(32, 3)),
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
       DEVISEMERE,
       codePrestation,
       codePrestationlib,
       code,
       ESTMICTSL,
       CODEPROVISION,
       CAST(MONTANTTTCVRAI AS NUMBER(32, 3)),
       ARMATEURLIB,
       EXERCICE,
       idavoir,pourcompte,pourcomptelib , armateur , paiement , paiementlib
FROM (SELECT ID,
             DATY,
             TIERS,
             DESIGNATION,
             TYPE,
             CAST(TVA AS NUMBER(20, 3))          AS TVA,
             REMARQUE,
             IDUSER,
             DATE_ECHEANCE,
             CAST(ETAT AS NUMBER(10))            AS etat,
             CAST(MONTANT AS NUMBER(32, 3))      AS MONTANT,
             CAST(MONTANTTVA AS NUMBER(32, 3))   AS MONTANTTVA,
             CAST(MONTANTAVOIR AS NUMBER(32, 3)) AS MONTANTAVOIR,
             CAST(MONTANTTTC AS NUMBER(32, 3))   AS MONTANTTTC,
             CAST(MONTANTPAYE AS NUMBER(32, 3))  AS MONTANTPAYE,
             CAST(MONTANTRESTE AS NUMBER(32, 3)) AS MONTANTRESTE,
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
             DEVISEMERE,
             codePrestation,
             codePrestationlib,
             code,
             ESTMICTSL,
             CODEPROVISION,
             MONTANTTTCVRAI,
             ARMATEURLIB,
             EXERCICE,
             IDAVOIR,pourcompte,pourcomptelib ,
             armateur , 
             paiement , 
             paiementlib
      FROM FACTURECLIENTMSUM_LIB
      WHERE DATY >= TO_DATE('2021-10-01', 'YYYY-MM-DD')
         OR ESTANCIENNE=1
      UNION ALL
      SELECT ID,
             DATY,
             TIERS,
             DESIGNATION,
             TYPE,
             CAST(TVA AS NUMBER(20, 3))          AS TVA,
             REMARQUE,
             IDUSER,
             DATE_ECHEANCE,
             CAST(ETAT AS NUMBER(10))            AS etat,
             CAST(MONTANT AS NUMBER(32, 3))      AS MONTANT,
             CAST(MONTANTTVA AS NUMBER(32, 3))   AS MONTANTTVA,
             CAST(MONTANTAVOIR AS NUMBER(32, 3)) AS MONTANTAVOIR,
             CAST(MONTANTTTC AS NUMBER(32, 3))   AS MONTANTTTC,
             CAST(MONTANTPAYE AS NUMBER(32, 3))  AS MONTANTPAYE,
             CAST(MONTANTRESTE AS NUMBER(32, 3)) AS MONTANTRESTE,
             TIERSLIB,
             CONTACT,
             ADRESSE,
             '-'                                 AS PREVISION,
             '-'                                 AS ESCALE,
             TYPE                                AS typelib,
             '-'                                 AS IDCATEGORIE,
             '-'                                 AS CATEGORIELIB,
             '-'                                 AS IDPROVISION,
             '-'                                 AS IDPROVISIONLIB,
             '-'                                 AS DEVISEMERE,
             ''                                  AS codePrestation,
             ''                                  AS codePrestationlib,
             ''                                  AS code,
             ''                                  AS ESTMICTSL,
             ''                                  AS CODEPROVISION,
             MONTANTTTC - MONTANTAVOIR           AS MONTANTTTCVRAI,
             CAST('-' AS VARCHAR2(500))             ARMATEURLIB,
             CAST(0 AS NUMBER(10))                  EXERCICE,
             '-'                                    idavoir,
             '-'                                    pourcompte,
             '-'                                    pourcomptelib , 
             '-'                                  as  armateur , 
			  '-'                                    paiement , 
             '-'                                  as  paiementlib 
      FROM analyseglobaleantsika)
;

CREATE OR REPLACE  VIEW FACTURE_CLIENT_UNION_ORDRE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
MONTANTTVA, MONTANTTTCVRAI, MONTANTTTC, MONTANTAVOIR, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, 
CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE,  paiement , paiementlib,  CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, ARMATEURLIB, 
EXERCICE, POURCOMPTE, POURCOMPTELIB ) AS 
  select ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
         cast(ETAT as number(10)),
       IDPREVISION,
         cast(MONTANT as number(30,3)),
         cast(MONTANTTVA as number(30,3)),
         cast(montantTTCvrai as number(30,3)),
         cast(MONTANTTTC as NUMBER(30,3)),
         cast(MONTANTAVOIR as NUMBER(30,3)),
         cast(MONTANTPAYE as NUMBER(30,3)),
         cast(MONTANTRESTE as NUMBER(30,3)),
       TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       DEVISEMERE,
       paiement , 
       paiementlib , 
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       ETATLIB,
       ARMATEURLIB,
       EXERCICE,
       POURCOMPTE,
       POURCOMPTELIB
from facture_client_union;

CREATE OR REPLACE  VIEW fACTURECLIENTVALIDE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL,
MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, TYPECLIENTLIB, POURCOMPTE, POURCOMPTELIB, CODEFILTRE , paiement , paiementlib) AS 
  SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       cast(fc.TVA as number(30, 3))            as TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(fc.MONTANT as NUMBER(30, 3))        as MONTANT,
       cast(fc.MONTANTTVA as NUMBER(30, 3))     as MONTANTTVA,
       cast(fc.MONTANTAVOIR as NUMBER(30, 3))   as MONTANTAVOIR,
       cast(fc.MONTANTTTC as NUMBER(30, 3))     as MONTANTTTC,
       cast(fc.MONTANTPAYE as NUMBER(30, 3))    as MONTANTPAYE,
       cast(fc.MONTANTRESTE as NUMBER(30, 3))   as MONTANTRESTE,
       fc.TIERSLIB,
       fc.CONTACT,
       fc.ADRESSE,
       fc.IDPREVISION,
       fc.ESCALE,
       fc.ETATLIB,
       fc.TYPELIB,
       fc.IDCATEGORIE,
       fc.CATEGORIELIB,
       fc.IDPROVISION,
       fc.IDPROVISIONLIB,
       fc.DEVISEMERE,
       fc.CODEPRESTATION,
       fc.CODEPRESTATIONLIB,
       fc.CODE,
       ESTMICTSL,
       CAST(fc.MONTANTTTCVRAI AS NUMBER(35, 3)) AS MONTANTTTCVRAI,
       ARMATEURLIB,
       EXERCICE,
       nvl(typelib,'-')                                  as typeclientlib,
       pourcompte,
       pourcomptelib , 
       fc.code as codeFiltre , 
       paiement , 
       paiementlib
FROM facture_client_union fc
WHERE id NOT IN (SELECT id FROM ProvisionFactureDefinitive);






CREATE OR REPLACE  VIEW BC_BL_LIVRE (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, QUANTITELIVRE, QUANTITERESTE, MONTANTBL,
MONTANTBLRESTE, UNITE, TVA, REMISE, MONTANTREMISE, OBSERVATION , montantHTSansRemise ) AS 
  SELECT BCF.ID,
       CASE WHEN BCF.PRODUIT IS NULL THEN BCF.REMARQUE ELSE ap.Nom END
                                                   AS PRODUIT,
       BCF.IDBC,
       BCF.QUANTITE,
       BCF.PU,
       BCF.QUANTITEPARPACK,
       BCF.MONTANT,
       BCF.REMARQUE,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitelivre,
       CAST(BCF.QUANTITE - NVL(BFG.qtelivre, 0) AS NUMBER(25, 2))
                                                   AS quantitereste,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU
                                                   AS MontantBL,
       (bcf.quantite * bcf.pu)
           - CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU
                                                   AS MontantBLreste,
       u.val                                     AS UNITE,
       bcf.TVA,
       bcf.REMISE,
       cast((BCF.REMISE * bcf.PU*bcf.QUANTITE) / 100 as NUMBER(30,2)) as montantRemise , 
       bcf.observation , 
       cast(bcf.quantite*bcf.pu AS NUMBER(30 , 3))
FROM union_bcf_spat_cemedi BCF
         LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG
                   ON BFG.IDBONDECOMMANDE = BCF.ID
         LEFT JOIN union_produit_tbd_cemedi ap ON BCF.produit = ap.id
         LEFT JOIN union_unite_tbd_cemedi u ON bcf.UNITE = u.id;
        
        UPDATE MENUDYNAMIQUE
SET HREF  = '/spat/pages/globalnegoce.jsp?but=stock/bc/analyse-detailsBC.jsp'
WHERE id = 'SED0000001';




CREATE OR REPLACE  VIEW AS_BONDELIVRAISON_FILLEQTE_RES AS 
  SELECT blf.ID,
       blf.PRODUIT,
       blf.NUMBL,
       blf.QUANTITE,
       blf.QUANTITEPARPACK,
       blf.IDDETAILSFACTUREFOURNISSEUR,
       blf.IDBONDECOMMANDE,
       NVL(qff.quantite, 0)                                                AS facture,
       blf.QUANTITE - NVL(qff.quantite, 0)                                 AS quantitereste,
       bcf.PU,
       tiers.nom                                                      AS nomTiers,
       tiers.id                                                       as idtiers,
       bcf.TVA,
       cast((blf.QUANTITE * bcf.PU) as number(34, 2))                 as montantht,
       cast((blf.QUANTITE * bcf.PU * bcf.TVA) / 100 as number(34, 2)) as montanttva,
       bc.PROJET,
       pr.DESIGNATION                                                 as projetlib,
       bc.CODE_ETAB                                                   as code_etablissement,
       ce.VAL                                                         as code_etablissementlib
      ,bcf.IDBC as IDBONDECOMMANDEMERE
FROM AS_BONDELIVRAISON_FILLE blf
         LEFT JOIN union_bcf_spat_cemedi bcf
                   ON bcf.id = blf.IDBONDECOMMANDE
         LEFT JOIN union_bc_spat_cemedi bc ON bc.id = bcf.idbc
         LEFT JOIN tiers ON tiers.id = bc.fournisseur
         LEFT JOIN FACTURE_FOURNISSEUR_QTE qff
                   ON qff.IDBLF = blf.id
         left join PROJET pr on pr.id = bc.PROJET
         left join CODEETABLISSEMENT ce on ce.id = CODE_ETAB;
 