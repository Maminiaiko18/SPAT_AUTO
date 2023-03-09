CREATE OR REPLACE VIEW ENGAGEMENTLIB (ID, DESIGNATION, CODEETABLISSEMENT, PROJET, MONTANT, DISPOAVANT, DISPOAPRES, COMPTE, ETAT, CODEETABLISSEMENTLIB, PROJETLIB, IDLC, IDLCLIB, DATY, AVECFACTURE, AVECFACTURELIB, MONTANTOP, DISPONIBLE, TIERS, TIERSLIB, NUM) AS 
  select e.ID,
       e.DESIGNATION,
       nvl(e.CODEETABLISSEMENT, lp.CODEETABLISSEMENT) as CODEETABLISSEMENT,
       nvl(e.PROJET, lp.PROJET)                       as PROJET,
       e.MONTANT,
       --e.DISPONIBLE,
       e.DISPOAVANT,
       e.DISPOAPRES,
       e.COMPTE,
       e.ETAT,
       nvl(ce.VAL, ce1.val)                             as codeetablissementlib,
       nvl(p.DESIGNATION, p1.designation)               as projetlib,
       e.IDLC,
       lp.DESIGNATION                                   as idLClib,
       DATY,
       AVECFACTURE,
       case
           when avecFacture = 0 then 'NON'
           when avecFacture = 1 then 'OUI'
           end                                          as avecFacturelib,
       cast(nvl(gr.montant, 0) as NUMBER(30, 2))        as montantop,
       cast(e.MONTANT- nvl(eng.MONTANTTAUX,0)-nvl(lib.montant, 0) as NUMBER(30, 2))        as disponible ,
       e.tiers ,
       t.NOM AS tierslib ,
       e.num
from engagement e
         left join CODEETABLISSEMENT ce on ce.ID = e.CODEETABLISSEMENT
         left join PROJET p on p.ID = e.PROJET
         left join LIGNECREDITDEPENSE lp on e.IDLC = lp.ID
         left join CODEETABLISSEMENT ce1 on ce1.ID = lp.CODEETABLISSEMENT
         left join PROJET p1 on p1.ID = lp.PROJET
         left join engagementOPMontant gr on gr.idengagement = e.ID
         left join FACTFOURN_ENGAGEMENT eng on eng.IDENGAGEMENT=e.id
         left join LIBERER_MONTANT lib on lib.IDENGAGEMENT=e.ID
    	 LEFT JOIN FOURNISSEUR_UNION_PERSONNEL t ON t.id = e.tiers;
