create view BONDELIVRAISON_CMPL_GROUPER AS
select ID_BC,
       sum(MONTANTTTC) as MONTANTTTC,
       sum(MONTANTTVA) as MONTANTTVA,
       sum(MONTANTPAYER) as MONTANTPAYER,
       sum(MONTANTHT) as MONTANTHT
from BONDELIVRAISON_CMPL
group by ID_BC;

create view ETATFACTUREMONTANTDATY_GPR as
select REMARQUE,sum(MONTANTPAYE) as montantpaye
from etatfacturemontantdaty
group by REMARQUE
/




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
         left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
         left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
         LEFT JOIN BONDELIVRAISONPARBC bl ON bl.IDBC = bc.ID
         left join TIERS ti on ti.ID = bc.fournisseur
/

create or replace view CONTRAT_CHANTIER_CPLSUM as
SELECT bc."ID",
       bc."IDCHANTIER",
       cH.nom                                            AS CHANTIERLIB,
       bc."DESIGNATION",
       bc."MONTANT",
       bc."PRESTATAIRE",
       ti.nom                                            AS PRESTATAIRElib,
       bc."ETAT",
       '' as idfacture,
       NVL(gr.montantpaye, 0)                                AS montant_paye,
       bc.montant - NVL(gr.montantpaye, 0)                   AS resteapaye,
       bc.TVA,
       bc.PROJET,
       bc.CODE_ETAB,
       bc.noContrat,
       ce.val                                            AS CODE_ETABLIB,
       pe.designation                                    AS PROJETLIB
FROM          --left JOIN etatfacturemontantdaty ff ON ff.id = op.DED_ID
         etatfacturemontantdaty_gpr gr
         RIGHT JOIN CONTRAT_CHANTIER bc ON bc.ID = gr.remarque
         LEFT JOIN CODEETABLISSEMENT ce ON ce.id = bc.code_etab
         LEFT JOIN CHANTIER cH ON ch.id = bc.IDCHANTIER
         LEFT JOIN TIERS ti ON ti.id = bc.PRESTATAIRE
         LEFT JOIN PROJET pe ON pe.id = bc.projet

/