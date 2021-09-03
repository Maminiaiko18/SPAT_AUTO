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
            (montantHTSimple*majoration)/100 as montantMaj,
            (montantHTSimple*reduction)/100 as montantRed
        from facture_client_filleHT ff;

create or replace view facture_client_filleNet as
        select
            ff.*,
            montantHTSimple+montantMaj-montantRed as montantNET
        from facture_client_filleMR ff;

create or replace view facture_client_filleWithTVA as
        select
            ff.*,
            (montantNET*tva)/100 as montantTVA
        from facture_client_filleNet ff;		
		
create or replace view facture_client_filleTTC as
        select
            ff.*,
            montantNET+montantTVA as montantTTC
        from facture_client_filleWithTVA ff;		