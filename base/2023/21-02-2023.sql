
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
