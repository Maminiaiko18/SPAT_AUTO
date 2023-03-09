
 CREATE OR replace VIEW AS_BC_ANALYSEFILLE_LIB AS SELECT
       mon.ID,
       case when mon.produit is null then mon.remarque else pr.nom END AS produit,
       mon.IDBC,
       mon.QUANTITE,
       mon.PU,
       mon.QUANTITEPARPACK,
       mon.MONTANT,
       mon.REMARQUE,
       mon.UNITE,
       mon.TVA,
       mon.MONTANTHT,
       mon.MONTANTTVA,
       mon.MONTANTTTC,
       mon.ETAT,
       bc.daty AS daty,
       bc.CODE_ETAB as code,
       bc.FOURNISSEUR,
       bc.PROJET,
       MONTANTREMISE
       from AS_BONDECOMMANDE_FILLE_MONTANT mon
         left join union_produit_tbd_cemedi pr on pr.id = mon.PRODUIT
         LEFT JOIN AS_BONDECOMMANDE bc ON bc.id = mon.idbc;
		 
		 
 INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('SED0000001', 'Analyse details', 'fa fa-area-chart', NULL, 5, 4, 'MEN00212');		 

ALTER TABLE AVOIRFCFILLE ADD duree number(10,2) ; 
       
       
CREATE OR REPLACE  VIEW AVOIRFCFILLE_PLUS (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, MONTANTDF, DESIGNATION, DEVISE, REMISE, TVADF, TVAAV, TVA, QTE, PU, MAJ, RED , duree) AS 
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
       cast(0 as number(10,2)) as red , 
       fc.DUREE 
from AvoirFCFille fc
        left join CAFCFILLECOMPLET ca on ca.id=fc.IDDETAILFACTURE  ;