create or replace view STATISTIQUEACTIVITE_LIBCOMPLET as
select s.*,
       n.VAL  AS IDNOMSOCIETELIB,
       t2.VAL AS IDTYPEMANIPULATIONLIB,
       t3.VAL AS IDTYPEMARCHANDISELIB,
       t4.VAL AS IDTYPEMESURELIB,
       ts.VAL as TYPESAISIELIB,
       na.nom||' - '||na.TYPENAVIRELIB as NAVIRELIB

from STATISTIQUEACTIVITE s
         LEFT JOIN TYPEACTIONCONTENEUR t ON s.IDTYPEACTIONCONTENEUR = t.ID
         LEFT JOIN NOMSOCIETE n ON s.IDNOMSOCIETE = n.ID
         LEFT JOIN TYPEMANIPULATION t2 ON s.IDTYPEMANIPULATION = t2.ID
         LEFT JOIN TYPEMARCHANDISE t3 ON s.IDTYPEMARCHANDISE = t3.ID
         LEFT JOIN TYPEMESURE t4 ON s.IDTYPEMESURE = t4.ID
         left join TYPESAISIE ts on ts.ID = s.TYPESAISIE
         left join NAVIRELIBCOMPLET na on na.ID = s.NAVIRE
/

create or replace view STATISTIQUEACTIVITE_NONMICTSL AS
select extract(month from DATY) as mois,
       extract(year from DATY)  as annee,
       sum(NOMBREUNITE)         as NOMBREUNITE,
       IDTYPEMANIPULATIONLIB
from STATISTIQUEACTIVITE_LIBCOMPLET
WHERE TYPESAISIE = 'TSAI002'
GROUP BY extract(month from DATY), extract(year from DATY), IDTYPEMANIPULATIONLIB;--3

create or replace view STATISTIQUEACTIVITE_MICTSL AS
select extract(month from DATY)                                 as mois,
       extract(year from DATY)                                  as annee,
       sum(PLEIN20PIEDS) + sum(VIDE20PIEDS) + sum(PLEIN40PIEDS) as somme_plein20_vide20_plein40,
       IDTYPEMANIPULATIONLIB
from STATISTIQUEACTIVITE_LIBCOMPLET
WHERE TYPESAISIE = 'TSAI001'
GROUP BY extract(month from DATY), extract(year from DATY), IDTYPEMANIPULATIONLIB;

CREATE TABLE MOIS AS
    (SELECT level as id,
            case LEVEL when 1 then 'Janvier'
                       when 2 then 'Fevrier'
                  when 3 then 'Mars'
                  when 4 then 'Avril'
                  when 5 then 'Mai'
                  when 6 then 'Juin'
                  when 7 then 'Juillet'
                  when 8 then 'Aout'
                  when 9 then 'Septembre'
                  when 10 then 'Octobre'
                  when 11 then 'Novembre'
                  when 12 then 'Decembre'
    end as val ,case LEVEL when 1 then 'Janvier'
                       when 2 then 'Fevrier'
                  when 3 then 'Mars'
                  when 4 then 'Avril'
                  when 5 then 'Mai'
                  when 6 then 'Juin'
                  when 7 then 'Juillet'
                  when 8 then 'Aout'
                  when 9 then 'Septembre'
                  when 10 then 'Octobre'
                  when 11 then 'Novembre'
                  when 12 then 'Decembre'
    end as desce
     FROM dual
     connect BY level <= 12);

create or replace view STATISTIQUEACTIVITE_NONMICTSL AS
select extract(month from DATY) as mois,
       extract(year from DATY)  as annee,
       sum(NOMBREUNITE)         as NOMBREUNITE,
       IDTYPEMANIPULATIONLIB,
       IDTYPEMANIPULATION
from STATISTIQUEACTIVITE_LIBCOMPLET
WHERE TYPESAISIE = 'TSAI002'
GROUP BY extract(month from DATY), extract(year from DATY), IDTYPEMANIPULATIONLIB,IDTYPEMANIPULATION;--3

create or replace view STATISTIQUEACTIVITE_MICTSL AS
select extract(month from DATY)                                 as mois,
       extract(year from DATY)                                  as annee,
       sum(PLEIN20PIEDS) + sum(VIDE20PIEDS) + sum(PLEIN40PIEDS) as somme_plein20_vide20_plein40,
       IDTYPEMANIPULATIONLIB,
       IDTYPEMANIPULATION
from STATISTIQUEACTIVITE_LIBCOMPLET
WHERE TYPESAISIE = 'TSAI001'
GROUP BY extract(month from DATY), extract(year from DATY), IDTYPEMANIPULATIONLIB,IDTYPEMANIPULATION;

create or replace view STATISTIQUEACTIVITE_MICTSL_GR AS
select nvl(m.mois, mo.ID)                                            as mois,
       nvl(m.annee, 0)                                               as annee,
       cast(nvl(IDTYPEMANIPULATIONLIB, '-') as varchar2(500))        as IDTYPEMANIPULATIONLIB,
       cast(nvl(IDTYPEMANIPULATION, '-') as varchar2(500))           as IDTYPEMANIPULATION,
       cast(nvl(m.somme_plein20_vide20_plein40, 0) as number(20, 2)) as somme_plein20_vide20_plein40
from STATISTIQUEACTIVITE_MICTSL m
         right join mois mo on mo.id = m.MOIS;

create or replace view STATISTIQUEACTIVITE_NMICTSL_GR AS
select nvl(m.mois, mo.ID)                                     as mois,
       nvl(m.annee, 0)                                        as annee,
       cast(nvl(IDTYPEMANIPULATIONLIB, '-') as varchar2(500)) as IDTYPEMANIPULATIONLIB,
       cast(nvl(IDTYPEMANIPULATION, '-') as varchar2(500))    as IDTYPEMANIPULATION,
       cast(nvl(m.NOMBREUNITE, 0) as number(20, 2))           as NOMBREUNITE
from STATISTIQUEACTIVITE_NONMICTSL m
         right join mois mo on mo.id = m.MOIS;
--------STAT_ACTIVITE

create  view PREVISION_STAT_ACTIVITE_LIBCPL as
select s.*,
       n.VAL  AS IDNOMSOCIETELIB,
       t2.VAL AS IDTYPEMANIPULATIONLIB,
       t3.VAL AS IDTYPEMARCHANDISELIB,
       t4.VAL AS IDTYPEMESURELIB,
       ts.VAL as TYPESAISIELIB,
       na.nom||' - '||na.TYPENAVIRELIB as NAVIRELIB

from PREVISION_STAT_ACTIVITE s
         LEFT JOIN TYPEACTIONCONTENEUR t ON s.IDTYPEACTIONCONTENEUR = t.ID
         LEFT JOIN NOMSOCIETE n ON s.IDNOMSOCIETE = n.ID
         LEFT JOIN TYPEMANIPULATION t2 ON s.IDTYPEMANIPULATION = t2.ID
         LEFT JOIN TYPEMARCHANDISE t3 ON s.IDTYPEMARCHANDISE = t3.ID
         LEFT JOIN TYPEMESURE t4 ON s.IDTYPEMESURE = t4.ID
         left join TYPESAISIE ts on ts.ID = s.TYPESAISIE
         left join NAVIRELIBCOMPLET na on na.ID = s.NAVIRE
/

create or replace view PREVISION_STAT_ACTIV_NONMICTSL AS
select extract(month from DATY) as mois,
       extract(year from DATY)  as annee,
       sum(NOMBREUNITE)         as NOMBREUNITE,
       IDTYPEMANIPULATIONLIB,
       IDTYPEMANIPULATION
from PREVISION_STAT_ACTIVITE_LIBCPL
WHERE TYPESAISIE = 'TSAI002'
GROUP BY extract(month from DATY), extract(year from DATY), IDTYPEMANIPULATIONLIB,IDTYPEMANIPULATION;--3

create or replace view PREVISION_STAT_ACTIV_MICTSL AS
select extract(month from DATY)                                 as mois,
       extract(year from DATY)                                  as annee,
       sum(PLEIN20PIEDS) + sum(VIDE20PIEDS) + sum(PLEIN40PIEDS) as somme_plein20_vide20_plein40,
       IDTYPEMANIPULATIONLIB,IDTYPEMANIPULATION
from PREVISION_STAT_ACTIVITE_LIBCPL
WHERE TYPESAISIE = 'TSAI001'
GROUP BY extract(month from DATY), extract(year from DATY), IDTYPEMANIPULATIONLIB,IDTYPEMANIPULATION;

create OR REPLACE view STATISTIQUEACTIVITE_MICTSL as
select extract(month from DATY)                                 as mois,
       extract(year from DATY)                                  as annee,
       sum(PLEIN20PIEDS) + sum(VIDE20PIEDS) + sum(PLEIN40PIEDS) as somme_plein20_vide20_plein40,
       IDTYPEACTIONCONTENEUR,
       IDTYPEACTIONCONTENEURLIB
from STATISTIQUEACTIVITE_LIBCOMPLET
WHERE TYPESAISIE = 'TSAI001'
GROUP BY extract(month from DATY), extract(year from DATY), IDTYPEACTIONCONTENEUR, IDTYPEACTIONCONTENEURLIB;


CREATE OR REPLACE VIEW STATISTIQUEACTIVITE_MICTSL_GR
            (MOIS, moislib,ANNEE, IDTYPEACTIONCONTENEURLIB, IDTYPEACTIONCONTENEUR, SOMME_PLEIN20_VIDE20_PLEIN40) AS
select nvl(m.mois, mo.ID)                                            as mois,
      nvl(mo.VAL, mo.val)                                            as mois,
       nvl(m.annee, 0)                                               as annee,
       cast(nvl(IDTYPEACTIONCONTENEURLIB, '-') as varchar2(500)) as IDTYPEACTIONCONTENEURLIB,
       cast(nvl(IDTYPEACTIONCONTENEUR, '-') as varchar2(500))     as IDTYPEACTIONCONTENEUR,
       cast(nvl(m.somme_plein20_vide20_plein40, 0) as number(20, 2)) as somme_plein20_vide20_plein40
from STATISTIQUEACTIVITE_MICTSL m
          join mois mo on mo.id = m.MOIS;

create or replace view STATISTIQUEACTIVITE_NMICTSL_GR as
select nvl(m.mois, mo.ID)                                     as mois,
       (m.annee)                                        as annee,
       cast(nvl(IDTYPEMANIPULATIONLIB, '-') as varchar2(500)) as IDTYPEMANIPULATIONLIB,
       cast(nvl(IDTYPEMANIPULATION, '-') as varchar2(500))    as IDTYPEMANIPULATION,
       cast(nvl(m.NOMBREUNITE, 0) as number(20, 2))           as NOMBREUNITE
from STATISTIQUEACTIVITE_NONMICTSL m
          join mois mo on mo.id = m.MOIS
/

create or replace view STATISTIQUEACTIVITE_NMICTSL_GR as
select nvl(m.mois, mo.ID)                                     as mois,
       nvl(mo.VAL,'-')                                     as moislib,
       (m.annee)                                        as annee,
       cast(nvl(IDTYPEMANIPULATIONLIB, '-') as varchar2(500)) as IDTYPEMANIPULATIONLIB,
       cast(nvl(IDTYPEMANIPULATION, '-') as varchar2(500))    as IDTYPEMANIPULATION,
       cast(nvl(m.NOMBREUNITE, 0) as number(20, 2))           as NOMBREUNITE
from STATISTIQUEACTIVITE_NONMICTSL m
          join mois mo on mo.id = m.MOIS
/




CREATE OR REPLACE FORCE VIEW STATISTIQUEACTIVITE_MICTSL
(
   MOIS,
   ANNEE,
   SOMME_PLEIN20_VIDE20_PLEIN40,
   IDTYPEACTIONCONTENEUR,
   IDTYPEACTIONCONTENEURLIB
)
AS
     SELECT EXTRACT (MONTH FROM DATY) AS mois,
            EXTRACT (YEAR FROM DATY) AS annee,
            SUM (PLEIN20PIEDS) + SUM (VIDE20PIEDS) + SUM (PLEIN40PIEDS) + SUM(VIDE40PIEDS)
               AS somme_plein20_vide20_plein40,
            IDTYPEACTIONCONTENEUR,
            IDTYPEACTIONCONTENEURLIB
       FROM STATISTIQUEACTIVITE_LIBCOMPLET
      WHERE TYPESAISIE = 'TSAI001'
   GROUP BY EXTRACT (MONTH FROM DATY),
            EXTRACT (YEAR FROM DATY),
            IDTYPEACTIONCONTENEUR,
            IDTYPEACTIONCONTENEURLIB;