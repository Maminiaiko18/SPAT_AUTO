ALTER TABLE mvtintracaisse ADD designation varchar(500) ;     

CREATE OR REPLACE  VIEW MVTINTRACAISSE_LIB (ID, DATY, CAISSEDEPART, CAISSEARRIVEE, MONTANT, MODEPAIEMENT, REMARQUE, ETAT , DESIGNATION) AS 
  select mv.id,
       daty,
       ca.VAL as caissedepart,
       ca1.VAL as caissearrivee,
       montant,
       mp.VAL as modepaiement,
       remarque,
       etat , 
       mv.designation
from mvtintracaisse mv
        left join CAISSE ca on ca.id=mv.caissedepart
        left join CAISSE ca1 on ca1.id=mv.caissearrivee
        left join MODEPAIEMENT mp on mp.id=mv.modepaiement;