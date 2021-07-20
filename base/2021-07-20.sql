CREATE OR REPLACE VIEW OCCUPMATERIELNAVALLIB
            (ID, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, IDNAVIRE, POSITION,
             OBSERVATION, ETAT, IDARRIVEE, IDARRIVEELIB, POSITIONLIB, DUREE, DATY, HEUREDEBUT, DATEFIN, HEUREFIN,
             ETATLIB, IDPREVISION, COMMANDANTID, IDACTIVITE, stFacture)
AS
select oc.id,
       oc.denomination       as idmateriel_naval,
       oc.valpilote          as idpilote,
       oc.valcommandant      as idcommandant,
       oc.valnatureoperation as idnatureoperation,
       oc.valmanoeuvrebord   as idmanoeuvrebord,
       oc.nomnavire          as idnavire,
       oc.position,
       oc.observation,
       oc.etat,
       oc.IDARRIVEE,
       oc.IDARRIVEELIB,
       oc.positionlib,
       oc.duree,
       oc.daty,
       oc.heuredebut,
       oc.datefin,
       oc.heurefin,
       oc.etatlib,
       oc.IDPREVISION,
       oc.IDCOMMANDANT       AS COMMANDANTID,
       ac.id as  IDACTIVITE,
       case
           when fc.id is not null then 'OUI'
           else 'NON' end    as estFacture
from OCCUPMATERIELNAVALLIBCOMPLET oc
        left join ACTIVITE ac on ac.REFOBJET=oc.id and ac.ETAT>=11
         left join factureFilleActivitePrestation fc on fc.idprestation = oc.id
order by DATY desc;


CREATE OR REPLACE VIEW OCCUPMATERIELNAVALLIB
            (ID, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, IDNAVIRE, POSITION,
             OBSERVATION, ETAT, IDARRIVEE, IDARRIVEELIB, POSITIONLIB, DUREE, DATY, HEUREDEBUT, DATEFIN, HEUREFIN,
             ETATLIB, IDPREVISION, COMMANDANTID, IDACTIVITE, estFacture)
AS
select oc.id,
       oc.denomination       as idmateriel_naval,
       oc.valpilote          as idpilote,
       oc.valcommandant      as idcommandant,
       oc.valnatureoperation as idnatureoperation,
       oc.valmanoeuvrebord   as idmanoeuvrebord,
       oc.nomnavire          as idnavire,
       oc.position,
       oc.observation,
       oc.etat,
       oc.IDARRIVEE,
       oc.IDARRIVEELIB,
       oc.positionlib,
       oc.duree,
       oc.daty,
       oc.heuredebut,
       oc.datefin,
       oc.heurefin,
       oc.etatlib,
       oc.IDPREVISION,
       oc.IDCOMMANDANT       AS COMMANDANTID,
       ac.id as  IDACTIVITE,
       case
           when fc.id is not null then 'OUI'
           else 'NON' end    as estFacture
from OCCUPMATERIELNAVALLIBCOMPLET oc
        left join ACTIVITE ac on ac.REFOBJET=oc.id and ac.ETAT>=11
         left join factureFilleActivitePrestation fc on fc.idprestation = oc.id
order by DATY desc;

create view OCCUPMATERIELNONAVALNFACTURE AS select *
From OCCUPMATERIELNAVALLIBV where ID not in (select id from OCCUPATIONMATERIELNAVALFAC
