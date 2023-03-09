create or replace view PREVISIONLIBCOMPLET  ("ID", "DATE_RADE", "PROVENANCE", "NAVIRE", "CONSIGNATAIRE", "CARGAISON", "PILOTE", "DATE_ARRIVEE",
             "HEURE_ARRIVEE", "DATE_DEPART", "HEURE_DEPART", "DESTINATION", "ETAT", "QUAIPROVENANCE",
             "VALQUAISPROVENANCE", "PAYSPROVENANCE", "VALPAYSPROVENANCE", "QUAIDESTINATION", "VALQUAISDESTINATION",
             "PAYSDESTINATION", "VALPAYSDESTINATION", "INTERNEPOVENANCE", "LONGUEURPROVENANCE", "TIRANTPROVENANCE",
             "PROFONDEURPROVENANCE", "REFERENCENAVIRE", "NOMNAVIRE", "PAVILLONNAVIRE", "JNTNAVIRE", "JBTNAVIRE",
             "PLTNAVIRE", "LHTNAVIRE", "LMNAVIRE", "TENAVIRE", "VOLUMENAVIRE", "REMARQUENAVIRE", "ETATNAVIRE",
             "VALCONSIGNATAIRE", "DESCECONSIGNATAIRE", "VALCARGAISON", "DESCECARGAISON", "VALPILOTE", "DESCEPILOTE",
             "INTERNEDESTINATION", "LONGUEURDESTINATION", "TIRANTDESTINATION", "PROFONDEURDESTINATION",
             "DESCEPROVENANCE", "DESCEDESTINATION", "VALTYPEQUAISPROVENANCE", "DESCETYPEQUAISPROVENANCE",
             "VALTYPEQUAISDESTINATION", "DESCETYPEQUAISDESTINATION", "DESCEQUAISPROVENANCE", "DESCEQUAISDESTINATION",
             "TYPEQUAISPROVENANCE", "TYPEQUAISDESTINATION",typenavire,typenavirelib) as
select pre.ID,
       pre.date_rade,
       pre.provenance,
       pre.navire,
       pre.consignataire,
       pre.cargaison,
       pre.pilote,
       pre.date_arrivee,
       pre.heure_arrivee,
       pre.date_depart,
       pre.heure_depart,
       pre.destination,
       pre.etat,
       pro.QUAI      as QUAIPROVENANCE,
       q.VAL         as valquaisprovenance,
       q.PAYS        as paysprovenance,
       pa.VAL        as valpaysprovenance,
       pr.QUAI       as QUAIDESTINATION,
       q1.val        as valquaisdestination,
       q1.PAYS       as paysdestination,
       pa1.VAL       as valpaysdestination,
       pro.INTERNE   AS INTERNEPOVENANCE,
       q.LONGUEUR    as longueurprovenance,
       q.TIRANT      as tirantprovenance,
       q.PROFONDEUR  as profondeurprovenance,
       na.REFERENCE  as referencenavire,
       na.NOM        as nomnavire,
       na.PAVILLON   as pavillonnavire,
       na.JNT        as jntnavire,
       na.JBT        as jbtnavire,
       na.PLT        as pltnavire,
       na.LHT        as lhtnavire,
       na.LM         as lmnavire,
       na.TE         as tenavire,
       na.VOLUME     as volumenavire,
       na.REMARQUE   as remarquenavire,
       na.ETAT       as etatnavire,
       con.NOMCLT    as valconsignataire,
       con.ADRCLT    as desceconsignataire,
       car.VAL       as valcargaison,
       car.DESCE     as descecargaison,
       pi.VAL        as valpilote,
       pi.DESCE      as descepilote,
       pr.INTERNE    AS INTERNEDESTINATION,
       q1.LONGUEUR   as longueurdestination,
       q1.TIRANT     as tirantdestination,
       q1.PROFONDEUR as profondeurdestination,
       pa.DESCE      as desceprovenance,
       pa1.DESCE     as descedestination,
       t.VAL         as valtypequaisprovenance,
       t.DESCE       as descetypequaisprovenance,
       t2.val        as valtypequaisdestination,
       t2.DESCE      as descetypequaisdestination,
       q.DESCE       as descequaisprovenance,
       q1.DESCE      as descequaisdestination,
       q.TYPEQUAIS   as typequaisprovenance,
       q1.TYPEQUAIS  as typequaisdestination,
       na.TYPE       as typenavire,
       tn.VAL        as typenavirelib
from prevision pre
         left join POSTEDESTINATAIRE pro on pro.id = pre.PROVENANCE
         join NAVIRE na on na.id = pre.NAVIRE
         left join CONSIGNATAIREMAT con on con.CDCLT = pre.CONSIGNATAIRE
         join CARGAISON car on car.id = pre.CARGAISON
         join pilote pi on pi.ID = pre.PILOTE
         left join POSTEDESTINATAIRE pr ON pr.ID = pre.DESTINATION
         left join QUAIS q on q.id = pro.QUAI
         left join QUAIS q1 on q1.id = pr.QUAI
         left join PAYS pa on pa.id = q.PAYS
         left join PAYS pa1 on pa1.id = q1.PAYS
         left JOIN TYPEQUAIS T on q.TYPEQUAIS = T.ID
         left JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
         left join TYPENAVIRE tn on tn.id = na.TYPE
/


create or replace view PREVISIONFICHE as
select id
     , nomnavire
     , valconsignataire
     , valcargaison
     , valpilote
     , valquaisprovenance
     , valpaysprovenance
     , valquaisdestination
     , valpaysdestination
     , date_arrivee
     , heure_arrivee
     , date_depart
     , heure_depart
     , etat
     , typenavirelib as type
from previsionLibComplet
/