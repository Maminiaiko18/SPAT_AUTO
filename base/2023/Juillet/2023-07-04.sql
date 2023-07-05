CREATE OR REPLACE  VIEW FCFILLECOMPLET (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MONTANTAVOIRAVECTSAUX, MONTANTAVTTCAVECTAUX, MONTANTAVTVAAVECTAUX, CODE,datefacturefille) AS 
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
       NVL(AV.montantsanstaux, 0)                                   AS mtavoir,
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
       CAST(nvl(av.montantavectsaux, 0) AS  NUMBER (30, 3)) AS  montantavoiravectsaux ,
       CAST(nvl(av.MONTANTTTC, 0) AS NUMBER (30, 3)) as montantavTTCavecTaux,
       CAST(nvl(av.MONTANTTVA, 0) AS NUMBER (30, 3)) as montantavTVAavecTaux,
       fc.code,
       fcf.daty AS datefacturefille 
FROM facture_client_fille fcf
         JOIN factureclient fc ON fcf.idmere = fc.id
         LEFT JOIN activite a ON a.id = fcf.idactivite
         LEFT JOIN AVOIRFCAVECTAUX_GRP av
                   ON AV.IDDETAILFACTURE = fcf.id
         LEFT JOIN mois m ON m.ID = EXTRACT(MONTH FROM fc.DATY)
         LEFT JOIN facture_client_filleTTC f ON f.ID = fcf.ID
         left join client_union t on fc.TIERS = t.cdclt;



CREATE OR REPLACE  VIEW AVOIRFCFILLE_PLUS (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, MONTANTDF, DESIGNATION, DEVISE, REMISE, TVADF, TVAAV, TVA, QTE, PU, MAJ, RED, DUREE,rang,datefacturefille ) AS 
  select

         fc.ID,

       fc.IDMERE,

       fc.IDDETAILFACTURE,

       fc.MONTANT,

       fc.COMPTE,

       cast(MONTANTHTSIMPLE as NUMBER(30, 2)) as montantdf,

       ca.designation as designation,

       ca.devise as devise,

       fc.REMISE ,

       ca.tva AS tvaDf ,

       fc.tva AS tvaAv,

       fc.tva,

       fc.QTE ,

       fc.PU ,

       cast(0 as number(10,2)) as maj ,

       cast(0 as number(10,2)) as red ,

       fc.DUREE,
       ca.rang,
       ca.datefacturefille 

from AvoirFCFille fc

        left join fcfillecomplet ca on ca.id=fc.IDDETAILFACTURE;
		

CREATE OR REPLACE
VIEW LIAISONENGAGEMENT_RESTE (IDENGAGEMENT,
DESIGNATION,
CODEETABLISSEMENT,
PROJET,
MONTANT,
DISPONIBLE,
DISPOAVANT,
DISPOAPRES,
COMPTE,
ETAT,
IDLC,
DATY,
AVECFACTURE,
TIERS,
NUM,
ANNEE,
OBSERVATION,
MONTANTRESTE,montantliberer) AS
SELECT
	e.ID,
	e.DESIGNATION,
	e.CODEETABLISSEMENT,
	e.PROJET,
	CAST((e.montant-nvl(lib.montant,0)) AS number(30,2)) AS MONTANT,
	e.DISPONIBLE,
	e.DISPOAVANT,
	e.DISPOAPRES,
	e.COMPTE,
	e.ETAT,
	e.IDLC,
	e.DATY,
	e.AVECFACTURE,
	e.TIERS,
	e.NUM, 
	e.ANNEE,
	e.OBSERVATION,
	(nvl(e.MONTANT, 0)-nvl(l.MONTANT, 0)-nvl(lib.montant,0)) AS montantreste ,
	lib.montant AS montantliberer
FROM
	ENGAGEMENT e
LEFT JOIN liaisonengagement_grp l ON
	l.idengagement = e.id
 LEFT JOIN liberer_grpengag lib ON lib.IDENGAGEMENT =e.id;



 
 
 INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN002111', 'Historique Libéré', 'fa fa-line-chart', '/spat/pages/globalnegoce.jsp?but=ligneCredit/historique-Liberer.jsp', 9, 3, 'MEN00211');

CREATE OR REPLACE  VIEW ENGAGEMENTLIB (ID, DESIGNATION, CODEETABLISSEMENT, PROJET, MONTANT, DISPOAVANT, DISPOAPRES, COMPTE, ETAT, CODEETABLISSEMENTLIB, PROJETLIB, IDLC, IDLCLIB, DATY, AVECFACTURE, AVECFACTURELIB, MONTANTOP, DISPONIBLE, TIERS, TIERSLIB, NUM, OBSERVATION, ANNEE, MONTANTRESTE,montantliberer) AS 
  SELECT
	e.ID,
	e.DESIGNATION,
	nvl(e.CODEETABLISSEMENT, lp.CODEETABLISSEMENT) AS CODEETABLISSEMENT,
	nvl(e.PROJET, lp.PROJET) AS PROJET,
	leb.MONTANT,
	--e.DISPONIBLE,
 e.DISPOAVANT,
	e.DISPOAPRES,
	e.COMPTE,
	e.ETAT,
	nvl(ce.VAL, ce1.val) AS codeetablissementlib,
	nvl(p.DESIGNATION, p1.designation) AS projetlib,
	e.IDLC,
	lp.DESIGNATION AS idLClib,
	e.DATY,
	e.AVECFACTURE,
	CASE
		WHEN e.avecFacture = 0 THEN 'NON'
		WHEN e.avecFacture = 1 THEN 'OUI'
	END AS avecFacturelib,
	CAST(nvl(gr.montant, 0) AS NUMBER(30,
	2)) AS montantop,
	CAST(e.MONTANT- nvl(eng.MONTANTTAUX, 0)-nvl(leb.montantliberer, 0) AS NUMBER(30,
	2)) AS disponible ,
	e.tiers ,
	t.NOM AS tierslib ,
	e.num,
	e.observation,
	e.ANNEE ,
	CAST(leb.MONTANTRESTE AS number(30,2)),
	CAST (leb.MONTANTLIBERER AS NUMBER(30,2)) AS montantliberer
FROM
	engagement e
  JOIN LIAISONENGAGEMENT_RESTE leb ON 
	leb.IDENGAGEMENT =e.id
LEFT JOIN CODEETABLISSEMENT ce ON
	ce.ID = e.CODEETABLISSEMENT
LEFT JOIN PROJET p ON
	p.ID = e.PROJET
LEFT JOIN LIGNECREDITDEPENSE lp ON
	e.IDLC = lp.ID
LEFT JOIN CODEETABLISSEMENT ce1 ON
	ce1.ID = lp.CODEETABLISSEMENT
LEFT JOIN PROJET p1 ON
	p1.ID = lp.PROJET
LEFT JOIN engagementOPMontant gr ON
	gr.idengagement = e.ID
LEFT JOIN FACTFOURN_ENGAGEMENT eng ON
	eng.IDENGAGEMENT = e.id
--LEFT JOIN LIBERER_MONTANT lib ON
--	lib.IDENGAGEMENT = e.ID
LEFT JOIN FOURNISSEUR_UNION_PERSONNEL t ON
	t.id = e.tiers 
;



CREATE OR REPLACE
 VIEW ENGAGEMENTLIBV (ID,
DESIGNATION,
CODEETABLISSEMENT,
PROJET,
MONTANT,
DISPOAVANT,
DISPOAPRES,
COMPTE,
ETAT,
CODEETABLISSEMENTLIB,
PROJETLIB,
IDLC,
IDLCLIB,
DATY,
AVECFACTURE,
AVECFACTURELIB,
MONTANTOP,
DISPONIBLE,
TIERS,
TIERSLIB,
NUM,
OBSERVATION,
ANNEE,
MONTANTRESTE,montantliberer) AS
SELECT
	ID,
	DESIGNATION,
	CODEETABLISSEMENT,
	PROJET,
	CAST(MONTANT AS NUMBER(30,2)),
	CAST(DISPOAVANT  AS NUMBER(30,2)),
	CAST(DISPOAPRES  AS NUMBER(30,2)),
	COMPTE,
	ETAT,
	CODEETABLISSEMENTLIB,
	PROJETLIB,
	IDLC,
	IDLCLIB,
	DATY,
	AVECFACTURE,
	AVECFACTURELIB,
	CAST(MONTANTOP  AS NUMBER(30,2)),
	CAST(DISPONIBLE  AS NUMBER(30,2)),
	TIERS,
	TIERSLIB,
	NUM,
	OBSERVATION,
	ANNEE,
	CAST(MONTANTRESTE AS NUMBER(30,2)),
	CAST (MONTANTLIBERER AS NUMBER(30,2)) AS montantliberer
	
FROM
	engagementlib
WHERE
	etat = 11 ;


CREATE OR REPLACE
VIEW ENGAGEMENTLIBC (ID,
DESIGNATION,
CODEETABLISSEMENT,
PROJET,
MONTANT,
DISPOAVANT,
DISPOAPRES,
COMPTE,
ETAT,
CODEETABLISSEMENTLIB,
PROJETLIB,
IDLC,
IDLCLIB,
DATY,
AVECFACTURE,
AVECFACTURELIB,
MONTANTOP,
DISPONIBLE,
TIERS,
TIERSLIB,
NUM,
OBSERVATION,
ANNEE,
MONTANTRESTE,
MONTANTLIBERER) AS
SELECT
	ID,
	DESIGNATION,
	CODEETABLISSEMENT,
	PROJET,
	MONTANT,
	DISPOAVANT,
	DISPOAPRES,
	COMPTE,
	ETAT,
	CODEETABLISSEMENTLIB,
	PROJETLIB,
	IDLC,
	IDLCLIB,
	DATY,
	AVECFACTURE,
	AVECFACTURELIB,
	MONTANTOP,
	DISPONIBLE,
	TIERS,
	TIERSLIB,
	NUM,
	OBSERVATION,
	ANNEE,
	MONTANTRESTE,
	MONTANTLIBERERfrom engagementlib
WHERE
	etat = 1;


  
  
  

       
       
       
       
       