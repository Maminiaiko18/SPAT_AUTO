CREATE OR REPLACE FORCE VIEW AVOIRFC_MONTANTLIBETAT
(
   ID,
   CODE,
   DATY,
   IDFACTURE,
   ETAT,
   MONTANT,
   TIERS,
   TIERSLIB,
   MONTANTPAYE,
   MONTANTRESTE,
   ETATLIB
)
AS
   SELECT op."ID",
		  op."CODE",
          op."DATY",
          op."IDFACTURE",
          op."ETAT",
          cast(op."MONTANT" as number(30,3)) as MONTANT,
          op."TIERS",
          op."TIERSLIB",
          cast(op."MONTANTPAYE" as number(30,3)) as MONTANTPAYE,
          cast(op."MONTANTRESTE" as number(30,3)) as MONTANTRESTE,
          CASE
             WHEN op.etat = 0 THEN 'annule'
             WHEN op.etat = 1 THEN 'cree'
             WHEN op.etat = 11 THEN 'vise'
          END
             AS etatlib
     FROM AVOIRFC_MONTANT op;
	 
create or replace view facture_client_filleHT as
        select 
            ff.*,
            cast(ff.quantite*ff.pu as number(30,3)) as montantHTSimple
        from facture_client_fille ff;

create or replace view facture_client_filleMR as
        select
            ff.*,
            cast((montantHTSimple*majoration)/100 as number(30,3)) as montantMaj,
            cast((montantHTSimple*reduction)/100 as number(30,3)) as montantRed
        from facture_client_filleHT ff;

create or replace view facture_client_filleNet as
        select
            ff.*,
            cast(montantHTSimple+montantMaj-montantRed as number(30,3)) as montantNET
        from facture_client_filleMR ff;

create or replace view facture_client_filleWithTVA as
        select
            ff.*,
            cast((montantNET*tva)/100 as number(30,3)) as montantTVA
        from facture_client_filleNet ff;		
		
create or replace view facture_client_filleTTC as
        select
            ff.*,
            cast(montantNET+montantTVA as number(30,3)) as montantTTC
        from facture_client_filleWithTVA ff;	

CREATE OR REPLACE FORCE VIEW ORDONNERPAYEMENTAVOIRFC
(
   ID,
   DED_ID,
   IDLIGNE,
   DATY,
   MONTANT,
   REMARQUE,
   ETAT,
   NUMEROOP,
   DESTINATION,
   MODEPAIEMENT,
   TIERS,
   IDUSER,
   NUMEROBED,
   IDFACTURE,
	type
)
AS
   SELECT op."ID",
          op."DED_ID",
          op."IDLIGNE",
          op."DATY",
          op."MONTANT",
          op."REMARQUE",
          op."ETAT",
          op."NUMEROOP",
          op."DESTINATION",
          op."MODEPAIEMENT",
          op."TIERS",
          op."IDUSER",
          op."NUMEROBED",
          av.idfacture,
		  av.type
     FROM ordonnerpayement op JOIN avoirFC av ON op.DED_ID = av.id;
		
		
CREATE OR REPLACE FORCE VIEW JOURNALCAISSELIB
(
   ID,
   DATESAISIE,
   DATEEFFET,
   FOLIO,
   CAISSE,
   NUMPIECE,
   LIBELLE,
   DEBIT,
   CREDIT,
   REMARQUE,
   ETAT,
   TIERS,
   IDTYPECHEQUE,
   IDPLACEMENT,
	idordre
)
AS
   SELECT id,
          datesaisie,
          dateeffet,
          folio,
          valcaisse AS caisse,
          numpiece,
          libelle,
          debit,
          credit,
          remarque,
          etat,
          tiers,
          valtypecheque AS idtypecheque,
          idplacement,
		  idordre
     FROM journalcaisselibcomplet;		
CREATE OR REPLACE FORCE VIEW JOURNALCAISSELIB_VISE
(
   ID,
   DATESAISIE,
   DATEEFFET,
   FOLIO,
   CAISSE,
   NUMPIECE,
   LIBELLE,
   DEBIT,
   CREDIT,
   REMARQUE,
   ETAT,
   TIERS,
   IDTYPECHEQUE,
   IDPLACEMENT,
   TIERSLIB,
   idordre
)
AS
   SELECT jc."ID",
          jc."DATESAISIE",
          jc."DATEEFFET",
          jc."FOLIO",
          jc."CAISSE",
          jc."NUMPIECE",
          jc."LIBELLE",
          jc."DEBIT",
          jc."CREDIT",
          jc."REMARQUE",
          jc."ETAT",
          jc."TIERS",
          jc."IDTYPECHEQUE",
          jc."IDPLACEMENT",
          fup.NOM AS tierslib,
          jc.idordre
     FROM journalcaisselib jc
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = jc.TIERS
          left join ordonnerpayement op on op.id=jc.idordre
    WHERE jc.etat >= 11;

create or replace view journalcaissevise_grp as
select
    tiers,
    idordre,
    sum(debit) as debit,
    sum(credit) as credit
from journalcaisselib_vise jc group by idordre,tiers;

create or replace view ordonnerpayement_jc_vise as
select 
    op.*, 
    jc.debit, 
    jc.credit 
from ordonnerpayement_vise op
join journalcaissevise_grp jc on jc.idordre=op.id;	

CREATE OR REPLACE FORCE VIEW AVOIRFC_MONTANT
(
   ID,
   DATY,
   IDFACTURE,
   ETAT,
   MONTANT,
   TIERS,
   TIERSLIB,
   MONTANTPAYE,
   MONTANTRESTE,
   CATEGORIE,
   CATEGORIELIB,
   MOTIF,
   MOTIFLIB,
   CODE,
   TYPE,
   TYPELIB,
   DESIGNATION
)
AS
   SELECT fc.ID,
          fc.DATY,
          fc.IDFACTURE,
          fc.ETAT,
          CAST (NVL (mr.montant, 0.0) AS NUMBER (30, 3)) AS montant,
          f.TIERS,
          f.tierslib,
          CAST (NVL (op.DEBIT, 0) AS NUMBER (30, 3)) AS montantpaye,
          CAST (NVL (mr.montant, 0.0) - NVL (op.DEBIT, 0) AS NUMBER (30, 3))
             AS montantreste,
          fc.CATEGORIE,
          c.VAL AS categorielib,
          fc.MOTIF,
          mo.val AS motiflib,
          fc.CODE,
          fc.TYPE,
          CASE
             WHEN fc.TYPE = '1' THEN 'interne'
             WHEN fc.TYPE = '2' THEN 'externe'
          END
             AS typelib,
          fc.DESIGNATION
     FROM AVOIRFC fc
          LEFT JOIN CATEGORIEAVOIRFC c ON fc.CATEGORIE = c.id
          LEFT JOIN MOTIFAVOIRFC mo ON fc.MOTIF = mo.id
          LEFT JOIN avoirfcavectaux_grp_mere mr ON mr.IDMERE = fc.ID
          LEFT JOIN FACTURECLIENT_libcomplet f ON fc.IDFACTURE = f.ID
          LEFT JOIN ordonnerpayement_jc_vise op ON op.ded_id = fc.ID;
		  
insert into categorieavoirfc values('CT001X','-','-');		  