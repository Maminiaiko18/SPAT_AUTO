CREATE OR REPLACE FORCE VIEW PLACEMENTLIB_CREE AS
select id,
       valentite as entite,
       date_placement,
       date_echeance,
       duree,
       montant,
       taux,
       numero,
       VALBANQUE as BANQUE,
       etat,
       iddeviselib as iddevise,
       MONTANTDEVISE
from PLACEMENTLIBCOMPLET
where etat = 1;

CREATE OR REPLACE FORCE VIEW PLACEMENTLIB_VISEE AS
select id,
       valentite as entite,
       date_placement,
       date_echeance,
       duree,
       montant,
       taux,
       numero,
       VALBANQUE as BANQUE,
       etat,
       iddeviselib as iddevise,
       MONTANTDEVISE
from PLACEMENTLIBCOMPLET
where etat = 11;
 
CREATE OR REPLACE FORCE VIEW PLACEMENTLIB_ECHU AS
select id,
       valentite as entite,
       date_placement,
       date_echeance,
       duree,
       montant,
       taux,
       numero,
       VALBANQUE as BANQUE,
       etat,
       iddeviselib as iddevise,
       MONTANTDEVISE
from PLACEMENTLIBCOMPLET
where etat = 12;