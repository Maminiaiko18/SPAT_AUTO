ALTER TABLE AVOIRFCFILLE ADD reduction number(30,3);
ALTER TABLE AvoirFCFille ADD majoration number(30,3);

CREATE OR REPLACE  VIEW AVOIRFCFILLE_PLUS (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, MONTANTDF, DESIGNATION, DEVISE, REMISE, TVADF, TVAAV, TVA, QTE, PU, MAJ, RED, DUREE, RANG, DATEFACTUREFILLE,reduction,majoration) AS 
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

       fc.DUREE,
       ca.rang,
       ca.datefacturefille ,
       fc.reduction,
       fc.majoration

from AvoirFCFille fc

        left join fcfillecomplet ca on ca.id=fc.IDDETAILFACTURE;


CREATE OR REPLACE  VIEW AVOIRFCFILLE_PDF (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, REMISE, DESIGNATION, TAUX, DEVISE, TVA, QTE, PU, DUREE, MONTANTHTDEVISE, majoration, reduction, RANG, DATEFACTUREFILLE,red,maj) AS 
  SELECT av.ID,
       av.IDMERE,
       av.IDDETAILFACTURE,
       av.MONTANT,
       av.COMPTE,
       av.remise,
       ca.designation                                                                               as designation,
       ca.taux,
       ca.devise,
       av.tva,
       CAST(nvl(av.qte, ca.quantite) AS NUMBER(30, 3))                                                 qte,
       CAST(nvl(av.pu, ca.pu) AS NUMBER(30, 3))                                                        pu,
       CAST(nvl(av.duree, ca.duree) as NUMBER(30, 3))                                                  duree,
       CAST(CASE WHEN devise = 'Ar' THEN av.montant / ca.taux else av.montant END AS NUMBER(30, 3)) AS montantHTDevise,
       ca.majoration                                                                                ,
       ca.reduction                                                                                 AS REDUCTION ,
       ca.rang,
       ca.datefacturefille ,
       av.reduction as red,
       av.majoration as maj
from AvoirFCFille av
         left join fcfillecomplet ca on ca.id = av.IDDETAILFACTURE
;
