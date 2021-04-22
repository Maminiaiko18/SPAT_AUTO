create view CONGE_LIB_ETAT as
select
        idconge as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        DISPONIBILITE, DATE_DEBUT_CONGE, DATE_FIN_CONGE, NOMBRE,etat
    from conge_libcomplete;

create view CONGE_LIBCOMPLETE as
select
        cong.ID as idconge, IDPERSONNEL, DISPONIBILITE, DATE_DEBUT_CONGE, DATE_FIN_CONGE, NOMBRE,cong.ETAT,
        info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email
    from conge cong
        join v_union_personnel info on cong.IDPERSONNEL = info.ID;

create view PERMISSION_LIBCOMPLETE as
select
        perm.ID as idpermission, IDPERSONNEL, OBJET, DATE_DEBUT_PERMISSION, DATE_FIN_PERMISSION, NOMBRE,ETAT,
        info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email
    from PERMISSION perm
        join v_union_personnel info on perm.IDPERSONNEL = info.ID;

create view PERMISSION_LIB_ETAT as
select
        idpermission as id,
        cast((nom || ' ' || prenom) as varchar2(200)) as idpersonnel,
        OBJET, DATE_DEBUT_PERMISSION, DATE_FIN_PERMISSION, NOMBRE,ETAT
    from permission_libcompletE;