************* compte_compta *************

create or replace view compta_compte_3chiffre as
	select CG_Num as id, CG_num as compte, cg_intitule as libelle, cg_type as typecompte,
       case when cg_type = 3 then (SUBSTR(cbCG_num, 1, 3)  || SUBSTR(cbCG_num, 5, 1))
            when cg_type = 1 and SUBSTR(cbCG_num, 1, 4) = '4007' then '407'
            else (SUBSTR(cbCG_num, 1, 2) || SUBSTR(cbCG_num, 5, 1)) end
        as chiffre3
	from F_COMPTEG;
	
GRANT SELECT, INSERT, UPDATE, DELETE ON spat_compta.compta_compte_3chiffre TO spat_capitainerie;
GRANT SELECT, INSERT, UPDATE, DELETE ON spat_compta.COMPTA_MOUVEMENT_DETAILGEN TO spat_capitainerie;
GRANT SELECT, INSERT, UPDATE, DELETE ON spat_compta.COMPTA_MOUVEMENT_DETAILS_GEN TO spat_capitainerie;
GRANT SELECT, INSERT, UPDATE, DELETE ON spat_compta.REPORTSOLDE_GENERAL TO spat_capitainerie;
GRANT SELECT, INSERT, UPDATE, DELETE ON spat_compta.REPORTSOLDE_JANVIER TO spat_capitainerie;

GRANT SELECT, INSERT, UPDATE, DELETE ON spat_compta.COMPTA_MOUVEMENT_GENERAL TO spat_capitainerie;

create or replace view analyseecriture as
select
    ecr.EC_No,
    ecr.CG_Num,
    cpt.CG_INTITULE,
    case when ecr.EC_SENS = 0 then ecr.EC_MONTANT
        else 0 end
    as dedit,
    case when ecr.EC_SENS = 1 then ecr.EC_MONTANT
        else 0 end
    as credit,
    ecr.EC_DATE,
    ecr.EC_RefPiece,
    ecr.EC_TresoPiece,
    ecr.EC_Lettrage,
    cpt.CG_TYPE,
    ecr.EC_Devise
from f_ecriturec ecr
    join f_compteg cpt on ecr.CG_NUM = cpt.CG_NUM;
	
GRANT SELECT, INSERT, UPDATE, DELETE ON spat_compta.analyseecriture TO spat_capitainerie;

************* spat_capitainerie *************

create MATERIALIZED view compta_compte_3chiffre as
	select * from spat_compta.compta_compte_3chiffre;
	
create view COMPTA_MOUVEMENT_DETAILGEN as
	select * from spat_compta.COMPTA_MOUVEMENT_DETAILGEN;

create view COMPTA_MOUVEMENT_DETAILS_GEN as
	select * from spat_compta.COMPTA_MOUVEMENT_DETAILS_GEN;

create view REPORTSOLDE_GENERAL as
	select * from spat_compta.REPORTSOLDE_GENERAL;

create view REPORTSOLDE_JANVIER as
	select * from spat_compta.REPORTSOLDE_JANVIER;
	
create view COMPTA_MOUVEMENT_GENERAL as
	select * from spat_compta.COMPTA_MOUVEMENT_GENERAL;
	
create MATERIALIZED view analyseecriture REFRESH WITH ROWID as
	select * from spat_compta.analyseecriture;
	
create or replace view materielnavallib as
    select
        mat.ID,
        mat.DENOMINATION,
        mat.DATE_AQUISITION,
        marque.VAL as idmarque,
        mat.PUISSANCE,
        mat.DETENTEUR,
        mat.MAINTENANCE,
        type.VAL as IDTYPE_MATERIEL,
        mat.IMMATRICULATION,
        mat.ETAT
    from MATERIEL_NAVAL mat
        join MARQUE_MATERIEL marque on marque.ID = mat.IDMARQUE
        join TYPE_MATERIEL type on type.id = mat.IDTYPE_MATERIEL;