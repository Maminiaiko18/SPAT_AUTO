
ALTER TABLE ADDITIF 
ADD CONSTRAINT additif_ff_fk FOREIGN key(idfacture) REFERENCES facture_fournisseur_mere(id);

CREATE OR REPLACE  VIEW FACTFOURN_MSUM_LIB_FICHE (ID, DATY, DESIGNATION, TIERSLIB, CONTACT, ADRESSE, TYPELIB, CATEGORIELIB, DATE_ECHEANCE, CODE_ETABLISSEMENTLIB, PROJETLIB, EXERCICE, CODE, NUMEROOP, IDBL, IDBC, IDENGAGEMENTLIB, MONTANTHTSANSREMISE, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, DATEREGUL, IDPROVISION, IDCATEGORIE, IDPROVISIONLIB, ETAT) AS 
  select
f.id,
f.daty,
f.designation,
f.tierslib,
f.contact,
f.adresse,
f.typelib,
f.categorielib,
f.date_echeance,
f.code_etablissementlib,
f.projetlib,
f.exercice,
f.code,
f.numeroop ,
f.idbl,
f.idbc,
f.idengagementlib,
CAST(f.montanthtsansremise AS NUMBER(32,2)),
CAST(f.montant AS NUMBER(32,2)),
CAST(f.montanttva AS NUMBER(32,2)),
CAST(f.montantavoir AS NUMBER(32,2)),
CAST((nvl(f.montantttc,0) + NVL(a.montant,0))AS NUMBER(32,2)),
CAST(f.montantpaye AS NUMBER(32,2)),
CAST((nvl(f.montantreste,0)+ NVL(a.montant,0)) AS NUMBER(32,2)),
f.dateregul,
f.idprovision ,
f.Idcategorie ,
f.idProvisionlib ,
f.etat
from factfourn_msum_lib f
LEFT JOIN ADDITIF a ON f.id=a.IDFACTURE ;

ALTER TABLE ADDITIF 
ADD CONSTRAINT additif_ff_fk FOREIGN key(idfacture) REFERENCES facture_fournisseur_mere(id);

CREATE OR REPLACE  VIEW FACTFOURN_MSUM_LIB_FICHE (ID, DATY, DESIGNATION, TIERSLIB, CONTACT, ADRESSE, TYPELIB, CATEGORIELIB, DATE_ECHEANCE, CODE_ETABLISSEMENTLIB, PROJETLIB, EXERCICE, CODE, NUMEROOP, IDBL, IDBC, IDENGAGEMENTLIB, MONTANTHTSANSREMISE, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, DATEREGUL, IDPROVISION, IDCATEGORIE, IDPROVISIONLIB, ETAT) AS 
  select
f.id,
f.daty,
f.designation,
f.tierslib,
f.contact,
f.adresse,
f.typelib,
f.categorielib,
f.date_echeance,
f.code_etablissementlib,
f.projetlib,
f.exercice,
f.code,
f.numeroop ,
f.idbl,
f.idbc,
f.idengagementlib,
CAST(f.montanthtsansremise AS NUMBER(32,2)),
CAST(f.montant AS NUMBER(32,2)),
CAST(f.montanttva AS NUMBER(32,2)),
CAST(f.montantavoir AS NUMBER(32,2)),
CAST((nvl(f.montantttc,0) + NVL(a.montant,0))AS NUMBER(32,2)),
CAST(f.montantpaye AS NUMBER(32,2)),
CAST((nvl(f.montantreste,0)+ NVL(a.montant,0)) AS NUMBER(32,2)),
f.dateregul,
f.idprovision ,
f.Idcategorie ,
f.idProvisionlib ,
f.etat
from factfourn_msum_lib f
LEFT JOIN ADDITIF a ON f.id=a.IDFACTURE ;

ALTER TABLE ADDITIF 
ADD CONSTRAINT additif_ff_fk FOREIGN key(idfacture) REFERENCES facture_fournisseur_mere(id);

CREATE OR REPLACE  VIEW FACTFOURN_MSUM_LIB_FICHE (ID, DATY, DESIGNATION, TIERSLIB, CONTACT, ADRESSE, TYPELIB, CATEGORIELIB, DATE_ECHEANCE, CODE_ETABLISSEMENTLIB, PROJETLIB, EXERCICE, CODE, NUMEROOP, IDBL, IDBC, IDENGAGEMENTLIB, MONTANTHTSANSREMISE, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, DATEREGUL, IDPROVISION, IDCATEGORIE, IDPROVISIONLIB, ETAT) AS 
  select
f.id,
f.daty,
f.designation,
f.tierslib,
f.contact,
f.adresse,
f.typelib,
f.categorielib,
f.date_echeance,
f.code_etablissementlib,
f.projetlib,
f.exercice,
f.code,
f.numeroop ,
f.idbl,
f.idbc,
f.idengagementlib,
CAST(f.montanthtsansremise AS NUMBER(32,2)),
CAST(f.montant AS NUMBER(32,2)),
CAST(f.montanttva AS NUMBER(32,2)),
CAST(f.montantavoir AS NUMBER(32,2)),
CAST((nvl(f.montantttc,0) + NVL(a.montant,0))AS NUMBER(32,2)),
CAST(f.montantpaye AS NUMBER(32,2)),
CAST((nvl(f.montantreste,0)+ NVL(a.montant,0)) AS NUMBER(32,2)),
f.dateregul,
f.idprovision ,
f.Idcategorie ,
f.idProvisionlib ,
f.etat
from factfourn_msum_lib f
LEFT JOIN ADDITIF a ON f.id=a.IDFACTURE ;

		 
		 
		 
		 --------------- JOURNALCAISSELIBCOMPLET vraiiii
		 CREATE OR REPLACE  VIEW JOURNALCAISSELIBCOMPLET (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, TIERS, IDTYPECHEQUE, DESIGNATION, IDDEVISE, IDMODE, NUMCHEQUE, TYPEMVT, IDORDRE, IDPLACEMENT, IDCAISSE, VALCAISSE, DESCECAISSE, VALTYPECHEQUE, DESCETYPECHEQUE, TIERSLIB, CODETIERS, IDBANQUE, IDBANQUELIB, NUMEROOP, TYPE, TYPELIB,IDTRAITE) AS 
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
        
        