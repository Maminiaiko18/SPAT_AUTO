ALTER TABLE TRAITE DROP CONSTRAINT TRAITE_TIERS_FK;
ALTER TABLE TRAITE ADD CONSTRAINT TRAITE_CLIENT_FK FOREIGN KEY (TIERS) REFERENCES CLIENT(CDCLT);


CREATE OR REPLACE FUNCTION getseqtraite
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_mvtintracaisse_fille.nextval INTO retour FROM dual;
  return retour;
END;

CREATE OR REPLACE FUNCTION getseqescompte
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqescompte.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

CREATE OR REPLACE FUNCTION getseqfctraite
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqfctraite.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

CREATE OR REPLACE VIEW factureclient_traite AS 
SELECT fc.*, ft.IDTRAITE  FROM FACTURECLIENT fc, fctraite ft where fc.ID = ft.IDFC;

alter table escompte 
	add  daty date;
    
    create or replace view escompte_lib as 
	select
	esc.id,
	tr.tiers,
	tr.banque,
	esc.frais,
	esc.etat,
	esc.daty
	
	from escompte esc 
	left join traite_lib tr on esc.idtraite = tr.id;