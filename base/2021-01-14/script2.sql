
create or replace view ORDONNERPAYEMENT_LIBETAT as
SELECT op.*,
          CASE
             WHEN etat = 0 THEN 'annule'
             WHEN etat = 1 THEN 'cree'
             WHEN etat = 11 THEN 'vise'
          END
             AS etatlib
     FROM OrdonnerPayement op
/


create or replace view ORDONNERPAYEMENT_CREE as
SELECT *
FROM ORDONNERPAYEMENT_LIBETAT
WHERE etat = 1
/

reate or replace view ORDONNERPAYEMENT_VISE as
SELECT *
FROM ORDONNERPAYEMENT_LIBETAT
WHERE etat = 11
/

create or replace view ORDONNERPAYEMENT_ANNULE as
SELECT *
FROM ORDONNERPAYEMENT_LIBETAT
WHERE etat = 0
/

