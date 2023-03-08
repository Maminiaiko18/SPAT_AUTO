UPDATE PLACEMENT_BANQUE_CAISSE SET desce='CAIS000004' WHERE id='pbc0006';

UPDATE PLACEMENT_BANQUE_CAISSE SET desce='CAIS000005' WHERE id='pbc0005';


alter table JOURNALCAISSE add  idplacementvrai varchar2(500) constraint fk_placementvrai references PLACEMENT;


CREATE OR REPLACE  VIEW AS_BC_ANALYSEFILLE_LIB (ID, PRODUIT, IDBC,NUMBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA, MONTANTHT, MONTANTTVA, MONTANTTTC, ETAT, DATY, CODE, FOURNISSEUR, PROJET, MONTANTREMISE, FOURNISSEURLIB, PROJETLIB, CODELIB) AS 
  SELECT mon.ID,
       case when mon.produit is null then mon.remarque else pr.nom END AS produit,
       mon.IDBC,
	   bc.NUMBC,
       mon.QUANTITE,
       mon.PU,
       mon.QUANTITEPARPACK,
       mon.MONTANT,
       mon.REMARQUE,
       mon.UNITE,
       mon.TVA,
       mon.MONTANTHT,
       mon.MONTANTTVA,
       mon.MONTANTTTC,
       mon.ETAT,
       bc.daty                                                         AS daty,
       bc.CODE_ETAB                                                    as code,
       bc.FOURNISSEUR,
       bc.PROJET,
       MONTANTREMISE,
       tiers.nom                                                       as FOURNISSEURLIB,
       p.designation                                                   as projetlib,
       ce.val                                                          as codelib
from AS_BCF_MONTANT_SANSCEMEDI mon
         left join as_produits pr on pr.id = mon.PRODUIT
         LEFT JOIN AS_BONDECOMMANDE bc ON bc.id = mon.idbc
		 LEFT JOIN  as_bondecommande_fille bcf ON bcf.id = mon.id 
         LEFT JOIN tiers ON tiers.id = bc.FOURNISSEUR
         left Join Projet p on p.id = bc.projet
         left join CODEETABLISSEMENT ce on ce.id = bc.CODE_ETAB;