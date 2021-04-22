******************************* SPAT_CAPITAINERIE *******************************

create table typecheque(
    id varchar2(50),
    val varchar2(500),
    desce varchar2(500),
    constraint PK_TYPECHEQUE primary key (id)
);

CREATE SEQUENCE seqtypecheque
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQtypecheque
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqtypecheque.nextval INTO retour FROM dual;
  return retour;
END;

alter table journalcaisse
    add (
        tiers varchar2(200),
        idtypecheque varchar2(50),
        constraint FK_TYPECAISSEJC  foreign key (idtypecheque) references typecheque (id)
    );
	
insert into typecheque (id,val,desce) values ('TCHQ00001','Au comptant','Au comptant');
insert into typecheque (id,val,desce) values ('TCHQ00002','&Agrave; cr&eacute;dit','&Agrave; cr&eacute;dit');

create table pourcentageprojet(
    id varchar2(50),
    idchantier varchar2(50),
    daty date,
    pourcentage number(10,2),
    observation varchar2(500),
    idutilisateur varchar2(50),
    etat number(10),
    constraint PK_POURCENTAGEPROJET primary key (id),
    constraint FK_IDCHANTIERPOURCPROJET foreign key (idchantier) references chantier (id)
);

CREATE SEQUENCE seqpourcentageprojet
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQpourcentageprojet
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqpourcentageprojet.nextval INTO retour FROM dual;
  return retour;
END;

create or replace view pourcentageprojetlibcomplet as
    select
        pp.*,
        ch.idtravaux, nom, datydebut, datyfin, montant, avancement, idtiers, ch.etat as etatchantier, nomtiers, desctiers, nif, stat, contact, responsable, adresse, type, etattiers, nomtravaux, datedebuttravaux, datefintravaux, montanttravaux, avancementtravaux, desctravaux, etattravaux, idtypetravaux, valtypetravaux, descetypetravaux,
        u.REFUSER, LOGINUSER, PWDUSER, NOMUSER, ADRUSER, TELUSER, IDROLE
    from pourcentageprojet pp
        join chantierlibcomplet ch on ch.id = pp.idchantier
        join utilisateur u on to_char(u.refuser) = pp.idutilisateur;
		
create or replace view pourcentageprojetlib as
    select
        id,
        nom as idchantier,
        daty,
        pourcentage,
        observation,
        nomuser as idutilisateur,
        etat
    from pourcentageprojetlibcomplet;
	
create or replace view pourcentageprojetlibcree as
    select * from pourcentageprojetlib where etat = 1;
	
create or replace view pourcentageprojetlibvalide as
    select * from pourcentageprojetlib where etat = 11;
	
create or replace view JOURNALCAISSELIBCOMPLET as
    select
        j.*,
        c.ID as idcaisse, c.val as valcaisse, c.desce as descecaisse,
        tc.val as valtypecheque, tc.desce as descetypecheque
    from Journalcaisse j
        join CAISSE C on j.CAISSE = C.ID
        join TYPECHEQUE tc on tc.id = j.idtypecheque;
		
create or replace view JOURNALCAISSELIB as
    select
        id,
        datesaisie,
        dateeffet,
        folio,
        valcaisse as caisse,
        numpiece,
        libelle,
        debit,
        credit,
        remarque,
        etat,
        tiers,
        valtypecheque as idtypecheque
    from journalcaisselibcomplet;
	
create or replace view journalcaissebanquelib as
    select
        jc.id,
        jc.datesaisie,
        jc.dateeffet,
        jc.folio,
        jc.valcaisse as caisse,
        jc.numpiece,
        jc.libelle,
        jc.debit,
        jc.credit,
        jc.remarque,
        jc.etat,
        jc.tiers,
        jc.valtypecheque as idtypecheque
    from journalcaisselibcomplet jc
        join CAISSE_BANQUE cb on cb.id = jc.caisse;
		
alter table travaux
    add (
        iddevise varchar2(50)
    );
	
create or replace view TRAVAUXLIBCOMPLET as
	select
		t."ID",t."NOM",t."DATEDEBUT",t."DATEFIN",t."MONTANT",t."AVANCEMENT",t."DESCRIPTION",t."ETAT",t."IDTYPETRAVAUX",
		typet.VAL as valtypetravaux, typet.DESCE as descetypetravaux,
		devise.VAL as valdevise, devise.desce as descedevise
	from travaux t
			 join TYPETRAVAUX typet on t.IDTYPETRAVAUX = typet.ID
			 join devisedemat devise on devise.id = t.iddevise;
			 
create or replace view TRAVAUXLIB as
    select
        id, nom, datedebut, datefin, montant, avancement, description, etat, valtypetravaux as idtypetravaux, valdevise as iddevise
    from TRAVAUXLIBCOMPLET;
	
create table type_renseignement_interne(
    id varchar2(50),
    val varchar2(500),
    desce varchar2(500),
    constraint PK_TYPERENSINT primary key (id)
);

CREATE SEQUENCE seqtype_renseignement_interne
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 7
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQtype_rens_interne
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqtype_renseignement_interne.nextval INTO retour FROM dual;
  return retour;
END;

insert into type_renseignement_interne (id,val,desce) values ('TRI00001','Gratification honorifique','Gratification honorifique');
insert into type_renseignement_interne (id,val,desce) values ('TRI00002','Sanction','Sanction');
insert into type_renseignement_interne (id,val,desce) values ('TRI00003','Fonction interne','Fonction interne');
insert into type_renseignement_interne (id,val,desce) values ('TRI00004','Changement de fonction','Changement de fonction');
insert into type_renseignement_interne (id,val,desce) values ('TRI00005','Mutation','Mutation');
insert into type_renseignement_interne (id,val,desce) values ('TRI00006','Promotion','Promotion');
	
create or replace view RENSEIGNEMENT_INT_LIBCOMPLET as
    select
        rens.id as idrenseignement, idpersonnel, libelle, type, daty, observation,
        info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email,
        type.val as valtype_rens_interne, type.desce as descetype_rens_interne
    from RENSEIGNEMENT_INTERNE rens
        join v_union_personnel info on rens.IDPERSONNEL = info.ID
        join TYPE_RENSEIGNEMENT_INTERNE type on type.id = rens.TYPE;
		
create or replace view RENSEIGNEMENT_INTERNE_LIB as
    select
        idrenseignement as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        libelle,
        valtype_rens_interne as type,
        daty,
        observation
    from renseignement_int_libcomplet;
	
insert into MENUDYNAMIQUE (id, libelle, icone, href, rang, niveau, id_pere) values ('MEN00101','Analyse trésorerie','fa fa-line-chart','/spat/pages/globalnegoce.jsp?but=treso/analyse-recap-treso.jsp',2,3,'MEN0021');
insert into MENUDYNAMIQUE (id, libelle, icone, href, rang, niveau, id_pere) values ('MEN00102','Analyse lien','fa fa-line-chart','/spat/pages/globalnegoce.jsp?but=analyse_lien/analyselien-liste.jsp',6,2,'MENP007');

insert into MENUDYNAMIQUE (id, libelle, icone, href, rang, niveau, id_pere) values ('MEN00103','Configuration','fa fa-cog','#',3,4,'MEN00174P');
insert into MENUDYNAMIQUE (id, libelle, icone, href, rang, niveau, id_pere) values ('MEN00104','Type ch&egrave;que','fa fa-euro','/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=typecheque',1,5,'MEN00103');

create or replace view journalcaissebanquelibcree as
    select * from journalcaissebanquelib where etat = 1;
	
create or replace view journalcaissebanquelibvalide as
    select * from journalcaissebanquelib where etat = 11;
	
******************************* SPAT_ANCIEN_FINANCE *******************************

create table categoriefacture(
    id varchar2(50),
    val varchar2(500),
    desce varchar2(500),
    constraint PK_CATFACTURE primary key (id)
);

CREATE SEQUENCE seqcategoriefacture
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 7
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQcategoriefacture
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqcategoriefacture.nextval INTO retour FROM dual;
  return retour;
END;

insert into categoriefacture (id,val,desce) values ('CATFACT000001','Redevances (produits de convention)','Redevances (produits de convention)');
insert into categoriefacture (id,val,desce) values ('CATFACT000002','Droits de port','Droits de port');
insert into categoriefacture (id,val,desce) values ('CATFACT000003','Capitainerie','Capitainerie');
insert into categoriefacture (id,val,desce) values ('CATFACT000004','Produits connexes','Produits connexes');
insert into categoriefacture (id,val,desce) values ('CATFACT000005','Remises accordées à MICTSL','Remises accordées à MICTSL');
insert into categoriefacture (id,val,desce) values ('CATFACT000006','Avoirs externes','Avoirs externes');

create table cdcattarifcategoriefacture(
    idcategorietarif varchar2(50),
    cdcattarif varchar2(50),
    constraint FK_IDCATTARIF foreign key (idcategorietarif) references categoriefacture (id)
);

insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000001','0075');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000001','0070');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000001','0045');

insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000002','0036');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000002','0084');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000002','0001');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000002','0002');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000002','0051');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000002','0062');

insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000003','0042');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000003','0039');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000003','0040');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000003','0057');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000003','0053');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000003','0055');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000003','0059');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000003','0060');

insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0048');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0061');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0044');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0049');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0080');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0007');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0067');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0047');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0006');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0047');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0088');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0068');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0046');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0064');
insert into cdcattarifcategoriefacture (idcategorietarif,cdcattarif) values ('CATFACT000004','0066');

create or replace view ANALYSEFACTURECONVENTIONNEL as
    select
        fact.nmfact,
        fact.dtfact as daty,
        catfact.val as categorie_facture,
        ' ' as sous_categorie_facture,
        cli.nomclt as client,
        cli.valtype_fact_cat_client as categorie_client,
        fact.noteexpl as designation,
        cast(fact.mtttva as number(18,3)) as mttc,
        cast(fact.mtthtva as number(18,3)) as mtht,
        cast(fact.taxe as number(18,3)) taxe,
        monn.abgmonn as devfact,
        cast(fact.mttdevise as number(18,3)) as mtdevise,
        0 as mtavoir,
        cast((fact.mtttva - fact.rstapayer) as number(18,3)) as paye,
        cast(fact.rstapayer as number(18,3)) as reste,
        fact.nmcptgen as numCompte,
        cast(cli.FAXCLT as varchar2(500)) as valcat
      from db2010.facture fact
        join db2010.monnaie monn on fact.cdmonn = monn.cdmonn
        join db2010.factprt prt on prt.nmfact = fact.nmfact
        join db2010.tarif tarif on tarif.cdtarif = prt.cdtarif
        join db2010.dosclt dos on dos.cddosclt = fact.cddosclt
        join spat_capitainerie.cltfactclientlibcomplet cli on cli.IDCLIENT = dos.cdclt
        join cdcattarifcategoriefacture cdcatfact on cdcatfact.cdcattarif = tarif.cdcattarif
        join categoriefacture catfact on catfact.id = cdcatfact.idcategorietarif
      where fact.nmfact not like '5%';

******************************* SPAT_CAPITAINERIE *******************************

drop materialized view ANALYSEFACTURECONVENTIONNEL;

create materialized view ANALYSEFACTURECONVENTIONNEL
    refresh force on demand
as
SELECT * FROM spat_ancien_finance.ANALYSEFACTURECONVENTIONNEL;

drop materialized view ANALYSEGLOBALEFACTURE;

create materialized view ANALYSEGLOBALEFACTURE
    refresh force on demand
as
SELECT * FROM spat_ancien_finance.ANALYSEGLOBALEFACTURE;