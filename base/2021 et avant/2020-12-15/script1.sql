 CREATE OR REPLACE FORCE VIEW ETATFACTUREMONTANTDATYRETENU
(
   ID,
   DATY,
   IDFOURNISSEUR,
   NOMFOURNISSEUR,
   IDTVA,
   MONTANTTTC,
   REMARQUE,
   DATEEMISSION,
   DESIGNATION,
   IDDEVISE,
   NUMFACT,
   DATYECHEANCE,
   ETAT,
   MONTANTPAYE,
   RESTE,
   ENTITE,
   MONTANTTTDEVISE,
   BUDGET,
   RETENUE,
   MONTANT
)
AS
   SELECT DISTINCT efm.id,
                   efm.daty,
                   efm.idfournisseur,
                   t.nom AS nomfournisseur,
                   efm.idtva,
                   efm.montantttc,
                   efm.remarque AS remarque,
                   efm.dateemission,
                   efm.designation,
                   efm.iddevise,
                   efm.numfact,
                   efm.datyecheance,
                   efm.etat,
                   COALESCE (efm.montantpaye, 0) AS montantpaye,
                   COALESCE (efm.reste, 0) AS reste,
                   '' AS entite,
                   dff.montantttc AS montantttdevise,
                   '' AS budget,
                   0 AS retenue,
                   0 AS montant
     FROM etatfacturemontant efm
          JOIN facturefournisseur dff ON dff.id = efm.id
          LEFT JOIN tiers t ON dff.idfournisseur = t.id
          LEFT JOIN ordonnerpayement op
             ON op.ded_id = dff.id AND OP.ETAT >= 11
          LEFT JOIN JOURNALCAISSE mv ON mv.idordre = op.id;