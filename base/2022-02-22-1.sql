create table engagement
(
    id varchar2(100) constraint engagement_pk primary key ,
        designation varchar2(500),
        codeEtablissement varchar2(500) constraint fk_code_etablissement_eng references codeetablissement,
        projet varchar2(500) constraint fk_projet_eng references PROJET,
        montant number(30,2),
        disponible number(30,2),
        dispoAvant number(30,2),
        dispoApres number(30,2),
        compte varchar2(100),
        etat number(10)
);
alter table engagement allocate extent ;

CREATE SEQUENCE seqengagement
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqengagement
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqengagement.nextval INTO retour FROM dual;
  return retour;
END;

create or replace view idengagementlib as
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
       p.DESIGNATION as projetlib
from engagement e
         left join CODEETABLISSEMENT ce on ce.ID = e.CODEETABLISSEMENT
         left join PROJET p on p.ID = e.PROJET;

alter table facture_fournisseur_mere add idengagement varchar2(100)constraint fk_engagementff references ENGAGEMENT;
alter table as_bondecommande add idengagement varchar2(100)  constraint fk_engagement_bc references ENGAGEMENT;

create or replace view UNION_BC_SPAT_CEMEDI as
select ID,
       DATY,
       ETAT,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       NUMBC,
       PROJET,
       CODE_ETAB,
       DELAIPAIEMENT,
       DELAILIVRAISON,
       TYPEPAIEMENT,IDENGAGEMENT
from AS_BONDECOMMANDE
union
select id,
       daty,
       etat,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       REFERENCE as          NUMBC,
       ''        as          PROJET,
       ''        as          CODE_ETAB,
       cast(0 as number(10)) DELAIPAIEMENT,
       ''        as          DELAILIVRAISON,
       ''        as          TYPEPAIEMENT,
       ''        as          IDENGAGEMENT
from bc_cemedi_vue;


create or replace view AS_BONDECOMMANDE_LIBELLE as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       mp.val         as modepaiement,
       bc.fournisseur,
       bc.tva,
       bc.NUMBC,
       ce.val         as CODE_ETAB,
       pe.designation as PROJET,
       IDENGAGEMENT,
       en.DESIGNATION as idengagementlib
from union_bc_spat_cemedi bc
         join modepaiement mp on bc.modepaiement = mp.id
         left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
         left join PROJET pe on pe.id = bc.projet
         left join ENGAGEMENT en on ce.ID = bc.IDENGAGEMENT;



create or replace view AS_BONDECOMMANDE_LIBELLE_LIB
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB, MONTANTREMISE, idengagementlib, IDENGAGEMENT)
as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                                                      as fournisseur,
       cast(bc.tva as NUMBER(10)),
       bc.NUMBC,
       cast(nvl(c.montantht, 0) as number(32, 2)),
       cast(nvl(c.montanttva, 0) as number(32, 2)),
       cast(nvl(c.montantttc, 0) as NUMBER(32, 2)),
       ''                                                                          as idfacture,
       cast(nvl(lfac.montantpayer, 0) as number(32, 2))                            as montant_paye_reel,
       cast((nvl(c.montantttc, 0) - nvl((bl.MONTANTTTC), 0)) as NUMBER(32, 2))     as resteapayegeneral,
       cast((nvl(c.montantttc, 0) - nvl((lfac.montantpayer), 0)) as NUMBER(32, 2)) as resteapayerreel,
       cast(nvl(bl.montantttc, 0) as NUMBER(32, 2))                                as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       cast(lfac.montantttc as NUMBER(32, 2))                                      as montantfacture,
       case
           when bcf.RESTELIVRE > 0 then 'VISE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE(E)'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and
                (lfac.montantttc - nvl(lfac.montantpayer, 0) is not null)
               THEN 'FACTURE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) > 0
               THEN 'EN ATTENTE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYE(E)'
           else 'CREE(E)'
           END                                                                     as etatlib,
       cast(MONTANTREMISE as NUMBER(32, 2)),
       idengagementlib,
       IDENGAGEMENT
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
         left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
         LEFT JOIN BONDELIVRAISONPARBC bl ON bl.IDBC = bc.ID
         left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur;

create or replace view FACTFOURN_MSUM(ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE,
    IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE,
    TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
    CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB,
    NUMEROOP, PROJET, PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC, EXERCICE,IDENGAGEMENT,idengagementlib) AS

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
       en.DESIGNATION                                                          as idengagementlib
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

create or replace view FACTFOURN_MSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT,
             CODE_ETABLISSEMENTLIB, NUMEROOP, PROJET, PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC, EXERCICE,
             IDENGAGEMENT, idengagementlib)
as
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
       MONTANTTTCVRAI,
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
       idengagementlib
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id;



  CREATE OR REPLACE VIEW FACTUREFOURNVALIDE_C (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER,
DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE,
TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL,
DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL,
NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE,
IDENGAGEMENT,idengagementlib) AS
  select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       ff.TVA,
       ff.REMARQUE,
       ff.IDUSER,
       ff.DATE_ECHEANCE,
       ff.ETAT,
       ff.IDPREVISION,
       ff.MONTANT,
       ff.MONTANTTVA,
       ff.MONTANTAVOIR,
       ff.MONTANTTTC,
       ff.MONTANTPAYE,
       ff.MONTANTRESTE,
       ff.TIERSLIB,
       ff.CONTACT,
       ff.ADRESSE,
       ff.ESCALE,
       ff.TYPELIB,
       ff.IDCATEGORIE,
       ff.CATEGORIELIB,
       ff.IDPROVISION,
       ff.IDPROVISIONLIB,
       ff.ESTDDPMICTSL,
       ff.DEVISEMERE,
       ff.CODEPRESTATION,
       ff.CODEPRESTATIONLIB,
       ff.CODE,
       ff.ESTMICTSL,
       ff.CODEPROVISION,
       ff.ETATLIB,
       ff.MONTANTTTCVRAI,
       ff.IDBL,
       ff.NUMEROOP,
       ff.projet,
       ff.code_etablissement,
       ff.projetlib,
       ff.code_etablissementlib,
       ff.NATURE,
       ff.NATURELIB,
       ff.IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
         IDENGAGEMENT,idengagementlib
from FACTUREFOURNVALIDE ff
         left join LIAISONINTRATABLE op on op.ID1 = ff.id
         left join ORDONNERPAYEMENT ord on op.ID2 = ord.id
where ff.etat = 1;

CREATE TABLE liberer 
( 
	id varchar(200) CONSTRAINT liberer_pk PRIMARY KEY , 
	idengagement varchar(200) CONSTRAINT liberer_engagement_id_fk REFERENCES engagement(id)
 , 
	montant number(30,3) ,
	etat integer 
) ; 
alter table liberer  allocate extent;


CREATE SEQUENCE   seq_liberer
 	INCREMENT  BY  1 
    MINVALUE 1 
    MAXVALUE 9999999999999999999
    START  WITH  1  
    CACHE 20  ;

CREATE OR REPLACE FUNCTION getseq_liberer
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_liberer.nextval INTO retour FROM dual;
  return retour;
END;

create or replace view libererlib as
select l.*,
       en.DESIGNATION as idengagementlib
from liberer l
    left join engagement en on l.IDENGAGEMENT = en.ID;
create or replace view libererlibC
    as
    select *from libererlib where ETAT=1;

create or replace view libererlibV
    as
    select *from libererlib where ETAT=11;


alter table ENGAGEMENT add idLC varchar2(100)constraint fk_lignecreditdepense references LIGNECREDITDEPENSE;

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
       lp.DESIGNATION as idLClib
from engagement e
         left join CODEETABLISSEMENT ce on ce.ID = e.CODEETABLISSEMENT
         left join PROJET p on p.ID = e.PROJET
         left join LIGNECREDITDEPENSE lp on e.IDLC = lp.ID;


create or replace view AS_BONDECOMMANDE_LIBCOMPLET as
select bc."ID",
       bc."DATY",
       bc."ETAT",
       bc."REMARQUE",
       bc."DESIGNATION",
       bc."MODEPAIEMENT",
       bc."FOURNISSEUR",
       bc."TVA",
       bc."NUMBC",
       bc."PROJET",
       bc."CODE_ETAB",
       bc."DELAIPAIEMENT",
       bc."DELAILIVRAISON",
       bc."TYPEPAIEMENT",
       mp.val         as modepaiementlibelle,
       tr.nom         AS FOURNISSEURLIBELLE,
       ce.val         as CODE_ETABLIBELLE,
       pe.designation as PROJETLIBELLE,
       bc.IDENGAGEMENT,
       en.DESIGNATION as IDENGAGEMENTlib
from union_bc_spat_cemedi bc
         left join modepaiement mp on bc.modepaiement = mp.id
         left join union_tiers_tbd_cemedi tr ON bc.fournisseur = tr.id
         left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
         left join PROJET pe on pe.id = bc.projet
         left join engagement en on en.ID=bc.IDENGAGEMENT;

CREATE OR REPLACE VIEW FACTUREFOURNVALIDE_V
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, PROJET, NUMEROOP,
             CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE,
             idengagement,
             idengagementlib)
AS
select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       ff.TVA,
       ff.REMARQUE,
       ff.IDUSER,
       ff.DATE_ECHEANCE,
       ff.ETAT,
       ff.IDPREVISION,
       ff.MONTANT,
       ff.MONTANTTVA,
       ff.MONTANTAVOIR,
       ff.MONTANTTTC,
       ff.MONTANTPAYE,
       ff.MONTANTRESTE,
       ff.TIERSLIB,
       ff.CONTACT,
       ff.ADRESSE,
       ff.ESCALE,
       ff.TYPELIB,
       ff.IDCATEGORIE,
       ff.CATEGORIELIB,
       ff.IDPROVISION,
       ff.IDPROVISIONLIB,
       ff.ESTDDPMICTSL,
       ff.DEVISEMERE,
       ff.CODEPRESTATION,
       ff.CODEPRESTATIONLIB,
       ff.CODE,
       ff.ESTMICTSL,
       ff.CODEPROVISION,
       ff.ETATLIB,
       ff.MONTANTTTCVRAI,
       ff.IDBL,
       ff.PROJET,
       ff.NUMEROOP,
       ff.CODE_ETABLISSEMENT,
       ff.PROJETLIB,
       ff.CODE_ETABLISSEMENTLIB,
       ff.NATURE,
       ff.NATURELIB,
       ff.IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
       idengagement,
       idengagementlib
from FACTUREFOURNVALIDE ff
         left join LIAISONINTRATABLE op on op.ID1 = ff.id
         left join ORDONNERPAYEMENT ord on op.ID2 = ord.id
where ff.etat >= 11
  and ff.id not in (select id1 from LIAISONINTRATABLE);


  CREATE OR REPLACE VIEW FACTUREFOURNVALIDE_C (ID, DATY, TIERS, DESIGNATION, TYPE, TVA,
      REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC,
      MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB,
      IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL,
      CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB,
      NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB) AS
  select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       ff.TVA,
       ff.REMARQUE,
       ff.IDUSER,
       ff.DATE_ECHEANCE,
       ff.ETAT,
       ff.IDPREVISION,
       ff.MONTANT,
       ff.MONTANTTVA,
       ff.MONTANTAVOIR,
       ff.MONTANTTTC,
       ff.MONTANTPAYE,
       ff.MONTANTRESTE,
       ff.TIERSLIB,
       ff.CONTACT,
       ff.ADRESSE,
       ff.ESCALE,
       ff.TYPELIB,
       ff.IDCATEGORIE,
       ff.CATEGORIELIB,
       ff.IDPROVISION,
       ff.IDPROVISIONLIB,
       ff.ESTDDPMICTSL,
       ff.DEVISEMERE,
       ff.CODEPRESTATION,
       ff.CODEPRESTATIONLIB,
       ff.CODE,
       ff.ESTMICTSL,
       ff.CODEPROVISION,
       ff.ETATLIB,
       ff.MONTANTTTCVRAI,
       ff.IDBL,
       ff.NUMEROOP,
       ff.projet,
       ff.code_etablissement,
       ff.projetlib,
       ff.code_etablissementlib,
       ff.NATURE,
       ff.NATURELIB,
       ff.IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
         IDENGAGEMENT,idengagementlib
from FACTUREFOURNVALIDE ff
         left join LIAISONINTRATABLE op on op.ID1 = ff.id
         left join ORDONNERPAYEMENT ord on op.ID2 = ord.id
where ff.etat = 1;

CREATE OR REPLACE VIEW FACTUREFOURNVALIDE_EP
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET,
             CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE,
             IDENGAGEMENT, IDENGAGEMENTLIB)
AS
select ff.ID,
       ff.DATY,
       ff.TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       ff.REMARQUE,
       ff.IDUSER,
       DATE_ECHEANCE,
       ff.ETAT,
       IDPREVISION,
       ff.MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       ESTDDPMICTSL,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       MONTANTTTCVRAI,
       'ATTENTE DE PAIEMENT' as ETATLIB,
       ff.IDBL,
       ff.NUMEROOP,
       projet,
       code_etablissement,
       projetlib,
       code_etablissementlib,
       NATURE,
       NATURELIB,
       IDBC,
       ord.NUMEROOP          as numop,
       ff.exercice,
       IDENGAGEMENT,
       IDENGAGEMENTLIB
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
         left join ORDONNERPAYEMENT ord on li.ID2 = ord.id
where (li.IDJOURNAL is not null
    and li.ETATJC = 1)
   or (li.IDJOURNAL is null);
CREATE OR REPLACE VIEW FACTUREFOURNVALIDE_P
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET,
             CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE,
             IDENGAGEMENT, IDENGAGEMENTLIB)
AS
select ff.ID,
       ff.DATY,
       ff.TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       ff.REMARQUE,
       ff.IDUSER,
       DATE_ECHEANCE,
       ff.ETAT,
       IDPREVISION,
       ff.MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       ESTDDPMICTSL,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       MONTANTTTCVRAI,
       'PAYE'       as ETATLIB,
       ff.IDBL,
       ff.NUMEROOP,
       projet,
       code_etablissement,
       projetlib,
       code_etablissementlib,
       NATURE,
       NATURELIB,
       IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
       IDENGAGEMENT,
       IDENGAGEMENTLIB
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
         left join ORDONNERPAYEMENT ord on li.ID2 = ord.id
where li.IDJOURNAL is not null
  and li.ETATJC = 11;
CREATE OR REPLACE VIEW FACTUREFOURNVALIDE_TOUS
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER,
             DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE,
             TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB,
             ESTDDPMICTSL,
             DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB,
             IDBL,
             NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP,
             EXERCICE,
             IDENGAGEMENT,
             IDENGAGEMENTLIB)
AS
select ID,
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
       cast(MONTANT as number(30, 2)),
       cast(MONTANTTVA as number(30, 2)),
       cast(MONTANTAVOIR as NUMBER(30, 2)),
       cast(MONTANTTTC as number(30, 2)),
       cast(MONTANTPAYE as number(30, 2)),
       cast(MONTANTRESTE as number(30, 2)),
       TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       ESTDDPMICTSL,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       cast(MONTANTTTCVRAI as number(30, 3)),
       ETATLIB,
       IDBL,
       NUMEROOP,
       PROJET,
       CODE_ETABLISSEMENT,
       PROJETLIB,
       CODE_ETABLISSEMENTLIB,
       NATURE,
       NATURELIB,
       IDBC,
       numop,
       exercice,
       IDENGAGEMENT,
       IDENGAGEMENTLIB
from (
         select ID,
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
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                ESTDDPMICTSL,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                'PAYE' as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
                IDENGAGEMENT,
                IDENGAGEMENTLIB
         from FACTUREFOURNVALIDE_C
         union
         select ID,
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
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                ESTDDPMICTSL,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                'PAYE' as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
                IDENGAGEMENT,
                IDENGAGEMENTLIB
         from FACTUREFOURNVALIDE_V
         union
         select ID,
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
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                ESTDDPMICTSL,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                'PAYE' as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
                IDENGAGEMENT,
                IDENGAGEMENTLIB
         from FACTUREFOURNVALIDE_ep
         union
         select ID,
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
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                ESTDDPMICTSL,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                'PAYE' as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
                IDENGAGEMENT,
                IDENGAGEMENTLIB
         from FACTUREFOURNVALIDE_p);





