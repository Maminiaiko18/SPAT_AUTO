UPDATE prevision SET pilote = NULL WHERE pilote IS NOT null;
  alter table prevision drop constraint SYS_C0042620;
  alter table prevision add  constraint  fk_commandant foreign key(pilote)  references commandant;
alter table mouvement add  constraint  fk_prevision foreign key(escale)  references prevision;
  
  
  CREATE OR REPLACE  VIEW PREVISIONLIBCOMPLET (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE, VALPAYSPROVENANCE, QUAIDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION, INTERNEPOVENANCE, LONGUEURPROVENANCE, TIRANTPROVENANCE, PROFONDEURPROVENANCE, REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, VALCARGAISON, DESCECARGAISON, VALPILOTE, DESCEPILOTE, INTERNEDESTINATION, LONGUEURDESTINATION, TIRANTDESTINATION, PROFONDEURDESTINATION, DESCEPROVENANCE, DESCEDESTINATION, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, DESCEQUAISPROVENANCE, DESCEQUAISDESTINATION, TYPEQUAISPROVENANCE, TYPEQUAISDESTINATION, TYPENAVIRE, TYPENAVIRELIB, ESCALE) AS 
  SELECT pre.ID,
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
          pro.QUAI AS QUAIPROVENANCE,
          q.VAL AS valquaisprovenance,
          q.PAYS AS paysprovenance,
          pa.VAL AS valpaysprovenance,
          pr.QUAI AS QUAIDESTINATION,
          q1.val AS valquaisdestination,
          q1.PAYS AS paysdestination,
          pa1.VAL AS valpaysdestination,
          pro.INTERNE AS INTERNEPOVENANCE,
          q.LONGUEUR AS longueurprovenance,
          q.TIRANT AS tirantprovenance,
          q.PROFONDEUR AS profondeurprovenance,
          na.REFERENCE AS referencenavire,
          na.NOM AS nomnavire,
          na.PAVILLON AS pavillonnavire,
          na.JNT AS jntnavire,
          na.JBT AS jbtnavire,
          na.PLT AS pltnavire,
          na.LHT AS lhtnavire,
          na.LM AS lmnavire,
          na.TE AS tenavire,
          na.VOLUME AS volumenavire,
          na.REMARQUE AS remarquenavire,
          na.ETAT AS etatnavire,
          con.NOMCLT AS valconsignataire,
          con.ADRCLT AS desceconsignataire,
          car.VAL AS valcargaison,
          car.DESCE AS descecargaison,
          pi.VAL AS valpilote,
          pi.DESCE AS descepilote,
          pr.INTERNE AS INTERNEDESTINATION,
          q1.LONGUEUR AS longueurdestination,
          q1.TIRANT AS tirantdestination,
          q1.PROFONDEUR AS profondeurdestination,
          pa.DESCE AS desceprovenance,
          pa1.DESCE AS descedestination,
          t.VAL AS valtypequaisprovenance,
          t.DESCE AS descetypequaisprovenance,
          t2.val AS valtypequaisdestination,
          t2.DESCE AS descetypequaisdestination,
          q.DESCE AS descequaisprovenance,
          q1.DESCE AS descequaisdestination,
          q.TYPEQUAIS AS typequaisprovenance,
          q1.TYPEQUAIS AS typequaisdestination,
          na.TYPE AS typenavire,
          tn.VAL AS typenavirelib,
          pre.escale
     FROM prevision pre
          LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
          left JOIN NAVIRE na ON na.id = pre.NAVIRE
          LEFT JOIN CONSIGNATAIREMAT con ON con.CDCLT = pre.CONSIGNATAIRE
          left JOIN CARGAISON car ON car.id = pre.CARGAISON
          left JOIN commandant pi ON pi.ID = pre.PILOTE
          LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = pre.DESTINATION
          LEFT JOIN QUAIS q ON q.id = pro.QUAI
          LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
          LEFT JOIN PAYS pa ON pa.id = q.PAYS
          LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
          LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
          LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
          LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE;

 CREATE OR REPLACE  VIEW PREVISIONLIBELLECOMPLET (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIVRE, QUAIPROVENANCE, INTERNEPROVENANCE, PAYSPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE, TIRANTPROVENANCE, QUAIDESTINATION, INTERNEDESTINATION, PAYSDESTINATION, LONGUEURDESTINATION, PROFONDEURDESTINATION, TIRANTDESTINATION, IDQUAIPROVENANCE, IDQUAIDESTINATION, CARGVAL, CARGDESCE, IDTYPEQUAIPROVENANCE, TYPEQUAIPROVENANCE, IDTYPEQUAIDESTINATION, TYPEQUAIDESTINATION, IDPILOTE, VALPILOTE, DESCEPILOTE) AS 
  select
    prev.id,
    prev.DATE_RADE,
    prev.PROVENANCE,
    prev.NAVIRE,
    prev.CONSIGNATAIRE,
    prev.CARGAISON,
    prev.PILOTE,
    prev.DATE_ARRIVEE,
    prev.HEURE_ARRIVEE,
    prev.DATE_DEPART,
    prev.HEURE_DEPART,
    prev.DESTINATION,
    prev.etat,
    c2.nomclt          as valCONSIGNATAIRE,
    c2.nomclt        as desceCONSIGNATAIRE,
    n1.reference    as referenceNAVIRE,
    n1.nom          as nomNAVIRE,
    p3.VAL          as pavillonNAVIRE,
    n1.jnt          as jntNAVIRE,
    n1.jbt          as jbtNAVIRE,
    n1.plt          as pltNAVIRE,
    n1.lht          as lhtNAVIRE,
    n1.lm           as lmNAVIRE,
    n1.te           as teNAVIRE,
    n1.volume       as volumeNAVIRE,
    n1.remarque     as remarqueNAVIRE,
    n1.ETAT as etatNavivre,
    q1.VAL          as quaiPROVENANCE,
    prov.interne    as internePROVENANCE,
    p1.VAL          as paysPROVENANCE,
    prov.longueur   as longueurPROVENANCE,
    prov.profondeur as profondeurPROVENANCE,
    prov.tirant     as tirantPROVENANCE,
    q2.VAL          as quaiDESTINATION,
    dest.interne    as interneDESTINATION,
    p2.VAL          as paysDESTINATION,
    dest.longueur   as longueurDESTINATION,
    dest.profondeur as profondeurDESTINATION,
    dest.tirant     as tirantDESTINATION,
    q1.id           as idquaiPROVENANCE,
    q2.id           as idquaiDESTINATION,
    carg.val        as cargval,
    carg.val        as cargdesce,
    tpq1.id         as idtypequaiPROVENANCE,
    tpq1.val        as typequaiPROVENANCE,
    tpq2.id         as idtypequaiDESTINATION,
    tpq2.val        as typequaiDESTINATION,
    plt.id          as idpilote,
    plt.val         as valpilote,
    plt.desce       as descepilote
from PREVISION prev
    left join NAVIRE n1 on n1.id = prev.NAVIRE
    left  join commandant plt on plt.id = prev.PILOTE
    left join clientmat C2 on prev.CONSIGNATAIRE = C2.CDCLT
    left join POSTEDESTINATAIRE prov on prov.id = prev.PROVENANCE
    left join POSTEDESTINATAIRE dest on dest.id = prev.DESTINATION
    left join pays p1 on prov.PAYS = p1.ID
    left join pays p2 on dest.PAYS = p2.ID
    left join QUAIS q1 on q1.id = prov.QUAI
    left join TYPEQUAIS tpq1 on tpq1.ID = q1.TYPEQUAIS
    left join QUAIS q2 on q2.id = dest.QUAI
    left join TYPEQUAIS tpq2 on tpq2.ID = q2.TYPEQUAIS
    left join pays p3 on p3.id = n1.pavillon
    left join CARGAISON carg on carg.id = prev.CARGAISON;


  CREATE OR REPLACE  VIEW PREVISIONLIBELLECOMPLET (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIVRE, QUAIPROVENANCE, INTERNEPROVENANCE, PAYSPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE, TIRANTPROVENANCE, QUAIDESTINATION, INTERNEDESTINATION, PAYSDESTINATION, LONGUEURDESTINATION, PROFONDEURDESTINATION, TIRANTDESTINATION, IDQUAIPROVENANCE, IDQUAIDESTINATION, CARGVAL, CARGDESCE, IDTYPEQUAIPROVENANCE, TYPEQUAIPROVENANCE, IDTYPEQUAIDESTINATION, TYPEQUAIDESTINATION, IDPILOTE, VALPILOTE, DESCEPILOTE) AS 
  select
    prev.id,
    prev.DATE_RADE,
    prev.PROVENANCE,
    prev.NAVIRE,
    prev.CONSIGNATAIRE,
    prev.CARGAISON,
    prev.PILOTE,
    prev.DATE_ARRIVEE,
    prev.HEURE_ARRIVEE,
    prev.DATE_DEPART,
    prev.HEURE_DEPART,
    prev.DESTINATION,
    prev.etat,
    c2.nomclt          as valCONSIGNATAIRE,
    c2.nomclt        as desceCONSIGNATAIRE,
    n1.reference    as referenceNAVIRE,
    n1.nom          as nomNAVIRE,
    p3.VAL          as pavillonNAVIRE,
    n1.jnt          as jntNAVIRE,
    n1.jbt          as jbtNAVIRE,
    n1.plt          as pltNAVIRE,
    n1.lht          as lhtNAVIRE,
    n1.lm           as lmNAVIRE,
    n1.te           as teNAVIRE,
    n1.volume       as volumeNAVIRE,
    n1.remarque     as remarqueNAVIRE,
    n1.ETAT as etatNavivre,
    q1.VAL          as quaiPROVENANCE,
    prov.interne    as internePROVENANCE,
    p1.VAL          as paysPROVENANCE,
    prov.longueur   as longueurPROVENANCE,
    prov.profondeur as profondeurPROVENANCE,
    prov.tirant     as tirantPROVENANCE,
    q2.VAL          as quaiDESTINATION,
    dest.interne    as interneDESTINATION,
    p2.VAL          as paysDESTINATION,
    dest.longueur   as longueurDESTINATION,
    dest.profondeur as profondeurDESTINATION,
    dest.tirant     as tirantDESTINATION,
    q1.id           as idquaiPROVENANCE,
    q2.id           as idquaiDESTINATION,
    carg.val        as cargval,
    carg.val        as cargdesce,
    tpq1.id         as idtypequaiPROVENANCE,
    tpq1.val        as typequaiPROVENANCE,
    tpq2.id         as idtypequaiDESTINATION,
    tpq2.val        as typequaiDESTINATION,
    plt.id          as idpilote,
    plt.val         as valpilote,
    plt.desce       as descepilote
from PREVISION prev
    left join NAVIRE n1 on n1.id = prev.NAVIRE
    left  join commandant plt on plt.id = prev.PILOTE
    left join clientmat C2 on prev.CONSIGNATAIRE = C2.CDCLT
    left join POSTEDESTINATAIRE prov on prov.id = prev.PROVENANCE
    left join POSTEDESTINATAIRE dest on dest.id = prev.DESTINATION
    left join pays p1 on prov.PAYS = p1.ID
    left join pays p2 on dest.PAYS = p2.ID
    left join QUAIS q1 on q1.id = prov.QUAI
    left join TYPEQUAIS tpq1 on tpq1.ID = q1.TYPEQUAIS
    left join QUAIS q2 on q2.id = dest.QUAI
    left join TYPEQUAIS tpq2 on tpq2.ID = q2.TYPEQUAIS
    left join pays p3 on p3.id = n1.pavillon
    left join CARGAISON carg on carg.id = prev.CARGAISON;

