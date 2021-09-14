CREATE OR REPLACE VIEW RUBRIQUE_ACTIVITELIB as
select ra.ID,
       ra.DESIGNATION,
       ra.CODE,
       c2.VAL       as CATEGORIE,
       r.VAL        as REDEVANCE,
       ra.PU,
       de.VAL       as DEVISE,
       ra.COMPTE,
       ua.VAL       as UNITE,
       ra.OBJET,
       ra.TVA,
       d.LIBELLEDIR as DIRECTION,
       ra.CONDITION,
       v.NOMCLT     as CLIENT,
       ra.DEVISE    as iddevise
from rubrique_activite ra
         left join CATEGORIEFACTURATION C2 on ra.CATEGORIE = C2.ID
         left join REDEVANCE r on r.ID = ra.REDEVANCE
         left join DEVISE de on de.ID = ra.DEVISE
         left join UNITE_ACTIVITE ua on ua.ID = ra.UNITE
         left join DIRECTION d on d.IDDIR = ra.DIRECTION
         left join V_CLIENT_CATEGORIE v on v.CDCLT = ra.CLIENT;