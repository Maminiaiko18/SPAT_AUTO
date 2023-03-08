INSERT INTO MENUDYNAMIQUE
(ID, ICONE, LIBELLE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENS00500', 'fa fa-table', 'Bon provisoire', NULL, 9, 3, 'MEN00211');
INSERT INTO MENUDYNAMIQUE
(ID, ICONE, LIBELLE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENS00501', 'fa fa-plus', 'Saisie', '/spat/pages/globalnegoce.jsp?but=facture/bon-provisoire-saisie.jsp', 1, 4, 'MENS00500');
INSERT INTO MENUDYNAMIQUE
(ID, ICONE, LIBELLE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENS00502', 'fa fa-list', 'Liste', '/spat/pages/globalnegoce.jsp?but=facture/bon-provisoire-liste.jsp', 2, 4, 'MENS00500');


----ariry
create table bon_provisoire_final( id varchar (100) CONSTRAINT bon_provisoire_final_pk PRIMARY KEY, tiers varchar(500), daty DATE, caisse varchar(100) CONSTRAINT bon_provisoire_f_caisse_id_fk references caisse(id), montant NUMBER (32,3), remarque varchar(500), etat integer ); CREATE SEQUENCE seqbon_provisoire_final INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999999 START WITH 1 CACHE 20 ; CREATE OR REPLACE FUNCTION getseqbon_provisoire_final RETURN NUMBER IS retour NUMBER; BEGIN SELECT seqbon_provisoire_final.nextval INTO retour FROM dual; return retour; END; SELECT * FROM FOURNISSEUR_UNION_PERSONNEL; CREATE OR replace view bon_provisoire_final_lib AS SELECT b.*, c.VAL AS caisselib, f.nom AS tierslib FROM bon_provisoire_final b LEFT JOIN FOURNISSEUR_UNION_PERSONNEL f ON F.id= b.tiers LEFT JOIN caisse c ON c.ID =b.caisse; create view bon_provisoire_final_lib_cree as select * from bon_provisoire_final_lib where etat=1; create view bon_provisoire_final_lib_vise as select * from bon_provisoire_final_lib where etat>=11;

---sedra


       
       

	create table bon_provisoire_final(
id varchar (100) CONSTRAINT bon_provisoire_final_pk  PRIMARY KEY,
tiers varchar(500),
daty DATE,
caisse varchar(100) CONSTRAINT bon_provisoire_f_caisse_id_fk references caisse(id),
montant NUMBER (32,3),
remarque varchar(500),
etat integer
);

CREATE SEQUENCE   seqbon_provisoire_final
 	INCREMENT  BY  1 
    MINVALUE 1 
    MAXVALUE 999999999999999
    START  WITH  1  
    CACHE 20  ;
    
   
CREATE OR REPLACE FUNCTION getseqbon_provisoire_final  		
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqbon_provisoire_final.nextval INTO retour FROM dual;
  return retour;	
END;  



	CREATE OR replace view bon_provisoire_final_lib AS SELECT
	b.*,
	c.VAL AS caisselib,
	f.nom AS tierslib
	FROM bon_provisoire_final b
	LEFT JOIN FOURNISSEUR_UNION_PERSONNEL f ON F.id= b.tiers
	LEFT JOIN caisse c ON c.ID =b.caisse;

	
	create view bon_provisoire_final_lib_cree as
select * from bon_provisoire_final_lib where etat=1;

create view bon_provisoire_final_lib_vise as
select * from bon_provisoire_final_lib where etat>=11;


	CREATE OR replace view bon_provisoire_final_lib AS SELECT
	b.*,
	c.VAL AS caisselib,
	f.nom AS tierslib
	FROM bon_provisoire_final b
	LEFT JOIN FOURNISSEUR_UNION_PERSONNEL f ON F.id= b.tiers
	LEFT JOIN caisse c ON c.ID =b.caisse;

	
	create view bon_provisoire_final_lib_cree as
select * from bon_provisoire_final_lib where etat=1;

create view bon_provisoire_final_lib_vise as
select * from bon_provisoire_final_lib where etat>=11;




ALTER table bon_provisoire_final
ADD estOM integer;


CREATE OR REPLACE  VIEW BON_PROVISOIRE_FINAL_LIB (ID, TIERS, DATY, CAISSE, MONTANT, REMARQUE, ETAT, CAISSELIB, TIERSLIB,ESTOM,designation) AS 
  SELECT
	b.ID,b.TIERS,b.DATY,b.CAISSE,b.MONTANT,b.REMARQUE,b.ETAT,
	c.VAL AS caisselib,
	f.nom AS tierslib,
	b.ESTOM ,
	b.designation
	FROM bon_provisoire_final b
	LEFT JOIN FOURNISSEUR_UNION_PERSONNEL f ON F.id= b.tiers
	LEFT JOIN caisse c ON c.ID =b.caisse;

ALTER table bon_provisoire_final
ADD designation varchar(500);


CREATE OR REPLACE VIEW BON_PROVISOIRE_FINAL_LIB_CREE (ID, TIERS, DATY, CAISSE, MONTANT, REMARQUE, ETAT, CAISSELIB, TIERSLIB,designation) AS 
  select ID,TIERS,DATY,CAISSE,MONTANT,REMARQUE,ETAT,CAISSELIB,TIERSLIB,designation from bon_provisoire_final_lib where etat=1;

 CREATE OR REPLACE  VIEW BON_PROVISOIRE_FINAL_LIB_VISE (ID, TIERS, DATY, CAISSE, MONTANT, REMARQUE, ETAT, CAISSELIB, TIERSLIB,designation) AS 
  select ID,TIERS,DATY,CAISSE,MONTANT,REMARQUE,ETAT,CAISSELIB,TIERSLIB,designation from bon_provisoire_final_lib where etat>=11;

 
 Alter table FACTURE_FOURNISSEUR_MERE
Add bonprovisoire varchar(500) CONSTRAINT  FACTURE_F_M_id_fk references bon_provisoire_final(id);



CREATE OR REPLACE  VIEW FACTFOURN_MSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB, NUMEROOP, PROJET, PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, DATEREGUL, MONTANTHTSANSREMISE,BONPROVISOIRE) AS 
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
       fc.BONPROVISOIRE
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
         left join engagement en on en.ID = fc.IDENGAGEMENT
;



CREATE OR REPLACE  VIEW FACTFOURN_MSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB, NUMEROOP, PROJET, PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, DATEREGUL, MONTANTHTSANSREMISE,bonprovisoire) AS 
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
       m.bonprovisoire
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id
;



CREATE OR REPLACE  VIEW BPVALIDE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB,bonprovisoire) AS 
  select ID,DATY,TIERS,DESIGNATION,TYPE,TVA,REMARQUE,IDUSER,DATE_ECHEANCE,ETAT,IDPREVISION,MONTANT,MONTANTTVA,MONTANTAVOIR,MONTANTTTC,MONTANTPAYE,MONTANTRESTE,TIERSLIB,CONTACT,ADRESSE,ESCALE,TYPELIB,IDCATEGORIE,CATEGORIELIB,IDPROVISION,IDPROVISIONLIB,ESTDDPMICTSL,DEVISEMERE,CODEPRESTATION,CODEPRESTATIONLIB,CODE,ESTMICTSL,CODEPROVISION,ETATLIB,bonprovisoire from factfourn_msum_lib where IDCATEGORIE='CATGFF002';

 
 ALTER TABLE journalcaisse 
 add bonprovisoire varchar(100) CONSTRAINT journalC_bon_prov_f_id_fk references bon_provisoire_final(id);
 



CREATE OR REPLACE  VIEW JOURNALCAISSELIBCOMPLET (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, 
TIERS, IDTYPECHEQUE, DESIGNATION, IDDEVISE, IDMODE, NUMCHEQUE, TYPEMVT, IDORDRE, IDPLACEMENT, IDCAISSE, VALCAISSE, DESCECAISSE, VALTYPECHEQUE,
DESCETYPECHEQUE, TIERSLIB, IDBANQUE, IDBANQUELIB, NUMEROOP , BONPROVISOIRE) AS 
  SELECT j.ID,
       j.DATESAISIE,
       j.DATEEFFET,
       j.FOLIO,
       j.CAISSE,
       j.NUMPIECE,
       j.LIBELLE,
       j.DEBIT,
       j.CREDIT,
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
       j.IDBANQUE,
       b.val as idbanquelib,
        op.NUMEROOP ,
        j.BONPROVISOIRE 
FROM Journalcaisse j
         JOIN CAISSE C
              ON j.CAISSE = C.ID
         LEFT JOIN TYPECHEQUE tc ON tc.id = j.idtypecheque
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL ti ON ti.id = j.TIERS
         LEFT JOIN MODEPAIEMENT m on j.idmode = m.id
         LEFT JOIN BANQUE b on j.idbanque = b.ID
         left join ORDONNERPAYEMENT op on op.id=j.IDORDRE;
        
        
        
