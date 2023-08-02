-----Flavien
CREATE OR REPLACE  VIEW CAFCFILLECOMPLET_DEVISE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, CODE, MONTANTHTDEVISE) AS 
  SELECT
	c.ID,c.IDMERE,c.DESIGNATION,c.QUANTITE,c.PU,c.COMPTE,c.IDPRODUIT,c.DEVISE,c.TAUX,c.IDACTIVITE,c.TVA,c.DATEFACT,c.RUBRIQUE,c.MOIS,c.ANNEE,c.HEUREDEBUT,c.HEUREFIN,c.REDUCTION,c.MAJORATION,c.TEST,c.RANG,c.DUREE,c.MONTANTAV,c.RUBRIQUECPL,c.DATY,c.TIERS,c.IDCATEGORIE,c.TYPE,c.DEVISEMERE,c.EXERCICE,c.IDAVOIR,c.ETAT,c.MTAVOIR,c.MONTANTREDUCTION,c.MONTANTMAJORATION,c.MONTANT,c.MONTANTTVA,c.MONTANTTTC,c.MOISLIB,c.MONTANTHTSIMPLE,c.CLIENT,c.CODE,
	cast(nvl(c.MONTANT /d.MONTANT, 0) as number(30,2)) AS montanthtdevise
FROM
	CAFCFILLECOMPLET c
	LEFT JOIN COURSDEVISE d ON (d.DATY = c.DATY AND d.IDDEVISE = 'Eur' AND ESTMICTSL = 0) ;
	
	CREATE OR REPLACE  VIEW ORDONNERPAYEMENT_LIB (ID, DED_ID, IDLIGNE, DESTINATION, DATY, MONTANT, REMARQUE, ETAT, NUMEROOP, MODEPAIEMENT,MODEPAIEMENTLIB, TIERS, ADRESSE, NUMFACT, DESTINATIONLIB, BENEFICIAIRE, DEVISE, DEVISELIB) AS 
  select op.ID,
       op.DED_ID,
       op.IDLIGNE,
       op.DESTINATION,
       op.DATY,
       op.MONTANT,
       op.REMARQUE,
       op.ETAT,
       op.NUMEROOP,
       mp.VAL  as MODEPAIEMENT,
       mp.id AS MODEPAIEMENTLIB,
       fup.NOM as TIERS,
       fup.ADRESSE,
       op1.numfact,
       de.val as destinationlib,
       op.tiers as beneficiaire,
       f.DEVISEMERE,
       d.desce AS deviselib
from ORDONNERPAYEMENT op
         left join MODEPAIEMENT mp on mp.id = op.MODEPAIEMENT
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id = op.TIERS
         left join concat_numfact_ff op1 on op.id=op1.id2
         left join DESTINATION de on de.id = op.DESTINATION
         left join FACTURE_FOURNISSEUR_MERE f on f.id =  nvl(SUBSTR(op.DED_ID, 0, INSTR(op.DED_ID, ';') - 1) ,op.DED_ID)
		 LEFT JOIN devise d ON d.id =f.DEVISEMERE;

CREATE OR REPLACE  VIEW ORDONNERPAYEMENT_LIB_DEVISE (ID, DED_ID, IDLIGNE, DESTINATION, DATY, MONTANT, REMARQUE, ETAT, NUMEROOP, MODEPAIEMENT,MODEPAIEMENTLIB, TIERS, ADRESSE, NUMFACT, DESTINATIONLIB, BENEFICIAIRE, DEVISE, DEVISELIB, MONTANTDEVISE) AS 
  SELECT
	o.ID,o.DED_ID,o.IDLIGNE,o.DESTINATION,o.DATY,o.MONTANT,o.REMARQUE,o.ETAT,o.NUMEROOP,o.MODEPAIEMENT,o.MODEPAIEMENTLIB,o.TIERS,o.ADRESSE,o.NUMFACT,o.DESTINATIONLIB,o.BENEFICIAIRE,o.DEVISE,o.DEVISELIB,
	CAST (nvl(o.MONTANT /c.MONTANT , 0) AS NUMBER(30,2) ) AS MONTANTDEVISE
FROM
	OrdonnerPayement_LIB o 
	LEFT JOIN FACTURE_FOURNISSEUR_MERE f ON f.id = REGEXP_SUBSTR(o.DED_ID , '[^; ]+', 1, 1)
	LEFT JOIN COURSDEVISE c ON (c.DATY = f.DATEDEVISE AND c.IDDEVISE = o.DEVISE);
	
	
	ALTER TABLE FCDEFPR RENAME COLUMN DATY TO DATELIAISON;

CREATE OR REPLACE  VIEW FCDEFPRLIB (ID, ID1, ID2, ETAT, MONTANT, DATELIAISON,CODEPROV) AS 
  SELECT
	f.ID,f.ID1,f.ID2,f.ETAT,f.MONTANT,f.DATELIAISON, 
	fc.code AS codeprov
FROM
	FCDEFPR f
JOIN FACTURECLIENT fc 
ON
	f.ID2 = fc.ID;

CREATE OR REPLACE VIEW LIAISONPROVDEF (ID, IDMVT, IDFACT, MONTANT, CODEPROVISION, TYPEFACTURE, CODE, DATY,DATELIAISON) AS 
  SELECT p.ID,p.IDMVT,p.IDFACT,p.MONTANT,
		NVL(li.CODEPROV,fc2.CODE) AS  CODEPROVISION,
		case when fc.idcategorie like 'CATFCO1' then 'PROF'
       	when fc.idcategorie like 'CATFCO2' then 'PROV'
       	else 'FF' end as typefacture,
       	fc.code,
       	fc.daty,
       	li.dateliaison AS dateliaison
	FROM PAIEMENTFACTURE p 
	LEFT JOIN FACTURECLIENTMSUM fc ON fc.id = p.IDFACT  
	LEFT JOIN FACTURECLIENTMSUM fc2 ON fc2.id = fc.IDPROVISION  
	LEFT JOIN FCDEFPRLIB li ON  li.ID1 = p.IDFACT AND p.MONTANT = li.MONTANT AND li.ETAT = 11 ;

CREATE OR REPLACE VIEW SUIVI_PROVISION (ID, DATY, CAISSE, NUMPIECE, LIBELLE, CREDIT, TIERS,NUMCHEQUE, MONTANT, CODE, CODEPROVISION, DATEFACTURE,DATELIAISON, MONTANTPROVISION) AS 
  SELECT
		j.id,
		j.DATEEFFET AS daty,
		j.CAISSE ,
		j.NUMPIECE ,
		j.LIBELLE ,
		j.CREDIT ,
		j.TIERS ,
		j.NUMCHEQUE ,
		l.MONTANT,
		l.CODE ,
		l.CODEPROVISION ,
		l.DATY  AS datefacture,
		l.DATELIAISON ,
		f.montantttcvrai AS MONTANTPROVISION
		FROM JOURNALCAISSE_LIB j
		LEFT JOIN LIAISONPROVDEF l ON j.ID = l.IDMVT 
		LEFT JOIN FACTURECLIENTMSUM f ON f.code = l.CODEPROVISION 
	WHERE
		l.CODEPROVISION IS NOT NULL AND l.MONTANT > 0 ;
		
		
		-- SPAT_DEV.FACTUREFOURNVALIDE_C source

CREATE OR REPLACE  VIEW FACTUREFOURNVALIDE_C (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT, IDOP, IDREFPMT, VALCAISSEREFPMT, NUMPIECEREFPMT, DATEEFFETREFPMT, LIBELLEREFPMT, DEBITREFPMT, NUMCHEQUEREFPMT, DATEFACTURE, NUMBC, NUMBED,NUMFSB, MODEPAIEMENT) AS 
SELECT
	ff.ID,
	ff.DATY,
	ff.TIERS,
	ff.DESIGNATION,
	ff.TYPE,
	ff.TVA,
	ff.REMARQUE,
	ff.IDUSER,
	ff.DATE_ECHEANCE,
	ff.ETAT,
	ff.IDPREVISION,
	CAST(ff.MONTANT AS NUMBER(30,
	2)),
	CAST(ff.MONTANTTVA AS NUMBER(30,
	2)),
	CAST(ff.MONTANTAVOIR AS NUMBER(30,
	2)),
	CAST(ff.MONTANTTTC AS NUMBER(30,
	2)),
	CAST(ff.MONTANTPAYE AS NUMBER(30,
	2)),
	CAST(ff.MONTANTRESTE AS NUMBER(30,
	2)),
	ff.TIERSLIB,
	ff.CONTACT,
	ff.ADRESSE,
	ff.ESCALE,
	ff.TYPELIB,
	ff.IDCATEGORIE,
	ff.CATEGORIELIB,
	ff.IDPROVISION,
	ff.IDPROVISIONLIB,
	ff.ESTDDPMICTSL,
	ff.DEVISEMERE,
	ff.CODEPRESTATION,
	ff.CODEPRESTATIONLIB,
	ff.CODE,
	ff.ESTMICTSL,
	ff.CODEPROVISION,
	ff.ETATLIB,
	CAST(ff.MONTANTTTCVRAI AS NUMBER(30,
	2)) AS MONTANTTTCVRAI,
	ff.IDBL,
	ff.NUMEROOP,
	ff.projet,
	ff.code_etablissement,
	ff.projetlib,
	ff.code_etablissementlib,
	ff.NATURE,
	ff.NATURELIB,
	ff.IDBC,
	ord.NUMEROOP AS numop,
	ff.exercice,
	ff.IDENGAGEMENT,
	idengagementlib,
	CODE_ETABLISSEMENT AS CODEETABLISSEMENT,
	ord.id AS idop
       ,
	p.id AS idrefpmt
,
	p.valcaisse AS valcaisserefpmt
,
	p.numpiece AS numpiecerefpmt
,
	p.dateeffet AS dateeffetrefpmt
,
	p.libelle AS libellerefpmt
,
	p.debit AS debitrefpmt
,
	p.numcheque AS numchequerefpmt
,
	ff.DATEFACTURE
,
	ab.NUMBC 
,
	bd.numero AS numBed
,
	CASE
		WHEN bd.NUMFSB IS NOT NULL THEN bd.NUMFSB
		ELSE e.num
	END AS NUMFSB
,
	mod.val AS MODEPAIEMENT
FROM
	FACTUREFOURNVALIDE ff
LEFT JOIN LIAISONINTRATABLE op ON
	op.ID1 = ff.id
LEFT JOIN ORDONNERPAYEMENT ord ON
	op.ID2 = ord.id
LEFT JOIN PaiementOPJCUnion_op p ON
	p.idordre = ord.id
LEFT JOIN AS_BONDECOMMANDE ab ON
	ab.ID = ff.IDBC
LEFT JOIN modepaiement MOD ON
	mod.id = ord.MODEPAIEMENT
LEFT JOIN LIAISONBORDEREAUFF l ON
	l.IDOP = ff.id
LEFT JOIN BORDEREAUFF bd ON
	bd.ID = l.IDBORDEREAU
LEFT JOIN ENGAGEMENT e ON
	e.ID = ff.IDENGAGEMENT
WHERE
	ff.etat = 1
;


CREATE OR REPLACE  VIEW FACTUREFOURNVALIDE_V (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, PROJET, NUMEROOP, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT, IDOP, IDREFPMT, VALCAISSEREFPMT, NUMPIECEREFPMT, DATEEFFETREFPMT, LIBELLEREFPMT, DEBITREFPMT, NUMCHEQUEREFPMT, DATEFACTURE, NUMBC, NUMBED,NUMFSB, MODEPAIEMENT) AS 
  select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       ff.TVA,
       ff.REMARQUE,
       ff.IDUSER,
       ff.DATE_ECHEANCE,
       ff.ETAT,
       ff.IDPREVISION,
        cast(ff.MONTANT as number(30, 2)),
       cast(ff.MONTANTTVA as number(30, 2)),
       cast(ff.MONTANTAVOIR as NUMBER(30, 2)),
       cast(ff.MONTANTTTC as number(30, 2)),
       cast(ff.MONTANTPAYE as number(30, 2)),
       cast(ff.MONTANTRESTE as number(30, 2)),
       ff.TIERSLIB,
       ff.CONTACT,
       ff.ADRESSE,
       ff.ESCALE,
       ff.TYPELIB,
       ff.IDCATEGORIE,
       ff.CATEGORIELIB,
       ff.IDPROVISION,
       ff.IDPROVISIONLIB,
       ff.ESTDDPMICTSL,
       ff.DEVISEMERE,
       ff.CODEPRESTATION,
       ff.CODEPRESTATIONLIB,
       ff.CODE,
       ff.ESTMICTSL,
       ff.CODEPROVISION,
       ff.ETATLIB,
       ff.MONTANTTTCVRAI,
       ff.IDBL,
       ff.PROJET,
       ff.NUMEROOP,
       ff.CODE_ETABLISSEMENT,
       ff.PROJETLIB,
       ff.CODE_ETABLISSEMENTLIB,
       ff.NATURE,
       ff.NATURELIB,
       ff.IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
      ff.IDENGAGEMENT,
       idengagementlib,
       CODE_ETABLISSEMENT as CODEETABLISSEMENT,
       ord.id AS idop
            ,p.id AS idrefpmt
,p.valcaisse AS valcaisserefpmt
,p.numpiece AS numpiecerefpmt
,p.dateeffet AS dateeffetrefpmt
,p.libelle AS libellerefpmt
,CAST(p.debit AS number(30,2)) AS debitrefpmt
,p.numcheque as numchequerefpmt
,ff.DATEFACTURE
,ab.NUMBC 
,bd.numero AS numBed
,
	CASE
		WHEN bd.NUMFSB IS NOT NULL THEN bd.NUMFSB
		ELSE e.num
	END AS NUMFSB
,mod.val as MODEPAIEMENT
from FACTUREFOURNVALIDE ff
         left join LIAISONINTRATABLE op on op.ID1 = ff.id
         left join ORDONNERPAYEMENT ord on op.ID2 = ord.id
LEFT JOIN PaiementOPJCUnion_op p ON p.idordre=ord.id
LEFT JOIN AS_BONDECOMMANDE ab ON ab.ID = ff.IDBC 
left join modepaiement mod on mod.id=ord.MODEPAIEMENT
LEFT JOIN LIAISONBORDEREAUFF l ON
	l.IDOP = ff.id
LEFT JOIN BORDEREAUFF bd ON
	bd.ID = l.IDBORDEREAU
LEFT JOIN ENGAGEMENT e ON
	e.ID = ff.IDENGAGEMENT
where ff.etat >= 11
  and ff.id not in (select id1 from LIAISONINTRATABLE)
;




-- SPAT_DEV.FACTUREFOURNVALIDE_EP source

CREATE OR REPLACE  VIEW FACTUREFOURNVALIDE_EP (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT, IDOP, IDREFPMT, VALCAISSEREFPMT, NUMPIECEREFPMT, DATEEFFETREFPMT, LIBELLEREFPMT, DEBITREFPMT, NUMCHEQUEREFPMT, DATEFACTURE, NUMBC, NUMBED,NUMFSB, MODEPAIEMENT) AS 
  select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       ff.TVA,
       ff.REMARQUE,
       ff.IDUSER,
       DATE_ECHEANCE,
       ff.ETAT,
       IDPREVISION,
       ff.MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       ff.TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       ff.TYPELIB,
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
       MONTANTTTCVRAI,
       'ATTENTE DE PAIEMENT' as ETATLIB,
       ff.IDBL,
       ff.NUMEROOP,
       ff.projet,
       code_etablissement,
       projetlib,
       code_etablissementlib,
       NATURE,
       NATURELIB,
       IDBC,
       ord.NUMEROOP          as numop,
       ff.exercice,
      ff.IDENGAGEMENT,
       IDENGAGEMENTLIB,
       CODE_ETABLISSEMENT,
       ord.id AS idop
            ,p.id AS idrefpmt
,p.valcaisse AS valcaisserefpmt
,p.numpiece AS numpiecerefpmt
,p.dateeffet AS dateeffetrefpmt
,p.libelle AS libellerefpmt
,p.debit AS debitrefpmt
,p.numcheque as numchequerefpmt
,ff.DATEFACTURE
,ab.NUMBC 
,bd.numero AS numBed
,
	CASE
		WHEN bd.NUMFSB IS NOT NULL THEN bd.NUMFSB
		ELSE e.num
	END AS NUMFSB
,mod.val as MODEPAIEMENT
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
         left join ORDONNERPAYEMENT ord on li.ID2 = ord.id
LEFT JOIN PaiementOPJCUnion_op p ON p.idordre=ord.id
LEFT JOIN AS_BONDECOMMANDE ab ON ab.ID = ff.IDBC 
left join modepaiement mod on mod.id=ord.MODEPAIEMENT
LEFT JOIN LIAISONBORDEREAUFF l ON
	l.IDOP = ff.id
LEFT JOIN BORDEREAUFF bd ON
	bd.ID = l.IDBORDEREAU
LEFT JOIN ENGAGEMENT e ON
	e.ID = ff.IDENGAGEMENT
where (li.IDJOURNAL is not null
    and li.ETATJC = 1)
   or (li.IDJOURNAL is null);
  
  
-- SPAT_DEV.FACTUREFOURNVALIDE_P source

CREATE OR REPLACE VIEW FACTUREFOURNVALIDE_P (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT, IDOP, IDREFPMT, VALCAISSEREFPMT, NUMPIECEREFPMT, DATEEFFETREFPMT, LIBELLEREFPMT, DEBITREFPMT, NUMCHEQUEREFPMT, DATEFACTURE, NUMBC, NUMBED,NUMFSB, MODEPAIEMENT) AS 
  select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       ff.TVA,
       ff.REMARQUE,
       ff.IDUSER,
       DATE_ECHEANCE,
       ff.ETAT,
       IDPREVISION,
       ff.MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       ff.TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       ff.TYPELIB,
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
       MONTANTTTCVRAI,
       'PAYE'       as ETATLIB,
       ff.IDBL,
       ff.NUMEROOP,
       ff.projet,
       code_etablissement,
       projetlib,
       code_etablissementlib,
       NATURE,
       NATURELIB,
       IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
      ff.IDENGAGEMENT,
       IDENGAGEMENTLIB,
       CODE_ETABLISSEMENT,
       ord.id AS idop
            ,p.id AS idrefpmt
,p.valcaisse AS valcaisserefpmt
,p.numpiece AS numpiecerefpmt
,p.dateeffet AS dateeffetrefpmt
,p.libelle AS libellerefpmt
,p.debit AS debitrefpmt
,p.numcheque as numchequerefpmt
,ff.DATEFACTURE
,ab.NUMBC 
,bd.numero AS numBed
,
	CASE
		WHEN bd.NUMFSB IS NOT NULL THEN bd.NUMFSB
		ELSE e.num
	END AS NUMFSB
,mod.val as MODEPAIEMENT
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
         left join ORDONNERPAYEMENT ord on li.ID2 = ord.id
         left join PAIEMENTFACTUREF_GRP gr on gr.IDFACT = ff.id
LEFT JOIN PaiementOPJCUnion_op p ON p.idordre=ord.id
LEFT JOIN AS_BONDECOMMANDE ab ON ab.ID = ff.IDBC 
left join modepaiement mod on mod.id=ord.MODEPAIEMENT
LEFT JOIN LIAISONBORDEREAUFF l ON
	l.IDOP = ff.id
LEFT JOIN BORDEREAUFF bd ON
	bd.ID = l.IDBORDEREAU
LEFT JOIN ENGAGEMENT e ON
	e.ID = ff.IDENGAGEMENT
where li.IDJOURNAL is not null
  and li.ETATJC = 11
;



-- SPAT_DEV.FACTUREFOURNVALIDE_TOUS source

CREATE OR REPLACE  VIEW FACTUREFOURNVALIDE_TOUS (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT, IDOP, IDREFPMT, VALCAISSEREFPMT, NUMPIECEREFPMT, DATEEFFETREFPMT, LIBELLEREFPMT, DEBITREFPMT, NUMCHEQUEREFPMT, DATEFACTURE, NUMBC, NUMBED,NUMFSB, MODEPAIEMENT) AS 
  SELECT
  ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, 
  cast(MONTANT as number(30, 2)) AS MONTANT,
  cast(MONTANTTVA as number(30, 2)) AS MONTANTTVA,
  cast(MONTANTAVOIR as NUMBER(30, 2)) AS MONTANTAVOIR,
  cast(MONTANTTTC as number(30, 2)) as MONTANTTTC,
  cast(MONTANTPAYE as number(30, 2)) AS MONTANTPAYE,
  cast(MONTANTRESTE as number(30, 2)) AS MONTANTRESTE,
  TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION,
   IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL,
    CODEPROVISION,   cast(MONTANTTTCVRAI as number(30, 2)) AS MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, 
    CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT, 
    IDOP, IDREFPMT, VALCAISSEREFPMT, NUMPIECEREFPMT, DATEEFFETREFPMT, LIBELLEREFPMT, cast(DEBITREFPMT as number(30, 2)) AS DEBITREFPMT, NUMCHEQUEREFPMT, DATEFACTURE, NUMBC, NUMBED,NUMFSB, MODEPAIEMENT
  from(select ID,
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
         cast(MONTANT as number(30, 2)) AS MONTANT,
  cast(MONTANTTVA as number(30, 2)) AS MONTANTTVA,
  cast(MONTANTAVOIR as NUMBER(30, 2)) AS MONTANTAVOIR,
  cast(MONTANTTTC as number(30, 2)) as MONTANTTTC,
  cast(MONTANTPAYE as number(30, 2)) AS MONTANTPAYE,
  cast(MONTANTRESTE as number(30, 2)) AS MONTANTRESTE,
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
       cast(MONTANTTTCVRAI as number(30, 3)) AS MONTANTTTCVRAI,
       ETATLIB,
       IDBL,
       NUMEROOP,
       PROJET,
       CODE_ETABLISSEMENT,
       PROJETLIB,
       CODE_ETABLISSEMENTLIB,
       NATURE,
       NATURELIB,
       IDBC,
       numop,
       exercice,
      IDENGAGEMENT,
       IDENGAGEMENTLIB,
       codeetablissement,
       idop
,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt
 ,numchequerefpmt
 ,DATEFACTURE,
NUMBC 
, numBed
,numFSB
,MODEPAIEMENT
from (
         select ID,
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
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
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
                MONTANTTTCVRAI,
                'CREE'             as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
               IDENGAGEMENT,
                IDENGAGEMENTLIB,
                CODE_ETABLISSEMENT as codeetablissement,
                idop
,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt
 ,numchequerefpmt
  ,DATEFACTURE,
NUMBC 
, numBed
,numFSB
,MODEPAIEMENT
       from FACTUREFOURNVALIDE_C
         union
         select ID,
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
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
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
                MONTANTTTCVRAI,
                'VISE'             as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
               IDENGAGEMENT,
                IDENGAGEMENTLIB,
                CODE_ETABLISSEMENT as codeetablissement,
                idop
                ,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt
 ,numchequerefpmt
 ,DATEFACTURE,
NUMBC 
, numBed
,numFSB
,MODEPAIEMENT
        from FACTUREFOURNVALIDE_V
         union
         select ID,
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
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
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
                MONTANTTTCVRAI,
                'EN ATTENTE DE PAYEMENT'             as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
               IDENGAGEMENT,
                IDENGAGEMENTLIB,
                CODE_ETABLISSEMENT as codeetablissement,
                idop
                ,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt
 ,numchequerefpmt
  ,DATEFACTURE,
NUMBC 
, numBed
,numFSB
,MODEPAIEMENT
       from FACTUREFOURNVALIDE_ep
         union
         select ID,
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
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
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
                MONTANTTTCVRAI,
                'PAYE'             as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
               IDENGAGEMENT,
                IDENGAGEMENTLIB,
                CODE_ETABLISSEMENT as codeetablissement,
                idop
                ,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt
 ,numchequerefpmt
  ,DATEFACTURE,
NUMBC 
, numBed
,numFSB
,MODEPAIEMENT
       from FACTUREFOURNVALIDE_p))
         ;

		 

		
