
 CREATE OR REPLACE VIEW FACTURECLIENTMSUMFD as select * from FACTURECLIENTMSUM where idcategorie = 'CATFCO3';


------------FACTURECLIENTMSUMFD_LIB
CREATE OR REPLACE  VIEW FACTURECLIENTMSUMFD_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB, ESTANCIENNE, ARMATEUR, PAIEMENT, PAIEMENTLIB, LHT, LM, TE, JNT, PAVILLON, PAVILLONLIB, PROVENANCE, PROVENANCELIB, DESTINATION, DESTINATIONLIB, BATEAU, BATEAULIB, DATEDEPART, HEUREDEPART, DATEARRIVEE, HEUREARRIVEE, VOLUME, VOLUME100, NOMCLT, ADRCLT, NMSTTCLT, TELCLT, NIF, RC, DTTP, TP, DTQUIT, QUIT, CDCLT) AS 
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
       CAST(m.MONTANT AS NUMBER(32, 3)) as montant,
       CAST(M.MONTANTTVA AS NUMBER(32, 3)) as MONTANTTVA,
       CAST(M.MONTANTAVOIR AS NUMBER(32, 3)) as montantavoir,
       CAST(M.MONTANTTTC AS NUMBER(32, 3)) as MONTANTTTC,
       -- CAST (LEAST (NVL (pf.montant, 0),(m.montant-m.montantavoir)) AS NUMBER (32, 3)) AS montantpaye,
       CAST((NVL(pf.montant, 0)) AS NUMBER(32, 3)) AS montantpaye ,
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
       CAST(m.MONTANTTTCVRAI AS NUMBER(32, 3)) as MONTANTTTCVRAI,
       m.NAVIRE,
       m.ARMATEURLIB,
       m.EXERCICE,
       IDAVOIR,
       pourcompte,
       pourcomptelib,
       ESTANCIENNE,
       m.armateur,
       d.id as paiement,
       d.val as paiementlib,
       CAST(m.lht AS NUMBER(10,2)) as lht,
       CAST(m.lm AS NUMBER(10,2)) as lm,
       CAST(m.te AS NUMBER(10,2)) as te,
       CAST(m.jnt AS NUMBER(10,2)) as jnt,
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
        m.volume100,
        m. nomclt,
		m. adrclt,
		m. nmsttclt,
		m. telclt,
		m.nif,
		m. rc,
		m.dttp,
		m.tp,
		m.dtquit,
		m.quit,
        fup.cdclt
FROM FACTURECLIENTMSUMFD m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id
         LEFT JOIN devise d ON d.id = m.paiement
         left join postedestinatairelibcomplet p1 on p1.id=m.provenance
         left join postedestinatairelibcomplet p2 on p2.id=m.destination;
         
        
     -- FACTURE_CLIENT_UNIONfd

CREATE OR REPLACE  VIEW FACTURE_CLIENT_UNIONfd (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, IDAVOIR, POURCOMPTE, POURCOMPTELIB, ARMATEUR, PAIEMENT, PAIEMENTLIB, LHT, LM, TE, JNT, DATEDEPART, HEUREDEPART, DATEARRIVEE, HEUREARRIVEE, BATEAU, BATEAULIB, PROVENANCE, PROVENANCELIB, DESTINATION, DESTINATIONLIB, PAVILLON, PAVILLONLIB, NOMCLT, ADRCLT, NMSTTCLT, TELCLT, NIF, RC, DTTP, TP, DTQUIT, QUIT, CDCLT) AS 
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
 nomclt,adrclt,nmsttclt,telclt,nif,rc,dttp,tp,dtquit,quit, cdclt
FROM
    (
    SELECT
        ID,
        DATY,
        TIERS,
        DESIGNATION,
        TYPE,
        CAST(TVA AS NUMBER(20,3)) AS TVA,
        REMARQUE,
        IDUSER,
        DATE_ECHEANCE,
        CAST(ETAT AS NUMBER(10)) AS etat,
        CAST(MONTANT AS NUMBER(32,3)) AS MONTANT,
        CAST(MONTANTTVA AS NUMBER(32,3)) AS MONTANTTVA,
        CAST(MONTANTAVOIR AS NUMBER(32,3)) AS MONTANTAVOIR,
		CASE 
        	WHEN abs(montantreste)<50 AND montantreste!=0 THEN CAST(MONTANTPAYE AS NUMBER(32,3))
        	ELSE CAST(MONTANTTTC AS NUMBER(32,3)) 
		END AS MONTANTTTC,		
        CAST(MONTANTPAYE AS NUMBER(32,3)) AS MONTANTPAYE,
		CASE 
        	WHEN abs(montantreste)<50 AND montantreste!=0 THEN CAST(MONTANTPAYE-MONTANTPAYE AS NUMBER(32,3)) --here
        	ELSE CAST(montantreste AS NUMBER(32,3)) 
    	END AS montantreste,
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
        CAST (lht AS NUMBER(10,2)) AS lht,
        CAST (lm AS NUMBER(10,2)) AS lm,
        CAST (te AS NUMBER(10,2)) AS te,
        CAST (jnt AS NUMBER(10,2)) AS jnt , datedepart , heuredepart ,
datearrivee ,
heurearrivee ,
bateau , bateaulib  , provenance , provenancelib  , destination  , destinationlib , pavillon , pavillonlib,
 nomclt,adrclt,nmsttclt,telclt,nif,rc,dttp,tp,dtquit,quit, cdclt
    FROM
        FACTURECLIENTMSUMfd_LIB
    WHERE
        DATY >= TO_DATE('2021-10-01', 'YYYY-MM-DD')
        OR ESTANCIENNE = 1);
        
       
       -- SPAT0112.FACTURE_CLIENT_UNIONVfd

CREATE OR REPLACE  VIEW FACTURE_CLIENT_UNIONVFD (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, CODEFILTRE, IDAVOIR, POURCOMPTE, POURCOMPTELIB, ARMATEUR, PAIEMENT, PAIEMENTLIB, LHT, LM, TE, JNT, DATEDEPART, HEUREDEPART, DATEARRIVEE, HEUREARRIVEE, BATEAU, BATEAULIB, PROVENANCE, PROVENANCELIB, DESTINATION, DESTINATIONLIB, PAVILLON, PAVILLONLIB, NOMCLT, ADRCLT, NMSTTCLT, TELCLT, NIF, RC, DTTP, TP, DTQUIT, QUIT, CDCLT) AS 
  select fc.ID,fc.DATY,fc.TIERS,fc.DESIGNATION,TYPE,fc.TVA,fc.REMARQUE,fc.IDUSER,fc.DATE_ECHEANCE,fc.ETAT,
  CAST(fc.MONTANT AS NUMBER(35,3)) AS MONTANT,
  CAST(fc.MONTANTTVA AS NUMBER(35,3)) AS MONTANTTVA,
  CAST(fc.MONTANTAVOIR AS NUMBER(35,3)) AS MONTANTAVOIR,
  CAST(fc.MONTANTTTC AS NUMBER(35,3)) AS MONTANTTTC,
  CAST(fc.MONTANTPAYE AS NUMBER(35,3)) AS MONTANTPAYE,
  CAST(fc.MONTANTRESTE AS NUMBER(35,3)) AS MONTANTRESTE,
  TIERSLIB,CONTACT,ADRESSE,IDPREVISION,ESCALE,ETATLIB,TYPELIB,IDCATEGORIE,CATEGORIELIB,IDPROVISION,IDPROVISIONLIB,DEVISEMERE,CODEPRESTATION,CODEPRESTATIONLIB,fc.CODE,ESTMICTSL,CODEPROVISION,
  CAST(fc.MONTANTTTCVRAI AS NUMBER(35,3)) AS MONTANTTTCVRAI,
  fc.ARMATEURLIB,
  fc.EXERCICE ,
  fc.code as codeFiltre,
  fc.IDAVOIR,
  fc.POURCOMPTE,
  fc.POURCOMPTELIB,
  fc.ARMATEUR,
  fc.PAIEMENT,
  fc.PAIEMENTLIB,
  fc.LHT,
  fc.LM ,
  fc.TE,
  fc.JNT,
  fc.DATEDEPART,
  fc.HEUREDEPART,
  fc.DATEARRIVEE,
  fc.HEUREARRIVEE,
  fc.BATEAU,
  fc.BATEAULIB,
  fc.PROVENANCE,
  fc.PROVENANCELIB,
  fc.DESTINATION,
  fc.DESTINATIONLIB,
  fc.PAVILLON,
  fc.PAVILLONLIB,
  fc.NOMCLT,
  fc.ADRCLT,
  fc.NMSTTCLT,
  fc.TELCLT,
  fc.NIF,
  fc.rc,
  fc.DTTP,
  fc.tp,
  fc.DTQUIT,
  fc.QUIT,
   fc.cdclt
from facture_client_unionfd fc

where fc.etat >= 11 

 ;
 

----------REDEVANCECOMMUNALEFACTUREMD
CREATE OR REPLACE  VIEW REDEVANCECOMMUNALEFACTUREMD (ID, CODE, TYPELIB, DATY, TIERSLIB, MONTANTHT, TVA, MONTANTTTC) AS 
  select e.id,
       e.code,
       e.typelib,
       e.daty,
       e.tierslib,
       cast(a.MONTANTTAUX as NUMBER(30,3)) as montantHT,--(avy amin'ny d‚tails where rubrique=redevance communale)
       a.tva,-- (valeur tva ho an'ilay ligne)
       cast(a.MONTANTTAUX + MONTANTTAXE as NUMBER(30,3)) as montantTTC-- (an'ilay d‚tails foana)
from FACTURE_CLIENT_UNIONVfd e
        left join FACT_CLT_FILL_LIB_REST_TAXE  a on a.IDMERE=e.id
where COMPTE='46731' AND (e.code  NOT LIKE '3%'  and e.code  NOT LIKE '5%')
; 
 