CREATE OR REPLACE VIEW BPAIEMENT (ID, NUMFACT, IDFF, MONTANT, TIERSLIB, DATY, OBSERVATION, NUMCHEQUE) AS 
  SELECT
	jt.id,
	f.numeroop AS numfact,
	p.IDFACT AS IDFF,
	p.MONTANT ,
	jt.TIERSLIB||' - '|| ti.ADRESSE  AS tierslib,
	jt.DATEEFFET AS daty,
	jt.LIBELLE AS OBSERVATION  ,
	jt.IDBANQUELIB ||' '||jt.NUMCHEQUE|| ' le '|| jt.DATESAISIE AS NUMCHEQUE 
FROM 
	JOURNALCAISSELIBCOMPLET jt
LEFT JOIN PAIEMENTFACTUREF p ON
	jt.id = p.IDMVT
LEFT JOIN factfourn_msum_lib_fiche f ON
	p.IDFACT = f.id
LEFT JOIN FOURNISSEUR_UNION_PERSONNEL ti
ON jt.TIERS = ti.id	;


CREATE OR REPLACE VIEW caisserecette AS 
SELECT *FROM caisse WHERE id='CAIS000015' OR id='CAIS000014' ;

CREATE OR REPLACE VIEW JOURNALCAISSELIBCOMPLET (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, TIERS, IDTYPECHEQUE, DESIGNATION, IDDEVISE, IDMODE, NUMCHEQUE, TYPEMVT, IDORDRE, IDPLACEMENT, IDCAISSE, VALCAISSE, DESCECAISSE, VALTYPECHEQUE, DESCETYPECHEQUE, TIERSLIB, CODETIERS, IDBANQUE, IDBANQUELIB, NUMEROOP, TYPE, TYPELIB, IDTRAITE,ETATVERSEMENT, CODE) AS 
  SELECT j.ID,
       j.DATESAISIE,
       j.DATEEFFET,
       j.FOLIO,
       j.CAISSE,
       j.NUMPIECE,
       j.LIBELLE,
       cast(j.DEBIT as number(30,2)),
       cast(j.CREDIT as number(30,2)),
       j.REMARQUE,
       j.ETAT,
       j.TIERS,
       j.IDTYPECHEQUE,
       j.DESIGNATION,
       j.IDDEVISE,
       j.IDMODE,
       j.NUMCHEQUE,
       j.TYPEMVT,
       j.IDORDRE,
       j.IDPLACEMENT,
       c.ID    AS idcaisse,
       c.val   AS valcaisse,
       c.desce AS descecaisse,
       tc.val  AS valtypecheque,
       m.val   AS descetypecheque,
       ti.NOM  AS tierslib,
       ti.CDCLT AS codetiers,
       j.IDBANQUE,
       b.val as idbanquelib,
        op.NUMEROOP,
        fc.idcategorie AS TYPE,
       categ.VAL AS typelib,
	    j.IDTRAITE,
	    j.ETATVERSEMENT,
	    fc.code
FROM Journalcaisse j
         JOIN CAISSE C
              ON j.CAISSE = C.ID
         LEFT JOIN TYPECHEQUE tc ON tc.id = j.idtypecheque
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL ti ON ti.id = j.TIERS
         LEFT JOIN MODEPAIEMENT m on j.idmode = m.id
         LEFT JOIN BANQUE b on j.idbanque = b.ID
         left join ORDONNERPAYEMENT op on op.id=j.IDORDRE
         left join factureclient fc on fc.id=j.idplacement
         LEFT JOIN CATEGORIEFC categ ON categ.ID = fc.idcategorie;
		 
		 
		 CREATE OR REPLACE VIEW SEQ_JOURNAL_RECU_TRAITE (DATEEFFET, NUMPIECE, MOIS, ANNEE, MAXIDPARMOISANE) AS 
  SELECT 
    dateeffet, 
    numpiece,
    CAST(extract(MONTH from dateeffet) AS int) AS mois, 
    CAST(extract(YEAR from dateeffet)AS int) AS annee, 
 	CAST(substr(NUMPIECE, 4 , 5) AS int) as maxidparmoisane
FROM journalcaisse WHERE etat>=11 AND ETATVERSEMENT = -2 AND CREDIT > 0 ;


-- FACTFOURN_MSUM_LIB_FICHE source

CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIB_FICHE (ID, DATY, DESIGNATION, TIERSLIB, CONTACT, ADRESSE, TYPELIB, CATEGORIELIB, DATE_ECHEANCE, CODE_ETABLISSEMENTLIB, PROJETLIB, EXERCICE, CODE, NUMEROOP, IDBL, IDBC,IDENGAGEMENT, IDENGAGEMENTLIB, MONTANTHTSANSREMISE, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, DATEREGUL, IDPROVISION, IDCATEGORIE, IDPROVISIONLIB, ETAT, NUM, DEVISEMERE) AS 
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

CREATE OR REPLACE VIEW factfourn_msum_lib_ficheB
as
SELECT f.*,b.id AS idbordereau,b.NUMERO AS numBordereau FROM factfourn_msum_lib_fiche f
	LEFT JOIN LIAISONBORDEREAUFF l ON f.id = l.IDOP 
	LEFT JOIN bordereauFF b ON l.IDBORDEREAU = b.id;
	
	
	
	
ALTER TABLE LIBERER 
ADD (remarque VARCHAR2(250));

CREATE OR REPLACE VIEW LIBERERLIB (ID, IDENGAGEMENT, MONTANT, ETAT,REMARQUE, IDENGAGEMENTLIB) AS 
  select l.ID,l.IDENGAGEMENT,l.MONTANT,l.ETAT,l.remarque,
       en.DESIGNATION as idengagementlib
from liberer l
    left join engagement en on l.IDENGAGEMENT = en.ID;
	

	
	



CREATE OR REPLACE VIEW RECUTRAITE 
AS SELECT *FROM JOURNALCAISSELIBCOMPLET WHERE IDTRAITE is not NULL AND ETATVERSEMENT = -2 AND  CREDIT > 0;






INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN000692', 'Reçu', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=facture/traite-recu-liste.jsp', 5, 4, 'MDO0000056');