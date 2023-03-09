
  CREATE OR REPLACE VIEW COMPTABILANACTIF (IDRUBRIQUE, RUBRIQUE, REFERENCE, ETAT, CPT_RUBRIQUE, LIBELLE_CPT_RUBRIQUE, TYPE, DEBIT, CREDIT, EC_MONTANT, EC_DATE) AS
  SELECT IDRUBRIQUE,
          RUBRIQUE,
          REFERENCE,
          ETAT,
          CPT_RUBRIQUE,
          LIBELLE_CPT_RUBRIQUE,
          TYPE,
          CAST (credit AS NUMBER (32, 3)) AS debit,
          CAST (debit AS NUMBER (32, 3)) AS credit,
          CAST (EC_MONTANT AS NUMBER (32, 3)) AS ec_montant,
          EC_DATE
     FROM comptabilan
    WHERE reference LIKE 'R%';
  CREATE OR REPLACE VIEW COMPTABILANPASSIF (IDRUBRIQUE, RUBRIQUE, REFERENCE, ETAT, CPT_RUBRIQUE, LIBELLE_CPT_RUBRIQUE, TYPE, DEBIT, CREDIT, EC_MONTANT, EC_DATE) AS
  SELECT IDRUBRIQUE,
          RUBRIQUE,
          REFERENCE,
          ETAT,
          CPT_RUBRIQUE,
          LIBELLE_CPT_RUBRIQUE,
          TYPE,
          CAST (debit AS NUMBER (32, 3)) AS debit,
          CAST (credit AS NUMBER (32, 3)) AS credit,
          CAST (EC_MONTANT AS NUMBER (32, 3)) AS ec_montant,
          EC_DATE
     FROM comptabilan
    WHERE reference LIKE 'P%';

create or replace view ETAT_PROVISION_SIMPLE as
select fc.*,
       case
           when NUMPROVISION is not null then '01/' || substr((NUMPROVISION), 3, 2) || '/20' ||
                                              substr((NUMPROVISION), 0, 2)

           else '' end              as t,
       substr((NUMPROVISION), 5, 5) as numero
from ETAT_PROVISION fc;


create or replace view NUMEROETATPROV as
select cast(t as date)                                   as id,
       cast(max(NUMERO) + 1 as NUMBER(10)) as val,
       cast(max(NUMERO)  as NUMBER(10)) as desce
from ETAT_PROVISION_SIMPLE
group by t;


CREATE OR REPLACE VIEW ETAT_PROVISIONLIB
            (ID, IDFACTURE, IDNAVIRE, IDMODE, IDBANQUE, NUMPIECE, NUMPROVISION, OPERATION, TIERS, TIERSLIB, IDNAVIRELIB,
             IDMODELIB, IDBANQUELIB, IDFACTURELIB,CODE)
AS
select e.ID,
       e.IDFACTURE,
       e.IDNAVIRE,
       e.IDMODE,
       e.IDBANQUE,
       e.NUMPIECE,
       e.NUMPROVISION,
       e.OPERATION,
       f.TIERS,
       f.TIERSlib,
       n.NOM          as idnavirelib,
       m.VAL          as idmodelib,
       b.VAL          as idbanquelib,
       fc.DESIGNATION as IDFACTURELIB,
       fc.CODE
from ETAT_PROVISION e
         left join BANQUE B on e.IDBANQUE = B.ID
         left join MODEPAIEMENT m on e.IDMODE = m.ID
         left join FACTURECLIENT_LIBCOMPLET f on e.IDFACTURE = f.ID
         left join navire n on e.IDNAVIRE = n.ID
         left join FACTURECLIENT fc on fc.id = e.IDFACTURE;


create or replace view NUMEROETATPROV as
select cast(t as date)                       as id,
       cast(max(NUMERO) + 1 as NUMBER(10))   as numerosuivant,
       cast(max(NUMERO) as NUMBER(10))       as numeroactuelle,
       extract(year from (cast(t as date)))  as annee,
       extract(month from (cast(t as date))) as mois
from ETAT_PROVISION_SIMPLE
group by t;