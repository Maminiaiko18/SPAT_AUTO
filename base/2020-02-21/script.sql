UPDATE MENUDYNAMIQUE SET HREF='/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=type_materiel&value=Type Materiel' WHERE ID='MEN0072';
UPDATE ETATPATRIMOINE t SET t."VAL" = 'Bon etat', t."DESCE" = 'Bon etat' WHERE t."ID" LIKE 'ETAT000001';

alter table navire add etat number(10);
update navire set etat=1;

create or replace view NAVIRELIBCOMPLET as
select
        nav."ID",nav."REFERENCE",nav."NOM",nav."PAVILLON",nav."JNT",nav."JBT",nav."PLT",nav."LHT",nav."LM",nav."TE",nav."VOLUME",nav."REMARQUE",nav.ETAT,
        p.val as valpavillon, p.DESCE as descepavillon
    from navire nav
        join PAYS p on p.id = nav.PAVILLON;
		
create or replace view NAVIRELIB as
select
        id, reference, nom,
        valpavillon as pavillon,
        JNT, JBT, PLT, LHT, LM, TE, VOLUME, REMARQUE,
        etat
    from navirelibcomplet;
	
	create or replace view MOUVEMENTLIBELLECOMPLET as
select m.id,
       m.daty,
       m.escale,
       m.navire,
       m.consignataire,
       m.datearrivee,
       m.heure,
       m.provenance,
       m.destination,
       m.remarque,
       m.duree,
       m.CARGAISON,
       m.DATE_DEPART,
       m.HEURE_DEPART,
       tm.VAL          as typemvt,
       m.etat,
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
       n1.ETAT          as etatNavire,
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
       m.typemvt       as idtypemvt,
       q1.id           as idquaiPROVENANCE,
       q2.id           as idquaiDESTINATION,
       carg.val        as cargval,
       carg.val        as cargdesce,
       tpq1.id         as idtypequaiPROVENANCE,
       tpq1.val        as typequaiPROVENANCE,
       tpq2.id         as idtypequaiDESTINATION,
       tpq2.val        as typequaiDESTINATION
from MOUVEMENT m
         join NAVIRE n1 on n1.id = m.NAVIRE
         join clientmat C2 on m.CONSIGNATAIRE = C2.cdclt
         join POSTEDESTINATAIRE prov on prov.id = m.PROVENANCE
         join POSTEDESTINATAIRE dest on dest.id = m.DESTINATION
         join pays p1 on prov.PAYS = p1.ID
         join pays p2 on dest.PAYS = p2.ID
         join QUAIS q1 on q1.id = prov.QUAI
         join TYPEQUAIS tpq1 on tpq1.ID = q1.TYPEQUAIS
         join QUAIS q2 on q2.id = dest.QUAI
         join TYPEQUAIS tpq2 on tpq2.ID = q2.TYPEQUAIS
         join TYPEMVT tm on tm.id = m.TYPEMVT
         join pays p3 on p3.id = n1.pavillon
         join CARGAISON carg on carg.id = m.CARGAISON;
		 
		 
create or replace view V_MOUVEMENTLIB as
select
        id,
        daty,
        escale,
        nomnavire as navire,
        valCONSIGNATAIRE as consignataire,
        datearrivee,
        heure,
        quaiPROVENANCE as provenance,
        quaiDESTINATION as destination,
        remarque,
        duree,
        typemvt,
        etat,
        cargval as cargaison,
        heure_depart,
        date_depart,
        etatNavire
    from MOUVEMENTLIBELLECOMPLET;
	
create or replace view PREVISIONLIBELLECOMPLET as
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
    join NAVIRE n1 on n1.id = prev.NAVIRE
    join PILOTE plt on plt.id = prev.PILOTE
    join clientmat C2 on prev.CONSIGNATAIRE = C2.CDCLT
    join POSTEDESTINATAIRE prov on prov.id = prev.PROVENANCE
    join POSTEDESTINATAIRE dest on dest.id = prev.DESTINATION
    join pays p1 on prov.PAYS = p1.ID
    join pays p2 on dest.PAYS = p2.ID
    join QUAIS q1 on q1.id = prov.QUAI
    join TYPEQUAIS tpq1 on tpq1.ID = q1.TYPEQUAIS
    join QUAIS q2 on q2.id = dest.QUAI
    join TYPEQUAIS tpq2 on tpq2.ID = q2.TYPEQUAIS
    join pays p3 on p3.id = n1.pavillon
    join CARGAISON carg on carg.id = prev.CARGAISON;
	
	
create or replace view patrimoinelibbonetat as
    select
            pat.*
           from patrimoinelib pat
            where pat.etat='Bon etat';

create or replace view patrimoinelibdegrade as
    select
            pat.*
           from patrimoinelib pat
            where pat.etat='Degrade';


create or replace view patrimoinelibencoursrep as
    select
            pat.*
           from patrimoinelib pat
            where pat.etat='En cours de reparation';

create or replace view patrimoinelibusee as
    select
            pat.*
           from patrimoinelib pat
            where pat.etat='Usee';
			
create or replace view historiquesyndicatlibCree as
    select
        *from historiquesyndicatlib
        where ETAT=1;

create or replace view historiquesyndicatlibValide as
    select
        *from historiquesyndicatlib
        where ETAT=11;
		
 create table historique_valeur(
        id varchar2(100),
        idhisto varchar2(100) constraint historique_vak_fk references HISTORIQUE,
        refhisto varchar2(100),
        nom_table varchar2(100),
        nom_classe varchar2(100),
        val1 varchar2(100),
        val2 varchar2(100),
        val3 varchar2(100),
        val4 varchar2(100),
         val5 varchar2(100),
          val6 varchar2(100),
          val7 varchar2(100),
          val8 varchar2(100),
          val9 varchar2(100),
           val10 varchar2(100),
            val11 varchar2(100),
            val12 varchar2(100),
             val13 varchar2(100),
              val14 varchar2(100),
              val15 varchar2(100),
               val16 varchar2(100),
                val17 varchar2(100),
                 val18 varchar2(100),
                  val19 varchar2(1000),
                   val20 varchar2(100),
                val21 varchar2(100),
                 val22 varchar2(100),
                  val23 varchar2(100),
                   val24 varchar2(100),
                    val25 varchar2(100),
                     val26 varchar2(100),
                      val27 varchar2(100),
                       val28 varchar2(100),
                        val29 varchar2(100),
                         val30 varchar2(100),
                          val31 varchar2(100), val32 varchar2(100),
                           val33 varchar2(100),
                            val34 varchar2(100),
                             val35 varchar2(100),
                              val36 varchar2(100),
                               val37 varchar2(100),
                                val38 varchar2(100),
                                 val39 varchar2(100),
                                  val40 varchar2(100),
        ipuser varchar2(100)
    );
	
create or replace view CONGE_LIBCOMPLET as
	select
        cong.ID as idconge, IDPERSONNEL, DISPONIBILITE, DATE_DEBUT_CONGE, DATE_FIN_CONGE, NOMBRE, etat,
        info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email
    from conge cong
        join v_union_personnel info on cong.IDPERSONNEL = info.ID;

create or replace view CONGE_LIB as
	select
        idconge as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        DISPONIBILITE, DATE_DEBUT_CONGE, DATE_FIN_CONGE, NOMBRE, etat
    from conge_libcomplet;