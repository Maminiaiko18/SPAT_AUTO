create OR REPLACE view FACTURE_CLIENT_UNION_TOUS as
select fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       CAST(fc.MONTANT AS NUMBER(35, 2))        AS MONTANT,
       CAST(fc.MONTANTTVA AS NUMBER(35, 2))     AS MONTANTTVA,
       CAST(fc.MONTANTAVOIR AS NUMBER(35, 2))   AS MONTANTAVOIR,
       CAST(fc.MONTANTTTC AS NUMBER(35, 2))     AS MONTANTTTC,
       CAST(fc.MONTANTPAYE AS NUMBER(35, 2))    AS MONTANTPAYE,
       CAST(fc.MONTANTRESTE AS NUMBER(35, 2))   AS MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       ETATLIB,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       fc.CODE,
       ESTMICTSL,
       CODEPROVISION,
       CAST(fc.MONTANTTTCVRAI AS NUMBER(35, 2)) AS MONTANTTTCVRAI,
       fc.ARMATEURLIB,
       fc.EXERCICE,
       fc.code                                  as codeFiltre,
       fc.IDAVOIR,
       fc.POURCOMPTE,
       fc.POURCOMPTELIB,
       fc.ARMATEUR,
       fc.PAIEMENT,
       fc.PAIEMENTLIB,
       fc.LHT,
       fc.LM,
       fc.TE,
       fc.JNT,
       fc.DATEDEPART,
       fc.HEUREDEPART,
       fc.DATEARRIVEE,
       fc.HEUREARRIVEE,
       fc.BATEAU,
       fc.BATEAULIB,
       fc.PROVENANCE,
       fc.PROVENANCELIB,
       fc.DESTINATION,
       fc.DESTINATIONLIB,
       fc.PAVILLON,
       fc.PAVILLONLIB,
       fc.NOMCLT,
       fc.ADRCLT,
       fc.NMSTTCLT,
       fc.TELCLT,
       fc.NIF,
       fc.rc,
       fc.DTTP,
       fc.tp,
       fc.DTQUIT,
       fc.QUIT,
       fc.cdclt,
       fcnp.NUMPIECE
from facture_client_union fc
    LEFT JOIN facture_client_np fcnp ON fcnp.id = fc.id;


CREATE OR REPLACE VIEW  FACTURE_CLIENT_MICTSL
			(ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, CODEFILTRE, VAL,
             DESCE, TYPELIB,NUMPIECE)
 AS
select fc.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       ETAT,
       MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       ETATLIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       MONTANTTTCVRAI,
       ARMATEURLIB,
       EXERCICE,
       CODEFILTRE,
       'MC'                 as val,
       'MICTSL'             as desce,
       case
           when code like '3%' then 'PROFORMA A PAYER'
           when code like '5%' then 'DDE DE PRIX'
           else TYPELIB end AS TYPELIB
        ,fc.NUMPIECE
from FACTURE_CLIENT_UNION_TOUS fc
         left join RUBRIQUE_FACT_EMISES rfe on code like '%' || rfe.val || '%'
where (tiers = '0120037' or tiers = 'clt1' or tiers = 'TIE000499134559')
  and (lower(substr(code, 6, 1)) in ('a') or (lower(substr(code, 6, 2)) in ('rv')));



create or replace view FACTURECLIENT_EMISE_TOUS
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, CODEFILTRE, VAL,
             DESCE, TYPELIB, NUMPIECE,nbjours)
as
select ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       CAST(TVA AS NUMBER(20, 3)) AS tva,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       CAST(ETAT AS NUMBER(10))   AS etat,
       CAST(MONTANT AS NUMBER(32, 3)),
       CAST(MONTANTTVA AS NUMBER(32, 3)),
       CAST(MONTANTAVOIR AS NUMBER(32, 3)),
       CAST(MONTANTTTC AS NUMBER(32, 3)),
       CAST(MONTANTPAYE AS NUMBER(32, 3)),
       CAST(MONTANTRESTE AS NUMBER(32, 3)),
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       ETATLIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       DEVISEMERE,
       codePrestation,
       codePrestationlib,
       code,
       ESTMICTSL,
       CODEPROVISION,
       CAST(MONTANTTTCVRAI AS NUMBER(32, 3)),
       ARMATEURLIB,
       EXERCICE,
       CODEFILTRE,
       VAL,
       DESCE,
       TYPELIB,
       NUMPIECE,
       CASE
		WHEN (DATE_ECHEANCE - current_date) >0
		THEN CAST((DATE_ECHEANCE - current_date) AS integer)
	ELSE  0
	END AS nbjours
FROM (
         select *FROM FACTURE_CLIENT_MICTSL
         union
         select * FROM FACTURE_CLIENT_SANS_MICTSL);

		 
		 
CREATE OR REPLACE  view FACTURECLIENT_EMISE_VALIDE AS
select FC.*
from FACTURECLIENT_EMISE_TOUS FC
WHERE
	fc.id NOT IN (
	SELECT
		id
	FROM
		ProvisionFactureDefinitive);



CREATE OR REPLACE  view FACTURECLIENT_EMISE_CREE AS
select FC.*
from FACTURECLIENT_EMISE_TOUS FC
WHERE
	fc.etat = 1;

CREATE OR REPLACE  view FACTURECLIENT_EMISE_VISE AS
select FC.*
from FACTURECLIENT_EMISE_TOUS FC
WHERE
	fc.etat >= 11;

CREATE OR REPLACE  view FACTURECLIENT_EMISE_Apayer AS
select FC.*
from FACTURECLIENT_EMISE_TOUS FC
	where MONTANTRESTE > 0 AND  fc.etat >= 11;

CREATE OR REPLACE  view FACTURECLIENT_EMISE_AuComptant AS
select FC.*
from FACTURECLIENT_EMISE_TOUS FC
	where type = 'TFC002'
  and fc.etat >= 11;

CREATE OR REPLACE  view FACTURECLIENT_EMISE_ACredit AS
select FC.*
from FACTURECLIENT_EMISE_TOUS FC
	where type = 'TFC001'
  and fc.etat >= 11;

CREATE OR REPLACE  view FACTURECLIENT_EMISE_ANNULER AS
select FC.*
from FACTURECLIENT_EMISE_TOUS FC
	where  fc.etat=0;


CREATE OR REPLACE  view FACTURECLIENT_EMISE_ENRETARD AS
select FC.*
from FACTURECLIENT_EMISE_TOUS FC
WHERE DATE_ECHEANCE < to_date(CURRENT_DATE)
  AND MONTANTRESTE > 0;

CREATE OR REPLACE  view FACTURECLIENT_EMISE_ENALERTE AS
select FC.*
from FACTURECLIENT_EMISE_TOUS FC
where (CAST((fc.DATE_ECHEANCE - to_date(CURRENT_DATE)) AS integer)) <= 10
  AND (CAST((fc.DATE_ECHEANCE - to_date(CURRENT_DATE)) AS integer)) >= 0
  AND MONTANTRESTE > 0;

CREATE OR REPLACE  view FACTURECLIENT_EMISE_PAYEES AS
select FC.*
from FACTURECLIENT_EMISE_TOUS FC
where  fc.montantreste=0;
