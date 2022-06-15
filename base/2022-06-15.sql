

	CREATE OR REPLACE  VIEW PLACEMENT_ANALYSE_DAT (id , ENTITE, BANQUE, ANNEEPLACEMENT, ANNEEREMBOUSEMENT, MOISPLACEMENT, MOISREMBOUSEMENT, MONTANT, MONTANT_TERME, INTERET_RECEVOIR, INTERETNET, MOISPLACEMENTLIB, MOISREMBOUSEMENTLIB, DESIGNATION) AS 
  select '' , 
n.ENTITE,n.BANQUE,n.ANNEEPLACEMENT,n.ANNEEREMBOUSEMENT,n.MOISPLACEMENT,n.MOISREMBOUSEMENT,n.MONTANT,n.MONTANT_TERME,n.INTERET_RECEVOIR,n.INTERETNET,n.MOISPLACEMENTLIB,n.MOISREMBOUSEMENTLIB ,
'Souscription' as designation
from PLACEMENT_ANALYSE_NEW n
UNION
select '' , 
a.ENTITE,a.BANQUE,a.ANNEEPLACEMENT,a.ANNEEREMBOUSEMENT,a.MOISPLACEMENT,a.MOISREMBOUSEMENT,a.MONTANT,a.MONTANT_TERME,a.INTERET_RECEVOIR,a.INTERETNET,a.MOISPLACEMENTLIB,a.MOISREMBOUSEMENTLIB ,
'Annulation' as designation
from PLACEMENT_ANALYSE_ANNULE a  ;

alter table factureclient ADD volume NUMBER(20 , 3) ;
alter table factureclient ADD volume100 NUMBER(20 , 3) ; 



CREATE OR REPLACE  VIEW FACTURECLIENTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA,
MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB,
CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB, ESTANCIENNE, ARMATEUR, PAIEMENT, LHT,
LM, TE, JNT, DATEDEPART, HEUREDEPART, DATEARRIVEE, HEUREARRIVEE, BATEAU, PROVENANCE, DESTINATION, PAVILLON, PAVILLONLIB, BATEAULIB , volume , volume100) AS 
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
        nvl(nv.nom,nvc.nom) as bateaulib, 
        fc.volume , 
        fc.volume100
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






CREATE OR REPLACE  VIEW FACTURECLIENTMSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION,
MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, 
IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE,
IDAVOIR, POURCOMPTE, POURCOMPTELIB, ESTANCIENNE, ARMATEUR, PAIEMENT, PAIEMENTLIB, LHT, LM, TE, JNT, PAVILLON, PAVILLONLIB, PROVENANCE, PROVENANCELIB, 
DESTINATION, DESTINATIONLIB, BATEAU, BATEAULIB, DATEDEPART, HEUREDEPART, DATEARRIVEE, HEUREARRIVEE , volume , volume100) AS 
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
        m.heurearrivee ,  
        m.volume , 
        m.volume100
FROM factureclientMSum m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id
         LEFT JOIN devise d ON d.id = m.paiement
         left join postedestinatairelibcomplet p1 on p1.id=m.provenance
         left join postedestinatairelibcomplet p2 on p2.id=m.destination;


        
Update view FACT_CLT_FILL_LIB_REST_TAXE
add column nvl(ua2.val,ua1.val) as unite
left join unite_activite ua1 on ua1.id=r.unite
left join unite_activite ua2 on ua2.id=r1.unite   
        
CREATE OR REPLACE  VIEW FACT_CLT_FILL_LIB_REST_TAXE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX,
MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO,
MONTANTTVAEURO, MONTANTTAXE, MAJORATION, REDUCTION, DATEFACT, RUBRIQUE, RANG, DATY, DUREE, TYPE, ETAT , unite) AS 
  SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                                             AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))                         AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                                          AS resteAlivrer,
       CAST(fcm.MONTANT AS NUMBER(32, 3))                               AS MONTANTTAUX,
       CAST(fcm.MONTANT AS NUMBER(32, 5))                                 AS MONTANT,
       CAST(fcm.MTAVOIR AS NUMBER(32, 3))
                                                                          AS MONTANTAVOIRSANSTAUX,
       CAST(fcm.MTAVOIR AS NUMBER(32, 3))
                                                                          AS MONTANTAVOIRAVECTAUX,
       CAST(fcm.tva AS NUMBER(20, 3))                                     AS tva,
       fc.idactivite,
       ra.DESIGNATION                                                     AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                                           AS moislib,
       CAST(0 AS NUMBER(32, 2))                                           AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                                           AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                                           AS montantTVAEuro,
       CAST(MONTANTTVA AS NUMBER(20, 3))                                  AS montanttaxe,
       NVL(fc.majoration, 0)                                              AS majoration,
       NVL(fc.reduction, 0)                                               AS reduction,
       fc.DATEFACT,
       nvl(fc.RUBRIQUE, r.ID),
       fc.rang,
       CASE WHEN fc.IDACTIVITE IS NOT NULL THEN ra.DATY else fcm.DATY END AS daty,
       fc.DUREE,
       fcm.TYPE,
       fcm.ETAT , 
        nvl(ua2.val,ua1.val) as unite
FROM facture_client_fille_rangfinal fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN fcfillecomplet fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fc.RUBRIQUE
        left join unite_activite ua1 on ua1.id=r.unite
		left join unite_activite ua2 on ua2.id=r1.unite;
	
	Create view factfourn_msum_lib_fiche AS 
select
id,
daty,
designation,
tierslib,
contact,
adresse,
typelib,
categorielib,
date_echeance,
code_etablissementlib,
projetlib,
exercice,
code,
idbl,
idbc,
idengagementlib,
montanthtsansremise,
montant,
montanttva,
montantavoir,
montantttc,
montantpaye,
montantreste,
dateregul,
idprovision
from factfourn_msum_lib; 
	
Create OR REPLACE view factfourn_msum_lib_fiche AS 
select
id,
daty,
designation,
tierslib,
contact,
adresse,
typelib,
categorielib,
date_echeance,
code_etablissementlib,
projetlib,
exercice,
code,
idbl,
idbc,
idengagementlib,
montanthtsansremise,
montant,
montanttva,
montantavoir,
montantttc,
montantpaye,
montantreste,
dateregul,
idprovision , 
Idcategorie , 
idProvisionlib
from factfourn_msum_lib; 

        