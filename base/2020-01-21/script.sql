insert into natureoperation values('NAT0002','Départ','Départ');
insert into natureoperation values('NAT0003','Hors zone','Hors zone');
insert into natureoperation values('NAT0004','Opération en rade','Opération en rade');
insert into natureoperation values('NAT0005','Remorquage','Remorquage');
insert into natureoperation values('NAT0006','SAR','SAR');
insert into natureoperation values('NAT0007','Mission','Mission');
insert into natureoperation values('NAT0008','Lamanage','Lamanage');
insert into natureoperation values('NAT0009','Pilotage','Pilotage');
insert into natureoperation values('NAT0010','Assistance','Assistance');
insert into natureoperation values('NAT0011','Mouvement','Mouvement');

create or replace view occupmaterielnavallibnombre as
  select id,daty,idmateriel_naval,idpilote,idcommandant,
  idnatureoperation,idmanoeuvrebord,heuredebut,heurefin,
  idnavire,idclient,duree,position,observation,etat,datefin,
  cast(1 as number(10,2)) as nombre from occupmaterielnavallib;
  insert into menudynamique values('MEN0087','Analyse Occupation Materiel Naval','fa fa-plus','/spat/pages/globalnegoce.jsp?but=capitainerie/analyse-occupationmaterielnaval.jsp'||'&'||'colGroupe1=idmateriel_naval'||'&'||'colGroupe2=idclient','4','3','MEN0019');
  commit;
  
create or replace view infopersonnelglobalsyndicat as
    select
        info.*,
        histo.id as idhistosyndicat, histo.daty as datehistosyndicat, histo.etat as etathistosyndicat,
        synd.id as idsyndicat, synd.nom as nomsyndicat, synd.DESCRIPTION as descriptionsyndicat, synd.etat as etatsyndicat,
        poste.id as idposte, poste.val as valposte, poste.desce as desceposte
    from INFOPERSONNELGLOBAL info
        join HISTORIQUESYNDICAT histo on info.id=histo.IDPERSONNEL
        join SYNDICAT synd on synd.id=histo.IDSYNDICAT
        join POSTE poste on poste.ID=histo.IDPOSTE;
		
create or replace view t_salsyndicat as
    select
        tsal.*,
        histo.id as idhistosyndicat, histo.daty as datehistosyndicat, histo.etat as etathistosyndicat,
        synd.id as idsyndicat, synd.nom as nomsyndicat, synd.DESCRIPTION as descriptionsyndicat, synd.etat as etatsyndicat,
        poste.id as idposte, poste.val as valposte, poste.desce as desceposte
    from spat_rh.t_sal tsal
        join HISTORIQUESYNDICAT histo on tsal."SA_CompteurNumero"=histo.IDPERSONNEL
        join SYNDICAT synd on synd.id=histo.IDSYNDICAT
        join POSTE poste on poste.ID=histo.IDPOSTE;
		
create or replace view analyse_effectif_syndicat as
    select
        id,
        cast(numero_matricule as varchar2(100)) as matriculesalarie,
        cast(nom as varchar2(100)) as nom,
        cast(prenom as varchar2(100)) as prenom,
        case
            when genre='M' then 'Masculin'
            else 'F&eacute;minin' end as genre,
        datenaissance,
        nomsyndicat as syndicat,
        cast(1 as number(10,2)) as nombre,
        valposte as postesyndicat
    from infopersonnelglobalsyndicat
    union
    select
        cast("SA_CompteurNumero" as varchar2(100)) as id,
        cast("MatriculeSalarie" as varchar2(100)) as matriculesalarie,
        cast("Nom" as varchar2(100)) as nom,
        cast("Prenom" as varchar2(100)) as prenom,
        case when "Civilite"=0 then 'Masculin'
            else 'F&eacute;minin' end as genre,
        "DateNaissance" as datenaissance,
        nomsyndicat as syndicat,
        cast(1 as number(10,2)) as nombre,
        valposte as postesyndicat
    from t_salsyndicat;
	
create or replace view infopersonnelglobalconge as
    select
        info.*,
        conge.id as idconge, conge.DISPONIBILITE, conge.DATE_DEBUT_CONGE, conge.DATE_FIN_CONGE, conge.NOMBRE, conge.etat as etatconge
    from INFOPERSONNELGLOBAL info
        join conge conge on info.id=conge.IDPERSONNEL;
		
create or replace view t_salconge as
    select
        tsal.*,
        conge.id as idconge, conge.DISPONIBILITE, conge.DATE_DEBUT_CONGE, conge.DATE_FIN_CONGE, conge.NOMBRE, conge.etat as etatconge
    from spat_rh.t_sal tsal
        join conge conge on to_char(tsal."SA_CompteurNumero")=conge.IDPERSONNEL;
		
create or replace view analyse_conge_personnel as
    select
        id,
        cast(numero_matricule as varchar2(100)) as matriculesalarie,
        cast(nom as varchar2(100)) as nom,
        cast(prenom as varchar2(100)) as prenom,
        case
            when genre='M' then 'Masculin'
            else 'F&eacute;minin' end as genre,
        datenaissance,
        DATE_DEBUT_CONGE as date_debut,
        DATE_FIN_CONGE as date_fin,
        cast(1 as number(10,2)) as nombre,
        etatconge as etat
    from infopersonnelglobalconge
    union
    select
        cast("SA_CompteurNumero" as varchar2(100)) as id,
        cast("MatriculeSalarie" as varchar2(100)) as matriculesalarie,
        cast("Nom" as varchar2(100)) as nom,
        cast("Prenom" as varchar2(100)) as prenom,
        case when "Civilite"=0 then 'Masculin'
            else 'F&eacute;minin' end as genre,
        "DateNaissance" as datenaissance,
        DATE_DEBUT_CONGE as date_debut,
        DATE_FIN_CONGE as date_fin,
        cast(1 as number(10,2)) as nombre,
        etatconge as etat
    from t_salconge;
	
create or replace view infopersonnelglobalpermission as
    select
        info.*,
        p.id as idpermission, p.objet as objetpermission, p.DATE_DEBUT_PERMISSION, p.DATE_FIN_PERMISSION, p.NOMBRE, p.etat as etatpermission
    from INFOPERSONNELGLOBAL info
        join PERMISSION p on info.id=p.IDPERSONNEL;
		
create or replace view t_salpermission as
    select
        tsal.*,
        p.id as idpermission, p.objet as objetpermission, p.DATE_DEBUT_PERMISSION, p.DATE_FIN_PERMISSION, p.NOMBRE, p.etat as etatpermission
    from spat_rh.t_sal tsal
        join permission p on to_char(tsal."SA_CompteurNumero")=p.IDPERSONNEL;
		
create or replace view analyse_permission_personnel as
    select
        id,
        cast(numero_matricule as varchar2(100)) as matriculesalarie,
        cast(nom as varchar2(100)) as nom,
        cast(prenom as varchar2(100)) as prenom,
        case
            when genre='M' then 'Masculin'
            else 'F&eacute;minin' end as genre,
        datenaissance,
        DATE_DEBUT_PERMISSION as date_debut,
        DATE_FIN_PERMISSION as date_fin,
        cast(1 as number(10,2)) as nombre,
        etatpermission as etat
    from infopersonnelglobalpermission
    union
    select
        cast("SA_CompteurNumero" as varchar2(100)) as id,
        cast("MatriculeSalarie" as varchar2(100)) as matriculesalarie,
        cast("Nom" as varchar2(100)) as nom,
        cast("Prenom" as varchar2(100)) as prenom,
        case when "Civilite"=0 then 'Masculin'
            else 'F&eacute;minin' end as genre,
        "DateNaissance" as datenaissance,
        DATE_DEBUT_PERMISSION as date_debut,
        DATE_FIN_PERMISSION as date_fin,
        cast(1 as number(10,2)) as nombre,
        etatpermission as etat
    from t_salpermission;
	
create or replace view personnelsageinfopers as
    select
        id,
        cast(nom as varchar2(100)) as nom,
        cast(prenom as varchar2(100)) as prenom,
        cast(numero_matricule as varchar2(100)) as numeromatricule,
        datenaissance,
        case
            when genre='M' then 'Masculin'
            else 'F&eacute;minin' end as genre,
        cast(adresse as varchar2(500)) as adresse,
        cast(telephone as varchar2(100)) as telephone,
        cast(mail as varchar2(100)) as mail,
        cast(categorie as varchar2(100)) as categorie,
        cast(poste as varchar2(100)) as poste,
        cast(direction as varchar2(100)) as direction,
        cast('' as varchar2(100)) as qualification
    from infopersonnelglobal
    union
    select
        cast(emp."SA_CompteurNumero" as varchar2(100)) as id,
        cast(emp."Nom" as varchar2(100)) as nom,
        cast(emp."Prenom" as varchar2(100)) as prenom,
        cast(emp."MatriculeSalarie" as varchar2(100)) as numeromatricule,
        emp."DateNaissance" as datenaissance,
        case when emp."Civilite"=0 then 'Masculin'
            else 'F&eacute;minin' end as genre,
        cast(emp."Rue1" as varchar2(500)) as adresse,
        cast(emp."Telephone" as varchar2(100)) as telephone,
        cast(emp."EMail" as varchar2(100)) as mail,
        cast(cat."Intitule" as varchar2(100)) as categorie,
        cast(aff."EmploiOccupe" as varchar2(100)) as poste,
        cast('' as varchar2(100)) as direction,
        cast(aff."Qualification" as varchar2(100)) as qualification
    from spat_rh.t_sal emp
        join spat_rh.SPAT_AFFECTATION aff on trim(aff."NumSalarie") = trim(emp."SA_CompteurNumero")
        join spat_rh.T_CATEGORIE cat on trim(cat."Code") = trim(aff."Categorie");



CREATE OR REPLACE FORCE VIEW "POSTEDESTINATAIRELIBCOMPLET" ("ID", "IDQUAI", "INTERNE", "PAYS", "IDPAYS", "LONGUEUR", "PROFONDEUR", "TIRANT", "QUAI") AS 
  select p.id,
       q.VAL as idquai,
       case when interne = 1 then 'National' else 'International' end,
       p1.VAL as pays,
       p.pays as idpays,
       longueur,
       profondeur,
       tirant,
       q.VAL  as quai
from POSTEDESTINATAIRE p
         join quais q on q.id = p.QUAI
         join pays p1 on p1.id = p.PAYS;