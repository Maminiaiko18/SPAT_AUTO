******************* SPAT_CAPITAINERIE *******************

create table type_fact_cat_client(
    id varchar2(50),
    val varchar2(500),
    desce varchar2(500),
    constraint PK_TYPEFACT primary key (id)
);

CREATE SEQUENCE seqtype_fact_cat_client
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 4
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQtype_fact_cat_client
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqtype_fact_cat_client.nextval INTO retour FROM dual;
  return retour;
END;

create table client_fact_cat_client(
    id varchar2(50),
    idclient varchar2(50),
    idtype_fact_cat_client varchar2(50),
    statut number(10),
    constraint PK_CLIENTFACT primary key (id),
    constraint FK_IDTYPEFACT foreign key (idtype_fact_cat_client) references type_fact_cat_client(id)
);

CREATE SEQUENCE seqclient_fact_cat_client
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 36
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQclient_fact_cat_client
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqclient_fact_cat_client.nextval INTO retour FROM dual;
  return retour;
END;

ALTER TABLE contrat
ADD (
    typedroitport varchar2(500),
    redevance_domaniale number(10,2),
    redevance_locative number(10,2),
    pipeline number(10,2),
    typeduree varchar2(100)
);

insert into TYPE_FACT_CAT_CLIENT (id,val,desce) values ('TFCC000001','Concessionnaire','Concessionnaire');
insert into TYPE_FACT_CAT_CLIENT (id,val,desce) values ('TFCC000002','Permissionnaire','Permissionnaire');
insert into TYPE_FACT_CAT_CLIENT (id,val,desce) values ('TFCC000003','Autre','Autre');

insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00001','0120037','TFCC000001',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00002','0120047','TFCC000001',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00003','0120093','TFCC000001',0);

insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00004','0120067','TFCC000002',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00005','0120009','TFCC000002',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00006','0120001','TFCC000002',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00007','0120012','TFCC000002',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00008','0120010','TFCC000002',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00009','0120004','TFCC000002',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00010','0120083','TFCC000002',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00011','0120011','TFCC000002',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00012','0120098','TFCC000002',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00013','0120049','TFCC000002',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00014','0120352','TFCC000002',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00015','0120366','TFCC000002',0);

insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00016','0120331','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00017','0150007','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00018','0260136','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00019','0120003','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00020','0120029','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00021','0120012','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00022','0120008','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00023','0120285','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00024','0120243','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00025','0100024','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00026','0100019','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00027','0100042','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00028','1011320','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00029','0100198','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00030','0100054','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00031','0100230','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00032','0100224','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00033','0100268','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00034','0100293','TFCC000003',0);
insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00035','0100023','TFCC000003',0);

insert into client_fact_cat_client (id,idclient,idtype_fact_cat_client,statut) values ('CFCC00036','clt1','TFCC000001',0);

create table typedroitport(
    id varchar2(50),
    val varchar2(500),
    desce varchar2(500),
    constraint PK_TYPEDROITPORT primary key (id)
);

CREATE SEQUENCE seqtypedroitport
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 6
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQtypedroitport
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqtypedroitport.nextval INTO retour FROM dual;
  return retour;
END;

insert into typedroitport (id,val,desce) values ('TDP000001','&Agrave; l`import','&Agrave; l`import');
insert into typedroitport (id,val,desce) values ('TDP000002','&Agrave; l`export','&Agrave; l`export');
insert into typedroitport (id,val,desce) values ('TDP000003','Transbordement','Transbordement');
insert into typedroitport (id,val,desce) values ('TDP000004','Plein','Plein');
insert into typedroitport (id,val,desce) values ('TDP000005','Vide','Vide');

create table typeduree(
    id varchar2(50),
    val varchar2(500),
    desce varchar2(500),
    constraint PK_TYPEDUREE primary key (id)
);

CREATE SEQUENCE seqtypeduree
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 4
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQtypeduree
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqtypeduree.nextval INTO retour FROM dual;
  return retour;
END;

insert into typeduree (id,val,desce) values ('TPDUR000001','Semaine','Semaine');
insert into typeduree (id,val,desce) values ('TPDUR000002','Mois','Mois');
insert into typeduree (id,val,desce) values ('TPDUR000003','Annee','Annee');

create or replace view CONTRATLIBCOMPLET as
	select
        cont."ID",cont."IDTIERS",cont."DATE_SIGNATURE",cont."OBJET",cont."DEBUT_CONTRAT",cont."FIN_CONTRAT",cont."DUREE",cont."DROIT_ENTREE",cont."REDEVANCE_FIXE",cont."DEVISE",cont."REDEVANCE_VARIABLE",cont."UNITE",cont."DROIT_PORT",cont.TYPEDROITPORT,cont.REDEVANCE_DOMANIALE,cont.REDEVANCE_LOCATIVE,cont.PIPELINE,cont.TYPEDUREE,
        clt."CDCLT",clt."CDCAT",clt."NOMCLT",clt."ADRCLT",clt."NMSTTCLT",clt."TELCLT",clt."FAXCLT",clt."NMCIN",clt."NIF",clt."RC",
        unite.VAL as valunite, unite.DESCE as desceunite,
        tdp.id as idtypedroitport, tdp.VAL as valtypedroitport, tdp.desce as descetypedroitport,
        td.ID as idtypeduree, td.val as valtypeduree, td.DESCE as descetypeduree
    from contrat cont
        join SPAT_CAPITAINERIE.CLIENTMAT clt on clt.cdclt = cont.IDTIERS
        join UNITE unite on cont.UNITE = unite.ID
        join TYPEDROITPORT tdp on tdp.id=cont.TYPEDROITPORT
        join TYPEDUREE td on td.id=cont.TYPEDUREE;
		
create or replace view CONTRATLIB as
	select
        ID,
        NOMCLT as IDTIERS,
        DATE_SIGNATURE, OBJET, DEBUT_CONTRAT, FIN_CONTRAT, DUREE, DROIT_ENTREE, REDEVANCE_FIXE, DEVISE, REDEVANCE_VARIABLE,
        valunite as UNITE, DROIT_PORT, VALTYPEDROITPORT as TYPEDROITPORT, REDEVANCE_DOMANIALE, REDEVANCE_LOCATIVE, PIPELINE, VALTYPEDUREE as typeduree
    from CONTRATLIBCOMPLET;
	
create or replace view cltfactclientlibcomplet as
    select
        cltfact.*,
        clt.*,
        type.VAL as valtype_fact_cat_client, type.desce as descetype_fact_cat_client
    from CLIENT_FACT_CAT_CLIENT cltfact
        join SPAT_CAPITAINERIE.CLIENTMAT clt on clt.CDCLT=cltfact.IDCLIENT
        join TYPE_FACT_CAT_CLIENT type on type.id=cltfact.IDTYPE_FACT_CAT_CLIENT;
		
create or replace view cltfactclientlib as
    select
        id,
        NOMCLT as idclient,
        VALTYPE_FACT_CAT_CLIENT as idtype_fact_cat_client,
        STATUT
    from cltfactclientlibcomplet;
	
******************* SYS AS SYSDBA *******************

GRANT SELECT, INSERT, UPDATE, DELETE ON spat_capitainerie.cltfactclientlibcomplet TO spat_ancien_finance;

******************* SPAT_ANCIEN_FINANCE *******************

create or replace view ANALYSEFACTURECONCESSIONNAIRE as
select
    cast(mere.idfacturemere as varchar2(100)) as nmfact,
    mere.daty,
    case when cat.id = 'cat1' or cat.id = 'cat2' then 'Produit de convention' else  'Autres' end as categorie_facture,
    cast(scat.nomscatservice as varchar2(500)) as sous_categorie_facture,
    cast(cli.nom as varchar2(100)) as client,
    clt.valtype_fact_cat_client as categorie_client,
    cast(mere.noteexplicative as varchar2(500)) as designation,
    cast(mere.montantapayer as number(18,3)) as mttc,
    cast((mere.montantapayer / (1+(mere.idtva/100))) as number(18,3)) as mtht,
    cast((mere.montantapayer - (mere.montantapayer / (1+(mere.idtva/100)))) as number(18,3)) as taxe,
    mere.iddeviseen as devfact,
    cast(etat.idcourschange as number(18,3)) as mtdevise,
    cast(etat.avoir as number(18,3)) as mtavoir,
    cast(etat.paye as number(18,3)) as paye,
    cast((mere.montantapayer - etat.paye) as number(18,3)) as reste,
    cast('' as varchar2(100)) as numCompte,
    cast(clt.FAXCLT as varchar2(500)) as valcat
  from user2010.facturemere mere
    join user2010.client cli on mere.idclient = cli.idclient
    join user2010.etatfacturepaye etat on etat.idfacturemere = mere.idfacturemere
    join user2010.scatservice scat on scat.idscatservice = mere.idscatservice
    join user2010.categorie cat on cat.id = scat.idcategorie
    join spat_capitainerie.cltfactclientlibcomplet clt on clt.IDCLIENT = mere.idclient
  where mere.idfacturemere not like '5%';
  
create or replace view ANALYSEFACTURECONVENTIONNEL as
select
    fact.nmfact,
    fact.dtfact as daty,
    ' ' as categorie_facture,
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
  where fact.nmfact not like '5%';
  
create or replace view ANALYSEGLOBALEFACTURE as
select
    anal.nmfact,
    anal.daty,
    cast(anal.categorie_facture as varchar2(500)) as categorie_facture,
    cast(anal.sous_categorie_facture as varchar2(500)) as sous_categorie_facture,
	anal.client,
    anal.categorie_client,
	anal.designation,
	cast(anal.mttc as number(18,3)) as mttc,
	cast(anal.mtht as number(18,3)) as mtht,
	cast(anal.taxe as number(18,3)) as taxe,
	cast(anal.devfact as varchar2(100)) as devfact,
	cast(anal.mtdevise as number(18,3)) as mtdevise,
	cast(anal.mtavoir as number(18,3)) as mtavoir,
	cast(anal.paye as number(18,3)) as paye,
	cast(anal.reste as number(18,3)) as reste,
	anal.numcompte,
    cast(anal.VALCAT as varchar2(500)) as valcat
from (
    select * from analysefactureConcessionnaire
        union all
    select * from analysefactureConventionnel
         ) anal;
  
******************* SPAT_CAPITAINERIE *******************

drop materialized view ANALYSEFACTURECONCESSIONNAIRE;

create materialized view ANALYSEFACTURECONCESSIONNAIRE
    refresh force on demand as
		SELECT * FROM spat_ancien_finance.ANALYSEFACTURECONCESSIONNAIRE;
		
drop materialized view ANALYSEFACTURECONVENTIONNEL;

create materialized view ANALYSEFACTURECONVENTIONNEL
    refresh force on demand as
		SELECT * FROM spat_ancien_finance.ANALYSEFACTURECONVENTIONNEL;
		
drop materialized view ANALYSEGLOBALEFACTURE;

create materialized view ANALYSEGLOBALEFACTURE
    refresh force on demand as
		SELECT * FROM spat_ancien_finance.ANALYSEGLOBALEFACTURE;
		
create or replace view ANALYSEGLOBALEFACTURE_ANALYSE as
	select
		nmfact, daty, categorie_facture, sous_categorie_facture, client, categorie_client, designation,
		sum(cast(mttc as number(18,3))) as mttc,
		sum(cast(mtht as number(18,3))) as mtht,
		sum(cast(taxe as number(18,3))) as taxe,
		devfact,
		sum(cast(mtdevise as number(18,3))) as mtdevise,
		sum(cast(mtavoir as number(18,3))) as mtavoir,
		sum(cast(paye as number(18,3))) as paye,
		sum(cast(reste as number(18,3))) as reste,
		numcompte,valcat
	from analyseglobalefacture
	group by nmfact, daty, categorie_facture, sous_categorie_facture, client, categorie_client, designation,devfact,numcompte,valcat;
	
insert into MENUDYNAMIQUE (id, libelle, icone, href, rang, niveau, id_pere) values ('MEN0096','Configuration','fa fa-cog','#',4,3,'MEN0041');
insert into MENUDYNAMIQUE (id, libelle, icone, href, rang, niveau, id_pere) values ('MEN0097','Facture client','fa fa-file-o','#',1,4,'MEN0096');
insert into MENUDYNAMIQUE (id, libelle, icone, href, rang, niveau, id_pere) values ('MEN0098','Type facture','fa fa-check-square-o','#',2,4,'MEN0096');
insert into MENUDYNAMIQUE (id, libelle, icone, href, rang, niveau, id_pere) values ('MEN0099','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=facturation/client-fact-saisie.jsp',1,5,'MEN0097');
insert into MENUDYNAMIQUE (id, libelle, icone, href, rang, niveau, id_pere) values ('MEN00100','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=facturation/client-fact-liste.jsp',2,5,'MEN0097');