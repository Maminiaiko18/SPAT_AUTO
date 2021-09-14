update motifavoirFC set desce='1' where DESCE='interne';
update motifavoirFC set desce='2' where DESCE='externe';

alter table avoirFC add type varchar2(500);


  CREATE OR REPLACE VIEW AVOIRFC_MONTANT AS
  select fc.ID,
       fc.DATY,
       fc.IDFACTURE,
       fc.ETAT,
       cast(nvl(mr.montant, 0.0) as NUMBER(30, 3))                    as montant,
       f.TIERS,
       f.tierslib,
       cast(nvl(gr.DEBIT, 0) as NUMBER(30, 3))                        as montantpaye,
       cast(nvl(mr.montant, 0.0) - nvl(gr.DEBIT, 0) as NUMBER(30, 3)) as montantreste,
       fc.CATEGORIE,
       c.VAL                                                          as categorielib,
       fc.MOTIF,
       mo.val                                                         as motiflib,
       fc.CODE,
        fc.TYPE,
         case when fc.TYPE='1' then 'interne'
                when fc.TYPE='2' then 'externe'
        end as typelib,
         fc.DESIGNATION
from AVOIRFC fc
         left join CATEGORIEAVOIRFC c on fc.CATEGORIE = c.id
         left join MOTIFAVOIRFC mo on fc.MOTIF = mo.id
         left join avoirfcavectaux_grp_mere mr on mr.IDMERE = fc.ID
         left join FACTURECLIENT_libcomplet f on fc.IDFACTURE = f.ID
         left join JOURNALCAISSELIB_VISE_grp gr on gr.IDPLACEMENT = fc.ID;




CREATE OR REPLACE VIEW AVOIRFC_MONTANT_C AS
select *
from avoirFC_montant
where etat=1;

 
CREATE OR REPLACE VIEW AVOIRFC_MONTANT_V AS
select *
from avoirFC_montant
where etat>=11; 







