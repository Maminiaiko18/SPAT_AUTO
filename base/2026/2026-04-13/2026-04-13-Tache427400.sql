create view AS_BONDELIVRAISON_MTTCPL_Tiers as
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
       bc.NUMBC,
       bc.FOURNISSEUR ,
       t.NOM as fournisseurLib
FROM as_bondelivraison_factPay fp
         LEFT JOIN as_bondecommande bc
                   ON bc.id=fp.id_bc
         left join tiers t on t.id=bc.fournisseur
/

create view AS_BONDELIVRAISON_MTTCPL_TierV as
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
       bc.NUMBC,
       bc.FOURNISSEUR ,
       t.NOM as fournisseurLib
FROM as_bondelivraison_factPay fp
         LEFT JOIN as_bondecommande bc
                   ON bc.id=fp.id_bc
         left join tiers t on t.id=bc.fournisseur
where fp.ETAT = 11
/


create view AS_BONDELIVRAISON_MTTCPL_TierC as
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
       bc.NUMBC,
       bc.FOURNISSEUR ,
       t.NOM as fournisseurLib
FROM as_bondelivraison_factPay fp
         LEFT JOIN as_bondecommande bc
                   ON bc.id=fp.id_bc
         left join tiers t on t.id=bc.fournisseur
where fp.ETAT = 1
/


