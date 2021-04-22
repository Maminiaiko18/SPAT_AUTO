alter table facturefournisseur add numid varchar2(100);

create table additif
(
    ID        VARCHAR2(100) not null
        constraint AVOIR_PK
            primary key,
    DATY      DATE,
    IDFACTURE VARCHAR2(100),
    MONTANT   NUMBER(10, 2),
    TYPE      VARCHAR2(100),
    ETAT      NUMBER(10)
);

CREATE SEQUENCE seq_additif
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_additif
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_additif.nextval INTO retour FROM dual;
    return retour;
END;

create view FACTUREFOURNISSEUR_FINAL as
select
       IDMERE as idfacture,
       sum(QTE * pu) as montant,
       ff.IDTVA as tva,
       (sum(QTE * pu)*IDTVA)/100 as montanttva,
        sum(QTE * pu) -(sum(QTE * pu)*IDTVA)/100 as montantttc,REMARQUE as idbl
from DETAILSFACTUREFOURNISSEUR dff
         join FACTUREFOURNISSEUR ff on ff.id = dff.IDMERE
group by IDMERE, IDTVA,REMARQUE;

create view BONLIVRAISON_FINAL as
select numbl,
       IDBC,
       sum(QUANTITE * pu)                                            as montant,
       tva,
       nvl((sum(QUANTITE * pu) * tva) / 100, 0)                      as montanttva,
       sum(QUANTITE * pu) + nvl((sum(QUANTITE * pu) * tva) / 100, 0) as montantttc
from bondelivraion_avec_pu
group by numbl, tva,IDBC;

create view BONDECOMMANDE_GROUPER as
select sum(QUANTITE * pu) as montant, IDbc
from AS_BONDECOMMANDE_FILLE
group by IDBC;



create view BONCOMMANDE_FINAL as
select bcg.IDBC,
       nvl(bcg.montant,0) as montant,
       bc.TVA,
      cast(nvl((bcg.montant*bc.TVA)/100,0) as number(25,2)) as montanttva,
       cast(nvl(bcg.montant,0)+ nvl(( bcg.montant*bc.TVA)/100,0) as number(25,2)) as montantttc
from bondecommande_grouper bcg
         join AS_BONDECOMMANDE bc on bc.id=bcg.IDBC;



create view AS_BONDECOMMANDE_LIBELLE_LIB as
select bcl.id,
       bcl.daty,
       bcl.etat,
       bcl.remarque,
       bcl.designation,
       bcl.modepaiement,
       ti.NOM                                as fournisseur,
       bcl.tva,
       bcl.NUMBC,
       bc.montant,
       bc.montanttva,
       bc.montantttc,
       ff.idfacture,
       nvl(op.montant, 0)                    as montant_paye_reel,
       bc.montantttc - nvl(bl.montantttc, 0) as restepayergeneral,
       bc.montantttc - nvl(op.montant, 0)    as resteapayerreel
from ORDONNERPAYEMENTGROUPEFACT op
         join facturefournisseur_final ff on ff.idfacture = op.DED_ID
         join bonlivraison_final bl on bl.numbl = ff.IDBL
         right join boncommande_final bc on bc.IDBC = bl.IDBC
         join AS_BONDECOMMANDE_LIBELLE bcl on bcl.ID = bc.idbc
         left join TIERS ti on ti.id = bcl.fournisseur;

create or replace view AS_BONDELIVRAISON_F_GROUPER as
select sum(QUANTITE) as qtelivre, IDBONDECOMMANDE
from AS_BONDELIVRAISON_FILLE blf,
     AS_BONDELIVRAISON bl
where blf.NUMBL = bl.ID
  and bl.ETAT >= 11
group by IDBONDECOMMANDE;



create view BC_BL_LIVRE as
SELECT
	BCF.ID,
CASE
		WHEN ap.Nom IS NULL THEN BCF.PRODUIT
		ELSE ap.Nom
	END AS PRODUIT,
	BCF.IDBC,
	BCF.QUANTITE,
	BCF.PU,
	BCF.QUANTITEPARPACK,
	BCF.MONTANT,
	BCF.REMARQUE,
	CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitelivre,
	CAST(BCF.QUANTITE - NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitereste,
	CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU AS MontantBL,
	bcf.MONTANT-CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU AS MontantBLreste,
	u.DESCE AS UNITE
FROM
	AS_BONDECOMMANDE_FILLE BCF
LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG ON
	BFG.IDBONDECOMMANDE = BCF.ID
LEFT JOIN AS_PRODUITS ap ON
	BCF.produit = ap.id
LEFT JOIN UNITECHANTIER u ON
	bcf.UNITE = u.id;

create view AS_BONDECOMMANDE_LIBELLE_TIERS as
select bc."ID",bc."DATY",bc."ETAT",bc."REMARQUE",bc."DESIGNATION",bc."MODEPAIEMENT",bc."FOURNISSEUR",bc."TVA",
        nvl(ti.NOM,'-') as nomfournisseur
from AS_BONDECOMMANDE_LIBELLE bc
   left join TIERS ti on ti.id=bc.fournisseur;

create or replace view AS_BONDECOMMANDE_LIBELLE_TIERS as
select bcl.ID,
       bcl.DATY,
       bcl.ETAT,
       bcl.REMARQUE,
       bcl.DESIGNATION,
       bcl.MODEPAIEMENT,
       bcl.FOURNISSEUR,
       bcl.TVA,
       nvl(ti.NOM, '-')                      as nomfournisseur,
       bcl.NUMBC,
       bc.montant,
       bc.montanttva,
       bc.montantttc,
       ff.idfacture,
       nvl(op.montant, 0)                    as montant_paye_reel,
       bc.montantttc - nvl(bl.montantttc, 0) as restepayergeneral,
       bc.montantttc - nvl(op.montant, 0)    as resteapayerreel
from ORDONNERPAYEMENTGROUPEFACT op
         join facturefournisseur_final ff on ff.idfacture = op.DED_ID
         join bonlivraison_final bl on bl.numbl = ff.IDBL
         right join boncommande_final bc on bc.IDBC = bl.IDBC
         join AS_BONDECOMMANDE_LIBELLE bcl on bcl.ID = bc.idbc
         left join TIERS ti on ti.id = bcl.fournisseur;

create view AS_BONDELIVRAISON_LIBSUME as
select distinct b."ID",b."REMARQUE",b."IDBC",b."DATY",b."ETAT",b."POINT",b."ID_BC",
                bl.QUANTITE * bcf.pu                                                    as montant,
                (bl.QUANTITE * bcf.pu) * (bc.TVA / 100)                                 as montanttva,
                bl.QUANTITE * bcf.pu + (bl.QUANTITE * bcf.pu) * (bc.TVA / 100)          as montantttc,
                nvl((select montantttc from facturefournisseur_final ffl where ffl.IDBL = bl.NUMBL),
                    0)                                                                  as montant_facturer,
                nvl((select op.montant
                     from facturefournisseur_final ffl
                              join ORDONNERPAYEMENTGROUPEFACT op on ffl.idfacture = op.ded_id
                     where ffl.IDBL = bl.NUMBL),
                    0)                                                                  as montant_payer,
                bl.QUANTITE * bcf.pu + (bl.QUANTITE * bcf.pu) * (bc.TVA / 100) - nvl((select op.montant
                                                                                      from facturefournisseur_final ffl
                                                                                               join ORDONNERPAYEMENTGROUPEFACT op on ffl.idfacture = op.ded_id
                                                                                      where ffl.IDBL = bl.NUMBL),
                                                                                     0) as reste_a_payer,
                bl.QUANTITE * bcf.pu + (bl.QUANTITE * bcf.pu) * (bc.TVA / 100) -
                nvl((select montantttc from facturefournisseur_final ffl where ffl.IDBL = bl.NUMBL),
                    0)                                                                  as reste_a_facturer
from AS_BONDELIVRAISON_FILLE bl
         left join AS_BONDECOMMANDE_FILLE bcf on bcf.ID = bl.IDBONDECOMMANDE
         left join AS_BONDECOMMANDE bc on bc.id = bcf.IDBC
         right join as_bondelivraison b on b.id = bl.NUMBL;



create view AS_BONDELIVRAISON_LIBSUM as
select bl.id,
       bl.REMARQUE,
       bl.DATY,
       bl.ETAT,
       bl.POINT,
       bl.ID_BC,
       sum(montant)          as montant,
       sum(montanttva)       as montanttva,
       sum(montantttc)       as montantttc,
       sum(montant_facturer) as montant_facturer,
       sum(montant_payer)    as montant_payer,
       nvl(sum(reste_a_facturer),0) as reste_a_facturer,
       nvl(sum(reste_a_payer) ,0)   as reste_a_payer
from as_bondelivraison_LibSume bl
group by bl.id, bl.REMARQUE, ID_BC, bl.DATY, bl.ETAT, bl.POINT, bl.ID_BC;


create view AS_BONDELIVRAISON_FILLEQTE_RES as
select
            blf.ID,blf.PRODUIT,blf.NUMBL,blf.QUANTITE,blf.QUANTITEPARPACK,blf.IDDETAILSFACTUREFOURNISSEUR,blf.IDBONDECOMMANDE,
            nvl(qff.QTE,0) as facture,
            blf.QUANTITE-nvl(qff.QTE,0) as quantitereste,
            bcf.PU
        from AS_BONDELIVRAISON_FILLE blf
            left join AS_BONDECOMMANDE_FILLE bcf on bcf.id=blf.IDBONDECOMMANDE
            left join DETAILSFACTUREFOURNISSEUR qff on qff.IDINGREDIENT=blf.id;

create view CONTRAT_CHANTIER_CPLSUM as
select bc."ID",bc."IDCHANTIER",bc."DESIGNATION",bc."MONTANT",bc."PRESTATAIRE",bc."ETAT",
       ff.idfacture,
       nvl(op.montant, 0)                    as montant_paye,
       bc.montant - nvl(op.montant, 0)    as resteapaye
from ORDONNERPAYEMENTGROUPEFACT op
         join facturefournisseur_final ff on ff.idfacture = op.DED_ID
         right join CONTRAT_CHANTIER bc on bc.IDCHANTIER = ff.IDBL;


CREATE VIEW as_bondelivraison_LibSumVISE AS SELECT * FROM as_bondelivraison_LibSum WHERE etat = 11;
CREATE VIEW as_bondelivraison_LibSumCREE AS SELECT * FROM as_bondelivraison_LibSum WHERE etat = 1;