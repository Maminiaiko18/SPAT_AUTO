SELECT av.ID,

       av.IDMERE,

       av.IDDETAILFACTURE,

       av.MONTANT,

       av.COMPTE,

       av.remise,

       ca.designation as                               designation,

       ca.taux,

       ca.devise,

       av.tva,

       CAST(nvl(av.qte, ca.quantite) AS NUMBER(30, 3)) qte,

       CAST(nvl(av.pu, ca.pu) AS NUMBER(30, 3))        pu,

       CAST(nvl(av.duree, ca.duree) as NUMBER(30, 3))  duree,

       CAST(CASE
                WHEN devise = 'Ar' THEN av.montant / ca.taux

                else av.montant END AS NUMBER(30, 3))
                      AS                               montantHTDevise,

       ca.majoration  AS                               maj,

       ca.reduction   AS                               red

from AvoirFCFille av

         left join CAFCFILLECOMPLET ca on ca.id = av.IDDETAILFACTURE
;


create or replace view AS_BONDECOMMANDE_LIBELLE_LIB
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB, MONTANTREMISE, IDENGAGEMENTLIB, IDENGAGEMENT, CODEETABLISSEMENT,
             COMPTEBDG, MONTANTHTSANSREMISE)
as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                                                      as fournisseur,
       cast(bc.tva as NUMBER(10)),
       bc.NUMBC,
       cast(nvl(c.montantht, 0) as number(32, 2)),
       cast(nvl(c.montanttva, 0) as number(32, 2)),
       cast(nvl(c.montantttc, 0) as NUMBER(32, 2)),
       ''                                                                          as idfacture,
       cast(nvl(lfac.montantpayer, 0) as number(32, 2))                            as montant_paye_reel,
       cast((nvl(c.montantttc, 0) - nvl((bl.MONTANTTTC), 0)) as NUMBER(32, 2))     as resteapayegeneral,
       cast((nvl(c.montantttc, 0) - nvl((lfac.montantpayer), 0)) as NUMBER(32, 2)) as resteapayerreel,
       cast(nvl(bl.montantttc, 0) as NUMBER(32, 2))                                as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       cast(lfac.montantttc as NUMBER(32, 2))                                      as montantfacture,
       case
           when bc.etat = 0 then 'ANNULE(E)'
           when bcf.RESTELIVRE > 0 then 'VISE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE(E)'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and
                (lfac.montantttc - nvl(lfac.montantpayer, 0) is not null)
               THEN 'FACTURE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) > 0
               THEN 'EN ATTENTE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYE(E)'
           else 'CREE(E)'
           END                                                                     as etatlib,
       cast(MONTANTREMISE as NUMBER(32, 2)),
       idengagementlib,
       IDENGAGEMENT,
       CODEETABLISSEMENT,
       CODE_ETAB || PROJET                                                       as comptebdg    , 
       CAST((c.montantht + montantremise) AS number(30 , 3)) AS montantHTSansRemise
from AS_BONDECOMMANDE_LIBELLE bc
     left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
     left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
     left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
     LEFT JOIN AS_BONDELIVRAISON_BC bl on bl.id_bc=bc.id
     left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur;