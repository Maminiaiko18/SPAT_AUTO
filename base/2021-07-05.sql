
CREATE OR REPLACE VIEW FACTURECLIENTMSUM
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE,
             IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE)
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 2)) AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 2))  AS montanttva,
       NVL(grp.montantavoiravectaux, 0)               AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 2))
                                                      AS MONTANTTTC,
       pr.ESCALE
FROM FACTURECLIENT fc
         LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id
         left join PREVISION pr on pr.id = fc.IDPREVISION;
 

create OR REPLACE view FACTURECLIENTMSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE,ESCALE)
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
       CAST(NVL(jc.montant, 0) AS NUMBER(32, 2)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(jc.montant, 0) AS NUMBER(32, 2))
                                                 AS montantreste,
       fup.NOM                                   AS tierslib,
       fup.CONTACT,
       fup.ADRESSE,
       M.ESCALE
FROM factureclientMSum m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN JOURNALCAISSELIB_VISE_SUM jc ON jc.IDPLACEMENT = m.id;

CREATE OR REPLACE VIEW FACTURE_CLIENT_UNION
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE,
             IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE,
             MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE,IDPREVISION,ESCALE)
AS
select ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       cast(TVA as NUMBER(20, 2)) as tva,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       cast(ETAT as NUMBER(10))   as etat,
       cast(MONTANT as NUMBER(32, 2)),
       cast(MONTANTTVA as number(32, 2)),
       cast(MONTANTAVOIR as number(32, 2)),
       cast(MONTANTTTC as NUMBER(32, 2)),
       cast(MONTANTPAYE as NUMBER(32, 2)),
       cast(MONTANTRESTE as NUMBER(32, 2)),
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE
from (
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                cast(TVA as NUMBER(20, 2))          as TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                cast(ETAT as number(10))            as etat,
                cast(MONTANT as NUMBER(32, 2))      as MONTANT,
                cast(MONTANTTVA as NUMBER(32, 2))   as MONTANTTVA,
                cast(MONTANTAVOIR as NUMBER(32, 2)) as MONTANTAVOIR,
                cast(MONTANTTTC as NUMBER(32, 2))   as MONTANTTTC,
                cast(MONTANTPAYE as NUMBER(32, 2))  as MONTANTPAYE,
                cast(MONTANTRESTE as NUMBER(32, 2)) as MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                IDPREVISION,
                ESCALE
         from FACTURECLIENTMSUM_LIB
         union all
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                cast(TVA as NUMBER(20, 2))          as TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                cast(ETAT as NUMBER(10))            as etat,
                cast(MONTANT as NUMBER(32, 2))      as MONTANT,
                cast(MONTANTTVA as NUMBER(32, 2))   as MONTANTTVA,
                cast(MONTANTAVOIR as NUMBER(32, 2)) as MONTANTAVOIR,
                cast(MONTANTTTC as NUMBER(32, 2))   as MONTANTTTC,
                cast(MONTANTPAYE as NUMBER(32, 2))  as MONTANTPAYE,
                cast(MONTANTRESTE as NUMBER(32, 2)) as MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                '-' as PREVISION,
                '-' as ESCALE
         from analyseglobaleantsika);

CREATE OR REPLACE VIEW FACTURE_CLIENT_UNION
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE,
             IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE,
             MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE,IDPREVISION,ESCALE,ETATLIB)
AS
select ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       cast(TVA as NUMBER(20, 2)) as tva,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       cast(ETAT as NUMBER(10))   as etat,
       cast(MONTANT as NUMBER(32, 2)),
       cast(MONTANTTVA as number(32, 2)),
       cast(MONTANTAVOIR as number(32, 2)),
       cast(MONTANTTTC as NUMBER(32, 2)),
       cast(MONTANTPAYE as NUMBER(32, 2)),
       cast(MONTANTRESTE as NUMBER(32, 2)),
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       CASE WHEN ETAT=1 THEN 'CREE(E)'
            WHEN ETAT=11 THEN  'VISE(E)' END AS ETATLIB
from (
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                cast(TVA as NUMBER(20, 2))          as TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                cast(ETAT as number(10))            as etat,
                cast(MONTANT as NUMBER(32, 2))      as MONTANT,
                cast(MONTANTTVA as NUMBER(32, 2))   as MONTANTTVA,
                cast(MONTANTAVOIR as NUMBER(32, 2)) as MONTANTAVOIR,
                cast(MONTANTTTC as NUMBER(32, 2))   as MONTANTTTC,
                cast(MONTANTPAYE as NUMBER(32, 2))  as MONTANTPAYE,
                cast(MONTANTRESTE as NUMBER(32, 2)) as MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                IDPREVISION,
                ESCALE
         from FACTURECLIENTMSUM_LIB
         union all
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                cast(TVA as NUMBER(20, 2))          as TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                cast(ETAT as NUMBER(10))            as etat,
                cast(MONTANT as NUMBER(32, 2))      as MONTANT,
                cast(MONTANTTVA as NUMBER(32, 2))   as MONTANTTVA,
                cast(MONTANTAVOIR as NUMBER(32, 2)) as MONTANTAVOIR,
                cast(MONTANTTTC as NUMBER(32, 2))   as MONTANTTTC,
                cast(MONTANTPAYE as NUMBER(32, 2))  as MONTANTPAYE,
                cast(MONTANTRESTE as NUMBER(32, 2)) as MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                '-' as PREVISION,
                '-' as ESCALE
         from analyseglobaleantsika);
