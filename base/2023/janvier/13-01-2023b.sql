
CREATE VIEW FCTRAITE_TR as 
select 
fc.*,
t.daty AS datytraite,
t.tiers,
t.banque,
t.dateecheance,
t.reference,
t.etat AS etattraite,
t.montant AS montanttraite
from fctraite fc
left join traite t on t.id = fc.idtraite;


CREATE VIEW fctraite_jc as 
select 
fc.*,
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
from fctraite fc 
left join journalcaisse jc on fc.idjc = jc.id;


   CREATE OR REPLACE  VIEW TRAITE_LIB (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT) AS 
  select 
	tr.id,
	tr.daty,
	ti.nomclt as tiers,
	ba.val as banque,
	tr.dateEcheance,
	tr.etat,
	tr.montant
	
	from traite tr
	left join client_union ti on tr.tiers = ti.CDCLT 
	left join banque ba on tr.banque = ba.id ;