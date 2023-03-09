create view tmp_caisse as
select ca.ID,

       CASE WHEN CA.ID='CAIS000014' then 'pay2'
            WHEN CA.ID='CAIS000015' then 'pay1'
           else mp.id end AS VAL,

       CASE WHEN CA.ID='CAIS000014' then 'cheque'
          WHEN CA.ID='CAIS000015' then 'espece'
           else   mp.DESCE end AS desce


from CAISSE_LIB ca
         left join MODEPAIEMENT mp on mp.id = mp.id;

         create view caisse_finale as
select distinct id, val,desce from tmp_caisse; 

create or replace view JOURNALCAISSELIBCOMPLET as
select j."ID",
       j."DATESAISIE",
       j."DATEEFFET",
       j."FOLIO",
       j."CAISSE",
       j."NUMPIECE",
       j."LIBELLE",
       j."DEBIT",
       j."CREDIT",
       j."REMARQUE",
       j."ETAT",
       j."TIERS",
       j."IDTYPECHEQUE",
       j."DESIGNATION",
       j."IDDEVISE",
       j."IDMODE",
       j."NUMCHEQUE",
       j."TYPEMVT",
       j."IDORDRE",
       j."IDPLACEMENT",
       c.ID     as idcaisse,
       c.val    as valcaisse,
       c.desce  as descecaisse,
       tc.val   as valtypecheque,
       tc.desce as descetypecheque,
       ti.NOM   as tierslib
from Journalcaisse j
         join CAISSE C on j.CAISSE = C.ID
         left join TYPECHEQUE tc on tc.id = j.idtypecheque
         left join FOURNISSEUR_UNION_PERSONNEL ti on ti.id = j.TIERS
/

create or replace view BON_PROVISOIRE_LIB_CREE as
select *
from bon_provisoire_libcomplet
where etat = 1
/

create or replace view BON_PROVISOIRE_LIB_VALIDE as
select *
from bon_provisoire_libcomplet
where etat = 11
/

create or replace view BON_PROVISOIRE_LIB_REGULARISE as
select *
from bon_provisoire_libcomplet
where etat = 12
/


