create or replace view provisionviseeApayer as
select *
from facture_client_union
where idcategorie = 'CATFCO2'
  and MONTANTRESTE > 0
  and etat >= 11;
create or replace view provisionviseepayee as
select *
from facture_client_union
where idcategorie = 'CATFCO2'
  and MONTANTRESTE = 0
  and etat >= 11;

create view tousprovision as
select *
from facture_client_union
where idcategorie = 'CATFCO2';

create view facturemrevise as
select *
from factureclient
WHERE etat >= 11;

CREATE OR REPLACE VIEW PROVISIONFACTUREDEFINITIVE
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB,iddefinitive)
AS
SELECT facture_client_union.ID,
       facture_client_union.DATY,
       facture_client_union.TIERS,
       facture_client_union.DESIGNATION,
       facture_client_union.TYPE,
       facture_client_union.TVA,
      facture_client_union.REMARQUE,
       facture_client_union.IDUSER,
       facture_client_union.DATE_ECHEANCE,
       facture_client_union.ETAT,
       cast(MONTANT as number(32, 3))      as MONTANT,
       cast(MONTANTTVA as number(32, 3))   as montanttva,
       cast(MONTANTAVOIR as number(32, 3)) as MONTANTAVOIR,
       cast(MONTANTTTC as number(32, 3))   as MONTANTTTC,
       cast(MONTANTPAYE as number(32, 3))  as MONTANTPAYE,
       cast(MONTANTRESTE as number(32, 3)) as MONTANTRESTE,
       facture_client_union.TIERSLIB,
       facture_client_union.CONTACT,
       facture_client_union.ADRESSE,
       facture_client_union.IDPREVISION,
       facture_client_union.ESCALE,
       facture_client_union.ETATLIB,
       facture_client_union.TYPELIB,
       facture_client_union.IDCATEGORIE,
       facture_client_union.CATEGORIELIB,
       facture_client_union.IDPROVISION,
       facture_client_union.IDPROVISIONLIB,
       facturemrevise.ID as iddefinitive
FROM facture_client_union
        join facturemrevise on facturemrevise.IDPROVISION=FACTURE_CLIENT_UNION.ID
WHERE FACTURE_CLIENT_UNION.idcategorie = 'CATFCO2'
  /*AND id IN (SELECT idProvision
             FROM factureclient
             WHERE etat >= 11)*/
  AND FACTURE_CLIENT_UNION.etat >= 11;



  CREATE OR REPLACE  VIEW FACTURECLIENTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC,
ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL,codeprovision) AS
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
 fcf.CODE as codeprovision
FROM FACTURECLIENT fc
         LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id;


  CREATE OR REPLACE  VIEW FACTURECLIENTMSUM_LIB (ID, DATY, TIERS, DESIGNATION,
      TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
      MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB,
      CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION,
      IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB,
      CODE, ESTMICTSL,codeprovision) AS
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
       CAST(NVL(jc.montant, 0) AS NUMBER(32, 3)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(jc.montant, 0) AS NUMBER(32, 3))
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
codeprovision
FROM factureclientMSum m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN JOURNALCAISSELIB_VISE_SUM jc ON jc.IDPLACEMENT = m.id;


  CREATE OR REPLACE  VIEW FACTURECLIENTMSUMC as  select * from FACTURECLIENTMSUM_LIB
where etat = 1;

  CREATE OR REPLACE  VIEW FACTURECLIENTMSUMV as  select *
from FACTURECLIENTMSUM_LIB
where etat >= 11;




create or replace view FACTURE_CLIENT_UNION
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL,CODEPROVISION)
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
       CODEPROVISION
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
             CODEPROVISION
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
             ''                                  as CODEPROVISION
      FROM analyseglobaleantsika);

      CREATE OR REPLACE VIEW FACTURE_CLIENT_UNIONC
AS
select *from facture_client_union
where etat = 1;
CREATE OR REPLACE VIEW FACTURE_CLIENT_UNIONV as
select *
from facture_client_union
where etat = 11;



  CREATE OR REPLACE VIEW PROVISIONFACTUREDEFINITIVE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, IDDEFINITIVE) AS
  SELECT facture_client_union.ID,
       facture_client_union.DATY,
       facture_client_union.TIERS,
       facture_client_union.DESIGNATION,
       facture_client_union.TYPE,
       facture_client_union.TVA,
      facture_client_union.REMARQUE,
       facture_client_union.IDUSER,
       facture_client_union.DATE_ECHEANCE,
       facture_client_union.ETAT,
       cast(MONTANT as number(32, 3))      as MONTANT,
       cast(MONTANTTVA as number(32, 3))   as montanttva,
       cast(MONTANTAVOIR as number(32, 3)) as MONTANTAVOIR,
       cast(MONTANTTTC as number(32, 3))   as MONTANTTTC,
       cast(MONTANTPAYE as number(32, 3))  as MONTANTPAYE,
       cast(MONTANTRESTE as number(32, 3)) as MONTANTRESTE,
       facture_client_union.TIERSLIB,
       facture_client_union.CONTACT,
       facture_client_union.ADRESSE,
       facture_client_union.IDPREVISION,
       facture_client_union.ESCALE,
       facture_client_union.ETATLIB,
       facture_client_union.TYPELIB,
       facture_client_union.IDCATEGORIE,
       facture_client_union.CATEGORIELIB,
       facture_client_union.IDPROVISION,
       facture_client_union.IDPROVISIONLIB,
       facturemrevise.ID as iddefinitive
FROM facture_client_union
        join facturemrevise on facturemrevise.IDPROVISION=FACTURE_CLIENT_UNION.ID
WHERE FACTURE_CLIENT_UNION.idcategorie = 'CATFCO2'
  /*AND id IN (SELECT idProvision
             FROM factureclient
             WHERE etat >= 11)*/
  AND FACTURE_CLIENT_UNION.etat = 1;

  CREATE OR REPLACE VIEW PROVISIONFACTUREDEFINITIVE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, IDDEFINITIVE) AS
  SELECT facture_client_union.ID,
       facture_client_union.DATY,
       facture_client_union.TIERS,
       facture_client_union.DESIGNATION,
       facture_client_union.TYPE,
       facture_client_union.TVA,
      facture_client_union.REMARQUE,
       facture_client_union.IDUSER,
       facture_client_union.DATE_ECHEANCE,
       facture_client_union.ETAT,
       cast(MONTANT as number(32, 3))      as MONTANT,
       cast(MONTANTTVA as number(32, 3))   as montanttva,
       cast(MONTANTAVOIR as number(32, 3)) as MONTANTAVOIR,
       cast(MONTANTTTC as number(32, 3))   as MONTANTTTC,
       cast(MONTANTPAYE as number(32, 3))  as MONTANTPAYE,
       cast(MONTANTRESTE as number(32, 3)) as MONTANTRESTE,
       facture_client_union.TIERSLIB,
       facture_client_union.CONTACT,
       facture_client_union.ADRESSE,
       facture_client_union.IDPREVISION,
       facture_client_union.ESCALE,
       facture_client_union.ETATLIB,
       facture_client_union.TYPELIB,
       facture_client_union.IDCATEGORIE,
       facture_client_union.CATEGORIELIB,
       facture_client_union.IDPROVISION,
       facture_client_union.IDPROVISIONLIB,
       facturemrevise.ID as iddefinitive
FROM facture_client_union
        join facturemrevise on facturemrevise.IDPROVISION=FACTURE_CLIENT_UNION.ID
WHERE FACTURE_CLIENT_UNION.idcategorie = 'CATFCO2'
  /*AND id IN (SELECT idProvision
             FROM factureclient
             WHERE etat >= 11)*/
  AND FACTURE_CLIENT_UNION.etat >= 11;

  CREATE OR REPLACE VIEW PROVISIONFACTUREDEFINITIVETOUS (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, IDDEFINITIVE) AS
  SELECT facture_client_union.ID,
       facture_client_union.DATY,
       facture_client_union.TIERS,
       facture_client_union.DESIGNATION,
       facture_client_union.TYPE,
       facture_client_union.TVA,
      facture_client_union.REMARQUE,
       facture_client_union.IDUSER,
       facture_client_union.DATE_ECHEANCE,
       facture_client_union.ETAT,
       cast(MONTANT as number(32, 3))      as MONTANT,
       cast(MONTANTTVA as number(32, 3))   as montanttva,
       cast(MONTANTAVOIR as number(32, 3)) as MONTANTAVOIR,
       cast(MONTANTTTC as number(32, 3))   as MONTANTTTC,
       cast(MONTANTPAYE as number(32, 3))  as MONTANTPAYE,
       cast(MONTANTRESTE as number(32, 3)) as MONTANTRESTE,
       facture_client_union.TIERSLIB,
       facture_client_union.CONTACT,
       facture_client_union.ADRESSE,
       facture_client_union.IDPREVISION,
       facture_client_union.ESCALE,
       facture_client_union.ETATLIB,
       facture_client_union.TYPELIB,
       facture_client_union.IDCATEGORIE,
       facture_client_union.CATEGORIELIB,
       facture_client_union.IDPROVISION,
       facture_client_union.IDPROVISIONLIB,
       facturemrevise.ID as iddefinitive
FROM facture_client_union
        join facturemrevise on facturemrevise.IDPROVISION=FACTURE_CLIENT_UNION.ID
WHERE FACTURE_CLIENT_UNION.idcategorie = 'CATFCO2'
  /*AND id IN (SELECT idProvision
             FROM factureclient
             WHERE etat >= 11)*/
  AND FACTURE_CLIENT_UNION.etat >= 1;

  create view FACTURECLIENT_libcomplet as
select fc.*,
       fup.NOM as tierslib,
       cat.VAL as categorielib,
       tf.VAL as typelib
from FACTURECLIENT fc
    left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID=fc.TIERS
    left join CATEGORIEFC cat on cat.ID=fc.IDCATEGORIE
    left join TYPEFC tf on tf.ID=fc.TYPE;


create view JOURNALCAISSELIB_VISE_grp as
select cast(sum(DEBIT) as NUMBER(30, 3)) as DEBIT, IDPLACEMENT
from JOURNALCAISSELIB_VISE
group by IDPLACEMENT;

CREATE OR REPLACE VIEW AVOIRFC_MONTANT
            (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, tierslib, montantpaye, montantreste) AS
select fc.ID,
       fc.DATY,
       fc.IDFACTURE,
       fc.ETAT,
       cast(nvl(mr.montant, 0.0) as NUMBER(30, 3))                    as montant,
       f.TIERS,
       f.tierslib,
       cast(nvl(gr.DEBIT, 0) as NUMBER(30, 3))                        as montantpaye,
       cast(nvl(mr.montant, 0.0) - nvl(gr.DEBIT, 0) as NUMBER(30, 3)) as montantreste
from AVOIRFC fc
         left join avoirfcavectaux_grp_mere mr on mr.IDMERE = fc.ID
         left join FACTURECLIENT_libcomplet f on fc.IDFACTURE = f.ID
         left join JOURNALCAISSELIB_VISE_grp gr on gr.IDPLACEMENT = fc.ID;
create or replace
    view AVOIRFC_MONTANTLIBETAT as
SELECT op.*,
       CASE
           WHEN op.etat = 0 THEN 'annule'
           WHEN op.etat = 1 THEN 'cree'
           WHEN op.etat = 11 THEN 'vise'
           END AS etatlib
FROM AVOIRFC_MONTANT op;

create view avoirFC_montant_C
    as
    select *from avoirFC_montant where etat=1;
create view avoirFC_montant_V
    as
    select *from avoirFC_montant where etat>=11;

