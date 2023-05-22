
-------efa en prod
CREATE OR REPLACE VIEW seq_journal_dep_entree AS 
	SELECT 
	DATEEFFET,
	CAST(extract(MONTH from dateeffet) AS int) AS mois,
	CAST(extract(YEAR from dateeffet)AS int) AS annee,
	NUMPIECE,
	CAST(substr(NUMPIECE, length(NUMPIECE) - 6, 7) AS int) as maxidparmoisane
	FROM JOURNALCAISSE j 
		WHERE CREDIT > 0 
		AND CAISSE ='CAI0000000015200311' 
		AND NUMPIECE LIKE '%CD%';

		CREATE TABLE OPFACTURE 
   (	
      ID VARCHAR2(250), 
      IDOP VARCHAR2(250), 
      IDFACTURE VARCHAR2(250)
   );
   
   CREATE TABLE GESTIONPROVISION (
	ID VARCHAR(250) PRIMARY KEY,
	DATY DATE,
	IDPROVISION VARCHAR(250),
	IDENTIFICATION VARCHAR(10),
	FOREIGN KEY (IDPROVISION) REFERENCES factureclient(id)
);

CREATE OR REPLACE VIEW numero_gestion_prov
AS SELECT
    DATY, 
    IDENTIFICATION AS numpiece,
    CAST(extract(MONTH from DATY) AS int) AS mois, 
    CAST(extract(YEAR from DATY)AS int) AS annee,
    CAST(substr(IDENTIFICATION, length(IDENTIFICATION) - 2, 3) AS int) as maxidparmoisane
FROM GESTIONPROVISION WHERE IDENTIFICATION IS NOT NULL ;

CREATE SEQUENCE seq_gestionprov START WITH 1;


CREATE OR REPLACE FUNCTION getseqgestionprov
	  RETURN NUMBER IS
	  retour NUMBER;
	BEGIN
	  SELECT seq_gestionprov.nextval INTO retour FROM dual;
	  return retour;
	END;

	
   
  
  CREATE OR REPLACE VIEW FACTURECLIENTVALIDEImp (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, TYPECLIENTLIB, POURCOMPTE, POURCOMPTELIB, CODEFILTRE, PAIEMENT, PAIEMENTLIB, LHT, LM, TE, JNT, DATEDEPART, HEUREDEPART, DATEARRIVEE, HEUREARRIVEE, BATEAU, BATEAULIB, PROVENANCE, PROVENANCELIB, DESTINATION, DESTINATIONLIB, PAVILLON, PAVILLONLIB, NOMCLT, ADRCLT, NMSTTCLT, TELCLT, NIF, RC, DTTP, TP, DTQUIT, QUIT, CDCLT, MONTANTAPRED, MONTANTHTSIMPLE, MONTANTSANSREDUCTION) AS 
  SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       cast(fc.TVA as number(30, 2))                                   as TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(fc.MONTANT as NUMBER(30, 2))                               as MONTANT,
       cast(fc.MONTANTTVA as NUMBER(30, 2))                            as MONTANTTVA,
       cast(fc.MONTANTAVOIR as NUMBER(30, 2))                          as MONTANTAVOIR,
       cast(fc.MONTANTTTC as NUMBER(30, 2))                            as MONTANTTTC,
       cast(fc.MONTANTPAYE as NUMBER(30, 2))                           as MONTANTPAYE,
       cast(fc.MONTANTRESTE as NUMBER(30, 2))                          as MONTANTRESTE,
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
       CAST(fc.MONTANTTTCVRAI AS NUMBER(35, 2))                        AS MONTANTTTCVRAI,
       fc.ARMATEURLIB,
       EXERCICE,
       nvl(fc.typelib, '-')                                            as typeclientlib,
       fc.pourcompte,
       fc.pourcomptelib,
       fc.code                                                         as codeFiltre,
       fc.paiement,
       fc.paiementlib,
       cast(fc.LHT as NUMBER(30, 2))                                   AS LHT,
       cast(fc.LM as NUMBER(30, 2))                                    AS LM,
       cast(fc.TE as NUMBER(30, 3))                                    AS TE,
       cast(fc.JNT as NUMBER(30, 2))                                   AS JNT,
       fc.datedepart,
       fc.heuredepart,
       fc.datearrivee,
       fc.heurearrivee,
       fc.bateau,
       fc.bateaulib,
       fc.provenance,
       fc.provenancelib,
       fc.destination,
       fc.destinationlib,
       fc.pavillon,
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
       cast(cg.MONTANTREDUCTION as NUMBER(30, 2))                      AS montantapRed,
       cast(cg.MONTANTHTSIMPLE as NUMBER(30, 2)),
       cast(nvl(cg.MONTANT + cg.MONTANTREDUCTION, 0) as NUMBER(30, 2)) as montantsansreduction
FROM facture_client_union fc
         LEFT JOIN CAFCFILLECOMPLET_GRP cg ON fc.ID = cg.IDMERE;
		 
		 
	

CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIB_FICHE (ID, DATY,DATEFACTURE, DESIGNATION, TIERSLIB, CONTACT, ADRESSE, TYPELIB, CATEGORIELIB, DATE_ECHEANCE, CODE_ETABLISSEMENTLIB, PROJETLIB, EXERCICE, CODE, NUMEROOP, IDBL, IDBC, IDENGAGEMENT, IDENGAGEMENTLIB, MONTANTHTSANSREMISE, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, DATEREGUL, IDPROVISION, IDCATEGORIE, IDPROVISIONLIB, ETAT, NUM, DEVISEMERE) AS 
  select
id,
daty,
datefacture,
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
numeroop ,
idbl,
idbc,
idengagement,
idengagementlib,
CAST(montanthtsansremise AS NUMBER(32,2)),
CAST(montant AS NUMBER(32,2)),
CAST(montanttva AS NUMBER(32,2)),
CAST(montantavoir AS NUMBER(32,2)),
CAST(montantttc AS NUMBER(32,2)),
CAST(montantpaye AS NUMBER(32,2)),
CAST(montantreste AS NUMBER(32,2)),
dateregul,
idprovision ,
Idcategorie ,
idProvisionlib ,
etat,
num, 
DEVISEMERE 
from factfourn_msum_lib
;

CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIB_FICHEB 
as
  SELECT
	f.ID,
	f.DATY,
	f.DATEFACTURE,
	f.DESIGNATION,
	f.TIERSLIB,
	f.CONTACT,
	f.ADRESSE,
	f.TYPELIB,
	f.CATEGORIELIB,
	f.DATE_ECHEANCE,
	f.CODE_ETABLISSEMENTLIB,
	f.PROJETLIB,
	f.EXERCICE,
	f.CODE,
	f.NUMEROOP,
	f.IDBL,
	f.IDBC,
	f.IDENGAGEMENT,
	f.IDENGAGEMENTLIB,
	f.MONTANTHTSANSREMISE,
	f.MONTANT,
	f.MONTANTTVA,
	f.MONTANTAVOIR,
	f.MONTANTTTC,
	f.MONTANTPAYE,
	f.MONTANTRESTE,
	f.DATEREGUL,
	f.IDPROVISION,
	f.IDCATEGORIE,
	f.IDPROVISIONLIB,
	f.ETAT,
	f.NUM,
	f.DEVISEMERE,
	b.id AS idbordereau,
	b.NUMERO AS numBordereau
FROM
	factfourn_msum_lib_fiche f
LEFT JOIN LIAISONBORDEREAUFF l ON
	f.id = l.IDOP
LEFT JOIN bordereauFF b ON
	l.IDBORDEREAU = b.id;

	
CREATE OR REPLACE FORCE VIEW FACTFOURN_MSUM_LIB_MODIF_ORDRE (ID, DATY,DATEFACTURE, DATEREGUL, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB, NUMEROOP, PROJET, PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, MONTANTHTSANSREMISE) AS 
  SELECT m.ID,
       m.DATY,
       m.DATEFACTURE ,
	   m.DATEREGUL,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       '--' || m.remarque AS remarque,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.idprevision,
       CAST(m.MONTANT AS NUMBER(32, 2)) as MONTANT ,
       CAST(M.MONTANTTVA AS NUMBER(32, 2)) as MONTANTTVA,
       CAST(M.MONTANTAVOIR AS NUMBER(32, 2))as MONTANTAVOIR,
       CAST(M.MONTANTTTC AS NUMBER(32, 2))as MONTANTTTC,
       CAST(NVL(pf.montant, 0) AS NUMBER(32, 2)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(pf.montant, 0) AS NUMBER(32, 2)) AS montantreste,
       fup.NOM  AS tierslib,
       fup.CONTACT,
       fup.ADRESSE,
       M.ESCALE,
       TYPELIB,
       m.IDCATEGORIE,
       m.CATEGORIELIB,
       m.IDPROVISION,
       m.IDPROVISIONLIB,
       m.ESTDDPMICTSL,
       m.devisemere,
       m.codePrestation,
       m.codePrestationlib,
       m.CODE,
       m.ESTMICTSL,
       codeprovision,
       case
           when m.etat = 1 then 'CREE'
           when m.etat >= 11 then 'VISE'
           else '' end                           as etatlib,
       cast(MONTANTTTCVRAI as number(32,2)) as MONTANTTTCVRAI,
       m.IDBL,
       m.CODE_ETABLISSEMENT,
       m.CODE_ETABLISSEMENTLIB,
       m.NUMEROOP,
       m.PROJET,
       m.PROJETLIB,
       m.NUMFACT,
       m.NATURE,
       m.naturelib,
       m.IDBC,
       m.exercice,
       IDENGAGEMENT,
       idengagementlib ,
       cast(m.MONTANTHTSANSREMISE AS NUMBER(30,2)) AS MONTANTHTSANSREMISE
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id
		 
	;	
	
	
	CREATE OR REPLACE VIEW JOURNAL_AVOIR AS
SELECT *FROM etatjournalcaisselibrecette jv WHERE CAISSE ='CAI0000000017083858' AND credit > 0;

-- SPAT_DEV.BPVALIDE_C source

CREATE OR REPLACE  VIEW BPVALIDE_C (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, NUM) AS 
  SELECT
	ID,
	DATY,
	TIERS,
	DESIGNATION,
	TYPE,
	TVA,
	REMARQUE,
	IDUSER,
	DATE_ECHEANCE,
	ETAT,
	IDPREVISION,
	CAST(MONTANT AS NUMBER(32, 2)) as MONTANT ,
	CAST(MONTANTTVA AS NUMBER(32, 2)) as MONTANTTVA ,
	CAST(MONTANTAVOIR AS NUMBER(32, 2)) as MONTANTAVOIR ,
	CAST(MONTANTTTC AS NUMBER(32, 2)) as MONTANTTTC ,
	CAST(MONTANTPAYE AS NUMBER(32, 2)) as MONTANTPAYE ,
	CAST(MONTANTRESTE AS NUMBER(32, 2)) as MONTANTRESTE ,
	TIERSLIB,
	CONTACT,
	ADRESSE,
	ESCALE,
	TYPELIB,
	IDCATEGORIE,
	CATEGORIELIB,
	IDPROVISION,
	IDPROVISIONLIB,
	ESTDDPMICTSL,
	DEVISEMERE,
	CODEPRESTATION,
	CODEPRESTATIONLIB,
	CODE,
	ESTMICTSL,
	CODEPROVISION,
	ETATLIB,
	NUM
FROM
	BPvalide
WHERE
	etat = 1
;



INSERT INTO BANQUE
(ID, VAL, DESCE)
VALUES('BQU00007', 'BAOBAB', 'BAOBAB');





		 
	
	
	