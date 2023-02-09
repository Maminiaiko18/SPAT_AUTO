-------------------traite-------------------

CREATE OR REPLACE  VIEW TRAITE_LIB (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT,reference) AS 
  select 
	tr.id,
	tr.daty,
	ti.nomclt as tiers,
	ba.val as banque,
	tr.dateEcheance,
	tr.etat,
	tr.montant,
	tr.REFERENCE 
	from traite tr
	left join client_union ti on tr.tiers = ti.CDCLT 
	left join banque ba on tr.banque = ba.id ;

;

create or replace view caissetraite as 
select * from caisse where id = 'CAIS00000T00016';

create or replace view modetraite as
select * from modepaiement where id='pay6';

alter table mvtintracaisse 
add idtraite varchar(100) constraint mvtintracaisse_traite_fk references Traite(id);



