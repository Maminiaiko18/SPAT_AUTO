CREATE OR REPLACE VIEW MVTINTRACAISSE_LIB AS 
  select mv.id,
       daty,
       ca.VAL as caissedepart,
       ca1.VAL as caissearrivee,
       montant,
       mp.VAL as modepaiement,
       remarque,
       etat
from mvtintracaisse mv
        left join CAISSE ca on ca.id=mv.caissedepart
        left join CAISSE ca1 on ca1.id=mv.caissearrivee
        left join MODEPAIEMENT mp on mp.id=mv.modepaiement;