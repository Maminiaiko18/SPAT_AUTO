
CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE
            (ID, IDMERE, RUBRIQUE, DESIGNATION, PU, QUANTITE, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA,
             PRODUIT_LIB, ACTIVITELIB, DATEFACT, RUBRIQUELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION,
             RANG, DATY, DUREE, MONTANT,idrubrique)
AS
SELECT fi.ID,
       fi.IDMERE,
       fi.RUBRIQUE,
       fi.DESIGNATION,
       fi.PU,
       fi.QUANTITE,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fi.IDACTIVITE,
       fi.TVA,
       pr.nom                                                        AS produit_lib,
       ac.DESIGNATION                                                AS activitelib,
       TO_DATE(fi.DATEFACT, 'dd/MM/YY')                              AS DATEFACT,
       ra.DESIGNATION                                                AS rubriquelib,
       fi.MOIS,
       fi.ANNEE,
       fi.HEUREDEBUT,
       fi.HEUREFIN,
       nvl(fi.MAJORATION, 0)                                         as MAJORATION,
       nvl(fi.REDUCTION, 0)                                          as REDUCTION,
       case when fi.IDACTIVITE is not null then ra.RANG end          as rang,
       case when fi.IDACTIVITE is not null then ac.DATY end          as daty,
       fi.DUREE                                                      AS DUREE,
       cast(fi.QUANTITE * NVL(fi.DUREE, 1) * fi.pu as number(30, 3)) AS MONTANT,
       ra.ID as idrubrique
FROM FACTURE_CLIENT_FILLE fi
         LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
         LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = ac.RUBRIQUE ;




alter table FACTURECLIENT add constraint f_typefc foreign key(TYPE) references TYPEFC;


  CREATE OR REPLACE VIEW FACT_CLT_FILL_LIB_REST_TAXE (ID, IDMERE, DESIGNATION, QUANTITE, PU,
      COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT,
      MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
      ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO,
      MONTANTTAXE, MAJORATION, REDUCTION, DATEFACT, RUBRIQUE, RANG, DATY, DUREE,TYPE) AS
  SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                                             AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))                         AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                                          AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3))                             AS MONTANTTAUX,
       CAST(fcm.MONTANT AS NUMBER(32, 5))                                 AS MONTANT,
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3))
                                                                          AS MONTANTAVOIRSANSTAUX,
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3))
                                                                          AS MONTANTAVOIRAVECTAUX,
       CAST(fcm.tva AS NUMBER(20, 3))                                     AS tva,
       fc.idactivite,
       ra.DESIGNATION                                                     AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                                           AS moislib,
       CAST(0 AS NUMBER(32, 2))                                           AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                                           AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                                           AS montantTVAEuro,
       CAST((fc.pu * fc.QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                                          AS montanttaxe,
       NVL(fc.majoration, 0)                                              AS majoration,
       NVL(fc.reduction, 0)                                               AS reduction,
       fc.DATEFACT,
       nvl(fc.RUBRIQUE,r.ID),
       CASE
           WHEN fc.IDACTIVITE IS NOT NULL THEN r.RANG
           else r1.RANG END                                               AS rang,
       CASE WHEN fc.IDACTIVITE IS NOT NULL THEN ra.DATY else fcm.DATY END AS daty,
       fc.DUREE,
        fcm.TYPE
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fc.RUBRIQUE;
		 


CREATE OR REPLACE VIEW COMPTECAFACTURE
            (ID, VAL, DESCE, IDMERE, DESIGNATION, QUANTITE, PU, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, HEUREDEBUT,
             HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION, REDUCTION, DATEFACT,
             RUBRIQUE, RANG, DATY, VALMERECA, DESCEMERECA, MOIS, ANNEE, COMPTE,TYPE)
AS
select fdc.ID,
       cca.VAL,
       cca.DESCE,
       IDMERE,
       DESIGNATION,
       QUANTITE,
       PU,
       IDPRODUIT,
       DEVISE,
       TAUX,
       QTELIVREE,
       RESTEALIVRER,
       MONTANTTAUX,
       MONTANT,
       MONTANTAVOIRSANSTAUX,
       MONTANTAVOIRAVECTAUX,
       TVA,
       IDACTIVITE,
       ACTIVITELIB,
       HEUREDEBUT,
       HEUREFIN,
       MOISLIB,
       TAUXEURO,
       MONTANTHTEURO,
       MONTANTTVAEURO,
       MONTANTTAXE,
       MAJORATION,
       REDUCTION,
       DATEFACT,
       RUBRIQUE,
       RANG,
       DATY,
       mca.val                      as valMereCA,
       mca.desce                    as desceMereCA,
       extract(month from fdc.daty) as mois,
       extract(year from fdc.daty)  as annee,
       cca.val                      as compte,
       TYPE
from CompteCA cca,
     MereCA mca,
     FACT_CLT_FILL_LIB_REST_TAXE fdc
where fdc.compte like cca.val || '%'
  and fdc.compte is not null;
  
  
create or replace view COMPTECAFACTUREMOISAN as
select cca.rubrique,
       cca.compte,
       cca.DESCE                           as mere,
       cast(sum(montant) as number(32, 3)) as montant,
       cca.mois,
       cca.annee,
       TYPE,
       f.VAL as typelib
from CompteCAFacture cca
    left join TYPEFC f on f.ID=cca.TYPE
group by cca.rubrique, cca.DESCE, cca.mois, cca.annee, cca.compte,TYPE,
       f.VAL
/

create or replace view COMPTECAFACTAVOIR as
select cca."RUBRIQUE",
       cca."COMPTE",
       cca."MERE",
       cca."MONTANT",
       cca."MOIS",
       cca."ANNEE",
       cast(nvl(ccavoir.montant, 0) as number(32,3)) as avoir,
       TYPELIB         as type
from CompteCAFactureMoisAn cca
         left join CompteCAAvoirMoisAn ccavoir on cca.mois = ccavoir.mois and cca.annee = ccavoir.annee and
                                                  cca.compte = ccavoir.compte and cca.mere = ccavoir.mere
/

create view nombretypefc_parrubrique as
select RUBRIQUE,
       cast(count(TYPE) as NUMBER(10)) as nombre,
       TYPE
from CompteCAFacture
group by RUBRIQUE,TYPE;

create or replace view COMPTECAFACTUREMOISAN as
select cca.rubrique,
       cca.compte,
       cca.DESCE                           as mere,
       cast(sum(montant) as number(32, 3)) as montant,
       cca.mois,
       cca.annee,
       cca.TYPE,
       f.VAL as typelib,
       nvl(c.nombre,0) as nombre
from CompteCAFacture cca
    left join nombretypefc_parrubrique c on c.RUBRIQUE=cca.RUBRIQUE
    left join TYPEFC f on f.ID=cca.TYPE
group by cca.rubrique, cca.DESCE, cca.mois, cca.annee, cca.compte,cca.TYPE,
       f.VAL,c.nombre;
	   
create or replace view NOMBRETYPEFC_PARRUBRIQUE as
select RUBRIQUE,
       sum(case when TYPE='TFC001' then 1 else 0 end) as acredit,
       sum(case when TYPE='TFC002' then 1 else 0 end)  as aucomptant
from CompteCAFacture
group by RUBRIQUE
/

create or replace view COMPTECAFACTURE as
select fdc.ID,
       cca.VAL,
       cca.DESCE,
       IDMERE,
       DESIGNATION,
       QUANTITE,
       PU,
       IDPRODUIT,
       DEVISE,
       TAUX,
       QTELIVREE,
       RESTEALIVRER,
       MONTANTTAUX,
       MONTANT,
       MONTANTAVOIRSANSTAUX,
       MONTANTAVOIRAVECTAUX,
       TVA,
       IDACTIVITE,
       ACTIVITELIB,
       HEUREDEBUT,
       HEUREFIN,
       MOISLIB,
       TAUXEURO,
       MONTANTHTEURO,
       MONTANTTVAEURO,
       MONTANTTAXE,
       MAJORATION,
       REDUCTION,
       DATEFACT,
       RUBRIQUE,
       RANG,
       DATY,
       mca.val                      as valMereCA,
       mca.desce                    as desceMereCA,
       extract(month from fdc.daty) as mois,
       extract(year from fdc.daty)  as annee,
       cca.val                      as compte,
       TYPE,
       mca.VAL as mereca
from CompteCA cca,
     MereCA mca,
     FACT_CLT_FILL_LIB_REST_TAXE fdc
where fdc.compte like cca.val || '%'
  and fdc.compte is not null
/


  CREATE OR REPLACE VIEW TOUCHE_DE_NAVIRE (ID, DATY, ESCALE, NAVIRE, CONSIGNATAIRE, PROVENANCE, DESTINATION, REMARQUE, DUREE, TYPEMVT, CARGAISON, DATEARRIVEE, HEURE, ETAT, HEURE_DEPART, DATE_DEPART, VALMVT, DESCEMVT, VALCARGAISON, DESCECARGAISON, QUAIPROVENANCE, INTERNEPROVENANCE, PAYSPROVENANCE, VALQUAISPROVENANCE, DESCEQUAISPROVENANCE, TYPEQUAISPROVENANCE, TIRANTPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE, VALPAYSPROVENANCE, DESCEPAYSPROVENANCE, INTERNEDESTINATION, PAYSDESTINATION, VALQUAISDESTINATION, DESCEQUAISDESTINATION, TYPEQUAISDESTIANANTION, TIRANTDESTINATION, LONGUEURDESTINATION, PROFONDEURDESTINATION, VALPAYSDESTINATION, DESCEPAYSDESTINATION, REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, DEPART, ARRIVEE, DIFFERENCE, TYPENAVIRE, PAYSDESTINATIONDEPART, PAYSDESCEDESTINATIONDEPART, PAYSVALDESTINATIONDEPART, QUAISDESTINATIONDEPART, VALQUAISDESTINATIONDEPART, QUAISDESTINATION) AS
  select arr.id,
       arr.DATY,
       arr.ESCALE,
       arr.NAVIRE,
       arr.CONSIGNATAIRE,
       arr.PROVENANCE,
       arr.DESTINATION,
       arr.REMARQUE,
       arr.DUREE,
       arr.TYPEMVT,
       arr.CARGAISON,
       arr.DATEARRIVEE,
       arr.HEURE,
       arr.ETAT,
       dep.HEURE_DEPART,
       dep.DATE_DEPART,
       arr.VALMVT,
       arr.DESCEMVT,
       arr.VALCARGAISON,
       arr.DESCECARGAISON,
       arr.QUAIPROVENANCE,
       arr.INTERNEPROVENANCE,
       arr.PAYSPROVENANCE,
       arr.VALQUAISPROVENANCE,
       arr.DESCEQUAISPROVENANCE,
       arr.TYPEQUAISPROVENANCE,
       arr.TIRANTPROVENANCE,
       arr.LONGUEURPROVENANCE,
       arr.PROFONDEURPROVENANCE,
       arr.VALPAYSPROVENANCE,
       arr.DESCEPAYSPROVENANCE,
       arr.INTERNEDESTINATION,
       --arr.TYPEQUAISDESTIANANTION,
       arr.PAYSDESTINATION,
       arr.VALQUAISDESTINATION,
       arr.DESCEQUAISDESTINATION,
       arr.TYPEQUAISDESTIANANTION,
       arr.TIRANTDESTINATION,
       arr.LONGUEURDESTINATION,
       arr.PROFONDEURDESTINATION,
       arr.VALPAYSDESTINATION,
       arr.DESCEPAYSDESTINATION,
       arr.REFERENCENAVIRE,
       arr.NOMNAVIRE,
       arr.PAVILLONNAVIRE,
       arr.JNTNAVIRE,
       arr.JBTNAVIRE,
       arr.PLTNAVIRE,
       arr.LHTNAVIRE,
       arr.LMNAVIRE,
       arr.TENAVIRE,
       arr.VOLUMENAVIRE,
       arr.REMARQUENAVIRE,
       arr.ETATNAVIRE,
       arr.VALCONSIGNATAIRE,
       arr.DESCECONSIGNATAIRE,
       arr.VALTYPEQUAISPROVENANCE,
       arr.DESCETYPEQUAISPROVENANCE,
       arr.VALTYPEQUAISDESTINATION,
       arr.DESCETYPEQUAISDESTINATION,
       cast(0 as number(10, 2))          as depart,
       cast(1 as number(10, 2))          as arrivee,
       dep.date_depart - arr.datearrivee as DIFFERENCE,
       ty.val                            as typenavire,
       dep.PAYSDESTINATION               as paysdestinationdepart,
       dep.DESCEPAYSDESTINATION          as paysdescedestinationdepart,
       dep.valPAYSDESTINATION            as paysvaldestinationdepart,
       dep.QUAISDESTINATION              as QUAISDESTINATIONDEPART,
       dep.VALQUAISDESTINATION           AS VALQUAISDESTINATIONDEPART,
       arr.QUAISDESTINATION
from mouvementarrive_escale arr
         join mouvementdepart_escale dep on dep.escale = arr.escale
         left join NAVIRE nv on nv.id = arr.NAVIRE
         left join typenavire ty on ty.id = nv.type
order by DATEARRIVEE desc ,HEURE desc ;


alter table COMPTECA add libelle varchar2(500);


create or replace view CompteCAFactureMoisAn as
select cca.rubrique,
       r.DESIGNATION                                              as rubriquelib,
       cca.compte,
       cc.LIBELLE,
       c.VAL as comptemere,
       c.DESCE comptemerelib,
      -- cca.DESCE,
       mois,
       ANNEE,
       -- mereca,
       sum(case when TYPE = 'TFC001' then 1 else 0 end)           as nbreacredit,
       sum(case when TYPE = 'TFC002' then 1 else 0 end)           as aucomptant,
       sum(case when TYPE = 'TFC001' then MONTANTTAUX else 0 end) as montantacredit,
       sum(case when TYPE = 'TFC002' then MONTANTTAUx else 0 end) as montantaucomptant,
       sum(case when TYPE = 'TFC001' then MONTANTTAUX else 0 end) +
       sum(case when TYPE = 'TFC002' then MONTANTTAUx else 0 end) as montant

from CompteCAFacture cca
         left join MERECA c on c.ID = cca.DESCE
         left join COMPTECA cc on cc.ID = cca.VAL
         left join RUBRIQUE_ACTIVITE r on r.id = cca.RUBRIQUE
group by cca.rubrique,
         cca.compte,
         cca.DESCE, mois, ANNEE, c.VAL, c.DESCE, r.DESIGNATION,cc.LIBELLE;
		 
create or replace view COMPTECAFACTUREMOISAN as
select cca.rubrique,
       r.DESIGNATION                                              as rubriquelib,
       cca.compte,
       cc.LIBELLE,
       c.VAL as comptemere,
       c.DESCE comptemerelib,
       cca.DESCE as mere,
       mois,
       ANNEE,
       -- mereca,
       sum(case when TYPE = 'TFC001' then 1 else 0 end)           as nbreacredit,
       sum(case when TYPE = 'TFC002' then 1 else 0 end)           as aucomptant,
       sum(case when TYPE = 'TFC001' then MONTANTTAUX else 0 end) as montantacredit,
       sum(case when TYPE = 'TFC002' then MONTANTTAUx else 0 end) as montantaucomptant,
       sum(case when TYPE = 'TFC001' then MONTANTTAUX else 0 end) +
       sum(case when TYPE = 'TFC002' then MONTANTTAUx else 0 end) as montant

from CompteCAFacture cca
         left join MERECA c on c.ID = cca.DESCE
         left join COMPTECA cc on cc.ID = cca.VAL
         left join RUBRIQUE_ACTIVITE r on r.id = cca.RUBRIQUE
group by cca.rubrique,
         cca.compte,
         cca.DESCE, mois, ANNEE, c.VAL, c.DESCE, r.DESIGNATION,cc.LIBELLE;
		 

create or replace view COMPTECAFACTAVOIR as
select cca.*,
       nvl(ccavoir.montant,0) as montantavoir
from CompteCAFactureMoisAn cca
         left join CompteCAAvoirMoisAn ccavoir on cca.mois = ccavoir.mois and cca.annee = ccavoir.annee and
                                                  cca.compte = ccavoir.compte and cca.mere = ccavoir.mere
/

UPDATE COMPTECA SET VAL='70600', LIBELLE='CESSION EAU DOUCE', DESCE='MCA9' WHERE ID='1';
UPDATE COMPTECA SET VAL='70601', LIBELLE='ENLEVEMENT ORDURES', DESCE='MCA1' WHERE ID='5';
UPDATE COMPTECA SET VAL='70602', LIBELLE='STATIONNEMENT OU IMMOBILISATION', DESCE='MCA1' WHERE ID='6';
UPDATE COMPTECA SET VAL='70603', LIBELLE='LOCATION REMORQUEURS', DESCE='MCA1' WHERE ID='7';
UPDATE COMPTECA SET VAL='70604', LIBELLE='LOC VEDETTES DE SERVITUDES', DESCE='MCA1' WHERE ID='8';
UPDATE COMPTECA SET VAL='70605', LIBELLE='PIQUAGES, PEINTURES, ...', DESCE='MCA1' WHERE ID='9';
UPDATE COMPTECA SET VAL='70606', LIBELLE='PIQUET D''INCENDIE', DESCE='MCA1' WHERE ID='10';
UPDATE COMPTECA SET VAL='70607', LIBELLE='LOCATION VAVENTY/ANTSIKA', DESCE='MCA1' WHERE ID='11';
UPDATE COMPTECA SET VAL='70610', LIBELLE='AUTRES PRESTATION CONNEXE', DESCE='MCA2' WHERE ID='12';
UPDATE COMPTECA SET VAL='70611', LIBELLE='OUVERTURE MAGASIN', DESCE='MCA2' WHERE ID='13';
UPDATE COMPTECA SET VAL='70630', LIBELLE='REDEV D''EXPLOITATION', DESCE='MCA3' WHERE ID='4';
UPDATE COMPTECA SET VAL='70631', LIBELLE='REDEVANCES LOCATIVES', DESCE='MCA3' WHERE ID='14';
UPDATE COMPTECA SET VAL='70632', LIBELLE='REDEVANCES DOMANIALES', DESCE='MCA4' WHERE ID='15';
UPDATE COMPTECA SET VAL='70634', LIBELLE='DROIT DE PORT/CONVENTION', DESCE='MCA4' WHERE ID='16';
UPDATE COMPTECA SET VAL='70640', LIBELLE='REDEVANCE FIXE MICTSL', DESCE='MCA4' WHERE ID='17';
UPDATE COMPTECA SET VAL='70641', LIBELLE='REDEVANCE VAR MICTSL', DESCE='MCA5' WHERE ID='18';
UPDATE COMPTECA SET VAL='70642', LIBELLE='DROIT DE PORT MICTSL', DESCE='MCA5' WHERE ID='19';
UPDATE COMPTECA SET VAL='70651', LIBELLE='CONSOMMATION EAU COURANTE', DESCE='MCA5' WHERE ID='20';
UPDATE COMPTECA SET VAL='70652', LIBELLE='PERCEPTION ANNUL FACTURES -P.DIV', DESCE='MCA6' WHERE ID='21';
UPDATE COMPTECA SET VAL='70653', LIBELLE='REDEVANCE SANITAIRE', DESCE='MCA6' WHERE ID='22';
UPDATE COMPTECA SET VAL='70662', LIBELLE='DROIT DE PORT/HYDRO DGB', DESCE='MCA6' WHERE ID='23';
UPDATE COMPTECA SET VAL='70670', LIBELLE='DROIT DU PORT SUR MARCH ET PASSAGER', DESCE='MCA7' WHERE ID='24';
UPDATE COMPTECA SET VAL='70671', LIBELLE='PEAGE M/SE DEBARQUEE (BORNAGE)', DESCE='MCA8' WHERE ID='25';
UPDATE COMPTECA SET VAL='70672', LIBELLE='PEAGE M/SE EMBARQUEE (BORNAGE)', DESCE='MCA8' WHERE ID='26';
UPDATE COMPTECA SET VAL='70680', LIBELLE='DROIT DE PORT', DESCE='MCA8' WHERE ID='27';
UPDATE COMPTECA SET VAL='70681', LIBELLE='LAMANAGE', DESCE='MCA9' WHERE ID='28';
UPDATE COMPTECA SET VAL='70682', LIBELLE='PILOTAGE', DESCE='MCA9' WHERE ID='29';
UPDATE COMPTECA SET VAL='70683', LIBELLE='REMORQUAGE', DESCE='MCA9' WHERE ID='30';
UPDATE COMPTECA SET VAL='70684', LIBELLE='STATIONNEMENT', DESCE='MCA9' WHERE ID='31';
UPDATE COMPTECA SET VAL='70685', LIBELLE='VEILLE DE SECURITE', DESCE='MCA9' WHERE ID='32';

commit;


create or replace view COMPTECAFACTUREMOISAN as
select cca.rubrique,
       r.DESIGNATION                                              as rubriquelib,
       cca.compte,
       cc.LIBELLE,
       c.VAL as comptemere,
       c.DESCE comptemerelib,
       cca.DESCE as mere,
       mois,
       ANNEE,
       -- mereca,
       sum(case when TYPE = 'TFC001' then 1 else 0 end)           as nbreacredit,
       sum(case when TYPE = 'TFC002' then 1 else 0 end)           as aucomptant,
       sum(case when TYPE = 'TFC001' then MONTANTTAUX else 0 end) as montantacredit,
       sum(case when TYPE = 'TFC002' then MONTANTTAUx else 0 end) as montantaucomptant,
       sum(case when TYPE = 'TFC001' then MONTANTTAUX else 0 end) +
       sum(case when TYPE = 'TFC002' then MONTANTTAUx else 0 end) as montant

from CompteCAFacture cca
         left join MERECA c on c.ID = cca.DESCE
         left join COMPTECA cc on cc.VAL = cca.VAL
         left join RUBRIQUE_ACTIVITE r on r.id = cca.RUBRIQUE
group by cca.rubrique,
         cca.compte,
         cca.DESCE, mois, ANNEE, c.VAL, c.DESCE, r.DESIGNATION,cc.LIBELLE
/


CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE
            (ID, IDMERE, RUBRIQUE, DESIGNATION, PU, QUANTITE, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA,
             PRODUIT_LIB, ACTIVITELIB, DATEFACT, RUBRIQUELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION,
             RANG, DATY, DUREE, MONTANT, IDRUBRIQUE)
AS
SELECT fi.ID,
       fi.IDMERE,
       (fi.RUBRIQUE)                                           as RUBRIQUE,
       fi.DESIGNATION,
       fi.PU,
       fi.QUANTITE,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fi.IDACTIVITE,
       fi.TVA,
       pr.nom                                                            AS produit_lib,
       ac.DESIGNATION                                                    AS activitelib,
       TO_DATE(fi.DATEFACT, 'dd/MM/YY')                                  AS DATEFACT,
       nvl(ra.DESIGNATION, r1.DESIGNATION)                               AS rubriquelib,
       fi.MOIS,
       fi.ANNEE,
       fi.HEUREDEBUT,
       fi.HEUREFIN,
       nvl(fi.MAJORATION, 0)                                             as MAJORATION,
       nvl(fi.REDUCTION, 0)                                              as REDUCTION,
       case
           when fi.IDACTIVITE is not null then ra.RANG
           else r1.RANG END                                              as rang,
       case when fi.IDACTIVITE is not null then ac.DATY else fc.DATY end as daty,
       fi.DUREE                                                          AS DUREE,
       cast(fi.QUANTITE * NVL(fi.DUREE, 1) * fi.pu as number(30, 3))     AS MONTANT,
       ra.ID                                                             as idrubrique
FROM FACTURE_CLIENT_FILLE fi
         LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
         LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = ac.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fi.RUBRIQUE
         LEFT JOIN FACTURECLIENT fc ON fc.ID = fi.IDMERE;
		 
create view facture_client_fille_rang_det as
select fc.*,
       CASE
           WHEN fc.IDACTIVITE IS NOT NULL THEN r.RANG
           else r1.RANG END AS rang_rubrique ,
       ma.RANG as rang_manoeuvre
from facture_client_fille fc
         LEFT JOIN ACTIVITELIBCOMPLET ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fc.RUBRIQUE
         left join OCCUPATIONMATERIELNAVAL oc on oc.id=ra.REFOBJET
         left join MANOEUVREBORD ma on ma.id=oc.IDMANOEUVREBORD ;
		 
create view facture_client_fille_rangfinal as
select fc.ID,
       IDMERE,
       DESIGNATION,
       QUANTITE,
       PU,
       COMPTE,
       IDPRODUIT,
       DEVISE,
       TAUX,
       IDACTIVITE,
       TVA,
       DATEFACT,
       RUBRIQUE,
       MOIS,
       ANNEE,
       HEUREDEBUT,
       HEUREFIN,
       REDUCTION,
       MAJORATION,
       TEST,
       DUREE,
     --  RANG_RUBRIQUE,
     --  RANG_MANOEUVRE,
       case
           when fc.RANG_MANOEUVRE is null or RANG_MANOEUVRE = 1 then RANG_RUBRIQUE
           when fc.RANG_MANOEUVRE = 2 then 6
           when fc.RANG_MANOEUVRE = 3 then RANG_RUBRIQUE + 5 end as rang
from facture_client_fille_rang_det fc;



  CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE (ID, IDMERE, RUBRIQUE, DESIGNATION, PU, QUANTITE, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, PRODUIT_LIB, ACTIVITELIB, DATEFACT, RUBRIQUELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION, RANG, DATY, DUREE, MONTANT, IDRUBRIQUE) AS
  SELECT fi.ID,
       fi.IDMERE,
       (fi.RUBRIQUE)                                           as RUBRIQUE,
       fi.DESIGNATION,
       fi.PU,
       fi.QUANTITE,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fi.IDACTIVITE,
       fi.TVA,
       pr.nom                                                            AS produit_lib,
       ac.DESIGNATION                                                    AS activitelib,
       TO_DATE(fi.DATEFACT, 'dd/MM/YY')                                  AS DATEFACT,
       nvl(ra.DESIGNATION, r1.DESIGNATION)                               AS rubriquelib,
       fi.MOIS,
       fi.ANNEE,
       fi.HEUREDEBUT,
       fi.HEUREFIN,
       nvl(fi.MAJORATION, 0)                                             as MAJORATION,
       nvl(fi.REDUCTION, 0)                                              as REDUCTION,
       fi.rang                                              as rang,
       case when fi.IDACTIVITE is not null then ac.DATY else fc.DATY end as daty,
       fi.DUREE                                                          AS DUREE,
       cast(fi.QUANTITE * NVL(fi.DUREE, 1) * fi.pu as number(30, 3))     AS MONTANT,
       ra.ID                                                             as idrubrique
FROM facture_client_fille_rangfinal  fi
         LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
         LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = ac.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fi.RUBRIQUE
         LEFT JOIN FACTURECLIENT fc ON fc.ID = fi.IDMERE;
		 

  CREATE OR REPLACE VIEW FACT_CLT_FILL_LIB_REST_TAXE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION, REDUCTION, DATEFACT, RUBRIQUE, RANG, DATY, DUREE, TYPE) AS
  SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                                             AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))                         AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                                          AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3))                             AS MONTANTTAUX,
       CAST(fcm.MONTANT AS NUMBER(32, 5))                                 AS MONTANT,
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3))
                                                                          AS MONTANTAVOIRSANSTAUX,
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3))
                                                                          AS MONTANTAVOIRAVECTAUX,
       CAST(fcm.tva AS NUMBER(20, 3))                                     AS tva,
       fc.idactivite,
       ra.DESIGNATION                                                     AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                                           AS moislib,
       CAST(0 AS NUMBER(32, 2))                                           AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                                           AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                                           AS montantTVAEuro,
       CAST((fc.pu * fc.QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                                          AS montanttaxe,
       NVL(fc.majoration, 0)                                              AS majoration,
       NVL(fc.reduction, 0)                                               AS reduction,
       fc.DATEFACT,
       nvl(fc.RUBRIQUE,r.ID),
      fc.rang,
       CASE WHEN fc.IDACTIVITE IS NOT NULL THEN ra.DATY else fcm.DATY END AS daty,
       fc.DUREE,
        fcm.TYPE
FROM facture_client_fille_rangfinal fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fc.RUBRIQUE;
		 
		 

create or replace view COMPTECAFACTAVOIR as
select cca."RUBRIQUE",
       cca."RUBRIQUELIB",
       cca."COMPTE",
       cca."LIBELLE",
       cca."COMPTEMERE",
       cca."COMPTEMERELIB",
       cca."MERE",
       cca."MOIS",
       cca."ANNEE",
       cca."NBREACREDIT" as nbCredit,
       cca."AUCOMPTANT" as nbComptant,
       cca."MONTANTACREDIT" as credit,
       cca."MONTANTAUCOMPTANT" comptant,
       cca."MONTANT",
       nvl(ccavoir.montant, 0) as avoir
from CompteCAFactureMoisAn cca
         left join CompteCAAvoirMoisAn ccavoir on cca.mois = ccavoir.mois and cca.annee = ccavoir.annee and
                                                  cca.compte = ccavoir.compte and cca.mere = ccavoir.mere
/

create or replace view COMPTECAFACTAVOIR as
select cca."RUBRIQUE",
       cca."RUBRIQUELIB",
       cca."COMPTE",
       cca."LIBELLE",
       cca."COMPTEMERE",
       cca."COMPTEMERELIB",
       cca."MERE",
       cca."MOIS",
       cca."ANNEE",
       cast(cca."NBREACREDIT" as NUMBER(30,3)) as nbCredit,
       cast(cca."AUCOMPTANT" as number(30,3)) as nbComptant,
       cast(cca."MONTANTACREDIT" as NUMBER(30,3)) as credit,
       cast(cca."MONTANTAUCOMPTANT" as NUMBER(30,3)) comptant,
       cast(cca."MONTANT" as NUMBER(30,3)) as MONTANT,
       nvl(ccavoir.montant, 0) as avoir
from CompteCAFactureMoisAn cca
         left join CompteCAAvoirMoisAn ccavoir on cca.mois = ccavoir.mois and cca.annee = ccavoir.annee and
                                                  cca.compte = ccavoir.compte and cca.mere = ccavoir.mere
/


create or replace view COMPTECAFACTAVOIR as
select cca."RUBRIQUE",
       cca."RUBRIQUELIB",
       cca."COMPTE",
       cca."LIBELLE",
       cca."COMPTEMERE",
       cca."COMPTEMERELIB",
       cca."MERE",
       cca."MOIS",
       cca."ANNEE",
       cast(cca."NBREACREDIT" as NUMBER(10)) as nbCredit,
       cast(cca."AUCOMPTANT" as number(10)) as nbComptant,
       cast(cca."MONTANTACREDIT" as NUMBER(30,3)) as credit,
       cast(cca."MONTANTAUCOMPTANT" as NUMBER(30,3)) comptant,
       cast(cca."MONTANT" as NUMBER(30,3)) as MONTANT,
       nvl(ccavoir.montant, 0) as avoir
from CompteCAFactureMoisAn cca
         left join CompteCAAvoirMoisAn ccavoir on cca.mois = ccavoir.mois and cca.annee = ccavoir.annee and
                                                  cca.compte = ccavoir.compte and cca.mere = ccavoir.mere
/

create or replace view COMPTECAFACTAVOIR as
select cca."RUBRIQUE",
       cca."RUBRIQUELIB",
       cca."COMPTE",
       cca."LIBELLE",
       cca."COMPTEMERE",
       cca."COMPTEMERELIB",
       cca."MERE",
       cca."MOIS",
       cca."ANNEE",
       cast(cca."NBREACREDIT" as NUMBER(10)) as nbCredit,
       cast(cca."AUCOMPTANT" as number(10)) as nbComptant,
       cast(cca."MONTANTACREDIT" as NUMBER(30,3)) as credit,
       cast(cca."MONTANTAUCOMPTANT" as NUMBER(30,3)) comptant,
       cast(cca."MONTANT" as NUMBER(30,3)) as MONTANT,
       cast(nvl(ccavoir.montant, 0) as NUMBER(30,3)) as avoir
from CompteCAFactureMoisAn cca
         left join CompteCAAvoirMoisAn ccavoir on cca.mois = ccavoir.mois and cca.annee = ccavoir.annee and
                                                  cca.compte = ccavoir.compte and cca.mere = ccavoir.mere
/


create view CompteCAFactAvoir_grp as
select cast('-' as VARCHAR2(100)) as RUBRIQUE,
       cast('-' as varchar2(100))    RUBRIQUELIB,
       COMPTE,
       LIBELLE,
       COMPTEMERE,
       COMPTEMERELIB,
       MERE,
       MOIS,
       ANNEE,
       sum(NBCREDIT)              as NBCREDIT,
       sum(NBCOMPTANT)            as NBCOMPTANT,
       sum(CREDIT)                as CREDIT,
       sum(COMPTANT)              as COMPTANT,
       sum(MONTANT)               as MONTANT,
       sum(AVOIR)                 as AVOIR
from CompteCAFactAvoir
group by cast('-' as VARCHAR2(100)), cast('-' as varchar2(100)), COMPTE, LIBELLE, COMPTEMERE, COMPTEMERELIB, MERE, MOIS,
         ANNEE;


UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000078141853';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000079141921';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000080141945';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70692' WHERE ID = 'RB0000000040144023';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000141150358';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000027103029';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000081142011';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000082142036';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000083142105';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000084142131';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '75810' WHERE ID = 'RB0000000085163853';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '75810' WHERE ID = 'RB0000000086163925';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70683' WHERE ID = 'RB0000000088170709';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70692' WHERE ID = 'RB0000000021170470';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70692' WHERE ID = 'RB0000000021170471';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70692' WHERE ID = 'RB0000000021170472';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70692' WHERE ID = 'RB0000000021170473';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170474';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70692' WHERE ID = 'RB0000000021170475';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70692' WHERE ID = 'RB0000000021170476';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170477';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170478';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170479';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70693' WHERE ID = 'RB0000000021170480';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70693' WHERE ID = 'RB0000000021170481';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70693' WHERE ID = 'RB0000000021170482';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70693' WHERE ID = 'RB0000000021170483';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70693' WHERE ID = 'RB0000000021170484';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70693' WHERE ID = 'RB0000000021170485';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170486';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70656' WHERE ID = 'RB0000000021170487';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170488';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170489';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70601' WHERE ID = 'RB0000000021170490';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170491';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170492';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70630' WHERE ID = 'RB0000000021170493';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70601' WHERE ID = 'RB0000000021170494';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000021170495';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70602' WHERE ID = 'RB0000000021170497';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170498';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000021170499';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000021170500';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000021170501';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000021170502';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000021170503';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170444';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70631' WHERE ID = 'RB0000000021170445';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70632' WHERE ID = 'RB0000000021170446';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70633' WHERE ID = 'RB0000000021170447';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '46733' WHERE ID = 'RB0000000021170448';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000021170449';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70601' WHERE ID = 'RBR0101';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70601' WHERE ID = 'RBR0102';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RBR0103';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RBR0104';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RBR0113';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RBR0114';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70692' WHERE ID = 'RB0000000029103544';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70692' WHERE ID = 'RB0000000036111753';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70686' WHERE ID = 'RB0000000101160238';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '75812' WHERE ID = 'RB0000000183101510';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000184101600';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70684' WHERE ID = 'RB0000000162155003';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RBR0115';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RBR0116';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RBR0123';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RBR0124';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70601' WHERE ID = 'RBR0125';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70682' WHERE ID = 'RBR0126';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70632' WHERE ID = 'RBR0127';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70687' WHERE ID = 'RBR0128';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70683' WHERE ID = 'RBR0129';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RBR0130';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000021170450';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000021170451';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000021170454';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000021170455';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170456';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000021170457';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170458';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170459';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70689' WHERE ID = 'RB0000000021170460';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70686' WHERE ID = 'RB0000000021170461';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170462';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170463';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170464';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170465';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = null WHERE ID = 'RB0000000021170466';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70651' WHERE ID = 'RB0000000021170467';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70692' WHERE ID = 'RB0000000029113124';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70670' WHERE ID = 'RB0000000030114834';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70630' WHERE ID = 'RB0000000057110308';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000058110631';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70652' WHERE ID = 'RB0000000059112123';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '46733' WHERE ID = 'RB0000000060112257';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70630' WHERE ID = 'RB0000000062140941';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70630' WHERE ID = 'RB0000000063141026';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70630' WHERE ID = 'RB0000000064141055';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70630' WHERE ID = 'RB0000000065141123';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70630' WHERE ID = 'RB0000000066141148';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70630' WHERE ID = 'RB0000000067141218';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000068141421';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000069141449';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000070141521';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000071141547';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000072141614';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000073141646';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000074141709';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000075141737';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000076141803';
UPDATE RUBRIQUE_ACTIVITE SET COMPTE = '70634' WHERE ID = 'RB0000000077141829';


commit;




CREATE OR REPLACE VIEW FACTURECLIENTVALIDE
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE,typeclientlib)
AS
SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       cast(fc.TVA as number(30, 3))            as TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(fc.MONTANT as NUMBER(30, 3))        as MONTANT,
       cast(fc.MONTANTTVA as NUMBER(30, 3))     as MONTANTTVA,
       cast(fc.MONTANTAVOIR as NUMBER(30, 3))   as MONTANTAVOIR,
       cast(fc.MONTANTTTC as NUMBER(30, 3))     as MONTANTTTC,
       cast(fc.MONTANTPAYE as NUMBER(30, 3))    as MONTANTPAYE,
       cast(fc.MONTANTRESTE as NUMBER(30, 3))   as MONTANTRESTE,
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
       CAST(fc.MONTANTTTCVRAI AS NUMBER(35, 3)) AS MONTANTTTCVRAI,
       ARMATEURLIB,
       EXERCICE,
       nvl(typelib,'-')                                  as typeclientlib
FROM facture_client_union fc
WHERE id NOT IN (SELECT id FROM ProvisionFactureDefinitive);






create or replace view FACTURECLIENTVALIDE_V as
select *
from factureClientValide
where etat >= 11
/


create view FACTURE_CLIENT_UNIONA as
select * from FACTURE_CLIENT_UNION where etat=0;


UPDATE RUBRIQUE_ACTIVITE  set rang = 13 where id='RB0000000021170448'; 

create view RUBRIQUE_ACTIVITE_MF_PU_0 as
select ra.*,
       de.ID as iddetformu,
       de.COMPTE  as comptedetformu,
       de.FORMULE as pudetformu,
       de.UNITE as unitedetformu
from RUBRIQUE_ACTIVITE ra
         join DETFORMUFACT de on de.MERE = ra.id
where pu is null;



create or replace view RUBRIQUE_ACTIVITE_MF_PU_0 as
select ra.*,
       de.ID      as iddetformu,
       de.COMPTE  as comptedetformu,
       de.FORMULE as pudetformu,
       de.UNITE   as unitedetformu,
       de.REM
from RUBRIQUE_ACTIVITE ra
         join DETFORMUFACT de on de.MERE = ra.id
where pu is null;

create or replace view rubrique_activite_pdf as
select id,
       code,
       COMPTE,
       DESIGNATION as prestation,
       pu  as tarif,
       UNITE
from RUBRIQUE_ACTIVITELIB
where pu is not null
union
select IDDETFORMU as id,
       code,
       comptedetformu as compte,
       REM as prestation,
       pudetformu as tarif,
       u.VAL as unite
from RUBRIQUE_ACTIVITE_MF_PU_0 yu
        left join UNITE_ACTIVITE u on u.ID=yu.unitedetformu
;




CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE
            (ID, IDMERE, RUBRIQUE, DESIGNATION, PU, QUANTITE, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA,
             PRODUIT_LIB, ACTIVITELIB, DATEFACT, RUBRIQUELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION,
             RANG, DATY,  MONTANT,DUREE, IDRUBRIQUE)
AS
SELECT fi.ID,
       fi.IDMERE,
       (fi.RUBRIQUE)                                                     as RUBRIQUE,
       fi.DESIGNATION,
       fi.PU,
       fi.QUANTITE,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fi.IDACTIVITE,
       fi.TVA,
       pr.nom                                                            AS produit_lib,
       ac.DESIGNATION                                                    AS activitelib,
       TO_DATE(fi.DATEFACT, 'dd/MM/YY')                                  AS DATEFACT,
       nvl(ra.DESIGNATION, r1.DESIGNATION)                               AS rubriquelib,
       fi.MOIS,
       fi.ANNEE,
       fi.HEUREDEBUT,
       fi.HEUREFIN,
       nvl(fi.MAJORATION, 0)                                             as MAJORATION,
       nvl(fi.REDUCTION, 0)                                              as REDUCTION,
       fi.rang                                                           as rang,
       case when fi.IDACTIVITE is not null then ac.DATY else fc.DATY end as daty,

       cast(fi.QUANTITE * NVL(fi.DUREE, 1) * fi.pu as number(30, 3))     AS MONTANT,
       fi.DUREE                                                          AS DUREE,
       ra.ID                                                             as idrubrique
FROM facture_client_fille_rangfinal fi
         LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
         LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = ac.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fi.RUBRIQUE
         LEFT JOIN FACTURECLIENT fc ON fc.ID = fi.IDMERE;
