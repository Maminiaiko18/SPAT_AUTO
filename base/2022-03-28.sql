+INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00022', 'Demande Achat', 'fa fa-table', '#', 8, 3, 'MEN00211');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00023', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=depense/demande-achat-saisie.jsp', 1, 4, 'MEN00022');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00024', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=depense/demande-achat-liste.jsp', 2, 4, 'MEN00022');



  CREATE OR REPLACE  VIEW JOURNALCAISSELIBCOMPLET (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE,
      NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, TIERS, IDTYPECHEQUE, DESIGNATION, IDDEVISE,
      IDMODE, NUMCHEQUE, TYPEMVT, IDORDRE, IDPLACEMENT, IDCAISSE, VALCAISSE, DESCECAISSE, VALTYPECHEQUE,
      DESCETYPECHEQUE, TIERSLIB, IDBANQUE, IDBANQUELIB,NUMEROOP) AS
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
        op.NUMEROOP
FROM Journalcaisse j
         JOIN CAISSE C
              ON j.CAISSE = C.ID
         LEFT JOIN TYPECHEQUE tc ON tc.id = j.idtypecheque
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL ti ON ti.id = j.TIERS
         LEFT JOIN MODEPAIEMENT m on j.idmode = m.id
         LEFT JOIN BANQUE b on j.idbanque = b.ID
         left join ORDONNERPAYEMENT op on op.id=j.IDORDRE;
		 
		 
create or replace view JOURNALCAISSELIBDEPENSE as
select*
from journalcaisselibcomplet
where debit > 0;

    
        
CREATE TABLE dem_achat_mere 
(
	id varchar(100) , 
	codeetablissement varchar(100) CONSTRAINT dem_achat_mere_code_etab_fk REFERENCES codeetablissement , 
	projet varchar(100) CONSTRAINT dem_achat_mere_projet_fk REFERENCES projet , 
	idengagement varchar(100) CONSTRAINT dem_achat_mere_engagement_fk REFERENCES engagement , 
	designation varchar(500) , 
	num varchar(200) , 
	daty DATE 
	
) ; 
        
ALTER TABLE dem_achat_mere ADD CONSTRAINT dem_achat_mere_pk PRIMARY KEY ; 
	
CREATE SEQUENCE   seq_dem_achat_mere
 	INCREMENT  BY  1 
    MINVALUE 1 
    MAXVALUE 999999999999999
    START  WITH  1  
    CACHE 20  ;
    
   
CREATE OR REPLACE FUNCTION getseq_dem_achat_mere           		
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_dem_achat_mere.nextval INTO retour FROM dual;
  return retour;	
END;  	


CREATE SEQUENCE   seqnumda
 	INCREMENT  BY  1 
    MINVALUE 1 
    MAXVALUE 999999999999999
    START  WITH  1  
    CACHE 20  ;
    
   
CREATE OR REPLACE FUNCTION getseqnumda           		
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqnumda.nextval INTO retour FROM dual;
  return retour;	
END;  	


CREATE OR REPLACE VIEW dem_achat_merelib AS SELECT 
dam.* , 
c.val AS codeetablissementlib , 
e.designation AS idengagementlib  , 
p.designation  AS projetlib 
FROM dem_achat_mere dam LEFT JOIN codeetablissement c ON dam.codeetablissement = c.id 
LEFT JOIN engagement e ON e.id = dam.idengagement 
LEFT JOIN projet p ON p.id = dam.projet ; 




CREATE TABLE dem_achat_fille 
(
	id varchar(100) CONSTRAINT dem_achat_fille_pk PRIMARY KEY , 
	idmere varchar(100) CONSTRAINT dem_achat_fille_dem_achat_m_fk REFERENCES dem_achat_mere , 
	produit varchar(100) CONSTRAINT  dem_achat_fille_as_produits_fk REFERENCES as_produits , 
	designation varchar(500) , 
	unite varchar(100) CONSTRAINT dem_achat_fille_unitechant_fk REFERENCES unitechantier , 
	qte number(30,3) , 
	pu number(30,3)
 ) ; 
 

	
CREATE SEQUENCE   seq_dem_achat_fille
 	INCREMENT  BY  1 
    MINVALUE 1 
    MAXVALUE 999999999999999
    START  WITH  1  
    CACHE 20  ;
    
   
CREATE OR REPLACE FUNCTION getseq_dem_achat_fille           		
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_dem_achat_fille.nextval INTO retour FROM dual;
  return retour;	
END;  


CREATE OR REPLACE VIEW dem_achat_fillelib  AS SELECT 
daf.* ,
ap.NOM AS produitlib , 
u.val AS unitelib , 
daf.QTE * daf.pu AS montant 
FROM DEM_ACHAT_FILLE daf LEFT JOIN AS_PRODUITS ap ON ap.id = daf.PRODUIT 
LEFT JOIN UNITECHANTIER u ON u.id = DAF.unite  ; 

ALTER TABLE as_bondecommande ADD  idDa varchar(100) constraint as_bdecommande_dem_achat_m_fk REFERENCES dem_achat_mere ; 