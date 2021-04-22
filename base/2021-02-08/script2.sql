CREATE OR REPLACE VIEW RECAP_TRESO(DATY, LIBELLE, NUMERO_COMPTE, MONTANT) AS
select DATY,
       LIBELLE,
       NUMERO_COMPTE,
       cast(montant as number(25, 2))
from recap_caisse
union
select date_placement as daty,
       'Placement'    as libelle,
       null           as numero_compte,
       cast(montant as number(25, 2))
from placement;


CREATE VIEW V_UNION_PERSONNEL_LIB AS
SELECT UNI.*, UNI.NOM || ' ' || UNI.PRENOM AS NOMETPRENOM
FROM V_UNION_PERSONNEL UNI;

create or replace view BON_PROVISOIRE_LIBCOMPLET as
SELECT bnp."ID",
       bnp."DATESAISIE",
       bnp."DATEEFFET",
       bnp."FOLIO",
       bnp."CAISSE",
       bnp."NUMPIECE",
       bnp."LIBELLE",
       bnp."DEBIT",
       bnp."CREDIT",
       bnp."REMARQUE",
       bnp."ETAT",
       bnp."BENEFICIAIRE",
       bnp."RESTE",
       c.VAL                          AS valcaisse,
       DESCE                          AS descecaisse,
       nvl(uni.NOMETPRENOM, bnp.beneficiaire) as beneficiairelib
FROM bon_provisoire_rst bnp
         JOIN caisse c ON bnp.CAISSE = c.ID
         left join V_UNION_PERSONNEL_LIB uni on uni.id = bnp.BENEFICIAIRE
/

CREATE OR REPLACE VIEW ANALYSEGLOBALEFACTURE_ANALYSE
            (NMFACT, DATY, CATEGORIE_FACTURE, SOUS_CATEGORIE_FACTURE, CLIENT, CATEGORIE_CLIENT,
             DESIGNATION, MTTC, MTHT, TAXE, DEVFACT, MTDEVISE, MTAVOIR, PAYE, RESTE, NUMCOMPTE,
             VALCAT)
AS
select nmfact,
       daty,
       categorie_facture,
       sous_categorie_facture,
       client,
       categorie_client,
       designation,
       cast(sum(mttc) as number(18, 2))     as mttc,
       cast(sum(mtht) as number(18, 2))     as mtht,
       cast(sum(taxe) as number(18, 2))     as taxe,
       devfact,
       cast(sum(mtdevise) as number(18, 2)) as mtdevise,
       cast(sum(mtavoir) as number(18, 2))  as mtavoir,
       cast(sum(paye) as number(18, 2))     as paye,
       cast(sum(reste) as number(18, 2))    as reste,
       numcompte,
       valcat
from analyseglobalefacture
group by nmfact, daty, categorie_facture, sous_categorie_facture, client, categorie_client, designation, devfact,
         numcompte, valcat;