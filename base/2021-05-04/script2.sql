create or replace view STATISTIQUEACTIVITELIB as
SELECT s.ID,
       s.TITRE,
       s.DATY,
       t.VAL  AS IDTYPEACTIONCONTENEUR,
       s.PLEIN20PIEDS,
       s.VIDE20PIEDS,
       s.PLEIN40PIEDS,
       s.VIDE40PIEDS,
       n.VAL  AS IDNOMSOCIETE,
       t2.VAL AS IDTYPEMANIPULATION,
       t3.VAL AS IDTYPEMARCHANDISE,
       t4.VAL AS IDTYPEMESURE,
       s.NOMBREUNITE,
       s.POIDS,
       ts.VAL as TYPESAISIE,
       s.ETAT,
       na.nom||' - '||na.TYPENAVIRELIB as NAVIRE,
       s.TYPESAISIE as idTypeSaisie
FROM STATISTIQUEACTIVITE s
         LEFT JOIN TYPEACTIONCONTENEUR t ON s.IDTYPEACTIONCONTENEUR = t.ID
         LEFT JOIN NOMSOCIETE n ON s.IDNOMSOCIETE = n.ID
         LEFT JOIN TYPEMANIPULATION t2 ON s.IDTYPEMANIPULATION = t2.ID
         LEFT JOIN TYPEMARCHANDISE t3 ON s.IDTYPEMARCHANDISE = t3.ID
         LEFT JOIN TYPEMESURE t4 ON s.IDTYPEMESURE = t4.ID
         left join TYPESAISIE ts on ts.ID = s.TYPESAISIE
        left join NAVIRELIBCOMPLET na on na.ID=s.NAVIRE
/


create or replace view STATISTIQUEACTIVITELIBC as
select *
from statistiqueactivitelib l
where l.ETAT = 1
/
create or replace view STATISTIQUEACTIVITELIBV as
select *
from statistiqueactivitelib l
where l.ETAT >= 11
/
