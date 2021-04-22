---------------------- SPAT_COMPTA ----------------------

create or replace view COMPTA_MOUVEMENT_DETAILGEN as
SELECT
		cse."EC_No" as id,
		null as contrep,
		cse."CG_Num" as compte,
		cse."EC_Montant" as debit,
		0 as credit,
		cse."EC_Intitule" as libellepiece,
		cse."EC_Intitule" as remarque,
		null as mere,
		null as analytique,
		null as compte_aux,
		cse."EC_Lettrage" as lettrage,
		cse."JO_Num" as journal,
		extract(year from cse."EC_Date") as annee,
		11 as etat,
		cse."EC_Date" as daty,
		null as folio,
		cast(0 as number(20,2)) as coursdevise,
		cast(cse."EC_Devise" as number(20,2)) as montantdevise
		FROM f_ecriturec cse
		join f_journaux cj on cj."JO_Num" = cse."JO_Num"
		join f_compteg cc on cse."CG_Num"=cc."CG_Num"
		WHERE 1<2 AND cj."JO_Num" <> 'RAN' AND cse."EC_Sens" = 1
	UNION ALL
	SELECT
		cse."EC_No" as id,
		null as contrep,
		cse."CG_Num" as compte,
		0 as debit,
		cse."EC_Montant" as credit,
		cse."EC_Intitule" as libellepiece,
		cse."EC_Intitule" as remarque,
		null as mere,
		null as analytique,
		null as compte_aux,
		cse."EC_Lettrage" as lettrage,
		cse."JO_Num" as journal,
		extract(year from cse."EC_Date"),
		11 as etat,
		cse."EC_Date" as daty,
		null as folio,
		cast(0 as number(20,2)) as coursdevise,
		cast(cse."EC_Devise" as number(20,2)) as montantdevise
		FROM f_ecriturec cse
		join f_journaux cj on cj."JO_Num" = cse."JO_Num"
		join f_compteg cc on cse."CG_Num"=cc."CG_Num"
		WHERE 1<2 AND cj."JO_Num" <> 'RAN' AND cse."EC_Sens" = 1;
		
create view COMPTA_MOUVEMENT_DETAILS_GEN as
	select ID, CONTREP, COMPTE, DEBIT, CREDIT, LIBELLEPIECE, REMARQUE, MERE, COMPTE_AUX, LETTRAGE, JOURNAL, ETAT, DATY,
	  FOLIO, cast(COURSDEVISE as number(20,2)) as COURSDEVISE, cast(MONTANTDEVISE as number(20,2)) as MONTANTDEVISE
	from COMPTA_MOUVEMENT_DETAILGEN;

---------------------- SPAT_CAPITAINERIE ----------------------

create or replace view COMPTA_MOUVEMENT_DETAILS_GEN as
	select * from spat_compta.COMPTA_MOUVEMENT_DETAILS_GEN;