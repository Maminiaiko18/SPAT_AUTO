create or replace view FACTURECLIENT_SEQUENCE_MCTSL as
select fc.ID,
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
       IDCATEGORIE,
       IDPROVISION,
       DEVISEMERE,
       ESTDDPMICTSL,
       CODEPRESTATION,
       CODE,
       substr((CODE), 2, 2) || '/' || substr((CODE), 4, 2) || '/01/'
           || substr((CODE), length((CODE)) - 5, 6) as datemoisseq,
       cast('01-' || substr((CODE), 4, 2) || '-20' || substr((CODE), 2, 2) as VARCHAR2(100)) as
         datemois,
       substr((CODE), length((CODE)) - 5, 6) as maxidparmoisane,
       estMictsl
from FACTURECLIENT fc
where estMictsl=1;


create or replace view NUMEROFACTUREMCTSL as
select DATEMOIS as id,
       cast(cast(max(maxidparmoisane) + 1 as NUMBER(10)) as VARCHAR2(500)) as val,
       '-'as desce
from factureclient_sequence_mctsl
group by DATEMOIS;

create replace view NUMEROFACTUREMCTSL_PARDATE as
select to_date(ID,'dd-mm-yyyy') as daty,
       cast( VAL as number(10)) -1  as numeroactuelle,
       cast(val as number(10))numerosuivant,
       cast(extract(month from to_date(id, 'dd-mm-yyyy')) as NUMBER(10)) as mois,
       cast(extract(year from to_date(id, 'dd-mm-yyyy')) as NUMBER(10)) as annee
       from NUMEROFACTUREMCTSL;
	   
create view FACTURECLIENT_SEQUENCE_SIMPLE as
select fc.ID,
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
       IDCATEGORIE,
       IDPROVISION,
       DEVISEMERE,
       ESTDDPMICTSL,
       CODEPRESTATION,
       CODE,
       substr((CODE), 2, 2) || '/' || substr((CODE), 4, 2) || '/01/'
           || substr((CODE), length((CODE)) - 2, 3) as datemoisseq,
       cast('01-' || substr((CODE), 4, 2) || '-20' || substr((CODE), 2, 2) as VARCHAR2(100)) as
         datemois,
       substr((CODE), length((CODE)) - 2, 3) as maxidparmoisane,
       ESTMICTSL
from FACTURECLIENT fc
where estMictsl != 1;

create or replace view NUMEROFACTURESIMPLE as
select datemois                                     as id,
       cast(max(maxidparmoisane) + 1 as NUMBER(10)) as val,
       '-'                                          as desce
from FACTURECLIENT_SEQUENCE_SIMPLE
group by datemois;


create or replace view NUMEROFACTURESIMPLE_PARDATE as
select to_date(id, 'dd-mm-yyyy') as daty,
       val - 1 as numeroactuelle,
       val as numerosuivant,
       cast(extract(month from to_date(id, 'dd-mm-yyyy')) as NUMBER(10)) as mois,
       cast(extract(year from to_date(id, 'dd-mm-yyyy')) as NUMBER(10)) as annee
from NUMEROFACTURESIMPLE;



CREATE or replace VIEW FACTURE_CLIENT_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION,
             IDACTIVITE, DATEFACT, RUBRIQUE)
AS
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
       fi.RUBRIQUE
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;



CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANT
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDPROVISION, IDCATEGORIE, MONTANT, MONTANTTAUX,
             MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MAJORATION, REDUCTION, MONTANTMAJORATION, MONTANTREDUCTION,
             IDACTIVITE, DATEFACT,RUBRIQUE)
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
       fm.RUBRIQUE
FROM facture_client_Mere_fille fm
         LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;



CREATE or replace VIEW FACTURE_CLIENT_MONTANTTC
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX,
             MONTANTAVOIRAVECTAUX, MONTANTTVA, MONTANTTAXE, MONTANTTC, IDACTIVITE, DATEFACT,RUBRIQUE)
AS
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       fc.IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATIONMERE,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(fc.MONTANT as number(32, 3))              as MONTANT,
       cast(fc.MONTANTTAUX as number(32, 3))          as MONTANTTAUX,
       cast(fc.MONTANTAVOIRSANSTAUX as number(32, 3)) as MONTANTAVOIRSANSTAUX,
       cast(fc.MONTANTAVOIRAVECTAUX as number(32, 3)) as MONTANTAVOIRAVECTAUX,
       CAST((fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                      AS montanttva,
       CAST((fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                      AS montanttaxe,
       CAST(
               (fc.pu * QUANTITE) + (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                      AS montanttc,
       fc.IDACTIVITE,
       fc.DATEFACT,
       fc.RUBRIQUE
FROM facture_client_montant fc;






