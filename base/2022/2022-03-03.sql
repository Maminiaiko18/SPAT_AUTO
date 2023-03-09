create or replace view engagementOP as
    select li.*,
           ff.IDENGAGEMENT,
           NUMEROOP
from LIAISONINTRATABLE li
        left join FACTURE_FOURNISSEUR_MERE ff on ff.ID=li.ID1;

create or replace view engagementOPMontant as
select idengagement
     , sum(montant) as montant
from engagementOP
group by idengagement;

create or replace view engagementOPMontant as
select idengagement
     , cast(sum(montant) as NUMBER(30,2)) as montant
from engagementOP
group by idengagement;

create or replace view ENGAGEMENTLIB as
select e."ID",
       e."DESIGNATION",
       nvl(e."CODEETABLISSEMENT", lp.CODEETABLISSEMENT) as CODEETABLISSEMENT,
       nvl(e."PROJET", lp.PROJET)                       as PROJET,
       e."MONTANT",
       e."DISPONIBLE",
       e."DISPOAVANT",
       e."DISPOAPRES",
       e."COMPTE",
       e."ETAT",
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
       cast(nvl(gr.montant, 0) as NUMBER(30, 2))        as montantop
from engagement e
         left join CODEETABLISSEMENT ce on ce.ID = e.CODEETABLISSEMENT
         left join PROJET p on p.ID = e.PROJET
         left join LIGNECREDITDEPENSE lp on e.IDLC = lp.ID
         left join CODEETABLISSEMENT ce1 on ce1.ID = lp.CODEETABLISSEMENT
         left join PROJET p1 on p1.ID = lp.PROJET
         left join engagementOPMontant gr on gr.idengagement = e.ID;

create or replace view FACTURECLIENTMSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR)
as
SELECT m.ID,
          m.DATY,
          m.TIERS,
          m.DESIGNATION,
          m.TYPE,
          m.TVA,
          '--' || m.remarque AS remarque,
          m.IDUSER,
          m.DATE_ECHEANCE,
          m.ETAT,
          m.idprevision,
          CAST (m.MONTANT AS NUMBER (32, 3)),
          CAST (M.MONTANTTVA AS NUMBER (32, 3)),
          CAST (M.MONTANTAVOIR AS NUMBER (32, 3)),
          CAST (M.MONTANTTTC AS NUMBER (32, 3)),
         -- CAST (LEAST (NVL (pf.montant, 0),(m.montant-m.montantavoir)) AS NUMBER (32, 3)) AS montantpaye,
          CAST ((NVL (pf.montant, 0)) AS NUMBER (32, 3)) AS montantpaye,
          CAST (M.MONTANTTTC - NVL (pf.montant, 0) AS NUMBER (32, 3))
             AS montantreste,
          fup.NOM AS tierslib,
          fup.CONTACT,
          fup.ADRESSE,
          M.ESCALE,
          TYPELIB,
          m.IDCATEGORIE,
          m.CATEGORIELIB,
          IDPROVISION,
          IDPROVISIONLIB,
          m.ESTDDPMICTSL,
          m.devisemere,
          m.codePrestation,
          m.codePrestationlib,
          m.CODE,
          m.ESTMICTSL,
          codeprovision,
          CAST (m.MONTANTTTCVRAI AS NUMBER (32, 3)),
          m.NAVIRE,
          m.ARMATEURLIB,
          m.EXERCICE,
          IDAVOIR
     FROM factureclientMSum m
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
          LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id
/

UPDATE MENUDYNAMIQUE
SET LIBELLE='Liste OP', ICONE='fa fa-list', HREF='/spat/pages/globalnegoce.jsp?but=ded/ordonnerpayement-liste.jsp', RANG=7, NIVEAU=3, ID_PERE='MEN00211'
WHERE ID='MEND0000200';

UPDATE MENUDYNAMIQUE
SET LIBELLE='Bordereaux', ICONE='fa fa-dashboard', HREF='#', RANG=6, NIVEAU=3, ID_PERE='MEN00211'
WHERE ID='MENUM01';
UPDATE MENUDYNAMIQUE
SET LIBELLE='Facture fournisseur', ICONE='fa fa-money', HREF='#', RANG=5, NIVEAU=3, ID_PERE='MEN00211'
WHERE ID='MEN00500';

UPDATE MENUDYNAMIQUE
SET LIBELLE='Bon Commande', ICONE='fa fa-money', HREF='#', RANG=4, NIVEAU=3, ID_PERE='MEN00211'
WHERE ID='MEN00212';


INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00999', 'Analyse', 'fa fa-dashboard', '/spat/pages/globalnegoce.jsp?but=depense/engagement-analyse.jsp', 3, 3, 'MEN00211');


create or replace view LIBERER_GRP as
select IDLC, sum(en.MONTANT) as MONTANT,DATY as DATYENGAGEMENT
from LIBERER li
    left join ENGAGEMENT en on en.ID=li.IDENGAGEMENT
where en.ETAT>=11
group by en.IDLC,DATY;

create view FACTFOURN_ENGAGEMENT as
SELECT CAST(SUM(fm.MONTANT) as number(30, 3))              AS montant,
       cast(SUM(fm.montanttaux) as number(30, 3))          AS montanttaux,
       cast(SUM(fm.MONTANTAVOIRSANSTAUX) as number(30, 3)) AS MONTANTAVOIRSANSTAUX,
       cast(SUM(fm.montantavoiravectaux) as number(30, 3)) AS montantavoiravectaux,
       CAST(SUM(fm.montanttaux * fm.tva / 100) AS NUMBER(30, 3))
                                                           AS montantTva,
       CAST(sum(fm.montanttaux+(fm.montanttaux * fm.tva / 100)) AS NUMBER(30, 3)) as montantttc,
       fm.IDENGAGEMENT
FROM FACTFOURN_MONTANT fm
where ETAT>=11
GROUP BY fm.IDENGAGEMENT;


create or replace view ENGAGEMENTLIB as
select e."ID",
       e."DESIGNATION",
       nvl(e."CODEETABLISSEMENT", lp.CODEETABLISSEMENT) as CODEETABLISSEMENT,
       nvl(e."PROJET", lp.PROJET)                       as PROJET,
       e."MONTANT",
       e."DISPONIBLE",
       e."DISPOAVANT",
       e."DISPOAPRES",
       e."COMPTE",
       e."ETAT",
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
       cast(e.MONTANT- nvl(eng.MONTANTTAUX,0)-nvl(gr.montant, 0) as NUMBER(30, 2))        as montantengament
from engagement e
         left join CODEETABLISSEMENT ce on ce.ID = e.CODEETABLISSEMENT
         left join PROJET p on p.ID = e.PROJET
         left join LIGNECREDITDEPENSE lp on e.IDLC = lp.ID
         left join CODEETABLISSEMENT ce1 on ce1.ID = lp.CODEETABLISSEMENT
         left join PROJET p1 on p1.ID = lp.PROJET
         left join engagementOPMontant gr on gr.idengagement = e.ID
         left join FACTFOURN_ENGAGEMENT eng on eng.IDENGAGEMENT=e.id
         left join LIBERER_MONTANT lib on lib.IDENGAGEMENT=e.ID;


create or replace view ENGAGEMENTLIB as
select e."ID",
       e."DESIGNATION",
       nvl(e."CODEETABLISSEMENT", lp.CODEETABLISSEMENT) as CODEETABLISSEMENT,
       nvl(e."PROJET", lp.PROJET)                       as PROJET,
       e."MONTANT",
       --e."DISPONIBLE",
       e."DISPOAVANT",
       e."DISPOAPRES",
       e."COMPTE",
       e."ETAT",
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
       cast(e.MONTANT- nvl(eng.MONTANTTAUX,0)-nvl(gr.montant, 0) as NUMBER(30, 2))        as disponible
from engagement e
         left join CODEETABLISSEMENT ce on ce.ID = e.CODEETABLISSEMENT
         left join PROJET p on p.ID = e.PROJET
         left join LIGNECREDITDEPENSE lp on e.IDLC = lp.ID
         left join CODEETABLISSEMENT ce1 on ce1.ID = lp.CODEETABLISSEMENT
         left join PROJET p1 on p1.ID = lp.PROJET
         left join engagementOPMontant gr on gr.idengagement = e.ID
         left join FACTFOURN_ENGAGEMENT eng on eng.IDENGAGEMENT=e.id
         left join LIBERER_MONTANT lib on lib.IDENGAGEMENT=e.ID;

create view SITUATIONLCDEPENSE_CPL as
select l.id,
       l.DESIGNATION,
       l.compte,
       l.ANNEE,
       l.montant                                                                   as montant,
       l.etat,
       substr(l.compte, 7, length(l.compte))                                       as comptestr,
       substr(l.COMPTE, 7) || substr(l.COMPTE, 1, 6)                               as compteinv,
       substr(l.COMPTE, 7)                                                         as comptesimple,
       substr(l.COMPTE, 1, 6)  as directionProjet ,
       substr(substr(l.COMPTE, 1, 6), 1, 3)                                        as direction,
       substr(substr(l.COMPTE, 1, 6), 4, 7)                                        as projet

from LIGNECREDITDEPENSE l
/

CREATE OR REPLACE VIEW engagementlibV_GRP as 
 SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib FROM engagementlibv GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib;
