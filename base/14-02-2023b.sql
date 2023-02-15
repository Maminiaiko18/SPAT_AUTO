------add column typelib
CREATE OR REPLACE  VIEW JOURNALCAISSELIBCOMPLET (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, TIERS, IDTYPECHEQUE, DESIGNATION, IDDEVISE, IDMODE, NUMCHEQUE, TYPEMVT, IDORDRE, IDPLACEMENT, IDCAISSE, VALCAISSE, DESCECAISSE, VALTYPECHEQUE, DESCETYPECHEQUE, TIERSLIB,CODETIERS, IDBANQUE, IDBANQUELIB, NUMEROOP, TYPE,typelib) AS 
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
       categ.VAL AS typelib
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
         
		 
------------add column num 		 
  ALTER TABLE FACTURE_FOURNISSEUR_MERE ADD
  num varchar(100);


------------add column num 	
 CREATE OR REPLACE  VIEW FACTFOURN_MSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB, NUMEROOP, PROJET, PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, DATEREGUL, MONTANTHTSANSREMISE,num) AS 
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 2))                          AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 2))                           AS montanttva,
       NVL(grp.montantavoiravectaux, 0)                                        AS montantavoir,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 2))
                                                                               AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                                                 AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                                               AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                                         AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                                                  as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                                                as codeprovision,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0) AS NUMBER(30, 2)) as MONTANTTTCVRAI,
       fc.IDBL,
       fc.CODE_ETABLISSEMENT,
       cod.VAL                                                                 as CODE_ETABLISSEMENTlib,
       fc.NUMEROOP,
       fc.PROJET,
       p.DESIGNATION                                                           as projetlib,
       fc.NUMFACT,
       fc.NATURE,
       n.VAL                                                                   as naturelib,
       bl.ID_BC,
       fc.EXERCICE,
       fc.IDENGAGEMENT,
       en.DESIGNATION                                                        as idengagementlib ,
       fc.DATEREGUL,
       cast(Nvl(grp.montant,0) AS number(30,2))                               as montantHTSansRemise,
       fc.NUM 
       FROM FACTURE_FOURNISSEUR_MERE fc
         LEFT JOIN FACTFOURN_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFf tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFF catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id
         left join CODEETABLISSEMENT cod on fc.CODE_ETABLISSEMENT = cod.ID
         left join projet p on fc.PROJET = p.ID
         LEFT JOIN nature n on fc.NATURE = n.ID
         left join AS_BONDELIVRAISON bl on bl.ID = nvl(fc.IDBL, fc.REMARQUE)
         left join engagement en on en.ID = fc.IDENGAGEMENT;
        

------------add column num 	
        CREATE OR REPLACE  VIEW FACTFOURN_MSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB, NUMEROOP, PROJET, PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, DATEREGUL, MONTANTHTSANSREMISE,num) AS 
  SELECT m.ID,
       m.DATY,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       '--' || m.remarque                        AS remarque,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.idprevision,
       CAST(m.MONTANT AS NUMBER(32, 2)),
       CAST(M.MONTANTTVA AS NUMBER(32, 2)),
       CAST(M.MONTANTAVOIR AS NUMBER(32, 2)),
       CAST(M.MONTANTTTC AS NUMBER(32, 2)),
       CAST(NVL(pf.montant, 0) AS NUMBER(32, 2)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(pf.montant, 0) AS NUMBER(32, 2))
                                                 AS montantreste,
       fup.NOM                                   AS tierslib,
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
       cast(MONTANTTTCVRAI as number(32,2)),
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
       m.DATEREGUL,
       cast(m.MONTANTHTSANSREMISE AS NUMBER(30,2)) AS MONTANTHTSANSREMISE,
       m.num
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id;
        
        
        
 -----------create
        CREATE OR REPLACE  VIEW PAIEMENTFACTUREBP (ID, IDMVT, IDFACT, MONTANT) AS 
  SELECT pf.ID,
          pf.IDMVT,
          pf.IDFACT,
          CAST(pf.MONTANT AS number(30,2))
     FROM paiementfacturef pf JOIN facture_fournisseur_mere ff ON ff.id = pf.idfact
    WHERE ff.etat >= 11 AND ff.idcategorie = 'CATGFF002';


   -------------create
   CREATE OR REPLACE  VIEW PAIEMENTFACTHORSBPAVECBP (ID, IDMVT, IDFACT, MONTANT, IDPROVISION) AS 
  SELECT pf.ID,
          pf.IDMVT,
          pf.IDFACT,
          cast(pf.MONTANT as number(30,2)),
          Pb.IDFACT as idprovision
     FROM paiementfacturef pf JOIN facture_fournisseur_mere ff ON ff.id = pf.idfact
     LEFT JOIN PAIEMENTFACTUREBP pb on PF.IDMVT=Pb.IDMVT
    WHERE ff.etat >= 11 AND ff.idcategorie != 'CATGFF002';


	
CREATE SEQUENCE SEQNUMBONPROV  START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999;
CREATE OR REPLACE FUNCTION GETSEQNUMBONPROV
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQNUMBONPROV.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 


--------------table PAIEMENTFCAVOIR
CREATE TABLE PAIEMENTFCAVOIR 
(	ID VARCHAR2(100), 
	IDPAIEMENT VARCHAR2(100), 
	IDAVOIR VARCHAR2(100), 
	 CONSTRAINT PAIEMENTFCAVOIR_PK PRIMARY KEY (ID), 
	 CONSTRAINT PAIEMENTFCAVOIR_FACT_FK FOREIGN KEY (IDPAIEMENT)
	  REFERENCES PAIEMENTFACTURE (ID) ENABLE, 
	 CONSTRAINT PAIEMENTFCAVOIR_FC_FK FOREIGN KEY (IDAVOIR)
	  REFERENCES AVOIRFC (ID) ENABLE
);

CREATE SEQUENCE SEQPaiementFCAvoir  START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999;


CREATE OR REPLACE FUNCTION GETSEQPaiementFCAvoir
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQPaiementFCAvoir.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 
