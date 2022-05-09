
ALTER TABLE AVOIRFCFILLE    		
	ADD  qte NUMBER (20,3);  		

ALTER TABLE AVOIRFCFILLE 
	ADD  pu NUMBER  (30,3);

	
	CREATE OR REPLACE  VIEW AVOIRFCFILLE_PLUS (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, MONTANTDF, DESIGNATION, DEVISE, REMISE, TVADF, TVAAV, TVA,qte,pu , maj , red) AS 
	  select 
	  	   fc.ID,
	       fc.IDMERE,
	       fc.IDDETAILFACTURE,
	       fc.MONTANT,
	       fc.COMPTE,
	       cast(MONTANTHTSIMPLE as NUMBER(30, 2)) as montantdf,
	       ca.designation as designation,
	       ca.devise as devise,
	       fc.REMISE , 
	       ca.tva AS tvaDf , 
	       fc.tva AS tvaAv,
	       fc.tva,
	       fc.QTE ,
	       fc.PU , 
	       cast(0 as number(10,2)) as maj , 
	       cast(0 as number(10,2)) as red
	from AvoirFCFille fc
	        left join CAFCFILLECOMPLET ca on ca.id=fc.IDDETAILFACTURE ; 
       
       
       
       
       




