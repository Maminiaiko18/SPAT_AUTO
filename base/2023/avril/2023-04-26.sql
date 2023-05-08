CREATE OR REPLACE VIEW MODEPAIEMENTBQ AS 
SELECT *FROM MODEPAIEMENT WHERE ID = 'pay1'
OR ID ='pay2' OR ID ='pay3' OR ID ='pay5';

INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USMO0000910', NULL, 'MEN00068', 'ROL000422', NULL, NULL, 0);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USMO0000911', NULL, 'MEN000681', 'ROL000422', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USMO0000912', NULL, 'MEN000684', 'ROL000422', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USMO0000913', NULL, 'MDO000040', 'ROL000422', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USMO0000914', NULL, 'MEN000664', 'ROL000422', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USMO0000915', NULL, 'MENLA001', 'ROL000422', NULL, NULL, 1);


CREATE OR REPLACE VIEW journalcaisselibdepenseVise  AS 
  SELECT
	ID,
	DATESAISIE,
	DATEEFFET,
	FOLIO,
	CAISSE,
	NUMPIECE,
	LIBELLE,
	CAST(DEBIT AS NUMBER(30,
	2)) AS debit,
	CAST(CREDIT AS NUMBER(30,
	2)) AS credit,
	REMARQUE,
	ETAT,
	TIERS,
	IDTYPECHEQUE,
	DESIGNATION,
	IDDEVISE,
	IDMODE,
	NUMCHEQUE,
	TYPEMVT,
	IDORDRE,
	IDPLACEMENT,
	IDCAISSE,
	VALCAISSE,
	DESCECAISSE,
	VALTYPECHEQUE,
	DESCETYPECHEQUE,
	TIERSLIB,
	IDBANQUE,
	IDBANQUELIB,
	NUMEROOP,
	CASE 
		WHEN 
			ETAT = 1 THEN 'Cree'
		WHEN
		ETAT = 11 THEN 'Vise'
	END AS ETATLIB
FROM
	JOURNALCAISSELIBDEPENSE WHERE  ETAT = 11;
	
	
	CREATE OR REPLACE  VIEW V_USERMENU AS 
  select
        um.id,
        u.LOGINUSER as Login,
        u.NOMUSER,
        u.REFUSER,
        menu.libelle as idmenu,
        um.idrole,
        um.codeservice,
        um.codedir,
        um.interdit
    from usermenu um
        join MENUDYNAMIQUELIB menu on menu.id = um.IDMENU
        join UTILISATEUR u on u.REFUSER = um.REFUSER;
		
		CREATE OR REPLACE
VIEW FCDEFPRLIB
AS
SELECT
	f.*,
	fc.code AS codeprov
FROM
	FCDEFPR f
JOIN FACTURECLIENT fc 
ON
	f.ID2 = fc.ID;

CREATE OR REPLACE VIEW LIAISONPROVDEF
AS
	SELECT p.*,
		CASE 
			WHEN
				(SELECT CODEPROV FROM FCDEFPRLIB f WHERE p.idfact =  f.id1 AND p.montant = f.montant AND f.etat = 11 ) IS NOT NULL 
					THEN (SELECT CODEPROV FROM FCDEFPRLIB f WHERE p.idfact =  f.id1 AND p.montant = f.montant AND f.etat = 11)
			ELSE
				(SELECT CODE FROM FACTURECLIENT WHERE ID = (SELECT IDPROVISION FROM FACTURECLIENT ff WHERE ff.id = p.idfact))
		END AS CODEPROVISION,
		case when fc.idcategorie like 'CATFCO1' then 'PROF'
       	when fc.idcategorie like 'CATFCO2' then 'PROV'
       	else 'FF' end as typefacture,
       	fc.code,
       	fc.daty
	FROM PAIEMENTFACTURE p JOIN FACTURECLIENT fc ON fc.id = p.IDFACT ;
	
	CREATE OR REPLACE
FORCE VIEW JOURNALCAISSELIBRECETTE AS 
  SELECT
	ID,
	DATESAISIE,
	DATEEFFET,
	FOLIO,
	CAISSE,
	NUMPIECE,
	LIBELLE,
	DEBIT,
	CREDIT,
	REMARQUE,
	ETAT,
	TIERS,
	IDTYPECHEQUE,
	DESIGNATION,
	IDDEVISE,
	IDMODE,
	NUMCHEQUE,
	TYPEMVT,
	IDORDRE,
	IDPLACEMENT,
	IDCAISSE,
	VALCAISSE,
	DESCECAISSE,
	VALTYPECHEQUE,
	DESCETYPECHEQUE,
	TIERSLIB,
	CODETIERS,
	IDBANQUE,
	IDBANQUELIB,
	NUMEROOP,
	gr.CODEFACTURE,
	CASE 
		WHEN 
			ETAT = 1 THEN 'Cree'
		WHEN
		ETAT = 11 THEN 'Vise'
	END AS ETATLIB
FROM
	journalcaisselibcomplet j
LEFT JOIN PAIEMENTFACTLIB_GRP gr ON
	gr.IDMVT = j.id
WHERE
	credit>0;
	
	
	CREATE OR REPLACE
 VIEW JOURNALCAISSELIBRECETTEBANQUET AS 
  SELECT
	ID,
	DATESAISIE,
	DATEEFFET,
	FOLIO,
	CAISSE,
	NUMPIECE,
	LIBELLE,
	CAST(DEBIT AS NUMBER(30,
	2)) AS DEBIT,
	CAST(CREDIT AS NUMBER(30,
	2)) AS CREDIT ,
	REMARQUE,
	ETAT,
	TIERS,
	IDTYPECHEQUE,
	DESIGNATION,
	IDDEVISE,
	IDMODE,
	NUMCHEQUE,
	TYPEMVT,
	IDORDRE,
	IDPLACEMENT,
	IDCAISSE,
	VALCAISSE,
	DESCECAISSE,
	VALTYPECHEQUE,
	DESCETYPECHEQUE,
	TIERSLIB,
	IDBANQUE,
	IDBANQUELIB,
	NUMEROOP,
	ETATLIB
FROM
	journalcaisselibrecette
WHERE
	DESCECAISSE = 'Banque'
	AND VALCAISSE != 'Traite'
;

CREATE OR REPLACE
 VIEW JOURNALCAISSELIBRECETTEBANQUEC AS 
  SELECT
	ID,
	DATESAISIE,
	DATEEFFET,
	FOLIO,
	CAISSE,
	NUMPIECE,
	LIBELLE,
	DEBIT,
	CREDIT,
	REMARQUE,
	ETAT,
	TIERS,
	IDTYPECHEQUE,
	DESIGNATION,
	IDDEVISE,
	IDMODE,
	NUMCHEQUE,
	TYPEMVT,
	IDORDRE,
	IDPLACEMENT,
	IDCAISSE,
	VALCAISSE,
	DESCECAISSE,
	VALTYPECHEQUE,
	DESCETYPECHEQUE,
	TIERSLIB,
	IDBANQUE,
	IDBANQUELIB,
	NUMEROOP,
	ETATLIB
	FROM journalcaisselibrecetteBanqueT
WHERE
	ETAT = 1;
	
	CREATE OR REPLACE
 VIEW JOURNALCAISSELIBRECETTEBANQUEV AS 
  SELECT
	ID,
	DATESAISIE,
	DATEEFFET,
	FOLIO,
	CAISSE,
	NUMPIECE,
	LIBELLE,
	DEBIT,
	CREDIT,
	REMARQUE,
	ETAT,
	TIERS,
	IDTYPECHEQUE,
	DESIGNATION,
	IDDEVISE,
	IDMODE,
	NUMCHEQUE,
	TYPEMVT,
	IDORDRE,
	IDPLACEMENT,
	IDCAISSE,
	VALCAISSE,
	DESCECAISSE,
	VALTYPECHEQUE,
	DESCETYPECHEQUE,
	TIERSLIB,
	IDBANQUE,
	IDBANQUELIB,
	NUMEROOP,
	ETATLIB
	FROM journalcaisselibrecetteBanqueT
WHERE
	ETAT = 11;
	
	
	CREATE OR REPLACE VIEW AS_BONDECOMMANDE_LIBELLE_LIB (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA, MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET, CODE_ETAB, MONTANTFACTURE, ETATLIB, MONTANTREMISE, IDENGAGEMENTLIB, IDENGAGEMENT, CODEETABLISSEMENT, COMPTEBDG, MONTANTHTSANSREMISE) AS 
  select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                                                      as fournisseur,
       cast(bc.tva as NUMBER(10)),
       bc.NUMBC,
       cast(nvl(c.montantht, 0) as number(32, 2)),
       cast(nvl(c.montanttva, 0) as number(32, 2)),
       cast(nvl(c.montantttc, 0) as NUMBER(32, 2)),
       ''                                                                          as idfacture,
       cast(nvl(lfac.montantpayer, 0) as number(32, 2))                            as montant_paye_reel,
       cast((nvl(c.montantttc, 0) - nvl((bl.MONTANTTTC), 0)) as NUMBER(32, 2))     as resteapayegeneral,
       cast((nvl(c.montantttc, 0) - nvl((lfac.montantpayer), 0)) as NUMBER(32, 2)) as resteapayerreel,
       cast(nvl(bl.montantttc, 0) as NUMBER(32, 2))                                as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       cast(lfac.montantttc as NUMBER(32, 2))                                      as montantfacture,
       case
           when bc.etat = 0 then 'ANNULE(E)'
           when bcf.RESTELIVRE > 0 then 'VISE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE(E)'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and
                (lfac.montantttc - nvl(lfac.montantpayer, 0) is not null)
               THEN 'FACTURE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) > 0
               THEN 'EN ATTENTE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYE(E)'
           else 'CREE(E)'
           END                                                                     as etatlib,
       cast(MONTANTREMISE as NUMBER(32, 2)),
       idengagementlib,
       bc.IDENGAGEMENT,
       CODEETABLISSEMENT,
       CODE_ETAB || PROJET                                                       as comptebdg    ,
       CAST((c.montantht + montantremise) AS number(30 , 3)) AS montantHTSansRemise
from AS_BONDECOMMANDE_LIBELLE bc
     left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
     left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
     left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
     LEFT JOIN AS_BONDELIVRAISON_BC bl on bl.id_bc=bc.id
     left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur;
		


