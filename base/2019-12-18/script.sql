
ALTER TABLE contrat_engagement_boncommande MODIFY( FOURNISSEUR_ID VARCHAR2(20));


create or replace view contrat_engagement_boncmdlib as 
select ceb.id, ceb.num_bc, ceb.organe_demandeur, ceb.type_commande, ceb.daty, ceb.montant_ht, ceb.tva, ceb.montant_ttc, ceb.montant_autoriser,cef.nom as fournisseur_id, ceb.bon_livraison, ceb.bon_entre, ceb.date_livraison, ceb.facturer, ceb.ordre_de_paiement, ceb.reference_paiement, ceb.type_paiement, ceb.tva_valider, ceb.id_organe_demandeur, ceb.type, ceb.condition_reglement, ceb.mode_reglement, ceb.note, ceb.etat
from contrat_engagement_boncommande ceb join contrat_engagement_fournisseur cef on ceb.fournisseur_id = cef.id


INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ("MEN00218", "Bilan","fa fa-plus", "/spat/pages/globalnegoce.jsp?but=compta/compta-bilan-actif-passif.jsp", "4", "3", "MEN0051");
INSERT INTO menudynamique (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ("MEN00219", "Compte de resultat","fa fa-plus", "/spat/pages/globalnegoce.jsp?but=compta/compta-bilan-produits-charges.jsp", "5", "3", "MEN0051");

---------------------------------- SPAT ENGAGEMENT -----------------------------------

create materialized view relation_op_facture
    refresh force on demand as
    select * from relation_op_facture@db_link_spat_engagement;

create materialized view engagement_paiement_op
    refresh force on demand as
    select * from engagement_paiement_op@db_link_spat_engagement;

create materialized view engagement_facture_bc
    refresh force on demand as
    select * from engagement_facture_bc@db_link_spat_engagement;

 ---------------------------------- SPAT CAPITAINERIE -----------------------------------


create or replace view v_analyse_bon_commande as
select 
	B."num_bc" as BONCOMMANDE, 
	FR."nom" as FOURNISSEUR,
	B."organe_demandeur" as ORGANE_DEMANDEUR,
	cast(L."nombre" as integer) as QUANTITE,
	B."montant_ttc" as MONTANTTOTAL,
	cast(ROF."montant_facture" as number(20,2)) as MONTANTFACTURE,
	cast((B."montant_ttc" - ROF."montant_facture") as number(20,2)) as MONTANTNONFACTURE,
	F."montant_facture" as MONTANTPAYE,
	F."reste" as MONTANTNONPAYE,
	case when  B."type_paiement" = 1 then "Investissement" else "Fonctionnement" end as CATEGORIE 
FROM spat_engagement.relation_op_facture ROF
JOIN spat_engagement.engagement_facture_bc F ON ROF."id_facture"=F."id_facture" AND ROF."type_facture"=F."type_facture"
JOIN spat_engagement.engagement_libelle_boncommande L ON L."id_facturer"=F."id_facture"
JOIN spat_engagement.engagement_boncommande B ON B."id_bc"=L."id_bc"
JOIN spat_engagement.engagement_fournisseur FR ON FR."id_fournisseur" =B."fournisseur_id";

create or replace view v_analyse_bon_commande_analyse as
select 
	*
FROM v_analyse_bon_commande;

create or replace view v_union_personnel as
select 
	cast(ts."SA_CompteurNumero" as varchar2(10)) as id,
	ts."MatriculeSalarie" as matriculeSalarie, 
	ts."Nom" as nom, 
	ts."Prenom" as prenom, 
	CASE ts."Civilite" WHEN 0 THEN 'Feminin' else 'Masculin' end as civilite, 
	ts."DateNaissance" as dateNaissance,
	ts."Telephone" as telephone,
	ts."EMail" as email 
from spat_rh.t_sal ts
	union all
select 
		id as id,
		numero_matricule as matriculeSalarie,
		nom,
		prenom,
		CASE genre WHEN 'F' THEN 'Feminin' else 'Masculin' end as civilite, 
		datenaissance,
		telephone,
		mail as email 
from infopersonnelglobal;

alter table Renseignement_interne drop constraint FK_PERSRENSEIGNEMENT;

--renseignement_interne_lib

create or replace view RENSEIGNEMENT_INT_LIBCOMPLET as
select
        rens.id as idrenseignement, idpersonnel, libelle, type, daty, observation,
        info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email
    from RENSEIGNEMENT_INTERNE rens
        join v_union_personnel info on rens.IDPERSONNEL = info.ID
;

create or replace view RENSEIGNEMENT_INTERNE_LIB as
select
        idrenseignement as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        libelle,
        type,
        daty,
        observation
    from renseignement_int_libcomplet
;

--conge_lib

alter table conge drop constraint FK_PERSCONGE;

create or replace view CONGE_LIBCOMPLET as
select
        cong.ID as idconge, IDPERSONNEL, DISPONIBILITE, DATE_DEBUT_CONGE, DATE_FIN_CONGE, NOMBRE,
        info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email
    from conge cong
        join v_union_personnel info on cong.IDPERSONNEL = info.ID
;

create or replace view CONGE_LIB as
select
        idconge as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        DISPONIBILITE, DATE_DEBUT_CONGE, DATE_FIN_CONGE, NOMBRE
    from conge_libcomplet
;

--enfant_personnel_lib

create or replace view ENFANT_PERSONNEL_LIBCOMPLET as
select
        rens.id as idenfantpersonnel, idpersonnel, NOM_PRENOM_ENFANT, DATENAISSANCEENFANT,
        info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email
    from ENFANT_PERSONNEL rens
        join v_union_personnel info on rens.IDPERSONNEL = info.ID
;

create or replace view ENFANT_PERSONNEL_LIB as
select
        idenfantpersonnel as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        NOM_PRENOM_ENFANT,
        DATENAISSANCEENFANT
    from enfant_personnel_libcomplet
;

--parcours_professionnel_lib
create or replace view PARCOURS_PRO_LIBCOMPLET as
select
        rens.id as idparcourspro, idpersonnel, ANNEE_PARCOURS_PRO, POSTE_OCCUPE, SOCIETE, DUREE,
        info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email
    from PARCOURS_PROFESSIONNEL rens
        join v_union_personnel info on rens.IDPERSONNEL = info.ID
;

create or replace view PARCOURS_PROFESSIONNEL_LIB as
select
        idparcourspro as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        ANNEE_PARCOURS_PRO, POSTE_OCCUPE, SOCIETE, DUREE
    from parcours_pro_libcomplet
;

--diplome_lib

alter table DIPLOME drop constraint FK_PERSDIPLOME;

create or replace view DIPLOME_LIBCOMPLET as
select
        dipl.ID as iddiplome, IDPERSONNEL, ANNEE_DIPLOME, TITRE, OPTIONS, ETABLISSEMENT,
		info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email    from DIPLOME dipl
        join v_union_personnel info on dipl.IDPERSONNEL = info.ID
;

create or replace view DIPLOME_LIB as
select
        iddiplome as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        ANNEE_DIPLOME, TITRE, OPTIONS, ETABLISSEMENT
    from diplome_libcomplet
;

--permission_lib
create or replace view PERMISSION_LIBCOMPLET as
select
        perm.ID as idpermission, IDPERSONNEL, OBJET, DATE_DEBUT_PERMISSION, DATE_FIN_PERMISSION, NOMBRE,
        info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email
    from PERMISSION perm
        join v_union_personnel info on perm.IDPERSONNEL = info.ID
;

create or replace view PERMISSION_LIB as
select
        idpermission as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        OBJET, DATE_DEBUT_PERMISSION, DATE_FIN_PERMISSION, NOMBRE
    from permission_libcomplet
;
--historiquesyndicatlib

alter table HISTORIQUESYNDICAT drop constraint FK_PERSONNEL;

create or replace view HISTORIQUESYNDICATLIBCOMPLET as
select 
			histo.id as "IDHISTORIQUE", 
			histo."IDSYNDICAT", 
			histo."IDPOSTE", 
			histo."IDPERSONNEL",
			histo."DATY",
			histo.etat as "ETATHISTORIQUE", 
			s.nom as "NOMSYNDICAT",
			s.description as "DESCSYNDICAT",
			s.etat as "ETATSYNDICAT",
			poste.val as "VALPOSTE",
			poste.desce as "DESCEPOSTE",
			info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email
		from 
			HISTORIQUESYNDICAT histo        
		join SYNDICAT s on histo.IDSYNDICAT = s.ID        
		join POSTE poste on histo.IDPOSTE = poste.ID        
		join v_union_personnel info on histo.IDPERSONNEL = info.ID
;

create or replace view HISTORIQUESYNDICATLIB as
select
        IDHISTORIQUE as id,
        NOMSYNDICAT as IDSYNDICAT,
        VALPOSTE as IDPOSTE,
        cast((nom || ' ' || prenom) as varchar2(500)) as IDPERSONNEL,
        daty,
        ETATHISTORIQUE as etat
    from historiquesyndicatlibcomplet
;