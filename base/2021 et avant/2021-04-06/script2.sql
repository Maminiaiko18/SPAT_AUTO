create or replace view AS_BONDECOMMANDE_LIBELLE_TIERS
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NOMFOURNISSEUR, NUMBC, MONTANT,
             MONTANTTVA, MONTANTTTC, IDFACTURE, MONTANT_A_PAYER, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL,
             CODE_ETAB, PROJET, ETATLIB, DELAIPAIEMENT, ADRESSE, REMISE, TYPEPAIEMENT, DELAILIVRAISON)
AS
select op.ID,
       op.DATY,
       op.ETAT,
       op.REMARQUE,
       op.DESIGNATION,
       op.MODEPAIEMENT,
       ti.id                                    as FOURNISSEUR,
       op.TVA,
       op.FOURNISSEUR,
       op.NUMBC,
       cast(op.montant as number(25, 2))        as MONTANT,
       cast(op.MONTANTTVA as number(25, 2))     as MONTANTTVA,
       cast(op.MONTANTTTC as number(25, 2))     as MONTANTTTC,
       cast(IDFACTURE as varchar2(100)),
       cast(MONTANT_A_PAYER as number(25, 2))   as MONTANTTTC,
       cast(MONTANT_PAYE_REEL as number(25, 2)) as MONTANT_PAYE_REEL,
       cast(RESTEPAYERGENERAL as number(25, 2)) as RESTEPAYERGENERAL,
       cast(RESTEAPAYERREEL as number(25, 2))   as RESTEAPAYERREEL,
       op.CODE_ETAB,
       op.PROJET,
       ETATLIB,
       bc.DELAIPAIEMENT,
       ti.ADRESSE,
       cast(0 as number(25, 2))                    remise,
       tc.VAL                                   as TYPEPAIEMENT,
       DELAILIVRAISON
from AS_BONDECOMMANDE_LIBELLE_LIB op
         left join union_bc_spat_cemedi bc on op.id = bc.ID
         left join union_tiers_tbd_cemedi ti on ti.NOM = op.FOURNISSEUR
         left join TYPECHEQUE tc on tc.id = bc.TYPEPAIEMENT
/

