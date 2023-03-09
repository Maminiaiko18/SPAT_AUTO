alter table as_bondecommande add delailivraison varchar2(100);
alter table as_bondecommande add typepaiement varchar2(100) constraint fk_typecheque references TYPECHEQUE;

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
       TYPEPAIEMENT
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
       '' as NUMBC,
       '' as PROJET,
       '' as CODE_ETAB,
       cast(0 as number(10)) DELAIPAIEMENT,
       '' as DELAILIVRAISON,
        '' as TYPEPAIEMENT
from bc_cemedi_vue
/

CREATE OR REPLACE  VIEW AS_BONDECOMMANDE_LIBELLE_TIERS
            ("ID", "DATY", "ETAT", "REMARQUE", "DESIGNATION", "MODEPAIEMENT", "FOURNISSEUR", "TVA", "NOMFOURNISSEUR",
             "NUMBC", "MONTANT", "MONTANTTVA", "MONTANTTTC", "IDFACTURE", "MONTANT_A_PAYER", "MONTANT_PAYE_REEL",
             "RESTEPAYERGENERAL", "RESTEAPAYERREEL", "CODE_ETAB", "PROJET", "ETATLIB", "DELAIPAIEMENT", "adresse",
             "remise","TYPEPAIEMENT","DELAILIVRAISON")
AS
select distinct op.ID,
                op.DATY,
                op.ETAT,
                op.REMARQUE,
                op.DESIGNATION,
                op.MODEPAIEMENT,
                ti.id                                    as FOURNISSEUR,
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
                cast(0 as number(20, 2))                    remise,
                tc.VAL as TYPEPAIEMENT,
                DELAILIVRAISON
from AS_BONDECOMMANDE_LIBELLE_LIB op
         left join union_bc_spat_cemedi bc on op.id = bc.ID
         join tiers ti on ti.NOM = op.FOURNISSEUR
         left join TYPECHEQUE tc on tc.id=bc.TYPEPAIEMENT;


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
       nvl(bl.montantttc, 0)                              as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       lfac.montantttc                                    as montantfacture,
       case
           when bcf.RESTELIVRE > 0 then 'VISE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE(E)'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) != 0
               THEN 'FACTURE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYE(E)'
           else 'CREE(E)'
           END                                            as etatlib
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
         left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
         LEFT JOIN BONDELIVRAISONPARBC bl ON bl.IDBC = bc.ID
         left join TIERS ti on ti.ID = bc.fournisseur;

alter table additif add remarque varchar2(4000);
alter table AVOIR add remarque varchar2(4000);

create or replace view AVOIR_LIB_VAL as
SELECT
	av."ID",
	av."DATY",
	av."IDFACTURE",
	av."MONTANT",
	av."TYPE",
	av."ETAT",
	fc.DESIGNATION ,
CASE
		WHEN AV.TYPE = '1' THEN 'HT'
		WHEN AV.TYPE = '2' THEN 'TTC'
	END AS TYPEAVOIR_desce,
	av.tva,
       av.REMARQUE
FROM
	avoir av
LEFT JOIN FACTUREFOURNISSEUR fc ON
	fc.id = av.idfacture
/

create or replace view ADDITIFLIB as
SELECT
	ad.ID,
	ad.DATY,
	ad.IDFACTURE,
	ff.DESIGNATION,
	ad.MONTANT,
	ad.TYPE,
CASE
		WHEN ad.TYPE = '1' THEN 'HT'
		WHEN ad.TYPE = '2' THEN 'TTC'
	END AS TYPEAVOIR_desce,
	ad.ETAT,
	ad.TVA ,
    ad.REMARQUE
FROM
	additif ad
LEFT JOIN FACTUREFOURNISSEUR ff ON
	ff.id = ad.IDFACTURE
/

create table destination
(
    id varchar2(100) constraint destination_pk primary key ,
        val varchar2(500),
        desce varchar2(500)
);

