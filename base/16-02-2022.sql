

CREATE OR REPLACE  VIEW JOURNALCAISSELIBCOMPLET (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, TIERS, IDTYPECHEQUE, DESIGNATION, IDDEVISE, IDMODE, NUMCHEQUE, TYPEMVT, IDORDRE, IDPLACEMENT, IDCAISSE, VALCAISSE, DESCECAISSE, VALTYPECHEQUE, DESCETYPECHEQUE, TIERSLIB, IDBANQUE, IDBANQUELIB, NUMEROOP, TYPE, TYPELIB,idtraite) AS 
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
       j.IDBANQUE,
       b.val as idbanquelib,
        op.NUMEROOP,
        fc.idcategorie AS TYPE,
       categ.VAL AS typelib,
       j.IDTRAITE 
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


        
    CREATE OR REPLACE  VIEW JOURNALCAISSELIB (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, TIERS, IDTYPECHEQUE, IDPLACEMENT, IDORDRE, DESCECAISSE,idtraite) AS 
  SELECT id,
          datesaisie,
          dateeffet,
          folio,
          valcaisse AS caisse,
          numpiece,
          libelle,
          debit,
          credit,
          remarque,
          etat,
          tiers,
          valtypecheque AS idtypecheque,
          idplacement,
		  idordre,
		  descecaisse,
		  idtraite
     FROM journalcaisselibcomplet;


    
    CREATE OR REPLACE  VIEW JOURNALCAISSELIB_VISE (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, TIERS, IDTYPECHEQUE, IDPLACEMENT, TIERSLIB, IDORDRE, DESCECAISSE,idtraite) AS 
  SELECT jc.ID,
          jc.DATESAISIE,
          jc.DATEEFFET,
          jc.FOLIO,
          jc.CAISSE,
          jc.NUMPIECE,
          jc.LIBELLE,
          jc.DEBIT,
          jc.CREDIT,
          jc.REMARQUE,
          jc.ETAT,
          jc.TIERS,
          jc.IDTYPECHEQUE,
          jc.IDPLACEMENT,
          fup.NOM AS tierslib,
          jc.idordre,
          jc.descecaisse,
          idtraite
     FROM journalcaisselib jc
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = jc.TIERS
          left join ordonnerpayement op on op.id=jc.idordre
    WHERE jc.etat >= 11;




CREATE OR REPLACE  VIEW PAIEMENTFC (ID, DATEEFFET, CAISSE, TIERSLIB, LIBELLE, MONTANT, IDFACT, ETAT, ETATLIB, VALCAISSE,idtraite) AS 
  select
    jc.id,
    JC.DATEEFFET,
    jc.caisse,
    jc.tierslib,
    jc.libelle,
    pf.montant,
    pf.idfact,
    jc.etat,
    CASE 
    	WHEN jc.etat = 1
    		THEN 'Créé'
        WHEN jc.ETAT >= 11
        	THEN 'visée'
        WHEN jc.ETAT =0
        	THEN 'Annulée'
    END AS etatlib,
    jc.desceCAISSE,
    jc.idtraite
    from
   journalcaisselib_vise jc
   left join paiementfacture pf
   on pf.idmvt=jc.id
;


-----------itokiana
CREATE OR REPLACE VIEW TRAITEMTTRESTE (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT, ESCOMPTE, TOTAL, REFERENCE, MONTANTRESTE, CDCLT, IDBANQUE, IDTYPEPIECE, TYPEPIECE) AS 
  SELECT t.ID,t.DATY,t.TIERS,t.BANQUE,t.DATEECHEANCE,t.ETAT,t.MONTANT,t.ESCOMPTE,t.TOTAL,t.REFERENCE,
 (t.total-tf. montantenlevetraite) AS montantreste, t.cdclt, t.idbanque,t.idtypepiece,
t.typepiece
 FROM TRAITE_LIBMTT t 
 LEFT JOIN traitemttfc tf ON tf.id=t.id
 


-----------------add column etatlib


CREATE OR REPLACE  VIEW TRAITEMTTRESTE_NONVERSEE (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT, ESCOMPTE, TOTAL, REFERENCE, MONTANTRESTE, CDCLT, IDBANQUE,etatlib) AS 
  SELECT ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT,ESCOMPTE,TOTAL,REFERENCE,MONTANTRESTE,CDCLT,IDBANQUE,etatlib FROM (
	SELECT t.ID,t.DATY,t.TIERS,t.BANQUE,t.DATEECHEANCE,t.ETAT,t.MONTANT,t.ESCOMPTE,t.TOTAL,t.REFERENCE,
 (t.total-tf. montantenlevetraite) AS montantreste, t.cdclt, t.idbanque, 
 CASE 
    	WHEN t.etat = 1
    		THEN 'Créé'
        WHEN t.etat = 11
        	THEN 'visée'
  END 
  AS etatlib
 FROM TRAITE_LIBMTT t 
 LEFT JOIN traitemttfc tf ON tf.id=t.id
) tmttrst WHERE id NOT IN (SELECT idtraite FROM MVTINTRACAISSE m WHERE m.idtraite IS NOT NULL AND m.ETATVERSEMENT = 11)
;

-------add column etatlib and etatversementlib
CREATE OR REPLACE VIEW mvtintracaissetraiteV AS select
mic.*,
t.Dateecheance,
c1.val AS caissedepartlib,
c2.val AS caissearriveelib,
m.Desce as modepaiementlib,
 case
           when mic.etat = 1 then 'CREE'
           when mic.etat >= 11 then 'VISE'
           else '' end                           as etatlib,
 case
           when mic.etatversement = -2 then 'versée'
           when mic.etatversement = 11 then 'encaissée'
           else '' end                           as etatversementlib
from mvtintracaisse mic
JOIN traite t on t.id = mic.idtraite
LEFT JOIN CAISSE C1 on C1.id = mic.caissedepart
LEFT JOIN CAISSE C2 on C2.id = mic.caissearrivee
LEFT JOIN MODEPAIEMENT m on m.id = mic.modepaiement
 where mic.etatversement = 11;
 
 
 
 
 
 
 CREATE OR REPLACE  VIEW TRAITEMTTRESTE (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT, ESCOMPTE, TOTAL, REFERENCE, MONTANTRESTE, CDCLT, IDBANQUE, IDTYPEPIECE, TYPEPIECE) AS 
  SELECT t.ID,t.DATY,t.TIERS,t.BANQUE,t.DATEECHEANCE,t.ETAT,CAST (t.MONTANT AS NUMBER(30,2)) AS montant,t.ESCOMPTE,CAST(t.TOTAL AS NUMBER(30,2)) AS total,t.REFERENCE,
 CAST((t.total-tf. montantenlevetraite) AS NUMBER(30,2)) AS montantreste, t.cdclt, t.idbanque,t.idtypepiece,
t.typepiece
 FROM TRAITE_LIBMTT t 
 LEFT JOIN traitemttfc tf ON tf.id=t.id;




CREATE OR REPLACE  VIEW TRAITE_FC (ID, IDTRAITE, IDFC, MONTANTFACTURE, MONTANTJC, MONTANT, DATY, ETAT, TIERS, BANQUE, FACTURECLIENTLIB,tierslib,etatlib) AS 
  select
	fc.ID,tl.id AS IDTRAITE,fc.id AS IDFC, FC.MONTANT as MONTANTFACTURE, j.CREDIT as MONTANTJC, pf.MONTANT,fc.DATY,fc.ETAT,
	tl.tiers,
	tl.banque,
	fc.designation as factureclientlib,
      fc.TIERSLIB,
      CASE 
    	WHEN j.etat = 1
    		THEN 'Créé'
        WHEN j.ETAT >= 11
        	THEN 'visée'
        WHEN j.ETAT =0
        	THEN 'Annulée'
    END AS etatlib
	from Paiementfacture pf
	LEFT JOIN JOURNALCAISSE j ON j.ID  = pf.IDMVT
    JOIN traite tl on tl.id = j.idtraite
	left join FACTURE_CLIENT_UNION2 fc on pf.IDFACT  = fc.id;



-----------insert in usermenu
INSERT INTO USERMENU (ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT) VALUES('UMENCA001', '*', 'MENFAC00010', '*', NULL, NULL, 1);
------modification condition
-- Modification condition
CREATE OR REPLACE VIEW MVTINTRACAISSETRAITEV (ID, DATY, CAISSEDEPART, CAISSEARRIVEE, MONTANT, MODEPAIEMENT, REMARQUE, ETAT, DESIGNATION, IDTRAITE, ETATVERSEMENT, IDFINALEDESTINATION, DATEECHEANCE, CAISSEDEPARTLIB, CAISSEARRIVEELIB, MODEPAIEMENTLIB, ETATLIB, ETATVERSEMENTLIB) AS 
  select
mic.ID,mic.DATY,mic.CAISSEDEPART,mic.CAISSEARRIVEE,mic.MONTANT,mic.MODEPAIEMENT,mic.REMARQUE,mic.ETAT,mic.DESIGNATION,mic.IDTRAITE,mic.ETATVERSEMENT,mic.IDFINALEDESTINATION,
t.Dateecheance,
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
           else '' end                           as etatversementlib
from mvtintracaisse mic
JOIN traite t on t.id = mic.idtraite
LEFT JOIN CAISSE C1 on C1.id = mic.caissedepart
LEFT JOIN CAISSE C2 on C2.id = mic.caissearrivee
LEFT JOIN MODEPAIEMENT m on m.id = mic.modepaiement
 where mic.etatversement = 11 AND mic.IDTRAITE NOT IN (SELECT IDTRAITE FROM mvtintracaisse WHERE ETATVERSEMENT  = -2)
;


CREATE OR REPLACE  VIEW AVOIRFC_MONTANTREGROUPLIBETAT (ID, CODE, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, MONTANTPAYE, MONTANTRESTE, ETATLIB) AS 
  SELECT op.ID,
		  op.CODE,
          op.DATY,
          op.IDFACTURE,
          op.ETAT,
          cast(op.MONTANT as number(30,3)) as MONTANT,
          op.TIERS,
          op.TIERSLIB,
          cast(op.MONTANTPAYE as number(30,3)) as MONTANTPAYE,
          cast(op.MONTANTRESTE as number(30,3)) as MONTANTRESTE,
          CASE
             WHEN op.etat = 0 THEN 'annule'
             WHEN op.etat = 1 THEN 'cree'
             WHEN op.etat = 11 THEN 'vise'
          END
             AS etatlib
     FROM AVOIRFC_MONTANT_REGROUP op;


CREATE OR REPLACE  VIEW UNION_AVOIRFF_MONTANT_REGROUP (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, MONTANTPAYE, MONTANTRESTE, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION) AS 
  SELECT ID,DATY,IDFACTURE,ETAT,CAST(MONTANT AS NUMBER(30,3)) AS MONTANT,TIERS,TIERSLIB,CAST(MONTANTPAYE AS NUMBER(30,3)) AS MONTANTPAYE,CAST(MONTANTRESTE AS NUMBER(30,3)) AS MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION
FROM 
(select ID,DATY,IDFACTURE,ETAT,CAST(MONTANT AS NUMBER(30,3)) AS MONTANT,TIERS,TIERSLIB,CAST(MONTANTPAYE AS NUMBER(30,3)) AS MONTANTPAYE,CAST(MONTANTRESTE AS NUMBER(30,3)) AS MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION 
  from AVOIRFF_MONTANT
    union
select ID,DATY,IDFACTURE,ETAT,CAST(montantttc AS NUMBER(30,3)) AS MONTANT,TIERS,TIERSLIB,CAST(MONTANTPAYE AS NUMBER(30,3)) AS MONTANTPAYE,CAST(MONTANTRESTE AS NUMBER(30,3)) AS MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION from 
AVOIRFC_MONTANT_REGROUP);






CREATE OR REPLACE VIEW TRAITE_FC AS
  select
	fc.ID,tl.id AS IDTRAITE,fc.id AS IDFC, FC.MONTANT as MONTANTFACTURE, j.CREDIT as MONTANTJC, pf.MONTANT,fc.DATY,fc.ETAT,
	tl.tiers,
	tl.banque,
	fc.designation as factureclientlib

	from Paiementfacture pf
	LEFT JOIN JOURNALCAISSE j ON j.ID  = pf.IDMVT
    JOIN traite tl on tl.id = j.idtraite
	left join FACTURE_CLIENT_UNION2 fc on pf.IDFACT  = fc.id;


create or replace view traiteetatversement as
select IDTRAITE, cast(-2 as number) as etatversement
from MVTINTRACAISSE
where IDTRAITE is not null
  and ETATVERSEMENT = -2
group by IDTRAITE
UNION ALL
select idtraite, cast(11 as number) as etatversement
from MVTINTRACAISSE
where idtraite is not null
  and ETATVERSEMENT = 11
  and IDTRAITE not in
      (select IDTRAITE from MVTINTRACAISSE where IDTRAITE is not null and ETATVERSEMENT = -2 group by IDTRAITE)
group by idtraite
;

create or replace view TRAITEMTTRESTE as
SELECT t.ID,
       t.DATY,
       t.TIERS,
       t.BANQUE,
       t.DATEECHEANCE,
       t.ETAT,
       CAST(t.MONTANT AS NUMBER(30, 2))                          AS montant,
       t.ESCOMPTE,
       CAST(t.TOTAL AS NUMBER(30, 2))                            AS total,
       t.REFERENCE,
       CAST((t.total - tf.montantenlevetraite) AS NUMBER(30, 2)) AS montantreste,
       t.cdclt,
       t.idbanque,
       t.idtypepiece,
       t.typepiece,
       nvl(te.etatversement, 1)                                  as etatversement,
       case
           when te.etatversement = -2 then 'Encaissée'
           when te.etatversement = 11 then 'Versée'
           else
               'Non Versée' end                                  as etatversementlib
FROM TRAITE_LIBMTT t
         LEFT JOIN traitemttfc tf ON tf.id = t.id
         LEFT JOIN traiteetatversement te on te.IDTRAITE = t.ID;

         --créé TRAITE_LIBC
create or replace view TRAITE_LIBC as
SELECT ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib  from TRAITEMTTRESTE where etat = 1;

--visé TRAITE_LIBV
create or replace view TRAITE_LIBV as
select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib from TRAITEMTTRESTE where etat = 11;

--escompté TRAITE_LIBESC
create or replace view TRAITE_LIBESC as
select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib from TRAITEMTTRESTE where id in (select idtraite from escompte where etat = 11);

--versé TRAITE_LIBVER
create or replace view TRAITE_LIBVER as
select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib from TRAITEMTTRESTE where etatversement= 11
    --id in (select idtraite from mvtintracaisse)
;

--non encaissé TRAITE_LIBNONENC
create or replace view TRAITE_LIBNONENC as
select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib from TRAITEMTTRESTE where etatversement= 11;

--encaissé TRAITE_LIBENC
create or replace view TRAITE_LIBENC as
select ID,DATY,TIERS,BANQUE,DATEECHEANCE,ETAT,MONTANT, etatversement, etatversementlib from TRAITEMTTRESTE where etatversement = -2;



CREATE OR REPLACE VIEW TRAITE_JC (ID, IDTRAITE, IDFC, MONTANT, DATY, ETAT, IDJC, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETATJC, TIERS, IDTYPECHEQUE, DESIGNATION, IDORDRE, IDDEVISE, IDMODE, NUMCHEQUE, TYPEMVT, IDPLACEMENT, IDBANQUE, IDPLACEMENTVRAI) AS 
  select 
jc.id,fc.ID AS idtraite,jc.IDPLACEMENT AS IDFC,fc.MONTANT,fc.DATY,fc.ETAT,jc.id AS IDJC,
jc.DATESAISIE,
jc.DATEEFFET,
jc.FOLIO,
jc.CAISSE,
jc.NUMPIECE,
jc.LIBELLE ,
jc.DEBIT,
jc.CREDIT,
jc.REMARQUE,
jc.ETAT AS etatjc,
jc.TIERS,
jc.IDTYPECHEQUE,
jc.DESIGNATION,
jc.IDORDRE,
jc.IDDEVISE,
jc.IDMODE,
jc.NUMCHEQUE,
jc.TYPEMVT,
jc.IDPLACEMENT,
jc.IDBANQUE,
jc.IDPLACEMENTVRAI 
from traite fc 
left join journalcaisse jc on fc.id = jc.IDTRAITE ;



CREATE OR REPLACE VIEW TRAITEMTTRESTE_NONVERSEE (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT, ESCOMPTE, TOTAL, REFERENCE, MONTANTRESTE, CDCLT, IDBANQUE) AS 
SELECT * FROM (
	SELECT t.ID,t.DATY,t.TIERS,t.BANQUE,t.DATEECHEANCE,t.ETAT,t.MONTANT,t.ESCOMPTE,t.TOTAL,t.REFERENCE,
 (t.total-tf. montantenlevetraite) AS montantreste, t.cdclt, t.idbanque
 FROM TRAITE_LIBMTT t 
 LEFT JOIN traitemttfc tf ON tf.id=t.id
) tmttrst WHERE id NOT IN (SELECT idtraite FROM MVTINTRACAISSE m WHERE m.idtraite IS NOT NULL AND m.ETATVERSEMENT = 11)
;









