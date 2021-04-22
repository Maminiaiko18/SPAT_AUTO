CREATE OR REPLACE VIEW QUAIS_MG AS
SELECT 
	q2.*
FROM QUAIS q2
JOIN POSTEDESTINATAIRE p ON q2.ID = p.QUAI 
WHERE INTERNE = 1;

CREATE OR REPLACE VIEW RECAP_QUAIS ("IDQUAI", "NOMQUAI", "IDTYPEQUAIS", "TYPEQUAIDESTINATION", "NUMEROESCALE_PREV", "NOMNAVIRE_PREV", "VALCONSIGNATAIRE_PREV", "CARGVAL_PREV", "DATE_ARRIVEE_PREV", "DATE_DEPART_PREV", "NUMEROESCALE_OCCUP", "NOMNAVIRE_OCCUP", "VALCONSIGNATAIRE_OCCUP", "CARGVAL_OCCUP", "DATE_ARRIVEE_OCCUP", "DATE_DEPART_OCCUP", "VALMVT") AS 
  select
    prev.QUAIDESTINATION as idQuai , prev.descequaisdestination as nomQuai, prev.typequaisdestination as idTypeQuais,
    prev.valtypequaisdestination as typequaidestination,
    '' as numeroEscale_prev, prev.nomnavire as nomnavire_prev , prev.valconsignataire as valconsignataire_prev,
    prev.valcargaison as cargval_prev, prev.date_arrivee as date_arrivee_prev, prev.date_depart as date_depart_prev,
    prev.ESCALE as numeroEscale_occup, '-' as nomnavire_occup , '-' as valconsignataire_occup,
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