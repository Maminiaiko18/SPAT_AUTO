-----------script engagement 

CREATE  OR REPLACE VIEW AS_BONDECOMMANDE_engagement as
SELECT
----- manao bc mere fille + where misy idengagement sy where etat vise
abf.*,A.DATY,A.ETAT,A.IDENGAGEMENT  
FROM  AS_BONDECOMMANDE_FILLE abf 
LEFT JOIN AS_BONDECOMMANDE a ON abf.IDBC = a.ID  
WHERE a.idengagement is not null and a.etat>=11;


CREATE OR replace VIEW AS_BONDECOMMANDE_grp
AS
SELECT 
--------groupena par idbc mere ny montant avy amin ny AS_BONDECOMMANDE_engagement
idbc,sum(montant) AS montant 
FROM AS_BONDECOMMANDE_engagement GROUP BY idbc;



CREATE OR REPLACE VIEW FACTFOURN_BC AS
SELECT 
------maka ze ff rattache amnah bc ary vise
f.*,
CAST(NVL(F.QUANTITE,0)*NVL(F.PU,0) AS NUMBER(30,2)) AS MONTANT,
AB2.ID AS IDBC 
FROM FACTFOURN_MERE_FILLE f
JOIN AS_BONDELIVRAISON AB ON AB.ID= F.IDBL 
JOIN AS_BONDECOMMANDE ab2 ON AB2.ID= AB.ID_BC
WHERE f.ETAT >=11;





CREATE OR REPLACE VIEW FACTFOURN_BC_grp AS
SELECT 
------groupena par idbc ny montantff ao amin ny FACTFOURN_BC
SUM(montant) AS montant,
idbc AS id  
FROM FACTFOURN_BC GROUP BY IDBC;


CREATE OR REPLACE VIEW AS_Bc_ff_mttvrai as
SELECT 
-----atambatra le bc(AS_BONDECOMMANDE_grp) sy le ff rATTACHE AMLE BC(FACTFOURN_BC_grp) DE ZE MONTANT AMBONY  NO RAISINA AS montantbcvrai
a.idbc AS id, a.montant AS montantbc,f.montant AS montantff,
CASE 
	WHEN (a.montant< f.montant)
		THEN f.montant
	ELSE a.montant
END 
AS montantbcvrai,
ae.idengagement
FROM AS_BONDECOMMANDE_grp a 
LEFT JOIN FACTFOURN_BC_grp f ON f.id= a.idbc
LEFT JOIN AS_BONDECOMMANDE ae ON ae.id = a.idbc;

CREATE OR replace VIEW bc_engag_montant as
SELECT
----GROUPENA PAR ENGAGEMENT LE MONTANTVRAI avy aMIN'NY AS_Bc_ff_mttvrai
idengagement ,
sum(nvl(montantbcvrai,0)) AS montant 
FROM AS_Bc_ff_mttvrai 
GROUP BY idengagement;


CREATE OR REPLACE view FACTFOURN_engag_nonbc as
SELECT 
--------maka ny ff tsy rattache BC nefa misy idengagement
f.*,CAST(NVL(F.QUANTITE,0)*NVL(F.PU,0) AS NUMBER(30,2)) AS MONTANT 
FROM FACTFOURN_MERE_FILLE f
WHERE  NOT EXISTS (SELECT id FROM FACTFOURN_BC fb WHERE fb.id=f.id) 
and f.idengagement is not null  
AND etat>=11;


CREATE OR replace VIEW FACTFOURN_engag_nonbc_grp
AS
SELECT 
----groupena by idengagement ny montant avy amin'ny FACTFOURN_engag_nonbc
idengagement,sum(nvl(montant,0)) AS montant 
FROM   FACTFOURN_engag_nonbc 
GROUP BY idengagement;





CREATE OR REPLACE VIEW liaisonEngagementBCFF AS 
SELECT
--------view hijerena RESTE ENGAGEMENT (atao moins ze efa niasa tam Bc na ze efa niasa tamnah FF)
e.id AS idengagement,
e.MONTANT ,
nvl(ag.montant,0) AS montantbc,
nvl(ff.montant,0) AS montantff,
CASE WHEN (nvl(e.MONTANT,0)-nvl(ag.montant,0)-nvl(ff.montant,0))<0 THEN 0
ELSE (nvl(e.MONTANT,0)-nvl(ag.montant,0)-nvl(ff.montant,0))
end
AS MONTANTreste
FROM ENGAGEMENT e 
LEFT JOIN  bc_engag_montant ag ON ag.idengagement =e.ID  
LEFT JOIN FACTFOURN_engag_nonbc_grp ff ON ff.idengagement =e.ID; 







------------CREATE TABLE  liaisonengagement
CREATE TABLE  liaisonengagement    (
ID VARCHAR(100) CONSTRAINT liaisonengagement_pk PRIMARY KEY,
ID1 VARCHAR(100),
ID2 VARCHAR(100),
MONTANT NUMBER(30,2)
);


create sequence seqliaisonengagement
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
      
      


CREATE OR REPLACE FUNCTION getseqliaisonengagement
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqliaisonengagement.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 





   CREATE OR REPLACE VIEW bc_ff_diff as
SELECT 
a.idbc AS id, a.montant AS montantbc,f.montant AS montantff,
CASE WHEN 
		(nvl(a.montant,0)-nvl(f.montant,0))<0 THEN 0
		
ELSE (nvl(a.montant,0)-nvl(f.montant,0)) 
END
AS montantreste,
ae.idengagement
FROM AS_BONDECOMMANDE_grp a 
LEFT JOIN FACTFOURN_BC_grp f ON f.id= a.idbc
LEFT JOIN AS_BONDECOMMANDE ae ON ae.id = a.idbc;



create view factfournmfvalide_grp as select idmere from FACTFOURN_MERE_FILLE f where etat>=11 group by f.idmere;
  

CREATE VIEW liaisonengagement_valide AS 
 SELECT l.* FROM liaisonengagement l
 JOIN AS_BONDECOMMANDE_grp a ON l.ID2=a.IDBC
UNION 
 SELECT l.* FROM liaisonengagement l
 JOIN factfournmfvalide_grp f ON f.idmere=l.ID2 ;

 
CREATE OR REPLACE VIEW liaisonengagement_grp as
SELECT id1 AS idengagement,sum(montant) AS montant FROM liaisonengagement_valide GROUP BY id1;



CREATE OR REPLACE  VIEW LIAISONENGAGEMENT_RESTE (IDengagement, DESIGNATION, CODEETABLISSEMENT, PROJET, MONTANT, DISPONIBLE, DISPOAVANT, DISPOAPRES, COMPTE, ETAT, IDLC, DATY, AVECFACTURE, TIERS, NUM, ANNEE, OBSERVATION, MONTANTRESTE) AS 
SELECT e.ID,e.DESIGNATION,e.CODEETABLISSEMENT,e.PROJET,e.MONTANT,e.DISPONIBLE,e.DISPOAVANT,e.DISPOAPRES,e.COMPTE,e.ETAT,e.IDLC,e.DATY,e.AVECFACTURE,e.TIERS,e.NUM,e.ANNEE,e.OBSERVATION,(nvl(e.MONTANT,0)-nvl(l.MONTANT,0)) AS montantreste FROM ENGAGEMENT e LEFT JOIN liaisonengagement_grp l ON l.idengagement =e.id;





-- ENGAGEMENTLIB source
CREATE OR REPLACE  VIEW ENGAGEMENTLIB (ID, DESIGNATION, CODEETABLISSEMENT, PROJET, MONTANT, DISPOAVANT, DISPOAPRES, COMPTE, ETAT, CODEETABLISSEMENTLIB, PROJETLIB, IDLC, IDLCLIB, DATY, AVECFACTURE, AVECFACTURELIB, MONTANTOP, DISPONIBLE, TIERS, TIERSLIB, NUM, OBSERVATION, ANNEE,montantreste) AS 
  SELECT
	e.ID,
	e.DESIGNATION,
	nvl(e.CODEETABLISSEMENT, lp.CODEETABLISSEMENT) AS CODEETABLISSEMENT,
	nvl(e.PROJET, lp.PROJET) AS PROJET,
	e.MONTANT,
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
	CAST(e.MONTANT- nvl(eng.MONTANTTAUX, 0)-nvl(lib.montant, 0) AS NUMBER(30,
	2)) AS disponible ,
	e.tiers ,
	t.NOM AS tierslib ,
	e.num,
	e.observation,
	EXTRACT(YEAR FROM e.daty),
	leb.MONTANTRESTE 
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
LEFT JOIN LIBERER_MONTANT lib ON
	lib.IDENGAGEMENT = e.ID
LEFT JOIN FOURNISSEUR_UNION_PERSONNEL t ON
	t.id = e.tiers ;




CREATE OR REPLACE  VIEW ENGAGEMENTLIBC as   select * from engagementlib where etat=1;


CREATE OR REPLACE  VIEW ENGAGEMENTLIBV  as   select * 
FROM
	engagementlib
WHERE
	etat >= 11;
	





---------------update engagement taloa
	
alter table FACTURE_FOURNISSEUR_MERE drop constraint FK_ENGAGEMENTFF;

alter table AS_BONDECOMMANDE drop constraint FK_ENGAGEMENT_BC;

alter table engagement_fille drop constraint FK_ENGAGEMENTMRE;


CREATE TABLE ENGAGEMENT_tmp AS
SELECT
	----backup table engagement(backup sad ho ampiasaina apres)
 *
FROM
	ENGAGEMENT e;
	

CREATE TABLE ENGAGEMENT_fille_tmp AS
SELECT
	----backup table engagement(backup sad ho ampiasaina apres)
 *
FROM
	ENGAGEMENT_fille e;

	
delete from engagement where 1<2;
	
delete from engagement_fille where 1<2;
	
	
	
-------ze montant BC no MAX
					 CREATE OR REPLACE VIEW FACTFOURN_BC_BC AS
					SELECT
						-----maka ze BC no ambony montant donc BC no atao insert anaty engagement
					a.idbc AS id,
					a.montant AS montantbc,
					f.montant AS montantff,
					ae.idengagement
					FROM
						AS_BONDECOMMANDE_grp a
					LEFT JOIN FACTFOURN_BC_GRP f ON
						f.id = a.idbc
					LEFT JOIN AS_BONDECOMMANDE ae ON
						ae.id = a.idbc
					WHERE
						(nvl(a.montant,0) >= nvl(f.montant,0))  ;


						
					-----------jointure entre engagement sy le bc (amzay, ze info tamini'ireo engagement efa nisy ho an'le bc iany ampiasaina amreo engagement vaovao)
						
						
					---------table anaovana insert anaty engagement (micreer engagement ho an'ireo BC )
					 CREATE TABLE ENGAGEMENTBCUP AS
					SELECT
						'CRI00000' || getseqengagement() AS id,
						e.DESIGNATION,
						e.CODEETABLISSEMENT,
						e.PROJET,
						f.MONTANTbc AS montant,
						0 AS DISPONIBLE,
						0 AS DISPOAVANT,
						0 AS DISPOAPRES,
						e.COMPTE,
						11 AS ETAT,
						e.IDLC,
						e.DATY,
						e.AVECFACTURE,
						e.TIERS,
						e.NUM,
						e.ANNEE,
						e.OBSERVATION,
						f.id as idbc
					FROM
						FACTFOURN_BC_BC f
					LEFT JOIN ENGAGEMENT_tmp e ON
						e.id = f.idengagement ;
					
					
					---------table anaovana insert anaty liaisonengagement (micreer liaisonengagement ho an'ireo BC  sy engagementireo)
					 CREATE TABLE tliaisonengagbcup AS
					SELECT
						'LTABI000000' || getseqliaisonengagement() AS id,
						e.id AS id1,
						e.idbc AS id2,
						e.montant
					FROM
						ENGAGEMENTBCUP e;
						
------------ze montant ff no ambony
					 CREATE OR REPLACE
					VIEW FACTFOURN_BC_ff AS
					SELECT
						-----maka ze ff no ambony montant donc BC no atao insert anaty engagement
					 a.idbc AS id,
						a.montant AS montantbc,
						f.montant AS montantff,
						ae.idengagement
					FROM
						AS_BONDECOMMANDE_grp a
					LEFT JOIN FACTFOURN_BC_GRP f ON
						f.id = a.idbc
					LEFT JOIN AS_BONDECOMMANDE ae ON
						ae.id = a.idbc
					WHERE
						(nvl(a.montant,0) < nvl(f.montant,0)) ;
						
						
						
						

					CREATE VIEW ff_ainsert_engag AS					
					SELECT m.id,m.montant,f.idengagement from(
					SELECT
						-------miverina any amle FACTFOURN_BC bola tsy grp by idbc 
					 IDMERE AS id, sum(montant) AS montant
					FROM
						FACTFOURN_BC f
					WHERE
						EXISTS(
						SELECT
							id
						FROM
							FACTFOURN_BC_ff bc
						WHERE
							f.IDBC = bc.id)	
					GROUP BY f.idmere)m JOIN FACTURE_FOURNISSEUR_MERE f on m.id=f.id;
					---------table anaovana insert anaty engagement (micreer engagement ho an'ireo ff )
					 CREATE TABLE ENGAGEMENTffUP AS
					SELECT
						'CRI00000' || getseqengagement() AS id,
						e.DESIGNATION,
						e.CODEETABLISSEMENT,
						e.PROJET,
						f.MONTANT AS montant,
						0 AS DISPONIBLE,
						0 AS DISPOAVANT,
						0 AS DISPOAPRES,
						e.COMPTE,
						11 AS ETAT,
						e.IDLC,
						e.DATY,
						e.AVECFACTURE,
						e.TIERS,
						e.NUM,
						e.ANNEE,
						e.OBSERVATION,
						f.id as idff 
					FROM
						ff_ainsert_engag f
					LEFT JOIN ENGAGEMENT_tmp e ON
						e.id = f.idengagement ;
					---------table anaovana insert anaty liaisonengagement (micreer liaisonengagement ho an'ireo ff  sy engagementireo)
					 CREATE TABLE tliaisonengagffup AS
					SELECT
						'LTABI000000' || getseqliaisonengagement() AS id,
						e.id AS id1,
						e.idff AS id2,
						e.montant
					FROM
						ENGAGEMENTffUP e;
						
				
-----ze ff tsy rattache BC :		
CREATE VIEW ff_ainsert_engagnonbc as
SELECT m.id,m.montant,f.IDENGAGEMENT from
(SELECT idmere AS id,sum(montant) AS montant FROM FACTFOURN_engag_nonbc GROUP BY idmere)m JOIN FACTURE_FOURNISSEUR_MERE f on m.id=f.id; 


	---------table anaovana insert anaty engagement (micreer engagement ho an'ireo ff tsy rattache BC )
					 CREATE TABLE ENGAGEMENTffsansbcUP AS
					SELECT
						'CRI00000' || getseqengagement() AS id,
						e.DESIGNATION,
						e.CODEETABLISSEMENT,
						e.PROJET,
						f.MONTANT AS montant,
						0 AS DISPONIBLE,
						0 AS DISPOAVANT,
						0 AS DISPOAPRES,
						e.COMPTE,
						11 AS ETAT,
						e.IDLC,
						e.DATY,
						e.AVECFACTURE,
						e.TIERS,
						e.NUM,
						e.ANNEE,
						e.OBSERVATION,
						f.id as idff 
					FROM
						ff_ainsert_engagnonbc f
					LEFT JOIN ENGAGEMENT_tmp e ON
						e.id = f.idengagement ;
					---------table anaovana insert anaty liaisonengagement (micreer liaisonengagement ho an'ireo ff  sy engagementireo)
					 CREATE TABLE tliaisonengagffsansbcup AS
					SELECT
						'LTABI000000' || getseqliaisonengagement() AS id,
						e.id AS id1,
						e.idff AS id2,
						e.montant
					FROM
						ENGAGEMENTffsansbcUP e;
						

							
						insert into engagement select id,designation,codeetablissement,projet,montant,disponible,dispoavant,dispoapres,compte,etat,idlc,daty,avecFacture,tiers,num,annee,observation from ENGAGEMENTBCUP;
						
						insert into engagement_fille select 'CRFI0000'||getseqengagement_fille(),id as idmere,designation,montant from ENGAGEMENTBCUP;
						insert into  liaisonengagement select * from tliaisonengagbcup;
						
						
						
						insert into engagement select id,designation,codeetablissement,projet,montant,disponible,dispoavant,dispoapres,compte,etat,idlc,daty,avecFacture,tiers,num,annee,observation from ENGAGEMENTffUP;
						insert into engagement_fille select 'CRFI0000'||getseqengagement_fille(),id as idmere,designation,montant from ENGAGEMENTffUP;
						insert into  liaisonengagement select * from tliaisonengagffup;
						
					
						insert into engagement select id,designation,codeetablissement,projet,montant,disponible,dispoavant,dispoapres,compte,etat,idlc,daty,avecFacture,tiers,num,annee,observation from ENGAGEMENTffsansbcUP;
												insert into engagement_fille select 'CRFI0000'||getseqengagement_fille(),id as idmere,designation,montant from ENGAGEMENTffsansbcUP;
						insert into  liaisonengagement select * from tliaisonengagffsansbcup;
						
						UPDATE AS_BONDECOMMANDE a SET a.IDENGAGEMENT =(SELECT l.id1 FROM liaisonengagement l WHERE l.id2=a.id ) WHERE 
						EXISTS (SELECT id FROM liaisonengagement l WHERE 
						a.id=l.id2);
						
						
		
		
		UPDATE FACTURE_FOURNISSEUR_MERE a SET a.IDENGAGEMENT =(SELECT l.id1 FROM liaisonengagement l WHERE l.id2=a.id ) WHERE 
						EXISTS (SELECT id FROM liaisonengagement l WHERE 
						a.id=l.id2);
						
						