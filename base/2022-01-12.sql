create view facture_client_fille_libVM as
select fcf.*
from facture_client_fille_lib fcf
         join factureclient fc on fc.id = fcf.idmere
where etat >= 11;


create or replace view ETATPROVISIONVRAI
            (ID, MONTANTFACTURE, MONTANTPROVISION, MONTANTPAYE, ECART, TIERS, TIERSLIB, DATY, TIERSPROVISION,
             TIERSLIBPROVISION, MONTANTRESTE, IDPROVISION)
as
SELECT fu.id,
       cast(SUM(NVL(FCUV.MONTANTTTC, 0)) as NUMBER(30,3)) AS montantfacture,
       cast(SUM(fu.MONTANTTTC) as NUMBER(30,3)) AS montantprovision,
       cast(SUM(fu.MONTANTPAYE) as NUMBER(30,3)) AS MONTANTPAYE,
       cast(SUM(fu.MONTANTPAYE) - SUM(NVL(FCUV.MONTANTTTC, 0)) as NUMBER(30,3)) AS ecart, --RAP
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
       cast(SUM(fu.MONTANTTTC) - NVL(SUM(FCUV.MONTANTTTC), 0) as NUMBER(30,3))
               AS MONTANTRESTE,
            ''
       FROM FACTURECLIENTMSUM_LIB  fu
            --left JOIN FACTURE_CLIENT_UNION fac ON fa.id = fac.IDPROVISION
            LEFT JOIN FACTURE_CLIENT_UNION_VISE FCUV
               ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib
/


create view CompteCAFactAvoir_grpNet as
select *
from CompteCAFactAvoir_grp
--where categorie != provision
-- -union
--     select *from
-- provisionnonregularisee;
;


create table remboursementPlacement
(
    id           varchar2(500)
        constraint remboursementPlacement_pk primary key,
    daty         date,
    idplacement  varchar2(500)
        constraint fk_placement_ references PLACEMENT,
    montantPlace number(30, 3),
    interet      number(30, 3),
    caisse       varchar2(100)
        constraint fk_caissepal references CAISSE,
    etat         number(10)
);


CREATE SEQUENCE seqremboursementPlacement
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqremboursementPlacement
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqremboursementPlacement.nextval INTO retour FROM dual;
  return retour;
END;

create view remboursementPlacementlib as
select r.*,
       p.entite,
       p.banque,
       c.val as caisselib
from remboursementPlacement r
    left join placementlib p on r.idplacement=p.ID
    left join caisse c on r.caisse=c.ID;
	
alter table facture_fournisseur_mere
    add estAuto  number(10);


  CREATE OR REPLACE VIEW FACTFOURN_MONTANT (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDPROVISION, IDCATEGORIE, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MAJORATION, REDUCTION, MONTANTMAJORATION, MONTANTREDUCTION, IDACTIVITE, DATEFACT, RUBRIQUE, MONTANTTAUXTVA) AS 
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
       CAST(fm.pu * fm.quantite AS NUMBER(30, 3))                                             AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3))
                                                                                              AS montanttaux,
       NVL(montantsanstaux, 0)                                                                AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 3))
                                                                                              AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)                                                                  as MAJORATION,
       NVL(fm.REDUCTION, 0)                                                                   as REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3)) as montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) AS NUMBER(30, 3))  as montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite ) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3)) * fm.tva /
       100                                                                                    as montanttauxtva
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirffavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID
 
 
  CREATE OR REPLACE VIEW DETAILSFACTUREFOURNISSEUR_PAYE (ID, IDINGREDIENT, QTE, PU, IDMERE, COMPTE, PUDEVISE, IDDQE, MARGE, TVA, DATY, MONTANTTTC, MONTANTPAYEPOURC, MONTANTPAYE, EXERCICE, ANNEE, MOIS) AS 
  select dff.ID,
       cast('-' as varchar2(100))                                                   IDINGREDIENT,
       dff.QUANTITE                                                              as QTE,
       dff.PU,
       dff.IDMERE,
       dff.COMPTE,
       dff.PUDEVISE,
       dff.IDDQE,
       dff.MARGE,
       dff.TVA,
       ff.DATY,
       dff1.MONTANTTAUX+MONTANTTAUXTVA-MONTANTAVOIRAVECTAUX as MONTANTTTC ,
       ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1))                     as montantpayepourc,
       (dff1.MONTANTTAUX+MONTANTTAUXTVA-MONTANTAVOIRAVECTAUX) * ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1)) as montantpaye,
       ff.EXERCICE ,
       dff.ANNEE  ,
       dff.MOIS
from factfourn_msum_lib ff
         right join FACTURE_FOURNISSEUR_FILLE dff on dff.IDMERE = ff.id
         right join FACTFOURN_MONTANT dff1 on dff1.id = dff.id
where ff.ETAT >= 11;


CREATE OR REPLACE VIEW SITUATIONLCDEPENSEV (ID, DESIGNATION, COMPTE, ANNEE, MONTANT, ETAT, FACTURE, PAYE,arecouvrir,restebudget) AS
select l.id,
       l.DESIGNATION,
       l.compte,
       l.ANNEE,
       l.montant                                                                   as montant,
       l.etat,
       cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))                              as facture,
       cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3))                             as PAYE,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3)) as arecouvrir,
       cast((l.montant) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                as restebudget
from LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf on l.compte = mf.compte AND mf.annee = l.annee
where l.etat >= 11
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat;



CREATE OR REPLACE VIEW SITUATIONLCDEPENSEV
            (ID, DESIGNATION, COMPTE, ANNEE, MONTANT, ETAT, FACTURE, PAYE, arecouvrir, restebudget,
             pourcEngage, pourcPaye)
AS
select l.id,
       l.DESIGNATION,
       l.compte,
       l.ANNEE,
       l.montant                                                                   as montant,
       l.etat,
       cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))                              as facture,
       cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3))                             as PAYE,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3)) as arecouvrir,
       cast((l.montant) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                as restebudget,
       cast(((nvl(sum(MONTANTTTC), 0)) / l.MONTANT) * 100 as NUMBER(30, 3))        as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100 as number(30, 3))       as pourcPaye
from LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
                   on l.compte = mf.compte AND mf.annee = l.annee
where l.etat >= 11
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat;

CREATE OR REPLACE VIEW SITUATIONLCRECETTEV
            (ID, DESIGNATION, COMPTE, ANNEE, MONTANT, ETAT, FACTURE, PAYE, arecouvrir, restebudget,
             pourcEngage, pourcPaye)
as
    select l.id,
       l.DESIGNATION,
       l.compte,
       l.ANNEE,
       l.montant                                                                   as montant,
       l.etat,
       cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))                              as facture,
       cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3))                             as PAYE,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3)) as arecouvrir,
       cast((l.montant) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                as restebudget,
       cast((nvl(sum(MONTANTTTC), 0) / l.MONTANT) * 100 as NUMBER(30, 3))        as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100 as number(30, 3))       as pourcPaye
from LIGNECREDITRECETTE l
         LEFT JOIN FACTURE_CLIENT_MF_PAYE mf
                   on l.compte = mf.compte AND mf.annee = l.annee
where l.etat >= 11
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat;