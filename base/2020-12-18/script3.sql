create view BONLIVRAISON_FINAL_VISE AS
select BLF.*,
       BL.ETAT
from BONLIVRAISON_FINAL BLF
         join AS_BONDELIVRAISON BL ON BL.ID = BLF.NUMBL
         WHERE   BL.ETAT>=11;

create or replace view AS_BONDECOMMANDE_LIBELLE_LIB as
select bcl.id,
       bcl.daty,
       bcl.etat,
       bcl.remarque,
       bcl.designation,
       bcl.modepaiement,
       ti.NOM                                as fournisseur,
       bcl.tva,
       bcl.NUMBC,
       bc.montant,
       bc.montanttva,
       bc.montantttc,
       ff.idfacture,
       nvl(op.montant, 0)                    as montant_paye_reel,
       bc.montantttc - nvl(bl.montantttc, 0) as restepayergeneral,
       bc.montantttc - nvl(op.montant, 0)    as resteapayerreel,
       nvl(bl.montantttc,0) as montant_a_payer
from ORDONNERPAYEMENTGROUPEFACT op
         join facturefournisseur_final ff on ff.idfacture = op.DED_ID
         join BONLIVRAISON_FINAL_VISE bl on bl.numbl = ff.IDBL
         right join boncommande_final bc on bc.IDBC = bl.IDBC
         join AS_BONDECOMMANDE_LIBELLE bcl on bcl.ID = bc.idbc
         left join TIERS ti on ti.id = bcl.fournisseur;

CREATE VIEW as_bondelivraison_MttCplVISE AS SELECT * FROM as_bondelivraison_MttCpl WHERE etat = 11;
CREATE VIEW as_bondelivraison_MttCplCREE AS SELECT * FROM as_bondelivraison_MttCpl WHERE etat = 1;

