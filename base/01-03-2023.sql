ALTER TABLE traite
ADD numcheque (varchar 100);

ALTER TABLE traite
ADD numpiece varchar(100);

UPDATE MENUDYNAMIQUE SET LIBELLE='Transfert Multiple' WHERE ID='MENTRA001';
UPDATE MENUDYNAMIQUE SET LIBELLE='Versement Traite' WHERE ID='MENTRA002';



CREATE OR REPLACE VIEW TRAITE_JC (ID, IDTRAITE, IDFC, MONTANT, DATY, ETAT, IDJC, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETATJC, TIERS, IDTYPECHEQUE, DESIGNATION, IDORDRE, IDDEVISE, IDMODE, NUMCHEQUE, TYPEMVT, IDPLACEMENT, IDBANQUE, IDPLACEMENTVRAI, ETATVERSEMENT, etatlib, etatversementlib, valcaisse) AS 
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
jc.IDPLACEMENTVRAI,
jc.ETATVERSEMENT,
case
           when jc.etat = 1 then 'CREEE'
           when jc.etat >= 11 then 'VISEE'
           else '' end                           as etatlib,
 case
           when jc.etatversement = -2 then 'Encaissee'
           when jc.etatversement = 11 then 'Versee'
           else '' end                           as etatversementlib,
           c.VAL AS valcaisse
from journalcaisse jc 
left join traite fc on fc.id = jc.IDTRAITE 
LEFT JOIN caisse c ON c.id = jc.CAISSE ;







CREATE OR REPLACE VIEW TRAITE_FCSUM (ID, FACTURECLIENTLIB, TIERSLIB, DATY, MONTANTFACTURE, ETATLIB, IDTRAITE, MONTANTTRAITE) AS 
  SELECT
t.id, 
t.factureclientlib,
t.tierslib,
t.daty,
cast(t.montantfacture as number(30,2)),
t.etatLib,
t.idTraite,
cast(m.montanttraite as number(30,2))
FROM TRAITE_FC t
LEFT JOIN montant_traite_fc m ON m.id=t.id AND m.idtraite=t.IDTRAITE ;


