----------------------- SPAT_CAPITAINERIE -----------------------

update menudynamique set href='/spat/pages/globalnegoce.jsp?but=capitainerie/analyse-occupationmaterielnaval.jsp' where id='MEN0087';

create or replace view COMPTABILAN as
    select
        rub.id as idrubrique, rub.libelle as rubrique, rub.reference, rub.etat,
        cptrub.compte as cpt_rubrique, cptrub.libelle as libelle_cpt_rubrique,
        case
          when ecr."EC_Sens" = 0 then 'Debit'
          else 'Credit'
        end as type,
        ecr."EC_Montant" as ec_montant,
        ecr."EC_Date" as ec_date
      from rubrique rub
        join compte_rubrique cptrub on cptrub.reference = rub.reference
        join spat_compta.f_ecriturec ecr on ecr."CG_Num" = cptrub.compte;
		
create or replace view comptabilanactif as
    select * from comptabilan where reference like 'A%';
	
create or replace view comptabilanpassif as
    select * from comptabilan where reference like 'P%';
	
create or replace view RECAP_MATERIEL_NAVAL as
	select
		coalesce(occup.IDMATERIEL_NAVAL,prev.IDMATERIEL_NAVAL) as id,
		coalesce(occup.DENOMINATION,prev.DENOMINATION) as denomination,
		coalesce(occup.VALTYPEMATERIEL,prev.VALTYPEMATERIEL) as typemateriel,
		occup.VALNATUREOPERATION as occup_operation,
		occup.POSITION,
		occup.daty as occup_date_arrivee,
		occup.datefin as occup_date_depart,
		occup.HEUREDEBUT as occup_heure_arrivee,
		occup.HEUREFIN as occup_heure_depart,
		prev.DATE_DEPART as prev_date_depart,
		prev.heure_depart as prev_heure_depart,
		prev.DATE_ARRIVEE as prev_date_arrivee,
		prev.heure_arrivee as prev_heure_arrivee,
		prev.VALNATUREOPERATION as prev_operation,
		prev.NOMCLT as prev_client
	from OCCUPMATERIELNAVALLIBCOMPLET occup
		full outer join PREVMATERIELNAVALLIBCOMPLET prev on occup.IDMATERIEL_NAVAL = prev.IDMATERIEL_NAVAL;
		
update MENUDYNAMIQUE set HREF='/spat/pages/globalnegoce.jsp?but=facturation/analyse-globale.jsp&colGroupe1=categorie_facture&colGroupe2=sous_categorie_facture&colGroupe3=client' where id = 'MEN0041';

create or replace view COMPTABILANPRODUIT as
    SELECT * FROM comptabilan WHERE reference LIKE 'X%';
	
create or replace view COMPTABILANCHARGE as
    select * from comptabilan where reference like 'C%';
	
create or replace view journalcaissebanquelib_analyse as
    select * from journalcaissebanquelib;
	
create view PERMISSION_PERSONNEL_LIB as
	select
        idpermission as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        idpersonnel as personnel,
        OBJET, DATE_DEBUT_PERMISSION, DATE_FIN_PERMISSION, NOMBRE
    from permission_libcomplet;
	
create view ENFANT_PERSONNEL_PERSONNE_LIB as
	select
        idenfantpersonnel as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        idpersonnel as personnel,
        NOM_PRENOM_ENFANT,
        DATENAISSANCEENFANT
    from enfant_personnel_libcomplet;
	
create or replace view tiers_valide as
    select * from tiers where etat = 11;

create or replace view tiers_cree as
    select * from tiers where etat = 1;
	
create or replace view recap_treso_analyse as
    select * from recap_treso;

alter table contrat_engagement_boncommande modify type varchar2(50);

create or replace view BON_PROVISOIRE_LIB_cree as
    select * from BON_PROVISOIRE_LIB where etat = 1;

create or replace view BON_PROVISOIRE_LIB_valide as
    select * from BON_PROVISOIRE_LIB where etat = 11;

create or replace view BON_PROVISOIRE_LIB_regularise as
    select * from BON_PROVISOIRE_LIB where etat = 12;
	
create or replace view CHANTIERLIBCOMPLET_cree as
    select * from CHANTIERLIBCOMPLET where etat = 1;

create or replace view CHANTIERLIBCOMPLET_valide as
    select * from CHANTIERLIBCOMPLET where etat = 11;
	
create or replace view PERMISSION_LIBCOMPLET as
	select
        perm.ID as idpermission, IDPERSONNEL, OBJET, DATE_DEBUT_PERMISSION, DATE_FIN_PERMISSION, NOMBRE, etat,
        info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email
    from PERMISSION perm
        join v_union_personnel info on perm.IDPERSONNEL = info.ID;
		
create or replace view PERMISSION_LIB as
	select
        idpermission as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        OBJET, DATE_DEBUT_PERMISSION, DATE_FIN_PERMISSION, NOMBRE, ETAT
    from permission_libcomplet;