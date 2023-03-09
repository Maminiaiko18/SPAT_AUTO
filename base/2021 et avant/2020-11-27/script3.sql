
CREATE TABLE ConsignataireTab(
id varchar2(100)  CONSTRAINT ConsignataireTab_pk PRIMARY KEY,
val varchar2(500), 
desce varchar(500)
);

CREATE SEQUENCE seq_ConsignataireTab
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seq_ConsignataireTab
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT  seq_ConsignataireTab.nextval INTO retour FROM dual;
  return retour;
END

CREATE VIEW consignataireSociete as
select * from consignatairemat where CDCLT in (select val from consignataireTab);

CREATE SEQUENCE SEQ_OP
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GET_SEQ_OP
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT SEQ_OP.nextval INTO retour FROM dual;
  return retour;
END;

ALTER TABLE Facturefournisseur add TYPE varchar2(100) references typeFF;

ALTER TABLE JOURNALCAISSE ADD designation varchar2(100);
ALTER TABLE JOURNALCAISSE ADD idordre varchar2(100)CONSTRAINT idordrejournal_fk REFERENCES ordonnerpayement null;
ALTER TABLE JOURNALCAISSE ADD iddevise varchar2(100);
ALTER TABLE JOURNALCAISSE ADD idmode varchar2(100);
ALTER TABLE JOURNALCAISSE ADD numcheque varchar2(100);
ALTER TABLE JOURNALCAISSE ADD typemvt varchar2(100);

insert into TypeFF values ('TPFF001', 'Simple', 'Simple');
insert into TypeFF values ('TPFF002', 'BED', 'BED');
