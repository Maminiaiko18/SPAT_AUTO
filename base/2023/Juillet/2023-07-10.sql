-------add column direction
CREATE OR REPLACE  VIEW ORDRE_MISSION_LIB (ID, IDINDEMNITEMISSION, IDINDEMNITEMISSIONLIB, IDTIERS, MOTIFVOYAGE, LIEUDEPLACEMENT, DUREE, DATEDEPART, NUMOM, ESTFORFAITAIRE, ESTFORFAITAIRELIB, ETAT, ETATLIB, NOM, PRENOM, FONCTION, MATRICULE, IDMOYENDEPLACEMENT, IDMOYENDEPLACEMENTLIB,DIRECTION) AS 
  select 
om.id ,
om.IDINDEMNITEMISSION,
cp.val AS IDINDEMNITEMISSIONlib,
om.idtiers,
om.MOTIFVOYAGE,
om.LIEUDEPLACEMENT,
om.DUREE,
om.DATEDEPART,
om.NUMOM,
om.ESTFORFAITAIRE,
CASE 
	WHEN om.ESTFORFAITAIRE = 1
	THEN 'oui'
	WHEN om.ESTFORFAITAIRE = -1
	THEN 'non'
END AS ESTFORFAITAIRElib,
om.ETAT,
CASE 
	WHEN om.etat = 1
	THEN 'crée'
	WHEN om.etat = 11
	THEN 'validée'
END AS etatlib,
i.NOM ,
i.PRENOM ,
i.POSTE AS fonction,
i.NUMERO_MATRICULE AS matricule,
om.IDMOYENDEPLACEMENT,
mo.VAL AS IDMOYENDEPLACEMENTlib,
dir.LIBELLEDIR AS direction
from ORDRE_MISSION om 
LEFT JOIN INFOPERSONNELGLOBAL i ON i.IDTIERS = om.IDTIERS 
LEFT JOIN INDEMNITE_MISSION im ON im.ID = om.IDINDEMNITEMISSION
LEFT JOIN CATEGORIE_PROFESSIONNEL cp ON cp.id = im.IDCATEGORIEPROFESSIONNEL 
LEFT JOIN moyen_deplacement mo ON mo.id = om.IDMOYENDEPLACEMENT
LEFT JOIN direction dir ON dir.iddir=i.DIRECTION ;



---add column RANG, DATEFACTUREFILLE
CREATE OR REPLACE  VIEW AVOIRFCFILLE_PDF (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, REMISE, DESIGNATION, TAUX, DEVISE, TVA, QTE, PU, DUREE, MONTANTHTDEVISE, MAJ, RED, RANG, DATEFACTUREFILLE) AS 
  SELECT av.ID,
       av.IDMERE,
       av.IDDETAILFACTURE,
       av.MONTANT,
       av.COMPTE,
       av.remise,
       ca.designation                                                                               as designation,
       ca.taux,
       ca.devise,
       av.tva,
       CAST(nvl(av.qte, ca.quantite) AS NUMBER(30, 3))                                                 qte,
       CAST(nvl(av.pu, ca.pu) AS NUMBER(30, 3))                                                        pu,
       CAST(nvl(av.duree, ca.duree) as NUMBER(30, 3))                                                  duree,
       CAST(CASE WHEN devise = 'Ar' THEN av.montant / ca.taux else av.montant END AS NUMBER(30, 3)) AS montantHTDevise,
       ca.majoration                                                                                AS maj,
       ca.reduction                                                                                 AS red,
       ca.rang,
       ca.datefacturefille 
from AvoirFCFille av
         left join fcfillecomplet ca on ca.id = av.IDDETAILFACTURE
;
