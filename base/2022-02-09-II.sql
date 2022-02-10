CREATE OR REPLACE VIEW FACTURECLIENT_SEQUENCE_SIMPLE ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDPREVISION", "IDCATEGORIE", "IDPROVISION", "DEVISEMERE", "ESTDDPMICTSL", "CODEPRESTATION", "CODE", "DATEMOISSEQ", "DATEMOIS", "MAXIDPARMOISANE", "ESTMICTSL", "CODEFACT", "TYPECATEG") AS 
  select fc.ID,
           DATY,
           TIERS,
           DESIGNATION,
           TYPE,
           TVA,
           REMARQUE,
           IDUSER,
           DATE_ECHEANCE,
           ETAT,
           IDPREVISION,
           IDCATEGORIE,
           IDPROVISION,
           DEVISEMERE,
           ESTDDPMICTSL,
           CODEPRESTATION,
           CODE,
           substr((CODE), 2, 2) || '/' || substr((CODE), 4, 2) || '/01/'
               || substr((CODE), length((CODE)) - 2, 3)||'/'||substr((CODE), length((CODE)) - 5,2 ) as datemoisseq,
           cast('01-' || substr((CODE), 4, 2) || '-20' || substr((CODE), 2, 2) as VARCHAR2(100)) as
             datemois,
           substr((CODE), length((CODE)) - 2, 3) as maxidparmoisane,
           ESTMICTSL,
          substr((CODE), length((CODE)) - 5,2 ) as codefact,
          substr(CODE, 1, 1) AS typecateg
    from FACTURECLIENT fc
    where estMictsl != 1;
   
CREATE OR REPLACE VIEW NUMEROFACTURESIMPLE ("ID", "VAL", "DESCE", "TYPECATEG") AS 
  select datemois                                     as id,
       cast(max(maxidparmoisane) + 1 as NUMBER(10)) as val,
       codefact                                          as desce,
       typecateg 
from FACTURECLIENT_SEQUENCE_SIMPLE
group by datemois,codefact, typecateg;

CREATE OR REPLACE VIEW NUMEROFACTURESIMPLE_PARDATE ("DATY", "NUMEROACTUELLE", "NUMEROSUIVANT", "MOIS", "ANNEE", "CODE", "TYPECATEG") AS 
  select to_date(id, 'dd-mm-yyyy') as daty,
       val - 1 as numeroactuelle,
       val as numerosuivant,
       cast(extract(month from to_date(id, 'dd-mm-yyyy')) as NUMBER(10)) as mois,
       cast(extract(year from to_date(id, 'dd-mm-yyyy')) as NUMBER(10)) as annee,
       desce as code,
       typecateg
from NUMEROFACTURESIMPLE;