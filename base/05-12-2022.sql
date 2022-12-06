
CREATE OR REPLACE  VIEW REDEVANCECOMMUNALEFACTUREMD (ID, CODE, TYPELIB, DATY, TIERSLIB, MONTANTHT, TVA, MONTANTTTC) AS 
  select e.id,
       e.code,
       e.typelib,
       e.daty,
       e.tierslib,
       cast(a.MONTANTTAUX as NUMBER(30,3)) as montantHT,--(avy amin'ny d‚tails where rubrique=redevance communale)
       a.tva,-- (valeur tva ho an'ilay ligne)
       cast(a.MONTANTTAUX + MONTANTTAXE as NUMBER(30,3)) as montantTTC-- (an'ilay d‚tails foana)
from FACTURE_CLIENT_UNIONV e
        left join FACT_CLT_FILL_LIB_REST_TAXE  a on a.IDMERE=e.id
where COMPTE='46731' AND (e.code  NOT LIKE '3%'  and e.code  NOT LIKE '5%');
