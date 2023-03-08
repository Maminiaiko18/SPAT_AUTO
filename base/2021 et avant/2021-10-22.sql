
delete from QUAIS where id='QUA000008';
delete from QUAIS where id='QUA0000000091152107';
delete from QUAIS where id='QUA000086122119';
delete from QUAIS where id='QQUA000013';
delete from QUAIS where id='QUA000014';
delete from QUAIS where id='QUA000046';



CREATE OR REPLACE VIEW FACTURECLIENTMSUM
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION,
             IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL,
             CODEPROVISION,MONTANTTTCVRAI)
AS
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 3)) AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3))  AS montanttva,
       NVL(grp.montantavoiravectaux, 0)               AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 3))
                                                      AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                        AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                      AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                         as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                       as codeprovision,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0) AS NUMBER(30, 3))
                                                      AS MONTANTTTCVRAI
FROM FACTURECLIENT fc
         LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id;
CREATE OR REPLACE VIEW FACTURECLIENTMSUM
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION,
             IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL,
             CODEPROVISION,MONTANTTTCVRAI)
AS
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 3)) AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3))  AS montanttva,
       NVL(grp.montantavoiravectaux, 0)               AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 3))
                                                      AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                        AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                      AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                         as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                       as codeprovision,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0) AS NUMBER(30, 3))
                                                      AS MONTANTTTCVRAI
FROM FACTURECLIENT fc
         LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id;
		 


create or replace view FACTURECLIENTMSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION,MONTANTTTCVRAI)
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
          CAST (NVL (pf.montant, 0) AS NUMBER (32, 3)) AS montantpaye,
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
          m.MONTANTTTCVRAI
     FROM factureclientMSum m
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
          LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id;
		  

create or replace view FACTURE_CLIENT_UNION
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION,MONTANTTTCVRAI)
as
SELECT ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       CAST(TVA AS NUMBER(20, 3)) AS tva,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       CAST(ETAT AS NUMBER(10))   AS etat,
       CAST(MONTANT AS NUMBER(32, 3)),
       CAST(MONTANTTVA AS NUMBER(32, 3)),
       CAST(MONTANTAVOIR AS NUMBER(32, 3)),
       CAST(MONTANTTTC AS NUMBER(32, 3)),
       CAST(MONTANTPAYE AS NUMBER(32, 3)),
       CAST(MONTANTRESTE AS NUMBER(32, 3)),
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       CASE WHEN ETAT = 1 THEN 'CREE(E)' WHEN ETAT = 11 THEN 'VISE(E)' END
                                  AS ETATLIB,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       DEVISEMERE,
       codePrestation,
       codePrestationlib,
       code,
       ESTMICTSL,
       CODEPROVISION,
       CAST(MONTANTTTCVRAI AS NUMBER(32, 3))
FROM (SELECT ID,
             DATY,
             TIERS,
             DESIGNATION,
             TYPE,
             CAST(TVA AS NUMBER(20, 3))          AS TVA,
             REMARQUE,
             IDUSER,
             DATE_ECHEANCE,
             CAST(ETAT AS NUMBER(10))            AS etat,
             CAST(MONTANT AS NUMBER(32, 3))      AS MONTANT,
             CAST(MONTANTTVA AS NUMBER(32, 3))   AS MONTANTTVA,
             CAST(MONTANTAVOIR AS NUMBER(32, 3)) AS MONTANTAVOIR,
             CAST(MONTANTTTC AS NUMBER(32, 3))   AS MONTANTTTC,
             CAST(MONTANTPAYE AS NUMBER(32, 3))  AS MONTANTPAYE,
             CAST(MONTANTRESTE AS NUMBER(32, 3)) AS MONTANTRESTE,
             TIERSLIB,
             CONTACT,
             ADRESSE,
             IDPREVISION,
             ESCALE,
             TYPELIB,
             IDCATEGORIE,
             CATEGORIELIB,
             IDPROVISION,
             IDPROVISIONLIB,
             DEVISEMERE,
             codePrestation,
             codePrestationlib,
             code,
             ESTMICTSL,
             CODEPROVISION,
             MONTANTTTCVRAI
      FROM FACTURECLIENTMSUM_LIB
      UNION ALL
      SELECT ID,
             DATY,
             TIERS,
             DESIGNATION,
             TYPE,
             CAST(TVA AS NUMBER(20, 3))          AS TVA,
             REMARQUE,
             IDUSER,
             DATE_ECHEANCE,
             CAST(ETAT AS NUMBER(10))            AS etat,
             CAST(MONTANT AS NUMBER(32, 3))      AS MONTANT,
             CAST(MONTANTTVA AS NUMBER(32, 3))   AS MONTANTTVA,
             CAST(MONTANTAVOIR AS NUMBER(32, 3)) AS MONTANTAVOIR,
             CAST(MONTANTTTC AS NUMBER(32, 3))   AS MONTANTTTC,
             CAST(MONTANTPAYE AS NUMBER(32, 3))  AS MONTANTPAYE,
             CAST(MONTANTRESTE AS NUMBER(32, 3)) AS MONTANTRESTE,
             TIERSLIB,
             CONTACT,
             ADRESSE,
             '-'                                 AS PREVISION,
             '-'                                 AS ESCALE,
             TYPE                                AS typelib,
             '-'                                 AS IDCATEGORIE,
             '-'                                 AS CATEGORIELIB,
             '-'                                 AS IDPROVISION,
             '-'                                 AS IDPROVISIONLIB,
             '-'                                 AS DEVISEMERE,
             ''                                  as codePrestation,
             ''                                  as codePrestationlib,
             ''                                  as code,
             ''                                  as ESTMICTSL,
             ''                                  as CODEPROVISION,
             MONTANTTTC-MONTANTAVOIR as  MONTANTTTCVRAI
      FROM analyseglobaleantsika);	
	  
	  
	  
CREATE OR REPLACE VIEW FACTFOURN_MSUM
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION,
             IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL,
             CODEPROVISION,MONTANTTTCVRAI)
AS
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 3)) AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3))  AS montanttva,
       NVL(grp.montantavoiravectaux, 0)               AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 3))
                                                      AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                        AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                      AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                         as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                       as codeprovision,
       CAST( NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0) AS NUMBER(30, 3)) as MONTANTTTCVRAI
FROM FACTURE_FOURNISSEUR_MERE fc
         LEFT JOIN FACTFOURN_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFf tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFF catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id;

		 
CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB,MONTANTTTCVRAI)
AS
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
       CAST(m.MONTANT AS NUMBER(32, 3)),
       CAST(M.MONTANTTVA AS NUMBER(32, 3)),
       CAST(M.MONTANTAVOIR AS NUMBER(32, 3)),
       CAST(M.MONTANTTTC AS NUMBER(32, 3)),
       CAST(NVL(pf.montant, 0) AS NUMBER(32, 3)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(pf.montant, 0) AS NUMBER(32, 3))
                                                 AS montantreste,
       fup.NOM                                   AS tierslib,
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
       case
           when m.etat = 1 then 'CREE'
           when m.etat >= 11 then 'VISE'
           else '' end                           as etatlib,
       MONTANTTTCVRAI
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id;
		 


  CREATE OR REPLACE VIEW FACTURECLIENTVALIDE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE,
      IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE,
      TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION,
      IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL,MONTANTTTCVRAI) AS
  SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
        cast(fc.TVA as number(30,3)) as TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
         cast(fc.MONTANT as NUMBER(30,3)) as MONTANT,
         cast(fc.MONTANTTVA as NUMBER(30,3)) as MONTANTTVA,
         cast(fc.MONTANTAVOIR as NUMBER(30,3)) as MONTANTAVOIR,
         cast(fc.MONTANTTTC as NUMBER(30,3)) as MONTANTTTC,
         cast(fc.MONTANTPAYE as NUMBER(30,3)) as MONTANTPAYE,
         cast(fc.MONTANTRESTE as NUMBER(30,3)) as MONTANTRESTE,
       fc.TIERSLIB,
       fc.CONTACT,
       fc.ADRESSE,
       fc.IDPREVISION,
       fc.ESCALE,
       fc.ETATLIB,
       fc.TYPELIB,
       fc.IDCATEGORIE,
       fc.CATEGORIELIB,
       fc.IDPROVISION,
       fc.IDPROVISIONLIB,
       fc.DEVISEMERE,
       fc.CODEPRESTATION,
       fc.CODEPRESTATIONLIB,
       fc.CODE,
         ESTMICTSL,
         fc.MONTANTTTCVRAI
FROM facture_client_union fc
WHERE id NOT IN (SELECT id FROM ProvisionFactureDefinitive);


create or replace view FACTURE_CLIENT_UNIONC as
select *
from facture_client_union
where etat = 1;

create or replace view FACTURE_CLIENT_UNIONV as
select *
from facture_client_union
where etat = 11;

create or replace view FACTURECLIENTAPAYER as
SELECT *
from facture_client_union
where MONTANTRESTE > 0;


create or replace view FACTURECLIENTACREDIT as
select *
from facture_client_union
where type = 'TFC002'
  and etat >= 11;
  
  
  create or replace view FACTURECLIENTAUCOMPTANT as
select *
from facture_client_union
where type = 'TFC002'
  and etat >= 11;
  create view FACTFOURN_MSUM_LIB_ODRE as
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
       montantTTCvrai,
       MONTANTTTC,
       MONTANTAVOIR,
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
       ETATLIB
from FACTFOURN_MSUM_LIB;


create or replace view facture_client_union_ordre
as
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
       montantTTCvrai,
       MONTANTTTC,
       MONTANTAVOIR,
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

       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       ETATLIB
from facture_client_union;



create or replace view FACTUREFOURNVALIDE as
select *
from factfourn_msum_lib
where idcategorie <> 'CATGFF002';

create or replace view FACTUREFOURNVALIDE_C as
select *
from FACTUREFOURNVALIDE
where etat = 1;



create or replace view FACTUREFOURNVALIDE_V as
select *
from FACTUREFOURNVALIDE
where etat >= 11
  and id not in (select id1 from LIAISONINTRATABLE);
  
  
  
create or replace view FACTUREFOURNVALIDE_EP as
select ff.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
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
       'ATTENTE DE PAIEMENT' as ETATLIB
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
where (li.IDJOURNAL is not null
    and li.ETATJC = 1);

create or replace view FACTUREFOURNVALIDE_P as
select ff.ID,
       DATY,*
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
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
       'PAYE' as ETATLIB
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
where li.IDJOURNAL is not null
  and li.ETATJC = 11;


  

create or replace view FACTUREFOURNVALIDE_TOUS as
select "ID",
       "DATY",
       "TIERS",
       "DESIGNATION",
       "TYPE",
       "TVA",
       "REMARQUE",
       "IDUSER",
       "DATE_ECHEANCE",
       "ETAT",
       "IDPREVISION",
       "MONTANT",
       "MONTANTTVA",
       "MONTANTAVOIR",
       "MONTANTTTC",
       "MONTANTPAYE",
       "MONTANTRESTE",
       "TIERSLIB",
       "CONTACT",
       "ADRESSE",
       "ESCALE",
       "TYPELIB",
       "IDCATEGORIE",
       "CATEGORIELIB",
       "IDPROVISION",
       "IDPROVISIONLIB",
       "ESTDDPMICTSL",
       "DEVISEMERE",
       "CODEPRESTATION",
       "CODEPRESTATIONLIB",
       "CODE",
       "ESTMICTSL",
       "CODEPROVISION",
       MONTANTTTCVRAI,
       "ETATLIB"
from FACTUREFOURNVALIDE_C
union
select "ID",
       "DATY",
       "TIERS",
       "DESIGNATION",
       "TYPE",
       "TVA",
       "REMARQUE",
       "IDUSER",
       "DATE_ECHEANCE",
       "ETAT",
       "IDPREVISION",
       "MONTANT",
       "MONTANTTVA",
       "MONTANTAVOIR",
       "MONTANTTTC",
       "MONTANTPAYE",
       "MONTANTRESTE",
       "TIERSLIB",
       "CONTACT",
       "ADRESSE",
       "ESCALE",
       "TYPELIB",
       "IDCATEGORIE",
       "CATEGORIELIB",
       "IDPROVISION",
       "IDPROVISIONLIB",
       "ESTDDPMICTSL",
       "DEVISEMERE",
       "CODEPRESTATION",
       "CODEPRESTATIONLIB",
       "CODE",
       "ESTMICTSL",
       "CODEPROVISION",
       MONTANTTTCVRAI,
       "ETATLIB"
from FACTUREFOURNVALIDE_V
union
select "ID",
       "DATY",
       "TIERS",
       "DESIGNATION",
       "TYPE",
       "TVA",
       "REMARQUE",
       "IDUSER",
       "DATE_ECHEANCE",
       "ETAT",
       "IDPREVISION",
       "MONTANT",
       "MONTANTTVA",
       "MONTANTAVOIR",
       "MONTANTTTC",
       "MONTANTPAYE",
       "MONTANTRESTE",
       "TIERSLIB",
       "CONTACT",
       "ADRESSE",
       "ESCALE",
       "TYPELIB",
       "IDCATEGORIE",
       "CATEGORIELIB",
       "IDPROVISION",
       "IDPROVISIONLIB",
       "ESTDDPMICTSL",
       "DEVISEMERE",
       "CODEPRESTATION",
       "CODEPRESTATIONLIB",
       "CODE",
       "ESTMICTSL",
       "CODEPROVISION",
       MONTANTTTCVRAI,
       "ETATLIB"
from FACTUREFOURNVALIDE_ep

union
select "ID",
       "DATY",
       "TIERS",
       "DESIGNATION",
       "TYPE",
       "TVA",
       "REMARQUE",
       "IDUSER",
       "DATE_ECHEANCE",
       "ETAT",
       "IDPREVISION",
       "MONTANT",
       "MONTANTTVA",
       "MONTANTAVOIR",
       "MONTANTTTC",
       "MONTANTPAYE",
       "MONTANTRESTE",
       "TIERSLIB",
       "CONTACT",
       "ADRESSE",
       "ESCALE",
       "TYPELIB",
       "IDCATEGORIE",
       "CATEGORIELIB",
       "IDPROVISION",
       "IDPROVISIONLIB",
       "ESTDDPMICTSL",
       "DEVISEMERE",
       "CODEPRESTATION",
       "CODEPRESTATIONLIB",
       "CODE",
       "ESTMICTSL",
       "CODEPROVISION",
       MONTANTTTCVRAI,
       "ETATLIB"
from FACTUREFOURNVALIDE_p;

alter table FACTURE_FOURNISSEUR_FILLE drop column IDINGREDIENT;;

create view FACTURE_FOURNISSEUR_QTE as
select idblf, cast(sum(QUANTITE) as NUMBER(10, 2)) as quantite
from FACTURE_FOURNISSEUR_FILLE
group by idblf;

CREATE OR REPLACE VIEW AS_BONDELIVRAISON_FILLEQTE_RES
            (ID, PRODUIT, NUMBL, QUANTITE, QUANTITEPARPACK, IDDETAILSFACTUREFOURNISSEUR, IDBONDECOMMANDE,
             FACTURE, QUANTITERESTE, PU, NOMTIERS, IDTIERS, TVA, MONTANTHT, MONTANTTVA, PROJET, PROJETLIB,
             CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB)
AS
SELECT blf.ID,
       blf.PRODUIT,
       blf.NUMBL,
       blf.QUANTITE,
       blf.QUANTITEPARPACK,
       blf.IDDETAILSFACTUREFOURNISSEUR,
       blf.IDBONDECOMMANDE,
       NVL(qff.quantite, 0)                                                AS facture,
       blf.QUANTITE - NVL(qff.quantite, 0)                                 AS quantitereste,
       bcf.PU,
       tiers.nom                                                      AS nomTiers,
       tiers.id                                                       as idtiers,
       bcf.TVA,
       cast((blf.QUANTITE * bcf.PU) as number(34, 2))                 as montantht,
       cast((blf.QUANTITE * bcf.PU * bcf.TVA) / 100 as number(34, 2)) as montanttva,
       bc.PROJET,
       pr.DESIGNATION                                                 as projetlib,
       bc.CODE_ETAB                                                   as code_etablissement,
       ce.VAL                                                         as code_etablissementlib
FROM AS_BONDELIVRAISON_FILLE blf
         LEFT JOIN union_bcf_spat_cemedi bcf
                   ON bcf.id = blf.IDBONDECOMMANDE
         LEFT JOIN union_bc_spat_cemedi bc ON bc.id = bcf.idbc
         LEFT JOIN tiers ON tiers.id = bc.fournisseur
         LEFT JOIN FACTURE_FOURNISSEUR_QTE qff
                   ON qff.IDBLF = blf.id
         left join PROJET pr on pr.id = bc.PROJET
         left join CODEETABLISSEMENT ce on ce.id = CODE_ETAB;

		 
create or replace view factureClientValide_v  as
select * from factureClientValide where etat>=11;



create view factureclientmsum_v as
select *from factureclientmsum where ETAT>=11;



  CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIB (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, IDPRODUITLIB, IDACTIVITE, CATEGORIEFACTURELIB, CATEGORIECLIENTLIB, RUBRIQUELIB, CLIENTLIB, MAJORATION, REDUCTION) AS
  select ID,
       IDMERE,
       DESIGNATION,
       cast(QUANTITE as NUMBER(32, 3))             as QUANTITE,
       cast(PU as NUMBER(32, 3))                   as PU,
       COMPTE,
       IDPRODUIT,
       DEVISE,
       TAUX,
       cast(QTELIVREE as number(32, 3))            as QTELIVREE,
       cast(RESTEALIVRER as NUMBER(32, 3))         as RESTEALIVRER,
       cast(MONTANTTAUX as NUMBER(32, 3))          as MONTANTTAUX,
       cast(MONTANT as NUMBER(32, 3))              as MONTANT,
       cast(MONTANTAVOIRSANSTAUX as NUMBER(32, 3)) as MONTANTAVOIRSANSTAUX,
       cast(MONTANTAVOIRAVECTAUX as NUMBER(32, 3)) as MONTANTAVOIRAVECTAUX,
       IDPRODUITLIB,
       IDACTIVITE,
       CATEGORIEFACTURELIB,
       CATEGORIECLIENTLIB,
       RUBRIQUELIB,
       clientlib,
       MAJORATION,
       REDUCTION
from (
         select fc.ID,
                fc.IDMERE,
                fc.DESIGNATION,
                fc.QUANTITE,
                fc.PU,
                fc.COMPTE,
                fc.IDPRODUIT,
                fc.DEVISE,
                fc.TAUX,
                cast(nvl(gr.QUANTITE, 0) as number(10, 3))               as qteLivree,
                cast(fc.QUANTITE - nvl(gr.QUANTITE, 0) as number(10, 3)) as resteAlivrer,
                cast(fcm.MONTANTTAUX as number(32, 3))                   as MONTANTTAUX,
                cast(fcm.MONTANT as NUMBER(32, 3))                       as MONTANT,
                cast(fcm.MONTANTAVOIRSANSTAUX as number(32, 3))          as MONTANTAVOIRSANSTAUX,
                cast(fcm.MONTANTAVOIRAVECTAUX as NUMBER(32, 3))          as MONTANTAVOIRAVECTAUX,
                pr.nom                                                   AS IDPRODUITlib,
                fc.IDACTIVITE,
                al.CATEGORIELIB                                          as categorieFacturelib,
                fcm.CATEGORIE                                            as categorieclientlib,
                nvl(RUBRIQUELIB, ra.DESIGNATION)                         as RUBRIQUELIB,
                v.NOMCLT as clientlib,
                nvl(fc.MAJORATION,0) as MAJORATION,
                nvl(fc.REDUCTION,0) as REDUCTION
         from facture_client_fille fc
                  left join AS_PRODUITS pr on pr.ID = fc.IDPRODUIT
                  left join as_bondelivraison_cl_grp gr on gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
                  left join FACTURE_CLIENT_MONTANT_LIB fcm on fcm.id = fc.id
                  left join ACTIVITELIBCOMPLET al on al.id = fc.IDACTIVITE
                  left join RUBRIQUE_ACTIVITE ra on ra.id = fc.RUBRIQUE
                   join factureclientmsum_v   f on fc.IDMERE = f.ID
                   left join  V_CLIENT_CATEGORIE v on v.CDCLT=f.TIERS
         union all
         select a.*,
                cast('-' as VARCHAR2(500)) as RUBRIQUELIB,
                cast('-' as VARCHAR2(500)) as clientlib,
                0 as MAJORATION,
                0 as REDUCTION
         from ANALYSEGLOBALFACTURE_FAC a);
		 
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEDI00012702', 'Import TC journalier', 'fa fa-edit', '/spat/pages/globalnegoce.jsp?but=import/ImportExcel-journalier.jsp', 5, 3, 'MDO000004');





