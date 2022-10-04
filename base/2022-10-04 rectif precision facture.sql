---- change LHT precision----
alter table factureclient rename column lht to lht_old;

alter table factureclient add lht NUMBER(10,3);

update factureclient set lht = lht_old;

alter table factureclient drop column lht_old;


----change LM precision----
alter table factureclient rename column lm to lm_old;

alter table factureclient add lm NUMBER(10,3);

update factureclient set lm = lm_old;

alter table factureclient drop column lm_old;


----change TE precision----
alter table factureclient rename column te to te_old;

alter table factureclient add te NUMBER(10,3);

update factureclient set te = te_old;

alter table factureclient drop column te_old;


----change jnt precision----
alter table factureclient rename column jnt to jnt_old;

alter table factureclient add jnt NUMBER(10,3);

update factureclient set jnt = jnt_old;

alter table factureclient drop column jnt_old;


--change lht, lm, te, jnt to number(10,3)
CREATE OR REPLACE VIEW "FACTURECLIENTMSUM" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDPREVISION", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "ESCALE", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "ESTDDPMICTSL", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "MONTANTTTCVRAI", "NAVIRE", "ARMATEURLIB", "EXERCICE", "IDAVOIR", "POURCOMPTE", "POURCOMPTELIB", "ESTANCIENNE", "ARMATEUR", "PAIEMENT", "LHT", "LM", "TE", "JNT", "DATEDEPART", "HEUREDEPART", "DATEARRIVEE", "HEUREARRIVEE", "BATEAU", "PROVENANCE", "DESTINATION", "PAVILLON", "PAVILLONLIB", "BATEAULIB", "VOLUME", "VOLUME100") AS 
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
         CAST(case when fc.lht IS NULL OR fc.lht=0 THEN CAST(nvl(nv.lht,nvc.lht) AS NUMBER(10,3))  else CAST(fc.lht AS NUMBER(10,3)) END AS NUMBER(10,3))  as  lht ,
         CAST(case when fc.lm is null OR fc.lm=0 then CAST(nvl(nv.lm,nvc.lm) AS NUMBER(10,3)) else CAST(fc.lm AS NUMBER(10,3)) end AS NUMBER(10,3))  as  lm ,
         CAST(case when fc.te is null OR fc.te=0 then CAST(nvl(nv.te,nvc.te) AS NUMBER(10,3)) else CAST(fc.te AS NUMBER(10,3)) end AS NUMBER(10,3))  as  te ,
         CAST(case when fc.jnt is null OR fc.jnt=0 then CAST(nvl(nv.jnt,nvc.jnt) AS NUMBER(10,3)) else CAST(fc.jnt AS NUMBER(10,3)) end AS NUMBER(10,3))  as  jnt ,
         nvl(pr.date_depart,fc.datedepart) as datedepart ,
        nvl(pr.heure_depart,fc.heuredepart) as heuredepart ,
        nvl(pr.date_arrivee,fc.datearrivee) as datearrivee ,
        nvl(pr.heure_arrivee,fc.heurearrivee) as heurearrivee ,
        nvl(pr.navire,fc.bateau) as bateau ,
        nvl(pr.provenance,fc.provenance) as provenance ,
        nvl(esca.DESTINATION,fc. destination) as destination ,
        nvl(nv.pavillon,nvc.pavillon) as pavillon,
        nvl(nv.valpavillon,nvc.valpavillon) as pavillonlib,
        nvl(nv.nom,nvc.nom) as bateaulib,
        fc.volume ,
        fc.volume100
FROM FACTURECLIENT fc
         LEFT JOIN CAFCFILLECOMPLET_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         left join MOUVEMENTDEPART_ESC esca on esca.ESCALE=pr.id
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

--change lht, lm, te, jnt to number(10,3)
CREATE OR REPLACE  VIEW FACTURECLIENTMSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB, ESTANCIENNE, ARMATEUR, PAIEMENT, PAIEMENTLIB, LHT, LM, TE, JNT, PAVILLON, PAVILLONLIB, PROVENANCE, PROVENANCELIB, DESTINATION, DESTINATIONLIB, BATEAU, BATEAULIB, DATEDEPART, HEUREDEPART, DATEARRIVEE, HEUREARRIVEE, VOLUME, VOLUME100) AS 
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
       CAST(m.lht AS NUMBER(10,3)),
       CAST(m.lm AS NUMBER(10,3)),
       CAST(m.te AS NUMBER(10,3)),
       CAST(m.jnt AS NUMBER(10,3)),
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

--change lht, lm, te, jnt to number(10,3)
CREATE OR REPLACE VIEW "FACTURE_CLIENT_UNION" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "MONTANTPAYE", "MONTANTRESTE", "TIERSLIB", "CONTACT", "ADRESSE", "IDPREVISION", "ESCALE", "ETATLIB", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "MONTANTTTCVRAI", "ARMATEURLIB", "EXERCICE", "IDAVOIR", "POURCOMPTE", "POURCOMPTELIB", "ARMATEUR", "PAIEMENT", "PAIEMENTLIB", "LHT", "LM", "TE", "JNT", "DATEDEPART", "HEUREDEPART", "DATEARRIVEE", "HEUREARRIVEE", "BATEAU", "BATEAULIB", "PROVENANCE", "PROVENANCELIB", "DESTINATION", "DESTINATIONLIB", "PAVILLON", "PAVILLONLIB") AS 
  SELECT
	ID,
	DATY,
	TIERS,
	DESIGNATION,
	TYPE,
	CAST(TVA AS NUMBER(20,
	3)) AS tva,
	REMARQUE,
	IDUSER,
	DATE_ECHEANCE,
	CAST(ETAT AS NUMBER(10)) AS etat,
	CAST(MONTANT AS NUMBER(32,
	3)),
	CAST(MONTANTTVA AS NUMBER(32,
	3)),
	CAST(MONTANTAVOIR AS NUMBER(32,
	3)),
	CAST(MONTANTTTC AS NUMBER(32,
	3)),
	CAST(MONTANTPAYE AS NUMBER(32,
	3)),
	CAST(MONTANTRESTE AS NUMBER(32,
	3)),
	TIERSLIB,
	CONTACT,
	ADRESSE,
	IDPREVISION,
	ESCALE,
	CASE
		WHEN ETAT = 1 THEN 'CREE(E)'
		WHEN ETAT = 11 THEN 'VISE(E)'
	END AS ETATLIB,
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
	CAST(MONTANTTTCVRAI AS NUMBER(32,
	3)),
	ARMATEURLIB,
	EXERCICE,
	idavoir,
	pourcompte,
	pourcomptelib,
	armateur,
	paiement,
	paiementlib,
	CAST(lht AS NUMBER(10, 3)),
	CAST(lm AS NUMBER(10, 3)),
	CAST(te AS NUMBER(10, 3)),
	CAST(jnt AS NUMBER(10,3)) ,

datedepart ,
heuredepart ,
datearrivee ,
heurearrivee ,
bateau , bateaulib  , provenance , provenancelib  , destination  , destinationlib , pavillon , pavillonlib
FROM
	(
	SELECT
		ID,
		DATY,
		TIERS,
		DESIGNATION,
		TYPE,
		CAST(TVA AS NUMBER(20,
		3)) AS TVA,
		REMARQUE,
		IDUSER,
		DATE_ECHEANCE,
		CAST(ETAT AS NUMBER(10)) AS etat,
		CAST(MONTANT AS NUMBER(32,
		3)) AS MONTANT,
		CAST(MONTANTTVA AS NUMBER(32,
		3)) AS MONTANTTVA,
		CAST(MONTANTAVOIR AS NUMBER(32,
		3)) AS MONTANTAVOIR,
		CAST(MONTANTTTC AS NUMBER(32,
		3)) AS MONTANTTTC,
		CAST(MONTANTPAYE AS NUMBER(32,
		3)) AS MONTANTPAYE,
		CAST(MONTANTRESTE AS NUMBER(32,
		3)) AS MONTANTRESTE,
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
		IDAVOIR,
		pourcompte,
		pourcomptelib,
		armateur,
		paiement,
		paiementlib,
		lht,
		lm,
		te,
		jnt ,
datedepart ,
heuredepart ,
datearrivee ,
heurearrivee ,
bateau , bateaulib  , provenance , provenancelib  , destination  , destinationlib , pavillon , pavillonlib
	FROM
		FACTURECLIENTMSUM_LIB
	WHERE
		DATY >= TO_DATE('2021-10-01', 'YYYY-MM-DD')
		OR ESTANCIENNE = 1);

--change lht, lm, te, jnt to number(10,3)
CREATE OR REPLACE VIEW "FACTURECLIENTVALIDE" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "MONTANTPAYE", "MONTANTRESTE", "TIERSLIB", "CONTACT", "ADRESSE", "IDPREVISION", "ESCALE", "ETATLIB", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "MONTANTTTCVRAI", "ARMATEURLIB", "EXERCICE", "TYPECLIENTLIB", "POURCOMPTE", "POURCOMPTELIB", "CODEFILTRE", "PAIEMENT", "PAIEMENTLIB", "LHT", "LM", "TE", "JNT", "DATEDEPART", "HEUREDEPART", "DATEARRIVEE", "HEUREARRIVEE", "BATEAU", "BATEAULIB", "PROVENANCE", "PROVENANCELIB", "DESTINATION", "DESTINATIONLIB", "PAVILLON", "PAVILLONLIB") AS 
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
       nvl(typelib, '-')                        as typeclientlib,
       pourcompte,
       pourcomptelib,
       fc.code                                  as codeFiltre,
       paiement,
       paiementlib,
       cast(fc.LHT as NUMBER(30,3)) AS LHT,
       cast(fc.LM as NUMBER(30,3)) AS LM,
       cast(fc.TE as NUMBER(30,3)) AS TE,
       cast(fc.JNT as NUMBER(30,3)) AS JNT,
       datedepart,
       heuredepart,
       datearrivee,
       heurearrivee,
       bateau,
       bateaulib,
       provenance,
       provenancelib,
       destination,
       destinationlib,
       pavillon,
       pavillonlib
FROM facture_client_union fc
WHERE id NOT IN (SELECT id FROM ProvisionFactureDefinitive);	



