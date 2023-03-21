
CREATE OR REPLACE  VIEW FACTURE_CLIENT_UNION_ORDRE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTTTCVRAI, MONTANTTTC, MONTANTAVOIR, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, PAIEMENT, PAIEMENTLIB, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, ARMATEURLIB, EXERCICE, POURCOMPTE, POURCOMPTELIB, DATEDEPART, HEUREDEPART, DATEARRIVEE, HEUREARRIVEE, BATEAU, BATEAULIB, PROVENANCE, PROVENANCELIB, DESTINATION, DESTINATIONLIB, PAVILLON, PAVILLONLIB, MONTANTAPRED, MONTANTHTSIMPLE, MONTANTSANSREDUCTION) AS
  select fcu.ID,
       fcu.DATY,
       fcu.TIERS,
       fcu.DESIGNATION,
       fcu.TYPE,
       fcu.TVA,
       fcu.REMARQUE,
       fcu.IDUSER,
       fcu.DATE_ECHEANCE,
       cast(fcu.ETAT as number(10)),
       fcu.IDPREVISION,
       cast(fcu.MONTANT as number(30, 2)),
       cast(fcu.MONTANTTVA as number(30, 2)),
       cast(fcu.montantTTCvrai as number(30, 2)),
       cast(fcu.MONTANTTTC as NUMBER(30, 2)),
       cast(fcu.MONTANTAVOIR as NUMBER(30, 2)),
       cast(fcu.MONTANTPAYE as NUMBER(30, 2)),
       cast(fcu.MONTANTRESTE as NUMBER(30, 2)),
       fcu.TIERSLIB,
       fcu.CONTACT,
       fcu.ADRESSE,
       fcu.ESCALE,
       fcu.TYPELIB,
       fcu.IDCATEGORIE,
       fcu.CATEGORIELIB,
       fcu.IDPROVISION,
       fcu.IDPROVISIONLIB,
       fcu.DEVISEMERE,
       fcu.paiement,
       fcu.paiementlib,
       fcu.CODEPRESTATION,
       fcu.CODEPRESTATIONLIB,
       fcu.CODE,
       fcu.ESTMICTSL,
       fcu.CODEPROVISION,
       fcu.ETATLIB,
       fcu.ARMATEURLIB,
       fcu.EXERCICE,
       fcu.POURCOMPTE,
       fcu.POURCOMPTELIB,
       fcu.datedepart,
       fcu.heuredepart,
       fcu.datearrivee,
       fcu.heurearrivee,
       fcu.bateau,
       fcu.bateaulib,
       fcu.provenance,
       fcu.provenancelib,
       fcu.destination,
       fcu.destinationlib,
       fcu.pavillon,
       fcu.pavillonlib,
       cast(cg.MONTANTREDUCTION as NUMBER(30, 2))                      AS montantapRed,
       cast(cg.MONTANTHTSIMPLE as NUMBER(30, 2)),
       cast(nvl(cg.MONTANT + cg.MONTANTREDUCTION, 0) as NUMBER(30, 2)) as montantsansreduction
from facture_client_union fcu
         LEFT JOIN CAFCFILLECOMPLET_GRP cg ON fcu.ID = cg.IDMERE;

		 
		 

CREATE OR REPLACE VIEW FACTURECLIENTVALIDE
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, TYPECLIENTLIB, POURCOMPTE,
             POURCOMPTELIB, CODEFILTRE, PAIEMENT, PAIEMENTLIB, LHT, LM, TE, JNT, DATEDEPART, HEUREDEPART, DATEARRIVEE,
             HEUREARRIVEE, BATEAU, BATEAULIB, PROVENANCE, PROVENANCELIB, DESTINATION, DESTINATIONLIB, PAVILLON,
             PAVILLONLIB, NOMCLT, ADRCLT, NMSTTCLT, TELCLT, NIF, RC, DTTP, TP, DTQUIT, QUIT, CDCLT, montantapRed,
             MONTANTHTSIMPLE, montantsansreduction)
AS
SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       cast(fc.TVA as number(30, 2))                                   as TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(fc.MONTANT as NUMBER(30, 2))                               as MONTANT,
       cast(fc.MONTANTTVA as NUMBER(30, 2))                            as MONTANTTVA,
       cast(fc.MONTANTAVOIR as NUMBER(30, 2))                          as MONTANTAVOIR,
       cast(fc.MONTANTTTC as NUMBER(30, 2))                            as MONTANTTTC,
       cast(fc.MONTANTPAYE as NUMBER(30, 2))                           as MONTANTPAYE,
       cast(fc.MONTANTRESTE as NUMBER(30, 2))                          as MONTANTRESTE,
       fc.TIERSLIB,
       fc.CONTACT,
       fc.ADRESSE,
       fc.IDPREVISION,
       fc.ESCALE,
       fc.ETATLIB,
       fc.TYPELIB,
       fc.IDCATEGORIE,
       fc.CATEGORIELIB,
       fc.IDPROVISION,
       fc.IDPROVISIONLIB,
       fc.DEVISEMERE,
       fc.CODEPRESTATION,
       fc.CODEPRESTATIONLIB,
       fc.CODE,
       ESTMICTSL,
       CAST(fc.MONTANTTTCVRAI AS NUMBER(35, 2))                        AS MONTANTTTCVRAI,
       fc.ARMATEURLIB,
       EXERCICE,
       nvl(fc.typelib, '-')                                            as typeclientlib,
       fc.pourcompte,
       fc.pourcomptelib,
       fc.code                                                         as codeFiltre,
       fc.paiement,
       fc.paiementlib,
       cast(fc.LHT as NUMBER(30, 2))                                   AS LHT,
       cast(fc.LM as NUMBER(30, 2))                                    AS LM,
       cast(fc.TE as NUMBER(30, 3))                                    AS TE,
       cast(fc.JNT as NUMBER(30, 2))                                   AS JNT,
       fc.datedepart,
       fc.heuredepart,
       fc.datearrivee,
       fc.heurearrivee,
       fc.bateau,
       fc.bateaulib,
       fc.provenance,
       fc.provenancelib,
       fc.destination,
       fc.destinationlib,
       fc.pavillon,
       fc.pavillonlib,
       fc.nomclt,
       fc.adrclt,
       fc.nmsttclt,
       fc.telclt,
       fc.nif,
       fc.rc,
       fc.dttp,
       fc.tp,
       fc.dtquit,
       fc.quit,
       fc.cdclt,
       cast(cg.MONTANTREDUCTION as NUMBER(30, 2))                      AS montantapRed,
       cast(cg.MONTANTHTSIMPLE as NUMBER(30, 2)),
       cast(nvl(cg.MONTANT + cg.MONTANTREDUCTION, 0) as NUMBER(30, 2)) as montantsansreduction
FROM facture_client_union fc
         LEFT JOIN CAFCFILLECOMPLET_GRP cg ON fc.ID = cg.IDMERE
WHERE fc.id NOT IN (SELECT id FROM ProvisionFactureDefinitive);

CREATE OR REPLACE VIEW TRAITE_FCLIB AS 
	SELECT t.IDTRAITE ,f.id AS idfact,f.code FROM TRAITE_FC t LEFT JOIN FACTURE_CLIENT_UNION2 f ON t.IDFC = f.ID ;

CREATE OR REPLACE VIEW JOURNALAVISCREDIT AS 
	SELECT *FROM JOURNALCAISSELIBCOMPLET j 
	WHERE 
		 DESCECAISSE ='Banque' 
			AND (SELECT count(id) FROM PAIEMENTFACTURE WHERE idmvt=j.id ) > 0
			 	AND IDCAISSE !='CAIS00000T00016' AND IDMODE !='pay6' ;-- caisse et MODE traite
				

				
CREATE OR REPLACE VIEW PAIEMENTFACTLIB AS
SELECT p.*, fc.code
FROM PAIEMENTFACTURE p
         LEFT JOIN FACTURE_CLIENT_UNION_TOUS fc ON p.IDFACT = fc.id;


CREATE OR REPLACE VIEW PAIEMENTFACTLIB_GRP AS
SELECT P.IDMVT,
       listagg(code, ';') WITHIN GROUP (ORDER BY code desc) as codefacture
FROM PAIEMENTFACTLIB p
group by p.IDMVT;

CREATE OR REPLACE  VIEW JOURNALCAISSELIBRECETTE AS
select ID,DATESAISIE,DATEEFFET,FOLIO,CAISSE,NUMPIECE,LIBELLE,DEBIT,CREDIT,REMARQUE,ETAT,TIERS,IDTYPECHEQUE,DESIGNATION,IDDEVISE,IDMODE,NUMCHEQUE,TYPEMVT,IDORDRE,IDPLACEMENT,IDCAISSE,VALCAISSE,DESCECAISSE,VALTYPECHEQUE,DESCETYPECHEQUE,TIERSLIB,CODETIERS,IDBANQUE,IDBANQUELIB,NUMEROOP
,gr.CODEFACTURE 
from  journalcaisselibcomplet j
left join PAIEMENTFACTLIB_GRP gr on gr.IDMVT = j.id
where credit>0;

CREATE OR REPLACE  VIEW etatjournalcaisselibrecette AS
SELECT ID,
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
       CODEFACTURE
FROM journalcaisselibrecette j
WHERE idcaisse IN ('CAI0000000010174129', 'CAIS000014', 'CAIS000015');

-- JOURNALCAISSELIB_SANSPROV source

CREATE OR REPLACE  VIEW JOURNALCAISSELIB_SANSPROV AS
select jc.ID,jc.DATESAISIE,jc.DATEEFFET,jc.FOLIO,jc.CAISSE,jc.NUMPIECE,jc.LIBELLE,jc.DEBIT,jc.CREDIT,jc.REMARQUE,jc.ETAT,jc.TIERS
  ,jc.IDTYPECHEQUE,jc.DESIGNATION,jc.IDDEVISE,jc.IDMODE,jc.NUMCHEQUE,jc.TYPEMVT,jc.IDORDRE,jc.IDPLACEMENT,jc.IDCAISSE
  ,jc.VALCAISSE,jc.DESCECAISSE,jc.VALTYPECHEQUE,jc.DESCETYPECHEQUE,jc.TIERSLIB,jc.CODETIERS,jc.IDBANQUE,jc.IDBANQUELIB,jc.NUMEROOP,jc.CODEFACTURE from journalcaisselibrecette jc left outer join PROVISIONFACTURETOUS pr on pr.id=jc.idplacement
where pr.id is NULL;


-- JOURNALCAISSELIB_PROVISION source

CREATE OR REPLACE  VIEW JOURNALCAISSELIB_PROVISION 
as select jc.ID,jc.DATESAISIE,jc.DATEEFFET,jc.FOLIO,jc.CAISSE,jc.NUMPIECE,jc.LIBELLE,jc.DEBIT,jc.CREDIT
  ,jc.REMARQUE,jc.ETAT,jc.TIERS,jc.IDTYPECHEQUE,jc.DESIGNATION,jc.IDDEVISE,jc.IDMODE
  ,jc.NUMCHEQUE,jc.TYPEMVT,jc.IDORDRE,jc.IDPLACEMENT,jc.IDCAISSE,jc.VALCAISSE,jc.DESCECAISSE
  ,jc.VALTYPECHEQUE,jc.DESCETYPECHEQUE,jc.TIERSLIB,jc.CODETIERS,jc.IDBANQUE,jc.IDBANQUELIB,jc.NUMEROOP,jc.CODEFACTURE from journalcaisselibrecette jc join PROVISIONFACTURETOUS pr on pr.id=jc.idplacement;

 
CREATE OR REPLACE  VIEW JOURNALAVISCREDIT AS
SELECT ID,DATESAISIE,DATEEFFET,FOLIO,CAISSE,NUMPIECE,LIBELLE,DEBIT,CREDIT,REMARQUE,ETAT,TIERS,IDTYPECHEQUE,DESIGNATION,IDDEVISE,IDMODE,NUMCHEQUE,TYPEMVT,IDORDRE,IDPLACEMENT,IDCAISSE,VALCAISSE,DESCECAISSE,VALTYPECHEQUE,DESCETYPECHEQUE,TIERSLIB,CODETIERS,IDBANQUE,IDBANQUELIB,NUMEROOP,CODEFACTURE FROM JOURNALCAISSELIBRECETTE j 
WHERE DESCECAISSE ='Banque' 
			AND (SELECT count(id) FROM PAIEMENTFACTURE WHERE idmvt=j.id ) > 0 
			 	AND IDCAISSE !='CAIS00000T00016' AND IDMODE !='pay6'; 
				
				
				
CREATE OR REPLACE VIEW TRAITELIB_GRP AS
SELECT  IDTRAITE,LISTAGG(CODE , ';') WITHIN GROUP (ORDER BY CODE) AS CODE FROM TRAITE_FCLIB tf
GROUP BY IDTRAITE;


CREATE OR REPLACE  VIEW MVTINTRACAISSETRAITEV AS 
SELECT 
mic.ID,mic.DATY,mic.CAISSEDEPART,mic.CAISSEARRIVEE,mic.MONTANT,mic.MODEPAIEMENT,mic.REMARQUE,mic.ETAT,mic.DESIGNATION,mic.IDTRAITE,mic.ETATVERSEMENT,mic.IDFINALEDESTINATION,
t.Dateecheance,t.reference,t.tiers,t.CDCLT AS codeclient,
c1.val AS caissedepartlib,
c2.val AS caissearriveelib,
m.Desce as modepaiementlib,
 case
           when mic.etat = 1 then 'CREE'
           when mic.etat >= 11 then 'VISE'
           else '' end                           as etatlib,
 case
           when mic.etatversement = -2 then 'encaissée'
           when mic.etatversement = 11 then 'versée'
           else '' end                           as etatversementlib,
           c3.val AS finaledestinationlib,
grp.code AS facture
from mvtintracaisse mic
JOIN traite_lib t on t.id = mic.idtraite
LEFT JOIN CAISSE C1 on C1.id = mic.caissedepart
LEFT JOIN CAISSE C2 on C2.id = mic.caissearrivee
LEFT JOIN caisse C3 ON c3.id= mic.IDFINALEDESTINATION 
LEFT JOIN MODEPAIEMENT m on m.id = mic.modepaiement
LEFT JOIN TRAITELIB_GRP grp ON mic.IDTRAITE = grp.idTraite
 where mic.etatversement = 11 AND mic.IDTRAITE NOT IN (SELECT IDTRAITE FROM mvtintracaisse WHERE ETATVERSEMENT  = -2);
 
 
 
create or replace view TRAITE_LIBC as
SELECT ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib,MONTANTRESTE,reference  from TRAITEMTTRESTE where etat = 1;
create or replace view TRAITE_LIBV as
select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib,MONTANTRESTE,reference from TRAITEMTTRESTE where etat = 11;

create or replace view TRAITE_LIBESC as
select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib,MONTANTRESTE,reference from TRAITEMTTRESTE where id in (select idtraite from escompte where etat = 11);

create or replace view TRAITE_LIBVER as
select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib,MONTANTRESTE,reference from TRAITEMTTRESTE where etatversement= 11;

create or replace view TRAITE_LIBNONENC as
select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib,MONTANTRESTE,reference from TRAITEMTTRESTE where etatversement= 11;

create or replace view TRAITE_LIBENC as
select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib,MONTANTRESTE, reference from TRAITEMTTRESTE where etatversement = -2;


select * from TRAITE_LIBC

  CREATE OR REPLACE FORCE VIEW TRAITE_LIBC" ("ID", "DATY", "TIERS", "BANQUE", "DATEECHEANCE", "ETAT", "MONTANT", "ETATVERSEMENT", "ETATVERSEMENTLIB", "MONTANTRESTE", "REFERENCE") AS
  SELECT ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib,MONTANTRESTE,reference  from TRAITEMTTRESTE where etat = 1






 