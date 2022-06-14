
insert into detformufact values('DFF0000000023170543X',1,1,'0.033','UA045','STAT. QUAI A USAGE MULTIPLE C','RB0000000021170449','[estNational]==''National''&&[typequais]==''TQ002''','[longueur]*[nbheure]','70684');
insert into detformufact values('DFF0000000023170544X',1,1,'0.063','UA045','STAT. QUAI A USAGE MULTIPLE LC','RB0000000021170449','[estNational]==''International''&&[typequais]==''TQ002''','[longueur]*[nbheure]','70684');

CREATE OR REPLACE VIEW "PLACEMENTLIB_NOUVEAU" ("ID", "ENTITE", "DATE_PLACEMENT", "DATE_ECHEANCE", "DUREE", "MONTANT", "TAUX", "NUMERO", "BANQUE", "ETAT", "IDDEVISE", "MONTANTDEVISE", "ANCIENPLACEMENT") AS 
  select 
    "ID",
    "ENTITE",
    "DATE_PLACEMENT",
    "DATE_ECHEANCE",
    "DUREE",
    "MONTANT",
    "TAUX",
    "NUMERO",
    valbanque AS "BANQUE",
    "ETAT",
    "IDDEVISE",
    "MONTANTDEVISE",
    "ANCIENPLACEMENT" 
from PLACEMENTLIBCOMPLET where etat>=11 and ancienPlacement is NULL;