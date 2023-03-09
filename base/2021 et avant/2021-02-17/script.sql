CREATE OR REPLACE FORCE VIEW AS_BONDECOMMANDE_LIBCOMPLET ("ID", "DATY", "ETAT", "REMARQUE", "DESIGNATION", "MODEPAIEMENT", "FOURNISSEUR", "TVA", "NUMBC", "PROJET", "CODE_ETAB", "DELAIPAIEMENT", "DELAILIVRAISON", "TYPEPAIEMENT", "MODEPAIEMENTLIBELLE", "FOURNISSEURLIBELLE", "CODE_ETABLIBELLE", "PROJETLIBELLE") AS 
  select bc."ID",bc."DATY",bc."ETAT",bc."REMARQUE",bc."DESIGNATION",bc."MODEPAIEMENT",bc."FOURNISSEUR",bc."TVA",bc."NUMBC",bc."PROJET",bc."CODE_ETAB",bc."DELAIPAIEMENT",bc."DELAILIVRAISON",bc."TYPEPAIEMENT",
       mp.val         as modepaiementlibelle,
       tr.nom         AS FOURNISSEURLIBELLE,
       ce.val         as CODE_ETABLIBELLE,
       pe.designation as PROJETLIBELLE
from union_bc_spat_cemedi bc
         left join modepaiement mp on bc.modepaiement = mp.id
        left join union_tiers_tbd_cemedi tr ON bc.fournisseur = tr.id
        left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
        left join PROJET pe on pe.id = bc.projet;