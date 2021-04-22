create OR REPLACE view pourcentageprojet_lib_etat
            (ID, CHANTIER, DATY, POURCENTAGE, OBSERVATION, IDUTILISATEUR, ETAT, ETATLIB,IDCHANTIER)
AS
select id,
      nom as idchantier,
       daty,
       pourcentage,
       observation,
       idutilisateur,
       etat,
       CASE
           WHEN etat = 1
               then 'CREE(E)'
           when ETAT = 11 then 'VALIDE(E)'
           when etat = 0 then 'ANNULE(E)' END as etatlib,
       IDCHANTIER as chantier
FROM POURCENTAGEPROJETLIBCOMPLET;

  CREATE OR REPLACE VIEW RECAP_QUAIS
    (IDQUAI, NOMQUAI, IDTYPEQUAIS, TYPEQUAIDESTINATION, NUMEROESCALE_PREV, NOMNAVIRE_PREV, VALCONSIGNATAIRE_PREV, CARGVAL_PREV, DATE_ARRIVEE_PREV, DATE_DEPART_PREV, NUMEROESCALE_OCCUP, NOMNAVIRE_OCCUP, VALCONSIGNATAIRE_OCCUP, CARGVAL_OCCUP, DATE_ARRIVEE_OCCUP, DATE_DEPART_OCCUP) AS
  select
    prev.QUAIDESTINATION as idQuai , prev.descequaisdestination as nomQuai, prev.typequaisdestination as idTypeQuais,
    prev.valtypequaisdestination as typequaidestination,
    '' as numeroEscale_prev, prev.nomnavire as nomnavire_prev , prev.valconsignataire as valconsignataire_prev,
    prev.valcargaison as cargval_prev, prev.date_arrivee as date_arrivee_prev, prev.date_depart as date_depart_prev,
    '-' as numeroEscale_occup, '-' as nomnavire_occup , '-' as valconsignataire_occup,
    '-' as cargval_occup, null as date_arrivee_occup, null as date_depart_occup
from PREVISIONLIBCOMPLET prev
union
select
    mvt.quaisdestination as idQuai, mvt.valquaisdestination as nomQuai, mvt.typequaisdestianantion as idTypeQuais,
    mvt.valtypequaisdestination as typequaidestination,
    '-' as numeroEscale_prev, '-' as nomnavire_prev , '-' as valconsignataire_prev,
    '-' as cargval_prev, null as date_arrivee_prev, null as date_depart_prev,
    mvt.escale as numeroEscale_occup, mvt.nomnavire as nomnavire_occup, mvt.desceconsignataire as valconsignataire_occup,
    mvt.valcargaison as cargval_occup, mvt.datearrivee as date_arrivee_occup, mvt.date_depart as date_depart_occup
from mouvementLibComplet mvt;

create or replace view DETAILSFFBONLIVRAISON as
select Detfac.id,
       Detfac.QTE,
       Detfac.pu,
       Detfac.IDMERE,
       Detfac.COMPTE,
       Detfac.IDINGREDIENT,
       NVL((select sum(bonF.quantite)
            from AS_BONDELIVRAISON_fille bonF
                     join as_bondelivraison bon on bon.id = bonF.NUMBL
            where etat = 11
              and bonF.iddetailsfacturefournisseur = Detfac.id
            group by iddetailsfacturefournisseur), 0)       as livre,
       QTE - NVL((select sum(bonF.quantite)
                  from AS_BONDELIVRAISON_fille bonF
                           join as_bondelivraison bon on bon.id = bonF.NUMBL
                  where etat = 11
                    and bonF.iddetailsfacturefournisseur = Detfac.id
                  group by iddetailsfacturefournisseur), 0) as reste,
       Detfac.iddqe
from detailsfacturefournisseur Detfac;


create or replace view DETAILSFFBONLIVRAISONLIB as
select dl.id,
       dl.QTE,
       dl.pu,
       dl.IDMERE,
       dl.COMPTE,
       i.LIBELLE as IDINGREDIENT,
       dl.livre,
       dl.reste,
       dl.iddqe
from Detailsffbonlivraison dl
         join ElementChantier i on i.id = dl.IDINGREDIENT;

create OR REPLACE view etatfacturemontantdatyretenu
            (id, daty, idfournisseur, nomfournisseur, idtva, montantttc, remarque, dateemission, designation, iddevise,
             numfact, datyecheance, etat, montantpaye, reste, entite, montantttdevise, budget, retenue, montant)
as
SELECT DISTINCT efm.id,
                efm.daty,
                efm.idfournisseur,
                t.nom                  AS nomfournisseur,
                efm.idtva,
                efm.montantttc,
                efm.remarque                  AS remarque,
                efm.dateemission,
                efm.designation,
                efm.iddevise,
                efm.numfact,
                efm.datyecheance,
                efm.etat,
                COALESCE(mv.debit, 0)  AS montantpaye,
                COALESCE(efm.reste, 0) AS reste,
                ''                     AS entite,
                dff.montantttc         AS montantttdevise,
                ''                     AS budget,
                0                      AS retenue,
                0                      AS montant
FROM etatfacturemontant efm
         JOIN facturefournisseur dff ON dff.id = efm.id
         LEFT JOIN tiers t ON dff.idfournisseur = t.id
    --  LEFT JOIN budget_depense bd ON dff.budget = bd.id
    -- JOIN marcheetat m ON dff.remarque = m.id
         LEFT JOIN ordonnerpayement op ON op.ded_id = dff.id AND OP.ETAT >= 11
         LEFT JOIN JOURNALCAISSE mv ON mv.idordre = op.id;