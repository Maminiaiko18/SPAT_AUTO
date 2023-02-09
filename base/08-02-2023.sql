---------script spat 06-02-2022

CREATE OR REPLACE  VIEW FACTURECLIENT_LIBCOMPLET (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDCATEGORIE, IDPROVISION, DEVISEMERE, ESTDDPMICTSL, CODEPRESTATION, CODE, ESTMICTSL, TIERSLIB, CATEGORIELIB, TYPELIB, ARMATEUR, ARMATEURLIB, POURCOMPTE,CDCLT) AS 
  select fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       fc.IDPREVISION,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.DEVISEMERE,
       fc.ESTDDPMICTSL,
       fc.CODEPRESTATION,
       fc.CODE,
       fc.ESTMICTSL,
       fup.NOM as tierslib,
       cat.VAL as categorielib,
       tf.VAL  as typelib,
       fc.armateur as armateur,
       a.val as armateurlib,
       fc.pourcompte,
       fup.CDCLT 
from FACTURECLIENT fc
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = fc.TIERS
         left join CATEGORIEFC cat on cat.ID = fc.IDCATEGORIE
         left join TYPEFC tf on tf.ID = fc.TYPE
         left join armateur_TBD a on a.id=fc.armateur;
		 



CREATE OR REPLACE  VIEW AVOIRFC_MONTANT (ID, DATY, IDFACTURE, ETAT, TIERS, TIERSLIB, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION, MONTANT, MONTANTTVA, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, CODEFACTURE, DATEFACTURE,cdclt) AS 
  SELECT fc.ID,
          fc.DATY,
          fc.IDFACTURE,
          fc.ETAT,

          f.TIERS,
          f.tierslib,

          fc.CATEGORIE,
          c.VAL AS categorielib,
          fc.MOTIF,
          mo.val AS motiflib,
          fc.CODE,
          fc.TYPE,
          CASE
             WHEN fc.TYPE = '1' THEN 'interne'
             WHEN fc.TYPE = '2' THEN 'externe'
          END
             AS typelib,
          fc.DESIGNATION ,
		  CAST (NVL (mr.montant, 0.0) AS NUMBER (30, 3)) AS montant,
          CAST (mr.montanttva AS NUMBER (30, 3)) as montanttva,
          CAST (mr.montantttc AS NUMBER (30, 3)) as montanttc ,
		  CAST (NVL (op.DEBIT, 0) AS NUMBER (30, 3)) AS montantpaye,
          CAST (NVL (mr.montantttc, 0.0) - NVL (op.DEBIT, 0) AS NUMBER (30, 3)) AS montantreste ,
		  f.code AS codeFacture,
		  f.DATY AS datefacture,
		  f.cdclt
     FROM AVOIRFC fc
          LEFT JOIN CATEGORIEAVOIRFC c ON fc.CATEGORIE = c.id
          LEFT JOIN MOTIFAVOIRFC mo ON fc.MOTIF = mo.id
          LEFT JOIN avoirfcavectaux_grp_mere mr ON mr.IDMERE = fc.ID
          LEFT JOIN FACTURECLIENT_libcomplet f ON fc.IDFACTURE = f.ID
          LEFT JOIN ordonnerpayement_jc_vise op ON op.ded_id = fc.ID;

		  
	
CREATE OR REPLACE  VIEW AVOIRFC_MONTANT_C (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, MONTANTPAYE, MONTANTRESTE, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION, MONTANTTVA, MONTANTTTC, CODEFACTURE, DATEFACTURE,cdclt) AS 
  select ID,DATY,IDFACTURE,ETAT,MONTANT,TIERS,TIERSLIB,MONTANTPAYE,MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,
  			MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION , montanttva , montantttc ,codeFacture,datefacture,cdclt
   from avoirFC_montant
  where etat=1;

  
  CREATE OR REPLACE  VIEW AVOIRFC_MONTANT_V (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, MONTANTPAYE, MONTANTRESTE, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION, MONTANTTVA, MONTANTTTC, CODEFACTURE, DATEFACTURE,cdclt ) AS 
  select ID,DATY,IDFACTURE,ETAT,MONTANT,TIERS,TIERSLIB,MONTANTPAYE,MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION , montanttva , montantttc,CODEFACTURE,datefacture,cdclt
from avoirFC_montant
where etat>=11;



-----07-02-2022
CREATE OR REPLACE  VIEW ORDONNERPAYEMENT_LIB (ID, DED_ID, IDLIGNE, DESTINATION, DATY, MONTANT, REMARQUE, ETAT, NUMEROOP, MODEPAIEMENT, TIERS, ADRESSE, NUMFACT, DESTINATIONLIB, BENEFICIAIRE, DEVISE) AS 
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
       fup.NOM as TIERS,
       fup.ADRESSE,
       op1.numfact,
       de.val as destinationlib,
       op.tiers as beneficiaire,
       f.DEVISEMERE
from ORDONNERPAYEMENT op
         left join MODEPAIEMENT mp on mp.id = op.MODEPAIEMENT
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id = op.TIERS
         left join concat_numfact_ff op1 on op.id=op1.id2
         left join DESTINATION de on de.id = op.DESTINATION
         left join FACTURE_FOURNISSEUR_MERE f on f.id =  nvl(SUBSTR(op.DED_ID, 0, INSTR(op.DED_ID, ';') - 1) ,op.DED_ID);
         
       
         
     
         
         
         
         CREATE OR REPLACE VIEW traitemttfc
         AS SELECT 
         t.ID,
         nvl(sum(f.CREDIT),0) AS montantenlevetraite
         FROM traite t
         LEFT JOIN journalcaisse f ON t.ID = f.IDTRAITE
         GROUP BY t.ID
             
 CREATE OR REPLACE VIEW traitemttreste
 AS 
 SELECT t.*,
 (t.total-tf. montantenlevetraite) AS montantreste
 FROM TRAITE_LIBMTT t 
 LEFT JOIN traitemttfc tf ON tf.id=t.id;
 







--comptablite/comptabilite
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENT001', '1700', 'MDO000080', 'ROL0000001342174504', NULL, NULL, 0);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENT002', '1700', 'MEN0006813', 'ROL0000001342174504', NULL, NULL, 0);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENT003', '1700', 'MEN00N101', 'ROL0000001342174504', NULL, NULL, 0);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENT004', '1700', 'MEN0006812', 'ROL0000001342174504', NULL, NULL, 0);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENT005', '1700', 'MEN0006811', 'ROL0000001342174504', NULL, NULL, 0);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENT007', '1700', 'MEN0005066', 'ROL0000001342174504', NULL, NULL, 0);
 
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENT008', '1700', 'MEN00211', 'ROL0000001342174504', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENT009', '1700', 'MEN000682', 'ROL0000001342174504', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENT0010', '1700', 'MDO000001', 'ROL0000001342174504', NULL, NULL, 1);

INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENT0011', '1700', 'MDO000010', 'ROL0000001342174504', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENT0012', '1700', 'MENBDG0001', 'ROL0000001342174504', NULL, NULL, 0);
INSERT INTO UTILISATEUR
(REFUSER, LOGINUSER, PWDUSER, NOMUSER, ADRUSER, TELUSER, IDROLE, CODEETABLISSEMENT)
VALUES(1700, 'comptabilite', 'mywztklsvsto', 'Comptabilité', 'DIR0000000104100035', '1002067', 'ROL0000001342174504', NULL);
	
	

	
	CREATE OR REPLACE  VIEW ENGAGEMENTLIB (ID, DESIGNATION, CODEETABLISSEMENT, PROJET, MONTANT, DISPOAVANT, DISPOAPRES, COMPTE, ETAT, CODEETABLISSEMENTLIB, PROJETLIB, IDLC, IDLCLIB, DATY, AVECFACTURE, AVECFACTURELIB, MONTANTOP, DISPONIBLE, TIERS, TIERSLIB, NUM, OBSERVATION,annee) AS 
  select e.ID,
       e.DESIGNATION,
       nvl(e.CODEETABLISSEMENT, lp.CODEETABLISSEMENT) as CODEETABLISSEMENT,
       nvl(e.PROJET, lp.PROJET)                       as PROJET,
       e.MONTANT,
       --e.DISPONIBLE,
       e.DISPOAVANT,
       e.DISPOAPRES,
       p1.COMPTE,
       e.ETAT,
       nvl(ce.VAL, ce1.val)                             as codeetablissementlib,
       nvl(p.DESIGNATION, p1.designation)               as projetlib,
       e.IDLC,
       lp.DESIGNATION                                   as idLClib,
       DATY,
       AVECFACTURE,
       case
           when avecFacture = 0 then 'NON'
           when avecFacture = 1 then 'OUI'
           end                                          as avecFacturelib,
       cast(nvl(gr.montant, 0) as NUMBER(30, 2))        as montantop,
       cast(e.MONTANT- nvl(eng.MONTANTTAUX,0)-nvl(lib.montant, 0) as NUMBER(30, 2))        as disponible ,
       e.tiers ,
       t.NOM AS tierslib ,
       e.num,
       e.observation,
       EXTRACT(YEAR FROM e.daty)
from engagement e
         left join CODEETABLISSEMENT ce on ce.ID = e.CODEETABLISSEMENT
         left join PROJET p on p.ID = e.PROJET
         left join LIGNECREDITDEPENSE lp on e.IDLC = lp.ID
         left join CODEETABLISSEMENT ce1 on ce1.ID = lp.CODEETABLISSEMENT
         left join PROJET p1 on p1.ID = lp.PROJET
         left join engagementOPMontant gr on gr.idengagement = e.ID
         left join FACTFOURN_ENGAGEMENT eng on eng.IDENGAGEMENT=e.id
         left join LIBERER_MONTANT lib on lib.IDENGAGEMENT=e.ID
    	 LEFT JOIN FOURNISSEUR_UNION_PERSONNEL t ON t.id = e.tiers;
		 
		 
		     	CREATE OR REPLACE  VIEW JOURNALCAISSE_TR (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, TIERS, IDTYPECHEQUE, DESIGNATION, IDORDRE, IDDEVISE, IDMODE, NUMCHEQUE, TYPEMVT, IDPLACEMENT, BANQUE, IDBANQUE, IDPLACEMENTVRAI) AS 
  select j.ID,j.DATESAISIE,j.DATEEFFET,j.FOLIO,j.CAISSE,j.NUMPIECE,j.LIBELLE,j.DEBIT,j.CREDIT,j.REMARQUE,j.ETAT,j.TIERS,j.IDTYPECHEQUE,j.DESIGNATION,j.IDORDRE,j.IDDEVISE,j.IDMODE,j.NUMCHEQUE,j.TYPEMVT,j.IDPLACEMENT,j.BANQUE,j.IDBANQUE,j.IDPLACEMENTVRAI FROM
journalcaisse j
JOIN caisse c on j.caisse = c.id
WHERE  c.id = 'CAIS00000T00016'
;


INSERT INTO MODEPAIEMENT
(ID, VAL, DESCE)
VALUES('pay7', 'provision', 'Paiement provision');


CREATE VIEW paiementprovision AS 
SELECT pr.IDFACT, LISTAGG(df.IDFACT, ',') WITHIN GROUP (ORDER BY pr.IDFACT ) AS idfd, pr.IDMVT, pr.MONTANT AS mttpr, 
nvl(sum(df.MONTANT) , 0) AS mttdf, 
nvl (pr.montant-sum(df.MONTANT), 0) AS reste
FROM PAIEMENTFACTUREPROVISION pr LEFT join paiementfactureHorsProvision df on pr.IDMVT = df.IDMVT
GROUP BY pr.IDFACT , pr.IDMVT, pr.MONTANT;


INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MEN906', NULL, 'MENM02503', 'ROL000002', NULL, NULL, 0);
		 
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MENFAC00010','CA en devise','fa fa-money','/spat/pages/globalnegoce.jsp?but=ca/chiffreAffaire-devise.jsp',18,2,'MEN0006');
	
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MENTRA002','Encaissement Traite','fa fa-list','/spat/pages/globalnegoce.jsp?but=facture/traite-encaissement-versee-liste.jsp',4,4,'MDO0000056');
	
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MENTRA001','Visa Multiple','fa fa-list','/spat/pages/globalnegoce.jsp?but=facture/visa-traite-multiple.jsp',3,4,'MDO0000056');

	
	CREATE OR REPLACE VIEW paiementfacturelibjc AS
SELECT 
	PF.*,
	JC.IDMODE ,
	JC.IDTRAITE 
FROM PAIEMENTFACTURE PF
LEFT JOIN JOURNALCAISSE JC ON JC.ID = PF.IDMVT ;




ALTER TABLE TRAITE DROP CONSTRAINT TRAITE_CLIENT_FK;
