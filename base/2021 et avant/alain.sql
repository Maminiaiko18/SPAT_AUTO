ALTER TABLE f_ecriturec MODIFY EC_date DATE;

CREATE OR REPLACE VIEW REPORTSOLDE_GENERAL (COMPTE, LIBELLE_COMPTE, DEBIT, CREDIT, TYPECOMPTE, MOIS, ANNEE, CHIFFRE3, CHIFFRE2) AS 
SELECT COMPTE, LIBELLE, CAST(DEBIT AS NUMBER(30,2)), CAST(CREDIT AS NUMBER(30,2)), TYPECOMPTE, MOIS, ANNEE, CHIFFRE3, CHIFFRE2 FROM(
	SELECT 
		cse.CG_Num as COMPTE, 
		cc.CG_INTITULE as libelle, 
		sum(cse.EC_MONTANT) as debit, 
		0 as credit, 
		cc.CG_TYPE as typecompte,
		EXTRACT(MONTH from cse.EC_DATE) as mois, 
		EXTRACT(YEAR from cse.EC_DATE) as annee, 
		substr(cse.CG_Num,1,2)||substr(cse.CG_Num,5,1) as CHIFFRE3, 
		substr(cse.CG_Num,1,2) as CHIFFRE2
	from
    	f_ecriturec cse, f_compteg cc, f_journaux jrn
	where
    	cc.CG_Num = cse.CG_Num 
    	--and cse.etat = 11 
    	and ec_sens = 0
    	and cse.JO_num = jrn.JO_num
	group by cse.CG_Num, cc.CG_INTITULE, cc.CG_TYPE,
		EXTRACT(MONTH from cse.EC_DATE), EXTRACT(YEAR from cse.EC_DATE)

	union 

	SELECT 
		cse.CG_Num as COMPTE, 
		cc.CG_INTITULE as libelle, 
		0 as debit, 
		sum(cse.EC_MONTANT) as credit, 
		cc.CG_TYPE as typecompte,
		EXTRACT(MONTH from cse.EC_DATE) as mois, 
		EXTRACT(YEAR from cse.EC_DATE) as annee, 
		substr(cse.CG_Num,1,2)||substr(cse.CG_Num,5,1) as CHIFFRE3, 
		substr(cse.CG_Num,1,2) as CHIFFRE2
	from
    	f_ecriturec cse, f_compteg cc, f_journaux jrn
	where
    	cc.CG_Num = cse.CG_Num 
    	--and cse.etat = 11 
    	and ec_sens = 1
    	and cse.JO_num = jrn.JO_num
	group by cse.CG_Num, cc.CG_INTITULE, cc.CG_TYPE,
		EXTRACT(MONTH from cse.EC_DATE), EXTRACT(YEAR from cse.EC_DATE)
);


CREATE OR REPLACE VIEW REPORTSOLDE_JANVIER (COMPTE, LIBELLE_COMPTE, DEBIT, CREDIT, TYPECOMPTE, MOIS, ANNEE, CHIFFRE3, CHIFFRE2) AS 
SELECT COMPTE, LIBELLE, CAST(sum(DEBIT) AS NUMBER(30,2)), CAST(sum(CREDIT) AS NUMBER(30,2)), TYPECOMPTE, MOIS, ANNEE, CHIFFRE3, CHIFFRE2 FROM(
	SELECT cse.CG_Num as COMPTE, cc.CG_INTITULE as libelle, cse.EC_MONTANT as debit, 0 as credit, cc.CG_TYPE as typecompte,
		EXTRACT(MONTH from cse.EC_DATE) AS MOIS, EXTRACT(YEAR from cse.EC_DATE) AS ANNEE, 
		CASE WHEN CG_TYPE = 0 THEN SUBSTR(CSE.CG_Num, 1,3)||SUBSTR(CSE.CG_Num, 5,1) 
     	ELSE SUBSTR(CSE.CG_Num, 1,2)||SUBSTR(CSE.CG_Num, 5,1) END as chiffre3, 
     	substr(cse.CG_Num,1,2) as chiffre2
	from
    	f_ecriturec cse, 
    	f_compteg cc, 
    	f_journaux jrn
	where
    	cc.CG_Num = cse.CG_Num and cse.JO_num = 'RAN'
    	and jrn.JO_num = cse.JO_num and ec_sens = 0

    union 

    SELECT cse.CG_Num as COMPTE, cc.CG_INTITULE as libelle, 0 as debit, cse.EC_MONTANT as credit, cc.CG_TYPE as typecompte,
		EXTRACT(MONTH from cse.EC_DATE) AS MOIS, EXTRACT(YEAR from cse.EC_DATE) AS ANNEE, 
		CASE WHEN CG_TYPE = 0 THEN SUBSTR(CSE.CG_Num, 1,3)||SUBSTR(CSE.CG_Num, 5,1) 
     	ELSE SUBSTR(CSE.CG_Num, 1,2)||SUBSTR(CSE.CG_Num, 5,1) END as chiffre3, 
     	substr(cse.CG_Num,1,2) as chiffre2
	from
    	f_ecriturec cse, 
    	f_compteg cc, 
    	f_journaux jrn
	where
    	cc.CG_Num = cse.CG_Num and cse.JO_num = 'RAN'
    	and jrn.JO_num = cse.JO_num and ec_sens = 1

	)
group by COMPTE, LIBELLE, TYPECOMPTE, MOIS, ANNEE, CHIFFRE3, CHIFFRE2 ;






CREATE OR REPLACE VIEW COMPTA_MOUVEMENT_DETAILGEN (ID, CONTREP, COMPTE, DEBIT, CREDIT, LIBELLEPIECE, REMARQUE, MERE, REFERENCE_ENGAGEMENT, COMPTE_AUX, LETTRAGE, JOURNAL, EXERCICE, ETAT, DATY, FOLIO, COURSDEVISE, MONTANTDEVISE) AS 
SELECT 
	cse.ec_no as id, 
	null as contrep, 
	cse.cg_num as compte, 
	cse.EC_MONTANT as debit, 
	0 as credit,
	cse.EC_INTITULE as libellepiece, 
	cse.EC_INTITULE as remarque,
	null as mere, 
	null as analytique, 
	null as compte_aux,
	cse.ec_lettrage as lettrage,
	cse.JO_num as journal,
	extract(year from cse.EC_DATE), 
	1 as etat,
	cse.EC_DATE as daty, 
	null as folio, 
	cast(0 as number(20,2)) as coursdevise, 
	cast(cse.ec_devise as number(20,2)) as montantdevise 
	FROM f_ecriturec cse 
	join f_journaux cj on cj.JO_num = cse.JO_num 
	join f_compteg cc on cse.cg_num=cc.cg_num 
	WHERE 1<2 AND cj.JO_num <> 'RAN' AND cse.ec_sens = 1

	UNION 

SELECT 
	cse.ec_no as id, 
	null as contrep, 
	cse.cg_num as compte, 
	0 as debit, 
	cse.EC_MONTANT as credit,
	cse.EC_INTITULE as libellepiece, 
	cse.EC_INTITULE as remarque,
	null as mere, 
	null as analytique, 
	null as compte_aux,
	cse.ec_lettrage as lettrage,
	cse.JO_num as journal,
	extract(year from cse.EC_DATE), 
	1 as etat,
	cse.EC_DATE as daty, 
	null as folio, 
	cast(0 as number(20,2)) as coursdevise, 
	cast(cse.ec_devise as number(20,2)) as montantdevise 
	FROM f_ecriturec cse 
	join f_journaux cj on cj.JO_num = cse.JO_num 
	join f_compteg cc on cse.cg_num=cc.cg_num 
	WHERE 1<2 AND cj.JO_num <> 'RAN' AND cse.ec_sens = 1;



CREATE OR REPLACE VIEW COMPTA_MOUVEMENT_DETAILS_GEN (ID, CONTREP, COMPTE, DEBIT, CREDIT, LIBELLEPIECE, REMARQUE, MERE, REFERENCE_ENGAGEMENT, COMPTE_AUX, LETTRAGE, JOURNAL, EXERCICE, ETAT, DATY, FOLIO, COURSDEVISE, MONTANTDEVISE) AS 
  select ID, CONTREP, COMPTE, DEBIT, CREDIT, LIBELLEPIECE, REMARQUE, MERE, 
  REFERENCE_ENGAGEMENT, COMPTE_AUX, LETTRAGE, JOURNAL, EXERCICE, ETAT, DATY, 
  FOLIO, cast(COURSDEVISE as number(20,2)) as COURSDEVISE, cast(MONTANTDEVISE as number(20,2)) as MONTANTDEVISE 
from COMPTA_MOUVEMENT_DETAILGEN;
 



CREATE OR REPLACE VIEW COMPTA_MOUVEMENT_GENERAL (DEBIT, CREDIT, COMPTE, ETAT, LIBELLE_COMPTE, TYPECOMPTE, MOIS, ANNEE, CHIFFRE3, CHIFFRE2) AS 
select 
	cast(sum(debit)as number(30,2)) as debit, 
	cast(sum(credit) as number(30,2)) as credit, 
	compte, 
	etat, 
	libelle_compte, 
	typecompte, 
	mois, 
	annee, 
	chiffre3, 
	chiffre2 
	from(
   		select  
   			cse.ec_no as id,cse.EC_MONTANT as debit, 
   			0 as credit, 
   			cse.cg_num as compte,
   			cc.CG_INTITULE as libelle_compte,
            cse.EC_DATE as daty, 
            1 as etat, 
            cc.CG_TYPE as typecompte, 
            extract(month from cse.EC_DATE) as mois, 
            extract(year from cse.EC_DATE) as annee,
            substr(cse.cg_num,1,2)||substr(cse.cg_num,5,1) as chiffre3, 
            substr(cse.cg_num,1,2) as chiffre2
            from  f_ecriturec cse
            join f_compteg cc on cc.cg_num = cse.cg_num
            join f_journaux cj on cj.JO_num = cse.JO_num
            where cse.ec_sens = 0
            and not exists(
                select rs.id from reportsolde rs where rs.id = cse.ec_no
            )
            union 

        select  
   			cse.ec_no as id, 0 as debit, 
   			cse.EC_MONTANT as credit, 
   			cse.cg_num as compte,
   			cc.CG_INTITULE as libelle_compte,
            cse.EC_DATE as daty, 
            1 as etat, 
            cc.CG_TYPE as typecompte, 
            extract(month from cse.EC_DATE) as mois, 
            extract(year from cse.EC_DATE) as annee,
            substr(cse.cg_num,1,2)||substr(cse.cg_num,5,1) as chiffre3, 
            substr(cse.cg_num,1,2) as chiffre2
            from  f_ecriturec cse
            join f_compteg cc on cc.cg_num = cse.cg_num
            join f_journaux cj on cj.JO_num = cse.JO_num
            where cse.ec_sens = 1
            and not exists(
                select rs.id from reportsolde rs where rs.id = cse.ec_no
            )
)group by compte, etat, libelle_compte, typecompte, mois, annee, chiffre3, chiffre2 order by chiffre3 asc ;


CREATE OR REPLACE VIEW REPORTSOLDE (ID, COMPTE, LIBELLE_COMPTE, DEBIT, CREDIT, DATY, TYPECOMPTE, MOIS, ANNEE) AS 
	SELECT cse.ec_no, cse.cg_num, cc.CG_INTITULE, cse.EC_MONTANT, 0, cse.EC_DATE, cc.CG_TYPE,
		EXTRACT(MONTH from cse.EC_DATE), EXTRACT(YEAR from cse.EC_DATE)
		from
    	f_ecriturec cse, f_compteg cc, f_journaux jrn
		where
    		cc.cg_num = cse.cg_num and cse.JO_num = 'RAN'
    		and jrn.JO_num = cse.JO_num and cse.ec_sens = 0
    union 
    SELECT cse.ec_no, cse.cg_num, cc.CG_INTITULE, 0, cse.EC_MONTANT, cse.EC_DATE, cc.CG_TYPE,
		EXTRACT(MONTH from cse.EC_DATE), EXTRACT(YEAR from cse.EC_DATE)
		from
    	f_ecriturec cse, f_compteg cc, f_journaux jrn
		where
    		cc.cg_num = cse.cg_num and cse.JO_num = 'RAN'
    		and jrn.JO_num = cse.JO_num and cse.ec_sens = 1
	;


























