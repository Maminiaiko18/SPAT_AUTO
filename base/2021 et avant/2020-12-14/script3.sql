create or replace view journalcaisseOP as
    select
            jc.*,
            jc.CREDIT-jc.DEBIT as montant,
            op.DED_ID
        from journalcaisse jc
        left join ordonnerpayement op on op.id=jc.IDORDRE;

CREATE OR REPLACE VIEW  DETAILSFF_PARBC AS
SELECT IDINGREDIENT, SUM(qte)  AS QUANTITE
FROM DETAILSFACTUREFOURNISSEUR dff,
     facturefournisseur ff where ff.id=dff.idmere and ff.etat>=11
GROUP BY IDINGREDIENT;

CREATE OR REPLACE VIEW AS_BONDECOMMANDE_FILLEQTE_REST AS
SELECT BC.*,
      cast(NVL(FF.QUANTITE,0)as number(10,2)) AS QTEFACTUREE,
      cast(BC.QUANTITE - NVL(FF.QUANTITE,0) as number(10,2)) AS QTERESTE
FROM AS_BONDECOMMANDE_FILLE BC
        LEFT JOIN DETAILSFF_PARBC FF ON FF.IDINGREDIENT=BC.ID;

create or replace view detailsfacturefournisseurreste as
SELECT DFF.*,
       NVL(BC.QTERESTE,0) as QTERESTE

       FROM detailsfacturefournisseur DFF
       LEFT JOIN AS_BONDECOMMANDE_FILLEQTE_REST BC ON  DFF.IDINGREDIENT=BC.ID;

       CREATE OR REPLACE VIEW RECAP_QUAIS
    (IDQUAI, NOMQUAI, IDTYPEQUAIS, TYPEQUAIDESTINATION, NUMEROESCALE_PREV, NOMNAVIRE_PREV, VALCONSIGNATAIRE_PREV, CARGVAL_PREV, DATE_ARRIVEE_PREV, DATE_DEPART_PREV, NUMEROESCALE_OCCUP, NOMNAVIRE_OCCUP, VALCONSIGNATAIRE_OCCUP, CARGVAL_OCCUP, DATE_ARRIVEE_OCCUP, DATE_DEPART_OCCUP,valmvt) AS
  select
    prev.QUAIDESTINATION as idQuai , prev.descequaisdestination as nomQuai, prev.typequaisdestination as idTypeQuais,
    prev.valtypequaisdestination as typequaidestination,
    '' as numeroEscale_prev, prev.nomnavire as nomnavire_prev , prev.valconsignataire as valconsignataire_prev,
    prev.valcargaison as cargval_prev, prev.date_arrivee as date_arrivee_prev, prev.date_depart as date_depart_prev,
    '-' as numeroEscale_occup, '-' as nomnavire_occup , '-' as valconsignataire_occup,
    '-' as cargval_occup, null as date_arrivee_occup, null as date_depart_occup,'-'as valmvt
from PREVISIONLIBCOMPLET prev
union
select
    mvt.quaisdestination as idQuai, mvt.valquaisdestination as nomQuai, mvt.typequaisdestianantion as idTypeQuais,
    mvt.valtypequaisdestination as typequaidestination,
    '-' as numeroEscale_prev, '-' as nomnavire_prev , '-' as valconsignataire_prev,
    '-' as cargval_prev, null as date_arrivee_prev, null as date_depart_prev,
    mvt.escale as numeroEscale_occup, mvt.nomnavire as nomnavire_occup, mvt.desceconsignataire as valconsignataire_occup,
    mvt.valcargaison as cargval_occup, mvt.datearrivee as date_arrivee_occup, mvt.date_depart as date_depart_occup,mvt.valmvt
from mouvementLibComplet mvt;


create or replace view journalcaisseOP as
    select
            jc.*,
            jc.debit-jc.CREDIT as montant,
            op.DED_ID
        from journalcaisse jc
        left join ordonnerpayement op on op.id=jc.IDORDRE;


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
       Detfac.iddqe,
       Detfac.pu*Detfac.qte as montant
from detailsfacturefournisseur Detfac;

create view AS_BONDECOMMANDE_LIBELLE_TIERS AS
select bc.*,
        nvl(ti.NOM,'-') as nomfournisseur
from AS_BONDECOMMANDE_LIBELLE bc
   left join TIERS ti on ti.id=bc.fournisseur;