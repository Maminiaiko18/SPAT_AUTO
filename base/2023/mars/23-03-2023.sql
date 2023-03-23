
------create table PaiementOP
create table PaiementOP(
id varchar(100) CONSTRAINT paiementop_pk PRIMARY KEY,
idop varchar(100) CONSTRAINT paiementop_op_fk REFERENCES ORDONNERPAYEMENT(id),
idmvt varchar(100) CONSTRAINT paiementop_jc_fk REFERENCES journalcaisse(id),
montant Number(30,2)
);


--------seqPaiementOP
create sequence seqPaiementOP
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
     
-------getseqPaiementOP
  CREATE OR REPLACE FUNCTION getseqPaiementOP
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqPaiementOP.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;



CREATE OR REPLACE  VIEW MONTANT_TRAITE_FC (ID, IDTRAITE, MONTANTTRAITE) AS 
  select
	ID,IDTRAITE,
	sum(montant) AS montanttraite
	from TRAITE_FC 
	GROUP BY ID,IDTRAITE ;
	
	
	
	
	

create view PaiementOPLIBCOMPLET
            (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, TIERS,
             IDTYPECHEQUE, DESIGNATION, IDDEVISE, IDMODE, NUMCHEQUE, TYPEMVT, IDORDRE, IDPLACEMENT, IDCAISSE, VALCAISSE,
             DESCECAISSE, VALTYPECHEQUE, DESCETYPECHEQUE, TIERSLIB, CODETIERS, IDBANQUE, IDBANQUELIB, NUMEROOP, TYPE,
             TYPELIB, IDTRAITE)
as
SELECT j.ID,
       j.DATESAISIE,
       j.DATEEFFET,
       j.FOLIO,
       j.CAISSE,
       j.NUMPIECE,
       j.LIBELLE,
       cast(pop.montant as number(30,2)),
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
       op.id as idordre,
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
	    j.IDTRAITE
FROM PaiementOP pop JOIN
     Journalcaisse j on pop.IDMVT = j.id
         JOIN CAISSE C
              ON j.CAISSE = C.ID
         LEFT JOIN TYPECHEQUE tc ON tc.id = j.idtypecheque
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL ti ON ti.id = j.TIERS
         LEFT JOIN MODEPAIEMENT m on j.idmode = m.id
         LEFT JOIN BANQUE b on j.idbanque = b.ID
         join ORDONNERPAYEMENT op on op.id=pop.IDOP
         left join factureclient fc on fc.id=j.idplacement
         LEFT JOIN CATEGORIEFC categ ON categ.ID = fc.idcategorie;


create view PaiementOPJCUnion as
    select * from JOURNALCAISSELIBCOMPLET
        UNION ALL
    select * from PaiementOPLIBCOMPLET;
