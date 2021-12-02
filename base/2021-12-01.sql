INSERT INTO ROLES (IDROLE, DESCROLE, RANG) VALUES ('ROL001301', 'DSIA', 6);


CREATE OR REPLACE VIEW CARGAISONANALYSE (ID, CARGAISON, CARGAISONLIB, TONNAGE, DATE_ARRIVEE, MOIS, MOISLIB) AS
select p.id,
     cargaison,
     VALCARGAISON as cargaisonlib,
     tonnage,
     date_arrivee,
     extract(month from DATE_ARRIVEE) as mois,
     m.VAL  as moislib
from previsionlibcomplet p
  left join MOIS m on m.ID=extract(month from DATE_ARRIVEE);
