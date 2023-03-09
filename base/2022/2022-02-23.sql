
update  facture_client_fille  set  COMPTE='70684' where id in ('FCF0000009138114010', 'FCF0000009085092851');
update  facture_client_fille  set  COMPTE='70611' where id in ('FCF0000008873112347');


create or replace view COMPTABILANACTIF as
SELECT "IDRUBRIQUE",
          "RUBRIQUE",
          "REFERENCE",
          "ETAT",
          "CPT_RUBRIQUE",
          "LIBELLE_CPT_RUBRIQUE",
          "TYPE",
          CAST (credit AS NUMBER (32, 3)) AS debit,
          CAST (debit AS NUMBER (32, 3)) AS credit,
          CAST ("EC_MONTANT" AS NUMBER (32, 3)) AS ec_montant,
          "EC_DATE"
     FROM comptabilan
    WHERE reference LIKE 'R%';

create or replace view engagementlibV as
select *
from engagementlib where etat=11;



alter table  ligneCreditDepense add codeEtablissement varchar2(100) constraint fk_codeetablissement_lgin references codeEtablissement;
alter table  ligneCreditDepense add projet varchar2(100) constraint fk_projetlgi references codeEtablissement;


create or replace view ligneCreditDepenselib as
select ld.*,
       ce.VAL as CODEETABLISSEMENTlib,
       pr.DESIGNATION as projetlib
from ligneCreditDepense ld
        left join codeEtablissement ce on ce.ID=ld.CODEETABLISSEMENT
        left join PROJET pr on pr.ID=ld.PROJET;


alter table engagement add  daty date; 


create or replace view ENGAGEMENTLIB as
select e."ID",
       e."DESIGNATION",
       e."CODEETABLISSEMENT",
       e."PROJET",
       e."MONTANT",
       e."DISPONIBLE",
       e."DISPOAVANT",
       e."DISPOAPRES",
       e."COMPTE",
       e."ETAT",
       ce.VAL        as codeetablissementlib ,
       p.DESIGNATION as projetlib,
       e.IDLC,
       lp.DESIGNATION as idLClib,
       DATY
from engagement e
         left join CODEETABLISSEMENT ce on ce.ID = e.CODEETABLISSEMENT
         left join PROJET p on p.ID = e.PROJET
         left join LIGNECREDITDEPENSE lp on e.IDLC = lp.ID;


create or replace view FACTURE_FOURNISSEUR_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION,
             IDACTIVITE, DATEFACT, RUBRIQUE,IDENGAGEMENT)
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
       IDENGAGEMENT
FROM FACTURE_FOURNISSEUR_FILLE fi
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fc ON fi.idmere = fc.id;


create or replace view FACTFOURN_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION,
             IDACTIVITE, DATEFACT, RUBRIQUE,IDENGAGEMENT)
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
       fc.IDENGAGEMENT
FROM FACTURE_FOURNISSEUR_FILLE fi
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fc ON fi.idmere = fc.id;


create or replace view FACTFOURN_MONTANT as
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
       en.DATY as datyengagement
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirffavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID
         left join engagement en on en.id = fm.IDENGAGEMENT;


create or replace view FACTFOURN_MONTANT_ISNULL as
select IDLC, sum(MONTANT) as montant,DATYENGAGEMENT
from FACTFOURN_MONTANT
where IDENGAGEMENT is null
group by IDLC,DATYENGAGEMENT;
create or replace view FACTFOURN_MONTANT_NOTNULL as
select ff.IDLC, sum(ff.MONTANT)as MONTANT,DATYENGAGEMENT
from FACTFOURN_MONTANT ff
         join ENGAGEMENTLIBV v on v.ID=ff.IDENGAGEMENT
where IDENGAGEMENT is not null and v.ETAT=11
group by ff.IDLC,DATYENGAGEMENT;

create or replace view LIBERER_GRP as
select IDLC, sum(en.MONTANT) as MONTANT,DATY as DATYENGAGEMENT
from LIBERER li
    left join ENGAGEMENT en on en.ID=li.IDENGAGEMENT
group by en.IDLC,DATY;

create view FACTFOURN_MONTANT_CPL as
select n.IDLC, i.montant+nvl(n.MONTANT,0)-nvl(g.MONTANT,0) as montant, i.DATYENGAGEMENT
from FACTFOURN_MONTANT_ISNULL i
        left join FACTFOURN_MONTANT_NOTNULL n on i.IDLC=n.IDLC
        left join LIBERER_GRP g on i.IDLC=g.IDLC;

alter table LIGNECREDITDEPENSE drop constraint FK_PROJETLGI;
alter table LIGNECREDITDEPENSE   add 
        constraint FK_PROJETLGI foreign key (PROJET)
            references PROJET;