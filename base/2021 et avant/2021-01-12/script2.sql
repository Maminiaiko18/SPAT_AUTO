create OR REPLACE  view TOUCHE_DE_NAVIRE as
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
       dep.PAYSDESTINATION as paysdestinationdepart,
       dep.DESCEPAYSDESTINATION as paysdescedestinationdepart,
       dep.valPAYSDESTINATION as paysvaldestinationdepart,
       dep.QUAISDESTINATION as QUAISDESTINATIONDEPART,
       dep.VALQUAISDESTINATION AS VALQUAISDESTINATIONDEPART
from mouvementarrive_escale arr
         join mouvementdepart_escale dep on dep.escale = arr.escale
         left join NAVIRE nv on nv.id = arr.NAVIRE
         left join typenavire ty on nv.id = nv.type
/


INSERT INTO CAISSE (ID, VAL, DESCE, NUMERO) VALUES ('CAIS_00002', 'SPAT/BFV/C.C. Ariary', 'Banque', '00008 00490 02001000034 87');

INSERT INTO CAISSE (ID, VAL, DESCE, NUMERO) VALUES ('CAIS_00003', 'SPAT/SBM/C.C. Ariary', 'Banque', '00007 00902 30100002376 54');

INSERT INTO CAISSE (ID, VAL, DESCE, NUMERO) VALUES ('CAIS_00004', 'SPAT/BNI/C.C. Ariary', 'Banque', '00005 00020 13505820100 03');

INSERT INTO CAISSE (ID, VAL, DESCE, NUMERO) VALUES ('CAIS_00005', 'SPAT/BGFI/C.C. Ariary', 'Banque', '00012 01250 51000513011 72');

INSERT INTO CAISSE (ID, VAL, DESCE, NUMERO) VALUES ('CAIS_00006', 'SPAT/BOA AUG/C.C. Ariary', 'Banque', '00009 07400 22706130002 05');

INSERT INTO CAISSE (ID, VAL, DESCE, NUMERO) VALUES ('CAIS_00007', 'SPAT/TRESOR/C.C. Ariary', 'Banque', '45318');

INSERT INTO CAISSE (ID, VAL, DESCE, NUMERO) VALUES ('CAIS_00008', 'CEMEDI/BMOI/C.C. Ariary', 'Banque', '00004 00010 01002900119 32');

INSERT INTO CAISSE (ID, VAL, DESCE, NUMERO) VALUES ('CAIS_00009', 'BMOI CENTRE SCS', 'Banque', '00004 00010 07003500151 32');

INSERT INTO CAISSE (ID, VAL, DESCE, NUMERO) VALUES ('CAIS_00010', 'BNI CANTINE', 'Banque', '00005 00020 40027480101 22');

INSERT INTO CAISSE (ID, VAL, DESCE, NUMERO) VALUES ('CAIS_00011', 'BFV/DEVISE EN EURO ', 'Banque', '00008 00490 02071000013 09');

INSERT INTO CAISSE (ID, VAL, DESCE, NUMERO) VALUES ('CAIS_00012', 'BMOI/DEVISE EN EURO ', 'Banque', '00004 00010 01002701172 32');

INSERT INTO CAISSE (ID, VAL, DESCE, NUMERO) VALUES ('CAIS_00013', 'ESPECES DEPOSEES COFFRE BMOI', 'Caisse', null);

create  OR REPLACE view AS_BONDECOMMANDE_FILLE_LIBELLE as
select bcf.id,
       bcf.produit,
       bcf.idbc,
       bcf.quantite,
       bcf.pu,
       bcf.quantiteparpack,
       bcf.remarque,

       uc.VAL                                                            as unite,
       bcf.TVA,
       bcf.pu * bcf.QUANTITE                                             as montantht,
       (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100                           as montanttva,
       (bcf.pu * bcf.QUANTITE) + (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100 as montant
from as_bondecommande_fille bcf
         left join UNITECHANTIER uc on uc.id = bcf.UNITE
/

create OR REPLACE view AS_BONDECOMMANDE_DETSUMLIV as
select bcf.ID,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       bcf.TVA,
       nvl((select sum(bfl.QUANTITE)from AS_BONDELIVRAISON_FILLE bfl where bfl.IDBONDECOMMANDE=bcf.id group by IDBC),0) as quantitelivre,
       QUANTITE-nvl((select sum(bfl.QUANTITE)from AS_BONDELIVRAISON_FILLE bfl where bfl.IDBONDECOMMANDE=bcf.id group by IDBC),0) as quantitereste,
       uc.VAL as unite,
       pu*QUANTITE as montantht,
       (pu*QUANTITE*tva)/100 as montanttva
from AS_BONDECOMMANDE_FILLE bcf
        left join UNITECHANTIER uc on uc.id=bcf.UNITE
/

create OR REPLACE view AS_BONDECOMMANDE_FILLEQTE_REST as
SELECT BC."ID",
       BC."PRODUIT",
       BC."IDBC",
       BC."QUANTITE",
       BC."PU",
       BC."QUANTITEPARPACK",
       BC."MONTANT",
       BC."REMARQUE",
       cast(NVL(FF.QUANTITE, 0) as number(10, 2))               AS QTEFACTUREE,
       cast(BC.QUANTITE - NVL(FF.QUANTITE, 0) as number(10, 2)) AS QTERESTE,
        pu * bc.QUANTITE               as montantht,
       (pu * bc.QUANTITE * bc.tva) / 100 as montanttva
FROM AS_BONDECOMMANDE_FILLE BC
         LEFT JOIN DETAILSFF_PARBC FF ON FF.IDINGREDIENT = BC.ID
/

create OR REPLACE view AS_BONDECOMMANDE_FILLE_MONTANT
AS
select bcf.ID,
       bcf.PRODUIT,
       bcf.IDBC,
       bcf.QUANTITE,
       bcf.PU,
       bcf.QUANTITEPARPACK,
       bcf.MONTANT,
       bcf.REMARQUE,
       u.VAL                                                             AS UNITE,
       bcf.TVA,
       (bcf.QUANTITE * bcf.pu)                                           as montantht,
       (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100                           as montanttva,
       (bcf.QUANTITE * bcf.pu) + (bcf.QUANTITE * bcf.pu * bcf.TVA) / 100 as montantttc,
       bc.ETAT
from AS_BONDECOMMANDE_FILLE bcf
         left join AS_BONDECOMMANDE bc on bc.id = bcf.IDBC
         LEFT JOIN UNITECHANTIER u ON U.ID = BCF.UNITE;
create or replace view AS_BONDECOMMANDE_FILLE_grouper as
SELECT IDBC,
       sum(montantht)  as montantht,
       sum(montanttva) as montanttva,
       sum(montantttc) as montantttc
FROM AS_BONDECOMMANDE_FILLE_MONTANT
WHERE ETAT >= 11
group by IDBC;

create OR REPLACE view BONDELIVRAISON_PRIX as
select blf.numbl,
       BLF.ID,
       blf.qUANTITE                                                      AS QUANTITE,
       IDBONDECOMMANDE                                                   as IDBCF,
       nvl(abf.Pu, 0)                                                    as pu,
       ABF.IDBC,
       nvl(ABF.TVA, 0)                                                   as tva,
       BLF.QUANTITE * ABF.PU                                             AS mONTANTHT,
       (BLF.QUANTITE * ABF.PU * ABF.TVA) / 100                           AS MONTANTTVA,
       (BLF.QUANTITE * ABF.PU) + (BLF.QUANTITE * ABF.PU * ABF.TVA) / 100 AS MONTANTTTC
from AS_BONDELIVRAISON_FILLE blf
         left JOIN AS_BONDECOMMANDE_FILLE ABF on blf.IDBONDECOMMANDE = ABF.ID
/
CREATE or replace VIEW BONDELIVRAISONPARBC AS
SELECT IDBC,

       SUM(mONTANTHT)  AS mONTANTHT,
       SUM(MONTANTTVA) AS MONTANTTVA,
       SUM(MONTANTTTC) AS MONTANTTTC
FROM BONDELIVRAISON_PRIX
GROUP BY IDBC;




create or replace view AS_BONDECOMMANDE_LIBELLE_LIB
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB)
as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                             as fournisseur,
       bc.tva,
       bc.NUMBC,
       nvl(c.montantht, 0),
       nvl(c.montanttva, 0),
       nvl(c.montantttc, 0),
       ''                                                 as idfacture,
       nvl(lfac.montantpayer, 0)                          as montant_paye_reel,
       nvl(c.montantttc, 0) - nvl((bl.MONTANTTTC), 0)     as resteapayegeneral,
       nvl(c.montantttc, 0) - nvl((lfac.montantpayer), 0) as resteapayerreel,
       nvl(c.montantttc, 0)                               as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       lfac.montantttc                                    as montantfacture,
       case
           when bcf.RESTELIVRE > 0 then 'VISE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) != 0
               THEN 'FACTURER'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYER'
           else 'CREER'
           END                                            as etatlib
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join BONDELIVRAISON_CMPL lfac on lfac.ID_BC = bc.ID
         left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
         LEFT JOIN BONDELIVRAISONPARBC bl ON bl.IDBC = bc.ID
         left join TIERS ti on ti.ID = bc.fournisseur
/



CREATE OR REPLACE FORCE VIEW AS_BONDECOMMANDE_LIBELLE_TIERS
            ("ID", "DATY", "ETAT", "REMARQUE", "DESIGNATION", "MODEPAIEMENT", "FOURNISSEUR", "TVA", "NOMFOURNISSEUR",
             "NUMBC", "MONTANT", "MONTANTTVA", "MONTANTTTC", "IDFACTURE", "MONTANT_A_PAYER", "MONTANT_PAYE_REEL",
             "RESTEPAYERGENERAL", "RESTEAPAYERREEL", "CODE_ETAB", "PROJET", "ETATLIB","DELAIPAIEMENT","")
AS
select distinct op.ID,
                op.DATY,
                op.ETAT,
                op.REMARQUE,
                op.DESIGNATION,
                op.MODEPAIEMENT,
                op.FOURNISSEUR,
                op.TVA,
                op.FOURNISSEUR,
                op.NUMBC,
                cast(op.montant as number(10, 2))        as MONTANT,
                cast(op.MONTANTTVA as number(10, 2))     as MONTANTTVA,
                cast(op.MONTANTTTC as number(10, 2))     as MONTANTTTC,
                IDFACTURE,
                cast(MONTANT_A_PAYER as number(10, 2))   as MONTANTTTC,
                cast(MONTANT_PAYE_REEL as number(10, 2)) as MONTANT_PAYE_REEL,
                cast(RESTEPAYERGENERAL as number(10, 2)) as RESTEPAYERGENERAL,
                cast(RESTEAPAYERREEL as number(10, 2))   as RESTEAPAYERREEL,
                op.CODE_ETAB,
                op.PROJET,
                ETATLIB,
                bc.DELAIPAIEMENT,
                ti.ADRESSE,
                0 remise
from AS_BONDECOMMANDE_LIBELLE_LIB op
        left join AS_BONDECOMMANDE bc on op.id=bc.ID
         join tiers ti on ti.NOM = op.FOURNISSEUR;

         CREATE OR REPLACE FORCE VIEW AS_BONDECOMMANDE_LIBELLE_TIERS
            ("ID", "DATY", "ETAT", "REMARQUE", "DESIGNATION", "MODEPAIEMENT", "FOURNISSEUR", "TVA", "NOMFOURNISSEUR",
             "NUMBC", "MONTANT", "MONTANTTVA", "MONTANTTTC", "IDFACTURE", "MONTANT_A_PAYER", "MONTANT_PAYE_REEL",
             "RESTEPAYERGENERAL", "RESTEAPAYERREEL", "CODE_ETAB", "PROJET", "ETATLIB","DELAIPAIEMENT","adresse","remise")
AS
select distinct op.ID,
                op.DATY,
                op.ETAT,
                op.REMARQUE,
                op.DESIGNATION,
                op.MODEPAIEMENT,
                ti.id as FOURNISSEUR,
                op.TVA,
                op.FOURNISSEUR,
                op.NUMBC,
                cast(op.montant as number(10, 2))        as MONTANT,
                cast(op.MONTANTTVA as number(10, 2))     as MONTANTTVA,
                cast(op.MONTANTTTC as number(10, 2))     as MONTANTTTC,
                IDFACTURE,
                cast(MONTANT_A_PAYER as number(10, 2))   as MONTANTTTC,
                cast(MONTANT_PAYE_REEL as number(10, 2)) as MONTANT_PAYE_REEL,
                cast(RESTEPAYERGENERAL as number(10, 2)) as RESTEPAYERGENERAL,
                cast(RESTEAPAYERREEL as number(10, 2))   as RESTEAPAYERREEL,
                op.CODE_ETAB,
                op.PROJET,
                ETATLIB,
                bc.DELAIPAIEMENT,
                ti.ADRESSE,
                cast(0 as number(20,2)) remise
from AS_BONDECOMMANDE_LIBELLE_LIB op
        left join AS_BONDECOMMANDE bc on op.id=bc.ID
         join tiers ti on ti.NOM = op.FOURNISSEUR;
    
create or replace view AS_BONDECOMMANDE_LIBELLE_LIB
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB)
as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                             as fournisseur,
       bc.tva,
       bc.NUMBC,
       nvl(c.montantht, 0),
       nvl(c.montanttva, 0),
       nvl(c.montantttc, 0),
       ''                                                 as idfacture,
       nvl(lfac.montantpayer, 0)                          as montant_paye_reel,
       nvl(c.montantttc, 0) - nvl((bl.MONTANTTTC), 0)     as resteapayegeneral,
       nvl(c.montantttc, 0) - nvl((lfac.montantpayer), 0) as resteapayerreel,
       nvl(bl.montantttc, 0)                               as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       lfac.montantttc                                    as montantfacture,
       case
           when bcf.RESTELIVRE > 0 then 'VISE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) != 0
               THEN 'FACTURER'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYER'
           else 'CREER'
           END                                            as etatlib
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join BONDELIVRAISON_CMPL lfac on lfac.ID_BC = bc.ID
         left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
         LEFT JOIN BONDELIVRAISONPARBC bl ON bl.IDBC = bc.ID
         left join TIERS ti on ti.ID = bc.fournisseur
/



create or replace view AS_BONDELIVRAISON_FILLEQTE_RES as
SELECT blf."ID",
          blf."PRODUIT",
          blf."NUMBL",
          blf."QUANTITE",
          blf."QUANTITEPARPACK",
          blf."IDDETAILSFACTUREFOURNISSEUR",
          blf."IDBONDECOMMANDE",
          NVL (qff.QTE, 0) AS facture,
          blf.QUANTITE - NVL (qff.QTE, 0) AS quantitereste,
          bcf.PU,
          tiers.nom AS nomTiers,
          tiers.id as idtiers,
          bcf.TVA,
          cast((blf.QUANTITE*bcf.PU) as number(34,2))as montantht,
          cast((blf.QUANTITE*bcf.PU*bcf.TVA)/100 as number(34,2)) as montanttva
     FROM AS_BONDELIVRAISON_FILLE blf
          LEFT JOIN AS_BONDECOMMANDE_FILLE bcf
             ON bcf.id = blf.IDBONDECOMMANDE
          LEFT JOIN as_bondecommande bc ON bc.id = bcf.idbc
          LEFT JOIN tiers ON tiers.id = bc.fournisseur
          LEFT JOIN DETAILSFACTUREFOURNISSEUR qff
             ON qff.IDINGREDIENT = blf.id
/

 alter table report add etat number;

create or replace view REPORTLIB as
select r.id, daty, montant, c.val as caisse, devise, c.id as idcaisse,ETAT
from report r
         join caisse c on
    r.caisse = c.id
/