CREATE OR REPLACE VIEW factureclientAuComptant  as
select * from facture_client_union where type='TFC002' and etat>=11;

ALTER TABLE journalcaisse ADD banque varchar2(100) CONSTRAINT fk_journalcaisse_banque REFERENCES banque(id);

CREATE OR REPLACE  VIEW JOURNALCAISSELIBCOMPLET  AS 
 SELECT j.ID,
          j.DATESAISIE,
          j.DATEEFFET,
          j.FOLIO,
          j.CAISSE,
          j.NUMPIECE,
          j.LIBELLE,
          j.DEBIT,
          j.CREDIT,
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
          c.ID AS idcaisse,
          c.val AS valcaisse,
          c.desce AS descecaisse,
          tc.val AS valtypecheque,
          m.val AS descetypecheque,
          ti.NOM AS tierslib,
          j.banque,
          b.VAL AS banquelib
     FROM Journalcaisse j
          JOIN CAISSE C ON j.CAISSE = C.ID
          LEFT JOIN TYPECHEQUE tc ON tc.id = j.idtypecheque
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL ti ON ti.id = j.TIERS
          LEFT JOIN MODEPAIEMENT m on j.idmode=m.id
          LEFT JOIN BANQUE b ON j.banque=b.id;

ALTER  TABLE categorieAvoirFC ADD TYPE varchar2(500);
UPDATE categorieAvoirFC SET TYPE='2' WHERE id IN ('CT001','CT002','CT003','CT004','CT005','CT006');


CREATE OR REPLACE VIEW factureclientACredit  AS 
select * from facture_client_union where type='TFC002' and etat>=11;