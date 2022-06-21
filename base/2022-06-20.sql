Alter table AS_BONDECOMMANDE_FILLE
add devise varchar(500) CONSTRAINT AS_BC_F_devise_id_fk REFERENCES  devise(id);
Alter table AS_BONDECOMMANDE_FILLE
ADD taux NUMBER(30,3);

CREATE OR REPLACe VIEW UNION_BCF_SPAT_CEMEDI (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA, REMISE, OBSERVATION,devise,taux) AS 
  select bcf.ID,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       UNITE,
       TVA,
       REMISE , 
       bcf.observation,
       bcf.devise,
       bcf.taux
	   
from AS_BONDECOMMANDE_FILLE bcf
union
select id,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       UNITE,
       tva,
       cast(0 as NUMBER(30,2)), 
       cast ('-' as varchar(10)),
       cast ('-' as varchar(10)),
       cast(0 as NUMBER(30,2))
from bcf_cemedi_vue;



CREATE OR REPLACE VIEW AS_BONDECOMMANDE_FILLE_MONTANT (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA, REMISE, MONTANTHT, MONTANTTVA, MONTANTTTC, MONTANTREMISE, ETAT,montantDevise) AS 
  select bcf.ID,
       bcf.PRODUIT,
       bcf.IDBC,
       bcf.QUANTITE,
       bcf.PU,
       bcf.QUANTITEPARPACK,
       bcf.MONTANT,
       bcf.REMARQUE,
       u.VAL                                                                                        AS UNITE,
       bcf.TVA,
       bcf.REMISE,
       (bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)) - nvl((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)) * (REMISE / 100), 0)                   as montantht,
       ((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)) - nvl((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)) * (REMISE / 100), 0)) * bcf.TVA / 100 as montanttva,
       ((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)) - nvl((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)) * (REMISE / 100), 0)) +
       ((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)) - nvl((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)) * (REMISE / 100), 0)) * bcf.TVA / 100 as montantttc,
       nvl((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)) * (REMISE / 100), 0)                                             as montantremise,
       bc.ETAT,
        (bcf.QUANTITE * bcf.pu) as montantDevise
from union_bcf_spat_cemedi bcf
         join union_bc_spat_cemedi bc on bc.id = bcf.IDBC
         LEFT JOIN UNITECHANTIER u ON U.ID = BCF.UNITE;
        
		
		
		   
        CREATE OR REPLACE VIEW BC_BL_LIVRE (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, QUANTITELIVRE, QUANTITERESTE, MONTANTBL, MONTANTBLRESTE, UNITE, TVA, REMISE, MONTANTREMISE, OBSERVATION, MONTANTHTSANSREMISE, MONTANTTVA,taux,devise) AS 
  SELECT BCF.ID,
       CASE WHEN BCF.PRODUIT IS NULL THEN BCF.REMARQUE ELSE ap.Nom END  AS PRODUIT,
       BCF.IDBC,
       BCF.QUANTITE,
       BCF.PU,
       BCF.QUANTITEPARPACK,
       CAST((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1))*(1-(remise/100))  AS NUMBER(30 , 3)) as montant , 
       BCF.REMARQUE,
       CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitelivre,
       CAST(BCF.QUANTITE - NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitereste,
       CAST((NVL(BFG.qtelivre, 0) * BCF.PU* nvl(bcf.taux,1)) * (1-(bcf.remise/100)) AS NUMBER(30,2)) AS MontantBL,
       CAST(bcf.pu *nvl(bcf.taux,1) *(1-(bcf.remise/100)) * (bcf.quantite-NVL(BFG.qtelivre, 0)) AS NUMBER(30,2)) AS MontantBLreste,
       u.val                                     AS UNITE,
       bcf.TVA,
       bcf.REMISE,
       cast((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)*bcf.QUANTITE) / 100 as NUMBER(30,2)) as montantRemise , 
       bcf.observation , 
       cast(bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1)AS NUMBER(30 , 3)) AS montanthtsansremise , 
       CAST(((bcf.QUANTITE * bcf.pu * nvl(bcf.taux,1))*(1-(remise/100)) * bcf.tva)/100 AS number(30 , 3)) AS  montantTVA,
        bcf.taux,
        bcf.devise
FROM union_bcf_spat_cemedi BCF
         LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG
                   ON BFG.IDBONDECOMMANDE = BCF.ID
         LEFT JOIN union_produit_tbd_cemedi ap ON BCF.produit = ap.id
         LEFT JOIN union_unite_tbd_cemedi u ON bcf.UNITE = u.id

;

CREATE OR REPLACE VIEW AS_BONDELIVRAISON_MONTANT (ID, REMARQUE, IDBC, DATY, ETAT, POINT, ID_BC, MONTANT, TVA) AS 
  select mere.ID,
       mere.REMARQUE,
       mere.IDBC,
       mere.DATY,
       mere.ETAT,
       mere.POINT,
       mere.ID_BC,
       sum(fille.quantite * bcfille.pu * nvl(bcfille.taux,1)) as montant,
       bcmere.tva
from as_bondelivraison mere
         left join as_bondelivraison_fille fille on mere.id = fille.numbl
         left join union_bcf_spat_cemedi bcfille on fille.idbondecommande = bcfille.id
         left join union_bc_spat_cemedi bcmere on bcmere.id = bcfille.idbc
where bcmere.etat >= 11
group by mere.id, mere.remarque, mere.idbc, mere.daty, mere.etat, mere.point, mere.id_bc, bcmere.tva;

CREATE OR REPLACE  VIEW AS_BONDELIVRAISON_FILLEQTE_RES (ID, PRODUIT, NUMBL, QUANTITE, QUANTITEPARPACK, IDDETAILSFACTUREFOURNISSEUR, IDBONDECOMMANDE, FACTURE, QUANTITERESTE, PU, NOMTIERS, IDTIERS, TVA, MONTANTHT, MONTANTTVA, PROJET, PROJETLIB, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB, IDBONDECOMMANDEMERE, REMISE,taux,devise) AS 
  SELECT blf.ID,
       blf.PRODUIT,
       blf.NUMBL,
       blf.QUANTITE,
       blf.QUANTITEPARPACK,
       blf.IDDETAILSFACTUREFOURNISSEUR,
       blf.IDBONDECOMMANDE,
       NVL(qff.quantite, 0)                                                AS facture,
       blf.QUANTITE - NVL(qff.quantite, 0)                                 AS quantitereste,
       bcf.PU,
       tiers.nom                                                      AS nomTiers,
       tiers.id                                                       as idtiers,
       bcf.TVA,
       cast((blf.QUANTITE * bcf.PU * nvl(bcf.taux,1)) as number(34, 2))                 as montantht,
       cast((blf.QUANTITE * bcf.PU * nvl(bcf.taux,1)* bcf.TVA) / 100 as number(34, 2)) as montanttva,
       bc.PROJET,
       pr.DESIGNATION                                                 as projetlib,
       bc.CODE_ETAB                                                   as code_etablissement,
       ce.VAL                                                         as code_etablissementlib
      ,bcf.IDBC as IDBONDECOMMANDEMERE,
       bcf.remise,
       bcf.taux,
       bcf.devise
FROM AS_BONDELIVRAISON_FILLE blf
         LEFT JOIN union_bcf_spat_cemedi bcf
                   ON bcf.id = blf.IDBONDECOMMANDE
         LEFT JOIN union_bc_spat_cemedi bc ON bc.id = bcf.idbc
         LEFT JOIN tiers ON tiers.id = bc.fournisseur
         LEFT JOIN FACTURE_FOURNISSEUR_QTE qff
                   ON qff.IDBLF = blf.id
         left join PROJET pr on pr.id = bc.PROJET
         left join CODEETABLISSEMENT ce on ce.id = CODE_ETAB
;





