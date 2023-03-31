-----------create
CREATE OR REPLACE VIEW JOURNALCAISSE_BORDEREAUPAIE as
SELECT
	j.id,
	o.id AS idordre,
	opff.id AS idff ,
	code AS numfact ,
	o.montant AS montanttotal,
	opff.montant,
	ti.nom AS tierslib,
	j.CAISSE,
	opff.daty,
	j.DATESAISIE,
	j.DESIGNATION,
	j.NUMCHEQUE 
FROM
	JOURNALCAISSE j
LEFT JOIN ORDONNERPAYEMENT o ON
	o.ID = j.IDORDRE
LEFT JOIN liaisonopff opff ON
	opff.id2 = o.ID
LEFT JOIN FOURNISSEUR_UNION_PERSONNEL ti ON
	ti.id = j.TIERS;
	
------------add column code

CREATE OR REPLACE  VIEW JOURNALCAISSELIBCOMPLET (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, TIERS, IDTYPECHEQUE, DESIGNATION, IDDEVISE, IDMODE, NUMCHEQUE, TYPEMVT, IDORDRE, IDPLACEMENT, IDCAISSE, VALCAISSE, DESCECAISSE, VALTYPECHEQUE, DESCETYPECHEQUE, TIERSLIB, CODETIERS, IDBANQUE, IDBANQUELIB, NUMEROOP, TYPE, TYPELIB, IDTRAITE,code) AS 
  SELECT j.ID,
       j.DATESAISIE,
       j.DATEEFFET,
       j.FOLIO,
       j.CAISSE,
       j.NUMPIECE,
       j.LIBELLE,
       cast(j.DEBIT as number(30,2)),
       cast(j.CREDIT as number(30,2)),
       j.REMARQUE,
       j.ETAT,
       j.TIERS,
       j.IDTYPECHEQUE,
       j.DESIGNATION,
       j.IDDEVISE,
       j.IDMODE,
       j.NUMCHEQUE,
       j.TYPEMVT,
       j.IDORDRE,
       j.IDPLACEMENT,
       c.ID    AS idcaisse,
       c.val   AS valcaisse,
       c.desce AS descecaisse,
       tc.val  AS valtypecheque,
       m.val   AS descetypecheque,
       ti.NOM  AS tierslib,
       ti.CDCLT AS codetiers,
       j.IDBANQUE,
       b.val as idbanquelib,
        op.NUMEROOP,
        fc.idcategorie AS TYPE,
       categ.VAL AS typelib,
	    j.IDTRAITE,
	    fc.code
FROM Journalcaisse j
         JOIN CAISSE C
              ON j.CAISSE = C.ID
         LEFT JOIN TYPECHEQUE tc ON tc.id = j.idtypecheque
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL ti ON ti.id = j.TIERS
         LEFT JOIN MODEPAIEMENT m on j.idmode = m.id
         LEFT JOIN BANQUE b on j.idbanque = b.ID
         left join ORDONNERPAYEMENT op on op.id=j.IDORDRE
         left join factureclient fc on fc.id=j.idplacement
         LEFT JOIN CATEGORIEFC categ ON categ.ID = fc.idcategorie;
   
 
---------create view
CREATE OR REPLACE  VIEW FACTURECLIENTVALIDE_tous (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, TYPECLIENTLIB, POURCOMPTE, POURCOMPTELIB, CODEFILTRE, PAIEMENT, PAIEMENTLIB, LHT, LM, TE, JNT, DATEDEPART, HEUREDEPART, DATEARRIVEE, HEUREARRIVEE, BATEAU, BATEAULIB, PROVENANCE, PROVENANCELIB, DESTINATION, DESTINATIONLIB, PAVILLON, PAVILLONLIB, NOMCLT, ADRCLT, NMSTTCLT, TELCLT, NIF, RC, DTTP, TP, DTQUIT, QUIT, CDCLT, MONTANTAPRED, MONTANTHTSIMPLE, MONTANTSANSREDUCTION) AS 
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
         LEFT JOIN CAFCFILLECOMPLET_GRP cg ON fc.ID = cg.IDMERE;



	
INSERT INTO MODEPAIEMENT
(ID, VAL, DESCE)
VALUES('pay9', 'Régularisation par Avoirs', 'Régularisation par Avoirs');

INSERT INTO CAISSE
(ID, VAL, DESCE, NUMERO, "TYPE")
VALUES('CAI0000000017083858', 'Caisse avoir', 'Caisse', NULL, NULL);

ALTER TABLE FactureClientAvoir 
ADD daty DATE NOT NULL;
 -----------------alter table
       
        
ALTER TABLE caisse add
rangsitcptcrt integer;

ALTER TABLE caisse add
placesitcptcrt integer;

--------add column rangsitcptcrt,placesitcptcrt
CREATE OR REPLACE  VIEW REPORTDETAILSCAISSE (ID, IDMERE, IDINGREDIENT, IDUSER, QUANTITER, EXPLICATION, ETAT, IDCATEGORIEINGREDIENT, DATY, IDING, UNITE, COMPOSE, IDCATING,RANGSITCPTCRT,PLACESITCPTCRT) AS 
  SELECT r.id,
          '' AS idmere,
          c.val AS idingredient,
          '' AS iduser,
          r.montant AS quantiter,
          '' AS explication,
          r.etat,
          '' AS idcategorieingredient,
          r.daty,
          r.caisse AS iding,
          r.devise AS unite,
          '' AS COMPOSE,
          '' AS idcating,
          c.RANGSITCPTCRT,
          c.PLACESITCPTCRT 
     FROM report r JOIN caisse c ON r.caisse = c.id
    WHERE r.etat >= 11;
   
   ---------------
   create or replace view FACTURECLIENT_EMISE_TOUS
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, CODEFILTRE, VAL,
             DESCE, TYPELIB, NUMPIECE, NBJOURS, MONTANTPROV, ORDRE)
as
select fact.ID,
       fact.DATY,
       fact.TIERS,
       fact.DESIGNATION,
       fact.TYPE,
       CAST(fact.TVA AS NUMBER(20, 3))           AS tva,
       fact.REMARQUE,
       fact.IDUSER,
       fact.DATE_ECHEANCE,
       CAST(fact.ETAT AS NUMBER(10))             AS etat,
       CAST(nvl(fact.MONTANT, 0) AS NUMBER(32, 3)),
       CAST(nvl(fact.MONTANTTVA, 0) AS NUMBER(32, 3)),
       CAST(nvl(fact.MONTANTAVOIR, 0) AS NUMBER(32, 3)),
       CAST(nvl(fact.MONTANTTTC, 0) AS NUMBER(32, 3)),
       CAST(nvl(fact.MONTANTPAYE, 0) AS NUMBER(32, 3)),
       CAST(nvl(fact.MONTANTRESTE, 0) AS NUMBER(32, 3)),
       fact.TIERSLIB,
       fact.CONTACT,
       fact.ADRESSE,
       fact.IDPREVISION,
       fact.ESCALE,
       fact.ETATLIB,
       fact.IDCATEGORIE,
       fact.CATEGORIELIB,
       fact.IDPROVISION,
       fact.IDPROVISIONLIB,
       fact.DEVISEMERE,
       fact.codePrestation,
       fact.codePrestationlib,
       fact.code,
       fact.ESTMICTSL,
       fact.CODEPROVISION,
       CAST(nvl(fact.MONTANTTTCVRAI, 0) AS NUMBER(32, 3)),
       fact.ARMATEURLIB,
       fact.EXERCICE,
       fact.CODEFILTRE,
       fact.VAL,
       fact.DESCE,
       fact.TYPELIB,
       fact.NUMPIECE,
       CASE
           WHEN (fact.DATE_ECHEANCE - current_date) > 0
               THEN CAST((fact.DATE_ECHEANCE - current_date) AS integer)
           ELSE 0
           END                                   AS nbjours,
       cast(nvl(PF.montant, 0) as number(30, 2)) as montantprov
        ,
       cast(CASE
                WHEN fact.idcategorie = 'CATFCO1' then 18
                WHEN fact.type = 'TFC002' AND VAL = '01A' THEN 1
                WHEN fact.type = 'TFC002' AND VAL = '03A' THEN 2
                WHEN fact.type = 'TFC002' AND VAL = '05A' THEN 3
                WHEN fact.type = 'TFC002' AND VAL = '06A' THEN 4
                WHEN fact.type = 'TFC002' AND VAL = '07A' THEN 5
                WHEN fact.type = 'TFC002' AND VAL = '08A' THEN 6
                WHEN fact.type = 'TFC002' AND VAL = '09A' THEN 7

                WHEN fact.type = 'TFC001' AND VAL = '01A' THEN 8
                WHEN fact.type = 'TFC001' AND VAL = '03A' THEN 9
                WHEN fact.type = 'TFC001' AND VAL = '05A' THEN 10
                WHEN fact.type = 'TFC001' AND VAL = '06A' THEN 11
                WHEN fact.type = 'TFC001' AND VAL = '07A' THEN 12
                WHEN fact.type = 'TFC001' AND VAL = '08A' THEN 13
                WHEN fact.type = 'TFC001' AND VAL = '09A' THEN 14
                WHEN fact.idcategorie = 'CATFCO2' then 15
                WHEN fact.idcategorie = 'CATFCO3' then 16
                when fact.VAL = 'MC' THEN 17
           END as number(10))                    AS ORDRE
FROM (
         select *
         FROM FACTURE_CLIENT_MICTSL
         union
         select *
         FROM FACTURE_CLIENT_SANS_MICTSL) fact
         LEFT JOIN PMENTFACTHORSPROVAVPROVCPLT PF on PF.idfact = fact.id and pf.idprovision = fact.idprovision;
   


