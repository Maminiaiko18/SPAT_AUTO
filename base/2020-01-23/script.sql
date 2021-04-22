****************** SPAT_CAPITAINERIE **************************

update typepatrimoine set val='Terrains / Terre-pleine', desce='Terrains / Terre-pleine' where id='TYPE000001';

alter table patrimoine add devise varchar(100);
alter table patrimoine add cours_change number(18,2);
alter table patrimoine add date_change date;

insert into menudynamique values (
'MENP093','Patrimoines','fa fa-home','#',13,2,'MEN0004');

insert into menudynamique values (
'MENP094','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=patrimoine/patrimoine-saisie-RH.jsp',1,3,'MENP093');

insert into menudynamique values (
'MENP095','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=patrimoine/patrimoine-liste-RH.jsp',2,3,'MENP093');

CREATE OR REPLACE VIEW PATRIMOINERHLIBCOMPLET AS
SELECT p."ID",
       p."IDOBJET",
       p."IDTYPEPATRIMOINE",
       p."REMARQUE",
       p."ETAT" AS etatpatrimoine,
       p."LIBELLE",
       p."DESCRIPTION",
       p."MONTANT",
       pers."ID" as PERSID,
       pers."MATRICULESALARIE" as PERSMATRICULESALARIE,
       pers."NOM" as PERSNOM,
       pers."PRENOM" as PERSPRENOM,
       pers."CIVILITE" as PERSCIVILITE,
       pers."DATENAISSANCE" as PERSDATENAISSANCE,
       pers."TELEPHONE" as PERSTELEPHONE,
       pers."EMAIL" as PERSEMAIL,
       p."DEBUT_CONTRAT",
       p."FIN_CONTRAT",
       p."UTILISATION",
       type.val AS valtypepatrimoine,
       type.desce AS descetypepatrimoine,
       etat.VAL AS valetatpatrimoine,
       etat.DESCE AS desceetatpatrimoine,
       mat.DENOMINATION,
       DATE_AQUISITION,
       IDMARQUE,
       PUISSANCE,
       DETENTEUR,
       MAINTENANCE,
       IDTYPE_MATERIEL,
       IMMATRICULATION,
       mat.ETAT,
       VALMARQUE,
       DESCEMARQUE,
       VALTYPEMATERIEL,
       DESCETYPEMATERIEL
FROM PATRIMOINE p
JOIN TYPEPATRIMOINE TYPE ON p.IDTYPEPATRIMOINE = type.ID
JOIN ETATPATRIMOINE etat ON p.ETAT = etat.ID
JOIN V_UNION_PERSONNEL pers ON pers.id=p.OCCUPANT 
LEFT JOIN MATERIELNAVALLIBCOMPLET mat ON mat.id = p.IDOBJET;



CREATE OR REPLACE VIEW PATRIMOINERHLIB ("ID",
                                                "IDOBJET",
                                                "IDTYPEPATRIMOINE",
                                                "REMARQUE",
                                                "ETAT",
                                                "LIBELLE",
                                                "DESCRIPTION",
                                                "MONTANT",
                                                "OCCUPANT",
                                                "DEBUT_CONTRAT",
                                                "FIN_CONTRAT",
                                                "UTILISATION") AS
SELECT id,
       DENOMINATION AS idobjet,
       VALTYPEPATRIMOINE AS IDTYPEPATRIMOINE,
       REMARQUE,
       valetatpatrimoine AS etat,
       LIBELLE,
       DESCRIPTION,
       MONTANT,
       PERSMATRICULESALARIE||' '||PERSNOM||''||PERSPRENOM as OCCUPANT,
       DEBUT_CONTRAT,
       FIN_CONTRAT,
       UTILISATION
FROM PATRIMOINERHLIBCOMPLET;

****************** SPAT_RH **************************

create materialized view V_MVT_MENSUEL
	refresh force on demand as
		select * from V_MVT_MENSUEL@db_link_spat_rh;
		
create materialized view T_MOTIFDEPART
	refresh force on demand as
		select * from T_MOTIFDEPART@db_link_spat_rh;
		
****************** SYS AS SYSDBA **************************

GRANT SELECT, INSERT, UPDATE, DELETE ON spat_rh.V_MVT_MENSUEL TO spat_capitainerie;
GRANT SELECT, INSERT, UPDATE, DELETE ON spat_rh.T_MOTIFDEPART TO spat_capitainerie;

****************** SPAT_CAPITAINERIE **************************

create or replace view mvt_effectif as
    select
        vmvt."CodeMotifDepart" as idhisto,
        vmvt."CodeStatutProf" as matricule,
        vmvt."NumSalarie" as matricule_interne,
        vmvt."DateSortie" as debut_fct,
        motif."Intitule" as motif
    from SPAT_RH.V_MVT_MENSUEL vmvt
        join SPAT_RH.T_MOTIFDEPART motif on motif."Code"=vmvt."CodeMotifDepart";
		
create or replace view PATRIMOINELIBCOMPLET as
select
        p."ID",p."IDOBJET",p."IDTYPEPATRIMOINE",p."REMARQUE",p."ETAT" as etatpatrimoine,p."LIBELLE",p."DESCRIPTION",p."MONTANT",p."OCCUPANT",p."DEBUT_CONTRAT",p."FIN_CONTRAT",p."UTILISATION",
        p.DEVISE, p.COURS_CHANGE, p.DATE_CHANGE,
        type.val as valtypepatrimoine, type.desce as descetypepatrimoine,
        etat.VAL as valetatpatrimoine, etat.DESCE as desceetatpatrimoine,
        dev.id as iddevise, dev.val as valdevise, dev.DESCE as descedevise,
        clt.CDCLT, CDCAT, NOMCLT, ADRCLT, NMSTTCLT, TELCLT, FAXCLT, NMCIN, NIF, RC, CATEGORIE,
        mat.DENOMINATION, DATE_AQUISITION, IDMARQUE, PUISSANCE, DETENTEUR, MAINTENANCE, IDTYPE_MATERIEL, IMMATRICULATION, mat.ETAT, VALMARQUE, DESCEMARQUE, VALTYPEMATERIEL, DESCETYPEMATERIEL
    from PATRIMOINE p
        join TYPEPATRIMOINE type on p.IDTYPEPATRIMOINE = type.ID
        join ETATPATRIMOINE etat on p.ETAT = etat.ID
        join V_CLIENT_CATEGORIE clt on clt.cdclt=p.occupant
        join DEVISEDEMAT dev on dev.ID=p.DEVISE
        left join MATERIELNAVALLIBCOMPLET mat on mat.id = p.IDOBJET;
		
create or replace view PATRIMOINELIB as
select
        id,
        DENOMINATION as idobjet,
        VALTYPEPATRIMOINE as IDTYPEPATRIMOINE,
        REMARQUE,
        valetatpatrimoine as etat,
        LIBELLE, DESCRIPTION, MONTANT,
        NOMCLT as OCCUPANT, DEBUT_CONTRAT, FIN_CONTRAT,UTILISATION,
        VALDEVISE as devise,
        COURS_CHANGE,
        DATE_CHANGE
    from PATRIMOINELIBCOMPLET;
	
create or replace view DETAILSPATRIMOINELIB as
    select
        p.idobjet, idtypepatrimoine, remarque, etatpatrimoine, libelle, description, montant, occupant, debut_contrat, fin_contrat, utilisation, devise, cours_change, date_change, valtypepatrimoine, descetypepatrimoine, valetatpatrimoine, desceetatpatrimoine, iddevise, valdevise, descedevise, cdclt, cdcat, nomclt, adrclt, nmsttclt, telclt, faxclt, nmcin, nif, rc, categorie, denomination, date_aquisition, idmarque, puissance, detenteur, maintenance, idtype_materiel, immatriculation, etat, valmarque, descemarque, valtypemateriel, descetypemateriel,
        det.id,
        p.libelle as idpatrimoine,
        det.natureObjet,
        det.surfaceOccupe,
        det.surfaceDisponible
    from Details_Patrimoine det
	    join PATRIMOINELIBCOMPLET p on det.idPatrimoine = p.id;
		
****************** SPAT_ANCIEN_FINANCE **************************
		
create or replace view ANALYSEFACTURECONCESSIONNAIRE as
select
    cast(mere.idfacturemere as varchar2(100)) as nmfact,
    mere.daty,
    case when cat.id = 'cat1' or cat.id = 'cat2' then 'Produit de convention' else  'Autres' end as categorie_facture,
    cast(scat.nomscatservice as varchar2(500)) as sous_categorie_facture,
    cast(cli.nom as varchar2(100)) as client,
    clt.categorie as categorie_client,
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
    join V_CLIENT_CATEGORIE clt on clt.CDCLT = mere.idclient
  where mere.idfacturemere not like '5%';
  
create or replace view ANALYSEFACTURECONVENTIONNEL as
select
    fact.nmfact,
    fact.dtfact as daty,
   case
        when tarif.cdcattarif in ('0075','0070','0045') then 'Produit de convention'
        when tarif.cdcattarif in ('0036','0084','0001','0002','0051','0062') then 'Droits de port'
        when tarif.cdcattarif in ('0042','0039','0040','0057','0053','0055','0059','0060') then 'Capitainerie'
        else 'Autres' end
    as categorie_facture,
    case when tarif.cdcattarif = '0075' then 'REDEVANCES EXPLOIATATION'
     when tarif.cdcattarif = '0070' then 'REDEVANCES LOCATIVES'
     when tarif.cdcattarif = '0045' then 'REDEVANCES DOMANIALES'
     when tarif.cdcattarif = '70691' then 'PENALITE'
    else '' end
     as sous_categorie_facture,
    clt.nomclt as client,
    cli.categorie as categorie_client,
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
    join db2010.client clt on clt.cdclt = dos.cdclt
    join V_CLIENT_CATEGORIE cli on cli.CDCLT = clt.cdclt
  where fact.nmfact not like '5%';

****************** SPAT_CAPITAINERIE **************************

drop materialized view ANALYSEFACTURECONCESSIONNAIRE;

create materialized view ANALYSEFACTURECONCESSIONNAIRE
    refresh force on demand
as
SELECT * FROM spat_ancien_finance.ANALYSEFACTURECONCESSIONNAIRE;

drop materialized view ANALYSEFACTURECONVENTIONNEL;

create materialized view ANALYSEFACTURECONVENTIONNEL
    refresh force on demand
as
SELECT * FROM spat_ancien_finance.ANALYSEFACTURECONVENTIONNEL;

create or replace view ANALYSEGLOBALEAUCOMPTANT as
    select * from SPAT_CAPITAINERIE.ANALYSEGLOBALEFACTURE where nmfact like '2%';
	
create or replace view analysefactureacredit as
    select * from SPAT_CAPITAINERIE.ANALYSEGLOBALEFACTURE where nmfact like '1%';
	
create or replace view analysefactureproformat as
    select * from SPAT_CAPITAINERIE.ANALYSEGLOBALEFACTURE where nmfact like '3%';
	
create view caisse_uniquement as select * from caisse where desce = 'Caisse' ;

drop materialized view ANALYSEGLOBALEFACTURE;

create materialized view ANALYSEGLOBALEFACTURE
    refresh force on demand
as
SELECT * FROM spat_ancien_finance.ANALYSEGLOBALEFACTURE;