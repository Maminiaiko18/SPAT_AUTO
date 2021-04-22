CREATE OR REPLACE VIEW journalcaisselib_Analyse as
  (select * from journalcaisselib);
  
alter table historiquesyndicat drop constraint FK_PERSONNEL;

alter table historiquesyndicat add constraint FK_PERSONNEL foreign key (idpersonnel) references infopersonnelglobal (id);

create or replace view CONTRATLIBCOMPLET as
select
        cont."ID",cont."IDTIERS",cont."DATE_SIGNATURE",cont."OBJET",cont."DEBUT_CONTRAT",cont."FIN_CONTRAT",cont."DUREE",cont."DROIT_ENTREE",cont."REDEVANCE_FIXE",cont."DEVISE",cont."REDEVANCE_VARIABLE",cont."UNITE",cont."DROIT_PORT",
        clt.*,
        unite.VAL as valunite, unite.DESCE as desceunite
    from contrat cont
        join V_CLIENT_CATEGORIE clt on clt.cdclt = cont.IDTIERS
        join UNITE unite on cont.UNITE = unite.ID;

create or replace view CONTRATLIB as
select
        ID,
        NOMCLT as IDTIERS,
        DATE_SIGNATURE, OBJET, DEBUT_CONTRAT, FIN_CONTRAT, DUREE, DROIT_ENTREE, REDEVANCE_FIXE, DEVISE, REDEVANCE_VARIABLE,
        valunite as UNITE, DROIT_PORT
    from CONTRATLIBCOMPLET;

create or replace view analyseglobalefacture_Analyse as
	select
		nmfact, daty, categorie_facture, sous_categorie_facture, client, categorie_client, designation,
		cast(mttc as number(18,3)) as mttc,
		cast(mtht as number(18,3)) as mtht,
		cast(taxe as number(18,3)) as taxe,
		devfact,
		cast(mtdevise as number(18,3)) as mtdevise,
		cast(mtavoir as number(18,3)) as mtavoir,
		cast(paye as number(18,3)) as paye,
		cast(reste as number(18,3)) as reste,
		numcompte,valcat
	from analyseglobalefacture;
	
CREATE OR REPLACE FORCE VIEW "SPAT_CAPITAINERIE"."V_ANALYSE_PAIEMENT_CMD" ("BONCOMMANDE", "FOURNISSEUR", "ORGANE_DEMANDEUR", "QUANTITE", "MONTANTTOTAL", "MONTANTFACTURE", "MONTANTNONFACTURE", "MONTANTPAYE", "MONTANTNONPAYE", "CATEGORIE") AS 
  select BONCOMMANDE, FOURNISSEUR, ORGANE_DEMANDEUR, 
  	cast(1 as integer), 
	cast(MONTANTPAYE as number(25,2)), 
  	cast(0 as number(25,2)), 
  	cast(0 as number(25,2)),
  	cast(0 as number(25,2)), 
  	cast(0 as number(25,2)),
  	'Bon de commande PAYE' 
  from spat_engagement.v_analyse_bon_commande
  where MONTANTNONPAYE = 0
  union all
  select BONCOMMANDE, FOURNISSEUR, ORGANE_DEMANDEUR, 
  	cast(1 as integer), 
	cast(MONTANTNONPAYE as number(25,2)), 
  	cast(0 as number(25,2)), 
  	cast(0 as number(25,2)),
  	cast(0 as number(25,2)), 
  	cast(0 as number(25,2)),
  	'Bon de commande NON PAYE' 
  from spat_engagement.v_analyse_bon_commande
  where MONTANTNONPAYE > 0;
  
 CREATE OR REPLACE FORCE VIEW "SPAT_CAPITAINERIE"."V_ANALYSE_PAIEMENT_COMMANDE" ("BONCOMMANDE", "FOURNISSEUR", "ORGANE_DEMANDEUR", "QUANTITE", "MONTANTTOTAL", "MONTANTFACTURE", "MONTANTNONFACTURE", "MONTANTPAYE", "MONTANTNONPAYE", "CATEGORIE") AS 
  select BONCOMMANDE, FOURNISSEUR, ORGANE_DEMANDEUR, cast(QUANTITE as integer), cast(MONTANTTOTAL as number(25,2)), cast(MONTANTFACTURE as number(25,2)), cast(MONTANTNONFACTURE as number(25,2)), 
  cast(MONTANTPAYE as number(25,2)), cast(MONTANTNONPAYE as number(25,2)), CATEGORIE
  from V_ANALYSE_PAIEMENT_CMD;