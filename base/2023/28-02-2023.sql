
----------create
CREATE VIEW FACTURECLIENT_EMISE_comptant
AS SELECT * FROM FACTURECLIENT_EMISE
WHERE TYPE='TFC002';


----------create
CREATE VIEW FACTURECLIENT_EMISE_credit
AS SELECT * FROM FACTURECLIENT_EMISE
WHERE TYPE='TFC001';


---------add column CODE_ETABLISSEMENTlib
CREATE OR REPLACE  VIEW LIAISONBORDEREAUFF_LIBCOMPLET (ID, IDBORDEREAU, IDOP, REMARQUE, IDFACTURE, IDBORDEREAULIB, MONTANT, CODE_ETABLISSEMENT,CODE_ETABLISSEMENTlib) AS 
  select li.ID,
       li.IDBORDEREAU,
       li.IDOP,
       op.DESIGNATION,
       op.id          as idfacture,
       b2.designation as idbordereaulib,
       op.MONTANTTTC  as montant,
       op.CODE_ETABLISSEMENT,
       ce.desce AS CODE_ETABLISSEMENTlib
from liaisonbordereauff li
         left join bordereauFF_libcomplet b2 on li.idBordereau = b2.id
         left join FACTFOURN_MSUM_LIB op on op.id = li.idOP
         LEFT JOIN codeetablissement ce ON ce.ID =op.CODE_ETABLISSEMENT ;


        
------add column  MONTANTRESTE
 CREATE OR REPLACE  VIEW TRAITE_LIBV (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT, ETATVERSEMENT, ETATVERSEMENTLIB,montantreste) AS 
  select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib,MONTANTRESTE from TRAITEMTTRESTE where etat = 11;

  
------add column  MONTANTRESTE
CREATE OR REPLACE  VIEW TRAITE_LIBESC (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT, ETATVERSEMENT, ETATVERSEMENTLIB,montantreste) AS 
  select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib,MONTANTRESTE from TRAITEMTTRESTE where id in (select idtraite from escompte where etat = 11);


------add column  MONTANTRESTE
CREATE OR REPLACE  VIEW TRAITE_LIBVER (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT, ETATVERSEMENT, ETATVERSEMENTLIB,montantreste) AS 
  select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib,MONTANTRESTE from TRAITEMTTRESTE where etatversement= 11;


------add column  MONTANTRESTE
CREATE OR REPLACE  VIEW TRAITE_LIBNONENC (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT, ETATVERSEMENT, ETATVERSEMENTLIB) AS 
  select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib from TRAITEMTTRESTE where etatversement= 11;



------add column  MONTANTRESTE
CREATE OR REPLACE  VIEW TRAITE_LIBC (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT, ETATVERSEMENT, ETATVERSEMENTLIB,MONTANTRESTE) AS 
  SELECT ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib,MONTANTRESTE  from TRAITEMTTRESTE where etat = 1;



-----------create (itokiana)
CREATE OR REPLACE VIEW traiteversee as
select
mic.ID,mic.DATY,mic.CAISSEDEPART,mic.CAISSEARRIVEE,mic.MONTANT,mic.MODEPAIEMENT,mic.REMARQUE,mic.ETAT,mic.DESIGNATION,mic.IDTRAITE,mic.ETATVERSEMENT,mic.IDFINALEDESTINATION,
t.Dateecheance,
c1.val AS caissedepartlib,
c2.val AS caissearriveelib,
m.Desce as modepaiementlib,
 case
           when mic.etat = 1 then 'CREE'
           when mic.etat >= 11 then 'VISE'
           else '' end                           as etatlib,
 case
           when mic.etatversement = -2 then 'encaissée'
           when mic.etatversement = 11 then 'versée'
           else '' end                           as etatversementlib,
           c3.val AS finaledestinationlib
from mvtintracaisse mic
JOIN traite t on t.id = mic.idtraite
LEFT JOIN CAISSE C1 on C1.id = mic.caissedepart
LEFT JOIN CAISSE C2 on C2.id = mic.caissearrivee
LEFT JOIN caisse C3 ON c3.id= mic.IDFINALEDESTINATION 
LEFT JOIN MODEPAIEMENT m on m.id = mic.modepaiement
 where mic.etatversement = 11;
