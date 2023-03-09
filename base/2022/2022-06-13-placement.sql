CREATE OR REPLACE  VIEW "PLACEMENTLIB_NOUVEAU" ("ID", "ENTITE", "DATE_PLACEMENT", "DATE_ECHEANCE", "DUREE", "MONTANT", "TAUX", "NUMERO", "BANQUE", "ETAT", "IDDEVISE", "MONTANTDEVISE", "ANCIENPLACEMENT") AS 
select 
    "ID",
    "ENTITE",
    "DATE_PLACEMENT",
    "DATE_ECHEANCE",
    "DUREE",
    "MONTANT",
    "TAUX",
    "NUMERO",
    "BANQUE",
    "ETAT",
    "IDDEVISE",
    "MONTANTDEVISE",
    "ANCIENPLACEMENT" 
from PLACEMENTLIBCOMPLET where etat>=11 and ancienPlacement is NULL;


CREATE OR REPLACE  VIEW "PLACEMENT_ANNULATION" ("ID", "ENTITE", "DATE_PLACEMENT", "DATE_ECHEANCE", "DUREE", "MONTANT", "TAUX", "NUMERO", "BANQUE", "ETAT", "IDDEVISE", "MONTANTDEVISE") AS 
  SELECT 
    "ID",
    "ENTITE",
    "DATE_PLACEMENT",
    "DATE_ECHEANCE",
    "DUREE",
    "MONTANT",
    "TAUX",
    "NUMERO",
    "BANQUE",
    "ETAT",
    "IDDEVISE",
    "MONTANTDEVISE" 
  FROM
PLACEMENTLIB_ECHU where id not in (SELECT ancienplacement FROM PLACEMENTLIBCOMPLET where etat>=11);


CREATE OR REPLACE  VIEW "PLACEMENTLIB_RENOUVELLE" ("ID", "ENTITE", "DATE_PLACEMENT", "DATE_ECHEANCE", "DUREE", "MONTANT", "TAUX", "NUMERO", "BANQUE", "ETAT", "IDDEVISE", "MONTANTDEVISE", "ANCIENPLACEMENT") AS 
  select 
    "ID",
    "ENTITE",
    "DATE_PLACEMENT",
    "DATE_ECHEANCE",
    "DUREE",
    "MONTANT",
    "TAUX",
    "NUMERO",
    "BANQUE",
    "ETAT",
    "IDDEVISE",
    "MONTANTDEVISE",
    "ANCIENPLACEMENT" 
  from PLACEMENTLIBCOMPLET where etat>=11 and id not in (select id from placementlib_nouveau) and id not in (select id from PLACEMENT_ANNULATION);

CREATE OR REPLACE  VIEW "MVTCAISSEDETAILSLIB" ("ID", "IDINGREDIENTS", "SORTIE", "ENTREE", "DATY", "UNITE", "INGREDIENTS", "DEPOT") AS 
  SELECT fille.id,
          ca.ID AS idingredients,
          fille.DEBIT AS sortie,
          fille.CREDIT AS entree,
          fille.DATeeffet AS daty,
          fille.IDDEVISE AS unite,
          ca.val AS INGREDIENTs,
          ca.ID AS depot
     FROM journalcaisse fille JOIN caisse ca ON ca.ID = fille.CAISSE
    WHERE fille.etat >= 11
    and (idplacementvrai IS NULL OR idplacementvrai not in (select id from PLACEMENTLIB_RENOUVELLE));

CREATE OR REPLACE  VIEW "MVTCAISSEDETAILSLIB" ("ID", "IDINGREDIENTS", "SORTIE", "ENTREE", "DATY", "UNITE", "INGREDIENTS", "DEPOT") AS 
  SELECT fille.id,
          ca.ID AS idingredients,
          fille.DEBIT AS sortie,
          fille.CREDIT AS entree,
          fille.DATeeffet AS daty,
          fille.IDDEVISE AS unite,
          ca.val AS INGREDIENTs,
          ca.ID AS depot
     FROM journalcaisse fille JOIN caisse ca ON ca.ID = fille.CAISSE
    WHERE fille.etat >= 11
    and (idplacementvrai IS NULL OR (idplacementvrai not in (select id from PLACEMENTLIB_RENOUVELLE)) OR (idplacementvrai in (select id from PLACEMENTLIB_NOUVEAU) and debit!=0) OR (idplacementvrai in (select id from PLACEMENT_ANNULATION) and credit!=0));
