
create or replace view FACTURECLIENT_EMISE_MICTSL as
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
       MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       ETATLIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       MONTANTTTCVRAI,
       ARMATEURLIB,
       EXERCICE,
       CODEFILTRE,
       'MC' as val,
       'MICTSL' as desce,
       case
           when code like '3%' then 'PROFORMA A PAYER'
           when code like '5%' then 'DDE DE PRIX'
           else TYPELIB end AS TYPELIB
from FACTURE_CLIENT_UNIONV fc
         left join RUBRIQUE_FACT_EMISES rfe on code like '%' || rfe.val || '%'
where (tiers='0120037' or tiers='clt1' or tiers='TIE000499134559') and
      (lower(substr(code,6,1))in('a','rv'))
/


create or replace view FACTURECLIENT_EMISE_MICTSL as
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
       MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       ETATLIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       MONTANTTTCVRAI,
       ARMATEURLIB,
       EXERCICE,
       CODEFILTRE,
       'MC' as val,
       'MICTSL' as desce,
       case
           when code like '3%' then 'PROFORMA A PAYER'
           when code like '5%' then 'DDE DE PRIX'
           else TYPELIB end AS TYPELIB
from FACTURE_CLIENT_UNIONV fc
         left join RUBRIQUE_FACT_EMISES rfe on code like '%' || rfe.val || '%'
where (tiers='0120037' or tiers='clt1' or tiers='TIE000499134559') and
      (lower(substr(code,6,1))in('a') or (lower(substr(code,6,2))in('rv')));