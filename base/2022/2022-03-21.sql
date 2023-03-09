alter table engagement add annee number(10);

CREATE OR REPLACE VIEW ENGAGEMENTLIB
            (ID, DESIGNATION, CODEETABLISSEMENT, PROJET, MONTANT, DISPOAVANT, DISPOAPRES, COMPTE, ETAT,
             CODEETABLISSEMENTLIB, PROJETLIB, IDLC, IDLCLIB, DATY, AVECFACTURE, AVECFACTURELIB, MONTANTOP, DISPONIBLE,
             TIERS, TIERSLIB, NUM,ANNEE)
AS
select e.ID,
       e.DESIGNATION,
       nvl(e.CODEETABLISSEMENT, lp.CODEETABLISSEMENT)                                   as CODEETABLISSEMENT,
       nvl(e.PROJET, lp.PROJET)                                                         as PROJET,
       e.MONTANT,
       --e.DISPONIBLE,
       e.DISPOAVANT,
       e.DISPOAPRES,
       e.COMPTE,
       e.ETAT,
       nvl(ce.VAL, ce1.val)                                                             as codeetablissementlib,
       nvl(p.DESIGNATION, p1.designation)                                               as projetlib,
       e.IDLC,
       lp.DESIGNATION                                                                   as idLClib,
       DATY,
       AVECFACTURE,
       case
           when avecFacture = 0 then 'NON'
           when avecFacture = 1 then 'OUI'
           end                                                                          as avecFacturelib,
       cast(nvl(gr.montant, 0) as NUMBER(30, 2))                                        as montantop,
       cast(e.MONTANT - nvl(eng.MONTANTTAUX, 0) - nvl(lib.montant, 0) as NUMBER(30, 2)) as disponible,
       e.tiers,
       t.NOM                                                                            AS tierslib,
       e.num,
       e.ANNEE
from engagement e
         left join CODEETABLISSEMENT ce on ce.ID = e.CODEETABLISSEMENT
         left join PROJET p on p.ID = e.PROJET
         left join LIGNECREDITDEPENSE lp on e.IDLC = lp.ID
         left join CODEETABLISSEMENT ce1 on ce1.ID = lp.CODEETABLISSEMENT
         left join PROJET p1 on p1.ID = lp.PROJET
         left join engagementOPMontant gr on gr.idengagement = e.ID
         left join FACTFOURN_ENGAGEMENT eng on eng.IDENGAGEMENT = e.id
         left join LIBERER_MONTANT lib on lib.IDENGAGEMENT = e.ID
         LEFT JOIN TIERS t ON t.id = e.tiers
 



CREATE OR REPLACE VIEW FACTFOURN_MONTANT
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDPROVISION, IDCATEGORIE, MONTANT, MONTANTTAUX,
             MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MAJORATION, REDUCTION, MONTANTMAJORATION, MONTANTREDUCTION,
             IDACTIVITE, DATEFACT, RUBRIQUE, MONTANTTAUXTVA, IDENGAGEMENT, IDLC, DATYENGAGEMENT, ANNEE, TYPEENGAGEMENT,
             CODE_ETABLISSEMENT, PROJET)
AS
SELECT fm.ID,
       fm.IDMERE,
       fm.DESIGNATION,
       fm.QUANTITE,
       fm.PU,
       fm.COMPTE,
       fm.IDPRODUIT,
       fm.DEVISE,
       fm.TAUX,
       fm.DATY,
       fm.TIERS,
       fm.DESIGNATIONMERE,
       fm.TYPE,
       fm.TVA,
       fm.REMARQUE,
       fm.IDUSER,
       fm.DATE_ECHEANCE,
       fm.ETAT,
       IDPREVISION,
       IDPROVISION,
       IDCATEGORIE,
       CAST(fm.pu * fm.quantite AS NUMBER(30, 2))                                             AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2))
                                                                                              AS montanttaux,
       NVL(montantsanstaux, 0)                                                                AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 2))
                                                                                              AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)                                                                  as MAJORATION,
       NVL(fm.REDUCTION, 0)                                                                   as REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2)) as montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) AS NUMBER(30, 2))  as montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2)) * fm.tva /
       100                                                                                    as montanttauxtva,
       fm.IDENGAGEMENT,
       en.IDLC,
       en.DATY                                                                                as datyengagement,
       fm.annee,
       fm.TYPEENGAGEMENT,
       fm.CODE_ETABLISSEMENT,
       en.PROJET
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirffavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID
         left join engagement en on en.id = fm.IDENGAGEMENT;
 
 create or replace view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                     as compte,
       sum(l.montant)                                                   as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) + nvl(bc.montant, 0) +
            nvl(bp.montant, 0) as NUMBER(30, 3))                        as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                        as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                           as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))      as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))       as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3)) as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))    as pourcPaye,
       cast(sum(l.montant) - (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
                              nvl(bc.montant, 0)) as NUMBER(30, 3))     as resteApresEngmt,
       l.idprojet,
       l.iddirection                                                    AS idcodeEtablissement,
       l.ANNEE
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANT), 0) as NUMBER(30, 3))     as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE

                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    WHERE 1 < 2
                          --  and mf.daty >= '01/01/2022'
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTE, 1, 6) as compte, sum(MONTANT) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
                          -- and daty >= '01/01/2022'
                    group by substr(COMPTE, 1, 6), annee) n on n.compte = l.COMPTEfull
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev
                    WHERE 1 < 2
                          --  and ev.daty >= '01/01/2022'
                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                          --and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
         left join (select comptebdg, sum(montant) as montant
                    from AS_BONDECOMMANDE_SANSFACT_ENG bc
                    WHERE 1 < 2
                          --  and bc.daty >= '01/01/2022'
                    group by comptebdg) bc on bc.comptebdg = l.comptefull
         left join (select sum(MONTANT) as montant, CODE_ETABLISSEMENTLIB || PROJETLIB as compte
                    from BPNonRegul bp
                    WHERE 1 < 2
                          -- and bp.daty >= '01/01/2022'
                    group by CODE_ETABLISSEMENTLIB || PROJETLIB) bp on bp.compte = l.COMPTEFULL
where 1 < 2
GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.idprojet, l.iddirection, bc.montant, bp.montant, l.ANNEE
/


create or replace view FACTFOURN_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION,
             IDACTIVITE, DATEFACT, RUBRIQUE, IDENGAGEMENT, ANNEE, TYPEENGAGEMENT, CODE_ETABLISSEMENT, PROJET,IDBLF,IDBL)
as
SELECT fi.ID,
       fi.IDMERE,
       fi.DESIGNATION,
       fi.QUANTITE,
       fi.PU,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fc.daty,
       fc.tiers,
       fc.designation        AS designationmere,
       fc.TYPE,
       decode(fi.tva, null, fc.tva, fi.tva),
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.IDPREVISION,
       nvl(fi.REDUCTION, 0)  as REDUCTION,
       nvl(fi.MAJORATION, 0) as MAJORATION,
       fi.IDACTIVITE,
       fi.DATEFACT,
       fi.RUBRIQUE,
       fc.IDENGAGEMENT,
       ANNEE,
       TYPEENGAGEMENT,
       CODE_ETABLISSEMENT,
       PROJET,
       fi.IDBLF,
       fc.IDBL
FROM FACTURE_FOURNISSEUR_FILLE fi
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fc ON fi.idmere = fc.id
/



CREATE OR REPLACE VIEW FACTFOURN_MONTANT
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDPROVISION, IDCATEGORIE, MONTANT, MONTANTTAUX,
             MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MAJORATION, REDUCTION, MONTANTMAJORATION, MONTANTREDUCTION,
             IDACTIVITE, DATEFACT, RUBRIQUE, MONTANTTAUXTVA, IDENGAGEMENT, IDLC, DATYENGAGEMENT, ANNEE, TYPEENGAGEMENT,
             CODE_ETABLISSEMENT, PROJET,IDBL,IDBLF)
AS
SELECT fm.ID,
       fm.IDMERE,
       fm.DESIGNATION,
       fm.QUANTITE,
       fm.PU,
       fm.COMPTE,
       fm.IDPRODUIT,
       fm.DEVISE,
       fm.TAUX,
       fm.DATY,
       fm.TIERS,
       fm.DESIGNATIONMERE,
       fm.TYPE,
       fm.TVA,
       fm.REMARQUE,
       fm.IDUSER,
       fm.DATE_ECHEANCE,
       fm.ETAT,
       IDPREVISION,
       IDPROVISION,
       IDCATEGORIE,
       CAST(fm.pu * fm.quantite AS NUMBER(30, 2))                                             AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2))
                                                                                              AS montanttaux,
       NVL(montantsanstaux, 0)                                                                AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 2))
                                                                                              AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)                                                                  as MAJORATION,
       NVL(fm.REDUCTION, 0)                                                                   as REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2)) as montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) AS NUMBER(30, 2))  as montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2)) * fm.tva /
       100                                                                                    as montanttauxtva,
       fm.IDENGAGEMENT,
       en.IDLC,
       en.DATY                                                                                as datyengagement,
       fm.annee,
       fm.TYPEENGAGEMENT,
       fm.CODE_ETABLISSEMENT,
       en.PROJET,
       fm.IDBL,
       fm.IDBLF
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirffavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID
         left join engagement en on en.id = fm.IDENGAGEMENT;
		 
		 
create view FACTFOURN_PARBC as
select sum(ff.MONTANT) as MONTANT,
       sum(ff.MONTANTTAUX) as MONTANTTAUX,
       sum(ff.MONTANTAVOIRAVECTAUX) as MONTANTAVOIRAVECTAUX,
       sum(ff.MONTANTTAUXTVA) as MONTANTTAUXTVA,
       bl.ID_BC
from FACTFOURN_MONTANT ff
         left join AS_BONDELIVRAISON bl on bl.ID = ff.IDBL
         left join AS_BONDECOMMANDE bc on bl.ID_BC = bc.id
where bl.ETAT >= 11
  and bc.ETAT >= 11
  and ff.ETAT >= 11
group by ID_BC;



create or replace view as_bondecommande_facture as
select bc.ID,
       bc.DATY,
       bc.ETAT,
       bc.REMARQUE,
       bc.DESIGNATION,
       bc.MODEPAIEMENT,
       bc.FOURNISSEUR,
       bc.TVA,
       bc.NUMBC,
       bc.MONTANT,
       bc.MONTANTTVA,
       bc.MONTANTTTC,
       bc.IDFACTURE,
       bc.MONTANT_PAYE_REEL,
       bc.RESTEPAYERGENERAL,
       bc.RESTEAPAYERREEL,
       bc.MONTANT_A_PAYER,
       bc.PROJET,
       bc.CODE_ETAB,
     --  bc.MONTANTFACTURE,
       bc.ETATLIB,
       bc.MONTANTREMISE,
       bc.IDENGAGEMENTLIB,
       bc.IDENGAGEMENT,
       bc.CODEETABLISSEMENT,
       bc.COMPTEBDG,
       cast(nvl(ff.MONTANT,0) as NUMBER(30, 2)) as montantFacture
from AS_BONDECOMMANDE_LIBELLE_LIB bc
         left join FACTFOURN_PARBC ff on ff.ID_BC = bc.id;
		 
create view SITUATION_BC_SANSENG as
select bf.*,
       bf.MONTANT - bf.MONTANTFACTURE as montantNonFacture
from as_bondecommande_facture bf
where IDENGAGEMENT is null ;


ALTER TABLE facture_fournisseur_mere ADD dateRegul DATE ; 

CREATE OR REPLACE VIEW "SPAT_CAPITAINERIE"."FACTFOURN_MSUM" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDPREVISION", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "ESCALE", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "ESTDDPMICTSL", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "MONTANTTTCVRAI", "IDBL", "CODE_ETABLISSEMENT", "CODE_ETABLISSEMENTLIB", "NUMEROOP", "PROJET", "PROJETLIB", "NUMFACT", "NATURE", "NATURELIB", "IDBC", "EXERCICE", "IDENGAGEMENT", "IDENGAGEMENTLIB" , "DATEREGUL") AS 
  SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       fc.idprevision,
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 2))                          AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 2))                           AS montanttva,
       NVL(grp.montantavoiravectaux, 0)                                        AS montantavoir,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 2))
                                                                               AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                                                 AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                                               AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                                         AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                                                  as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                                                as codeprovision,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0) AS NUMBER(30, 2)) as MONTANTTTCVRAI,
       fc.IDBL,
       fc.CODE_ETABLISSEMENT,
       cod.VAL                                                                 as CODE_ETABLISSEMENTlib,
       fc.NUMEROOP,
       fc.PROJET,
       p.DESIGNATION                                                           as projetlib,
       fc.NUMFACT,
       fc.NATURE,
       n.VAL                                                                   as naturelib,
       bl.ID_BC,
       fc.EXERCICE,
       fc.IDENGAGEMENT,
       en.DESIGNATION                                                        as idengagementlib , 
       fc.DATEREGUL 
FROM FACTURE_FOURNISSEUR_MERE fc
         LEFT JOIN FACTFOURN_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFf tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFF catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id
         left join CODEETABLISSEMENT cod on fc.CODE_ETABLISSEMENT = cod.ID
         left join projet p on fc.PROJET = p.ID
         LEFT JOIN nature n on fc.NATURE = n.ID
         left join AS_BONDELIVRAISON bl on bl.ID = nvl(fc.IDBL, fc.REMARQUE)
         left join engagement en on en.ID = fc.IDENGAGEMENT;


CREATE OR REPLACE VIEW "SPAT_CAPITAINERIE"."FACTFOURN_MSUM_LIB" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDPREVISION", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "MONTANTPAYE", "MONTANTRESTE", "TIERSLIB", "CONTACT", "ADRESSE", "ESCALE", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "ESTDDPMICTSL", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "ETATLIB", "MONTANTTTCVRAI", "IDBL", "CODE_ETABLISSEMENT", "CODE_ETABLISSEMENTLIB", "NUMEROOP", "PROJET", "PROJETLIB", "NUMFACT", "NATURE", "NATURELIB", "IDBC", "EXERCICE", "IDENGAGEMENT", "IDENGAGEMENTLIB" , "DATEREGUL") AS 
  SELECT m.ID,
       m.DATY,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       '--' || m.remarque                        AS remarque,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.idprevision,
       CAST(m.MONTANT AS NUMBER(32, 2)),
       CAST(M.MONTANTTVA AS NUMBER(32, 2)),
       CAST(M.MONTANTAVOIR AS NUMBER(32, 2)),
       CAST(M.MONTANTTTC AS NUMBER(32, 2)),
       CAST(NVL(pf.montant, 0) AS NUMBER(32, 2)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(pf.montant, 0) AS NUMBER(32, 2))
                                                 AS montantreste,
       fup.NOM                                   AS tierslib,
       fup.CONTACT,
       fup.ADRESSE,
       M.ESCALE,
       TYPELIB,
       m.IDCATEGORIE,
       m.CATEGORIELIB,
       m.IDPROVISION,
       m.IDPROVISIONLIB,
       m.ESTDDPMICTSL,
       m.devisemere,
       m.codePrestation,
       m.codePrestationlib,
       m.CODE,
       m.ESTMICTSL,
       codeprovision,
       case
           when m.etat = 1 then 'CREE'
           when m.etat >= 11 then 'VISE'
           else '' end                           as etatlib,
       cast(MONTANTTTCVRAI as number(32,2)),
       m.IDBL,
       m.CODE_ETABLISSEMENT,
       m.CODE_ETABLISSEMENTLIB,
       m.NUMEROOP,
       m.PROJET,
       m.PROJETLIB,
       m.NUMFACT,
       m.NATURE,
       m.naturelib,
       m.IDBC,
       m.exercice,
       IDENGAGEMENT,
       idengagementlib ,
       m.DATEREGUL
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id ;


create or replace view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                     as compte,
       sum(l.montant)                                                   as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) + nvl(bc.montant, 0) +
            nvl(bp.montant, 0) as NUMBER(30, 3))                        as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                        as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                           as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))      as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))       as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3)) as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))    as pourcPaye,
       cast(sum(l.montant) - (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
                              nvl(bc.montant, 0)) as NUMBER(30, 3))     as resteApresEngmt,
       l.idprojet,
       l.iddirection                                                    AS idcodeEtablissement,
       l.ANNEE
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANT), 0) as NUMBER(30, 3))     as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE

                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    WHERE 1 < 2
                    --  and mf.daty >= '01/01/2022'
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTE, 1, 6) as compte, sum(MONTANT) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
                   --   and daty >= '01/01/2022'
                    group by substr(COMPTE, 1, 6), annee) n on n.compte = l.COMPTEfull
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev
                    WHERE 1 < 2
                  --    and ev.daty >= '01/01/2022'
                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                     -- and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
         left join (select comptebdg, sum(MONTANTNONFACTURE) as montant
                    from SITUATION_BC_SANSENG bc
                    WHERE 1 < 2
                    --  and bc.daty >= '01/01/2022'
                    group by comptebdg) bc on bc.comptebdg = l.comptefull
         left join (select sum(MONTANT) as montant, CODE_ETABLISSEMENTLIB || PROJETLIB as compte
                    from BPNonRegul bp
                    WHERE 1 < 2
                    --  and bp.daty >= '01/01/2022'
                    group by CODE_ETABLISSEMENTLIB || PROJETLIB) bp on bp.compte = l.COMPTEFULL
where 1 < 2
GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.idprojet, l.iddirection, bc.montant, bp.montant, l.idprojet,
         l.iddirection, l.ANNEE;
		 
		 
CREATE OR REPLACE VIEW ETATBPVRAI
            (ID, MONTANTFACTURE, MONTANTPROVISION, MONTANTPAYE, ECART, TIERS, TIERSLIB, DATY, TIERSPROVISION,
             TIERSLIBPROVISION, MONTANTRESTE, IDPROVISION,CODE_ETABLISSEMENTLIB,PROJETLIB,compteFull)
AS
SELECT fu.id,
       cast(SUM(NVL(FCUV.MONTANTTTC, 0)) as NUMBER(30, 3))                       AS montantfacture,
       cast(SUM(fu.MONTANTTTC) as NUMBER(30, 3))                                 AS montantprovision,
       cast(SUM(fu.MONTANTPAYE) as NUMBER(30, 3))                                AS MONTANTPAYE,
       cast(SUM(fu.MONTANTPAYE) - SUM(NVL(FCUV.MONTANTTTC, 0)) as NUMBER(30, 3)) AS ecart, --RAP
       fu.TIERS,
       fu.TIERSLIB,
       fu.DATY,
       '-'                                                                       AS tiersprovision,
       '-'                                                                       AS tierslibprovision,
       cast(SUM(fu.MONTANTTTC) - NVL(SUM(FCUV.MONTANTTTC), 0) as NUMBER(30, 3))
                                                                                 AS MONTANTRESTE,
       '',
       fu.CODE_ETABLISSEMENTLIB,
       fu.PROJETLIB,
       fu.CODE_ETABLISSEMENTLIB || fu.PROJETLIB                                  as compteFull
FROM factfourn_msum_lib fu
         LEFT JOIN FACTURE_fourn_VISE_gp FCUV ON fu.id = FCUV.IDPROVISION
GROUP BY fu.id,
         fu.DATY,
         fu.tiers,
         fu.tierslib,
         fu.CODE_ETABLISSEMENTLIB,
         fu.PROJETLIB;


create or replace  view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                     as compte,
       sum(l.montant)                                                   as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) + nvl(bc.montant, 0) +
            nvl(bp.montant, 0) as NUMBER(30, 3))                        as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                        as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                           as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))      as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))       as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3)) as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))    as pourcPaye,
       cast(sum(l.montant) - (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
                              nvl(bc.montant, 0)) as NUMBER(30, 3))     as resteApresEngmt,
       l.idprojet,
       l.iddirection                                                    AS idcodeEtablissement,
       l.ANNEE
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANT), 0) as NUMBER(30, 3))     as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE

                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    WHERE 1 < 2
                          --  and mf.daty >= '01/01/2022'
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTE, 1, 6) as compte, sum(MONTANT) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
                          --   and daty >= '01/01/2022'
                    group by substr(COMPTE, 1, 6), annee) n on n.compte = l.COMPTEfull
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev
                    WHERE 1 < 2
                          --    and ev.daty >= '01/01/2022'
                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                          -- and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
         left join (select comptebdg, sum(MONTANTNONFACTURE) as montant
                    from SITUATION_BC_SANSENG bc
                    WHERE 1 < 2
                          --  and bc.daty >= '01/01/2022'
                    group by comptebdg) bc on bc.comptebdg = l.comptefull
         left join (select sum(ECART) as montant, COMPTEFULL as compte
                    from ETATBPVRAI bp
                    WHERE 1 < 2
                          --  and bp.daty >= '01/01/2022'
                    group by COMPTEFULL) bp on bp.compte = l.COMPTEFULL
where 1 < 2
GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.idprojet, l.iddirection, bc.montant, bp.montant, l.idprojet,
         l.iddirection, l.ANNEE;

create or replace view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                     as compte,
       sum(l.montant)                                                   as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) + nvl(bc.montant, 0) +
            nvl(bp.montant, 0) as NUMBER(30, 3))                        as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                        as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                           as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))      as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))       as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3)) as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))    as pourcPaye,
       cast(sum(l.montant) - (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
                              nvl(bc.montant, 0)) as NUMBER(30, 3))     as resteApresEngmt,
       l.idprojet,
       l.iddirection                                                    AS idcodeEtablissement,
       l.ANNEE
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANT), 0) as NUMBER(30, 3))     as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE

                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    WHERE 1 < 2
                          --  and mf.daty >= '01/01/2022'
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTE, 1, 6) as compte, sum(MONTANT) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
                          --   and daty >= '01/01/2022'
                    group by substr(COMPTE, 1, 6), annee) n on n.compte = l.COMPTEfull
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev
                    WHERE 1 < 2
                          --    and ev.daty >= '01/01/2022'
                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                          -- and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
         left join (select comptebdg, sum(MONTANTNONFACTURE) as montant
                    from SITUATION_BC_SANSENG bc
                    WHERE 1 < 2
                          --  and bc.daty >= '01/01/2022'
                    group by comptebdg) bc on bc.comptebdg = l.comptefull
         left join (select sum(MONTANTRESTE) as montant, COMPTEFULL as compte
                    from ETATBPVRAI bp
                    WHERE 1 < 2
                          --  and bp.daty >= '01/01/2022'
                    group by COMPTEFULL) bp on bp.compte = l.COMPTEFULL
where 1 < 2
GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.idprojet, l.iddirection, bc.montant, bp.montant, l.idprojet,
         l.iddirection, l.ANNEE
/

create or replace view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                     as compte,
       sum(l.montant)                                                   as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) + nvl(bc.montant, 0) +
            nvl(bp.montant, 0) as NUMBER(30, 3))                        as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                        as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                           as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))      as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))       as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3)) as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))    as pourcPaye,
       cast(sum(l.montant) - (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
                              nvl(bc.montant, 0)) as NUMBER(30, 3))     as resteApresEngmt,
       l.idprojet,
       l.iddirection                                                    AS idcodeEtablissement,
       l.ANNEE
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANT), 0) as NUMBER(30, 3))     as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE

                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    WHERE 1 < 2 and mf.typeengagement!='ED'
                          --  and mf.daty >= '01/01/2022'
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTE, 1, 6) as compte, sum(MONTANT) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
                          --   and daty >= '01/01/2022'
                    group by substr(COMPTE, 1, 6), annee) n on n.compte = l.COMPTEfull
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev
                    WHERE 1 < 2
                          --    and ev.daty >= '01/01/2022'
                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                          -- and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
         left join (select comptebdg, sum(MONTANTNONFACTURE) as montant
                    from SITUATION_BC_SANSENG bc
                    WHERE 1 < 2
                          --  and bc.daty >= '01/01/2022'
                    group by comptebdg) bc on bc.comptebdg = l.comptefull
         left join (select sum(MONTANTRESTE) as montant, COMPTEFULL as compte
                    from ETATBPVRAI bp
                    WHERE 1 < 2
                          --  and bp.daty >= '01/01/2022'
                    group by COMPTEFULL) bp on bp.compte = l.COMPTEFULL
where 1 < 2
GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.idprojet, l.iddirection, bc.montant, bp.montant, l.idprojet,
         l.iddirection, l.ANNEE
/

create or replace view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                     as compte,
       sum(l.montant)                                                   as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) + nvl(bc.montant, 0) +
            nvl(bp.montant, 0) as NUMBER(30, 3))                        as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                        as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                           as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))      as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))       as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3)) as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))    as pourcPaye,
       cast(sum(l.montant) - (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
                              nvl(bc.montant, 0)) as NUMBER(30, 3))     as resteApresEngmt,
       l.idprojet,
       l.iddirection                                                    AS idcodeEtablissement,
       l.ANNEE
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANT), 0) as NUMBER(30, 3))     as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE

                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    WHERE 1 < 2 and (typeengagement!='ED' or TYPEENGAGEMENT is null)
                          --  and mf.daty >= '01/01/2022'
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTE, 1, 6) as compte, sum(MONTANT) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
                          --   and daty >= '01/01/2022'
                    group by substr(COMPTE, 1, 6), annee) n on n.compte = l.COMPTEfull
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev
                    WHERE 1 < 2
                          --    and ev.daty >= '01/01/2022'
                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                          -- and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
         left join (select comptebdg, sum(MONTANTNONFACTURE) as montant
                    from SITUATION_BC_SANSENG bc
                    WHERE 1 < 2
                          --  and bc.daty >= '01/01/2022'
                    group by comptebdg) bc on bc.comptebdg = l.comptefull
         left join (select sum(MONTANTRESTE) as montant, COMPTEFULL as compte
                    from ETATBPVRAI bp
                    WHERE 1 < 2
                          --  and bp.daty >= '01/01/2022'
                    group by COMPTEFULL) bp on bp.compte = l.COMPTEFULL
where 1 < 2 and l.COMPTEFULL='841AHA'
GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.idprojet, l.iddirection, bc.montant, bp.montant, l.idprojet,
         l.iddirection, l.ANNEE
/

