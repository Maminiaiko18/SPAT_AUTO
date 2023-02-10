---------------------------- 10-02-2023
--------- Tiavina

create or replace view MvtIntraCaisseTraite as 
select 
mit.*,
t.daty as datetraite,
t.dateecheance,
t.montant as montanttraite
from MvtIntraCaisse mit 
left join Traite t on t.id = mit.idtraite;

---------------------
------sedra
CREATE OR REPLACE  VIEW FACTURE_CLIENT_UNION2 (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB, ARMATEUR, PAIEMENT, PAIEMENTLIB, LHT, LM, TE, JNT, DATEDEPART, HEUREDEPART, DATEARRIVEE, HEUREARRIVEE, BATEAU, BATEAULIB, PROVENANCE, PROVENANCELIB, DESTINATION, DESTINATIONLIB, PAVILLON, PAVILLONLIB, NOMCLT, ADRCLT, NMSTTCLT, TELCLT, NIF, RC, DTTP, TP, DTQUIT, QUIT, CDCLT, NUMPIECE,numfact) AS 
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
    CAST(lht AS NUMBER(10, 2)),
    CAST(lm AS NUMBER(10, 2)),
    CAST(te AS NUMBER(10, 2)),
    CAST(jnt AS NUMBER(10,2)) ,
	datedepart ,
	heuredepart ,
	datearrivee ,
	heurearrivee ,
	bateau , bateaulib  , provenance , provenancelib  , destination  , destinationlib , pavillon , pavillonlib,
 nomclt,adrclt,nmsttclt,telclt,nif,rc,dttp,tp,dtquit,quit, cdclt,NUMPIECE,numfact
 
FROM
    (
    SELECT
        fc.ID,
        fc.DATY,
        fc.TIERS,
        fc.DESIGNATION,
        fc.TYPE,
        CAST(fc.TVA AS NUMBER(20,3)) AS TVA,
        fc.REMARQUE,
        fc.IDUSER,
        fc.DATE_ECHEANCE,
        CAST(fc.ETAT AS NUMBER(10)) AS etat,
        CAST(fc.MONTANT AS NUMBER(32,3)) AS MONTANT,
        CAST(fc.MONTANTTVA AS NUMBER(32,3)) AS MONTANTTVA,
        CAST(fc.MONTANTAVOIR AS NUMBER(32,3)) AS MONTANTAVOIR,
		CASE 
        	WHEN abs(fc.montantreste)<50 AND fc.montantreste!=0 THEN CAST(fc.MONTANTPAYE AS NUMBER(32,3))
        	ELSE CAST(fc.MONTANTTTC AS NUMBER(32,3)) 
		END AS MONTANTTTC,		
        CAST(fc.MONTANTPAYE AS NUMBER(32,3)) AS MONTANTPAYE,
		CASE 
        	WHEN abs(fc.montantreste)<50 AND fc.montantreste!=0 THEN CAST(fc.MONTANTPAYE-MONTANTPAYE AS NUMBER(32,3)) 
        	ELSE CAST(fc.montantreste AS NUMBER(32,3)) 
    	END AS montantreste,
        fc.TIERSLIB,
        fc.CONTACT,
        fc.ADRESSE,
        fc.IDPREVISION,
        fc.ESCALE,
        fc.TYPELIB,
        fc.IDCATEGORIE,
        fc.CATEGORIELIB,
        fc.IDPROVISION,
        fc.IDPROVISIONLIB,
        fc.DEVISEMERE,
        fc.codePrestation,
        fc.codePrestationlib,
        fc.code,
        fc.ESTMICTSL,
        fc.CODEPROVISION,
        fc.MONTANTTTCVRAI,
        fc.ARMATEURLIB,
        fc.EXERCICE,
        fc.IDAVOIR,
        fc.pourcompte,
        fc.pourcomptelib,
        fc.armateur,
        fc.paiement,
        fc.paiementlib,
        CAST (fc.lht AS NUMBER(10,2)) AS lht,
        CAST (fc.lm AS NUMBER(10,2)) AS lm,
        CAST (fc.te AS NUMBER(10,2)) AS te,
        CAST (fc.jnt AS NUMBER(10,2)) AS jnt , 
		fc.datedepart , 
		fc.heuredepart ,
		fc.datearrivee ,
		fc.heurearrivee ,
		fc.bateau , 
		fc.bateaulib  , 
		fc.provenance , 
		fc.provenancelib  , 
		fc.destination  , 
		fc.destinationlib , 
		fc.pavillon , 
		fc.pavillonlib,
		fc.nomclt,
		fc.adrclt,
		fc.nmsttclt,
		fc.telclt,
		fc.nif,
		fc.rc,
		fc.dttp,
		fc.tp,
		fc.dtquit,
		fc.quit, 
		fc.cdclt,
		fcnp.numpiece,
		fcnp.numpiece AS numfact
    FROM
        FACTURECLIENTMSUM_LIB fc
		LEFT JOIN facture_client_np fcnp ON fcnp.id= fc.id
    WHERE
        DATY >= TO_DATE('2021-10-01', 'YYYY-MM-DD')
        OR ESTANCIENNE = 1
);


CREATE OR REPLACE  VIEW PMENTFACTHORSPROVAVPROVCPLT (ID, IDMVT, IDFACT, MONTANT, IDPROVISION, DATY, TIERS, TIERSLIB, DESIGNATION, TYPE, REMARQUE, DATE_ECHEANCE, ETATLIB, ETAT, CONTACT, ADRESSE, DEVISEMERE, MONTANTTVA, MONTANTAVOIR, MONTANTPAYE, MONTANTRESTE, CATEGORIELIB) AS 
  SELECT prov.ID,prov.IDMVT,prov.IDFACT,prov.MONTANT,prov.IDPROVISION, 
fcu.daty,
 fcu.TIERS,
 fcu.TIERSLIB,
 fcu.DESIGNATION , 
 fcu.TYPE, 
 fcu.REMARQUE,
 fcu.DATE_ECHEANCE,
fcu.ETATLIB,
 fcu.ETAT, 
 fcu.CONTACT,
 fcu.ADRESSE, 
 fcu.DEVISEMERE,
 cast(fcu.MONTANTTVA as number(25,2)) as MONTANTTVA, 
 cast(fcu.MONTANTAVOIR as number(25,2)) as MONTANTAVOIR, 
 cast(fcu.MONTANTPAYE as number(25,2)) AS MONTANTPAYE ,
cast(fcu.MONTANTRESTE as number(25,2)) AS MONTANTRESTE, 
fcu.CATEGORIELIB,
fcu.numfact
FROM PAIEMENTFACTHORSPROVAVECPROV prov LEFT join FACTURE_CLIENT_UNION2 fcu on prov.idfact = fcu.ID;

