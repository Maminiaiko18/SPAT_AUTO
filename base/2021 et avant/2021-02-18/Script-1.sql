create or replace view AS_BONDELIVRAISON_MTTCPL as
  SELECT fp."ID",
  fp."REMARQUE",
  fp."IDBC",
  fp."DATY",
  fp."ETAT",
  fp."POINT",
  fp."ID_BC",
  fp."MONTANT",
  fp."TVA",
  fp."MONTANTTVA",
  fp."MONTANTTTC",
  fp."MONTANTPAYE",
  fp."MONTANTFACT",
  fp."MONTANTTVAFACT",
  fp."MONTANTFACTTTC",
  fp.montantfactttc-fp.montantpaye    AS rap,
  fp.montantttc    -fp.montantfactttc AS reste_a_facturer,
  bc.NUMBC
FROM as_bondelivraison_factPay fp
LEFT JOIN as_bondecommande bc
ON bc.id=fp.id_bc;

select * from as_bondelivraison_factPay;


  CREATE OR REPLACE  VIEW AS_BONDELIVRAISON_MTTCPLCREE
  AS
  SELECT "ID",
    "REMARQUE",
    "IDBC",
    "DATY",
    "ETAT",
    "POINT",
    "ID_BC",
    "MONTANT",
    "TVA",
    "MONTANTTVA",
    "MONTANTTTC",
    "MONTANTPAYE",
    "MONTANTFACT",
    "MONTANTTVAFACT",
    "MONTANTFACTTTC",
    "RAP",
    "RESTE_A_FACTURER",
    NUMBC
  FROM as_bondelivraison_MttCpl
  WHERE etat = 1; 
  
  CREATE OR REPLACE VIEW AS_BONDELIVRAISON_MTTCPLVISE 
  AS
  SELECT "ID",
    "REMARQUE",
    "IDBC",
    "DATY",
    "ETAT",
    "POINT",
    "ID_BC",
    "MONTANT",
    "TVA",
    "MONTANTTVA",
    "MONTANTTTC",
    "MONTANTPAYE",
    "MONTANTFACT",
    "MONTANTTVAFACT",
    "MONTANTFACTTTC",
    "RAP",
    "RESTE_A_FACTURER",
       NUMBC
  FROM as_bondelivraison_MttCpl
  WHERE etat = 11;