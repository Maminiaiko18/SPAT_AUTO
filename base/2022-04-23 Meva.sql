--mampiakatra montant HT, TVA, TTC
CREATE OR REPLACE VIEW "BONDELIVRAISON_PRIX" ("NUMBL", "ID", "QUANTITE", "IDBCF", "PU", "IDBC", "TVA", "MONTANTHT", "MONTANTTVA", "MONTANTTTC") AS 
  select blf.numbl,
       BLF.ID,
       blf.qUANTITE                                                      AS QUANTITE,
       IDBONDECOMMANDE                                                   as IDBCF,
       nvl(abf.Pu, 0)                                                    as pu,
       ABF.IDBC,
       nvl(ABF.TVA, 0)                                                   as tva,
       blf.MONTANTHT                                             AS mONTANTHT,
       blf.MONTANTTVA                            AS MONTANTTVA,
       blf.montanttc AS MONTANTTTC
from AS_BONDELIVRAISON_FILLE_MTT blf
         left JOIN union_bcf_spat_cemedi ABF on blf.IDBONDECOMMANDE = ABF.ID;

--nanampy colonne
CREATE OR REPLACE VIEW "AS_BONDECOMMANDE_LIBELLE_LIB" ("ID", "DATY", "ETAT", "REMARQUE", "DESIGNATION", "MODEPAIEMENT", "FOURNISSEUR", "TVA", "NUMBC", "MONTANT", "MONTANTTVA", "MONTANTTTC", "IDFACTURE", "MONTANT_PAYE_REEL", "RESTEPAYERGENERAL", "RESTEAPAYERREEL", "MONTANT_A_PAYER", "PROJET", "CODE_ETAB", "MONTANTFACTURE", "ETATLIB", "MONTANTREMISE", "IDENGAGEMENTLIB", "IDENGAGEMENT", "CODEETABLISSEMENT", "COMPTEBDG") AS 
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
       CODE_ETAB || PROJET                                                         as comptebdg
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
         left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
         LEFT JOIN BONDELIVRAISONPARBC bl ON bl.IDBC = bc.ID
         left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur;

--mampiakatra remise
CREATE OR REPLACE VIEW "AS_BONDELIVRAISON_FILLEQTE_RES" ("ID", "PRODUIT", "NUMBL", "QUANTITE", "QUANTITEPARPACK", "IDDETAILSFACTUREFOURNISSEUR", "IDBONDECOMMANDE", "FACTURE", "QUANTITERESTE", "PU", "NOMTIERS", "IDTIERS", "TVA", "MONTANTHT", "MONTANTTVA", "PROJET", "PROJETLIB", "CODE_ETABLISSEMENT", "CODE_ETABLISSEMENTLIB","remise") AS 
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
       cast((blf.QUANTITE * bcf.PU) as number(34, 2))                 as montantht,
       cast((blf.QUANTITE * bcf.PU * bcf.TVA) / 100 as number(34, 2)) as montanttva,
       bc.PROJET,
       pr.DESIGNATION                                                 as projetlib,
       bc.CODE_ETAB                                                   as code_etablissement,
       ce.VAL                                                         as code_etablissementlib,
       bcf.remise AS remise
FROM AS_BONDELIVRAISON_FILLE blf
         LEFT JOIN union_bcf_spat_cemedi bcf
                   ON bcf.id = blf.IDBONDECOMMANDE
         LEFT JOIN union_bc_spat_cemedi bc ON bc.id = bcf.idbc
         LEFT JOIN tiers ON tiers.id = bc.fournisseur
         LEFT JOIN FACTURE_FOURNISSEUR_QTE qff
                   ON qff.IDBLF = blf.id
         left join PROJET pr on pr.id = bc.PROJET
         left join CODEETABLISSEMENT ce on ce.id = CODE_ETAB;

--ajout HT, TTC, TVA group by details facture
CREATE OR REPLACE VIEW "AVOIRFCAVECTAUX_GRP" AS 
  SELECT ac.IDDETAILFACTURE,
            CAST (SUM (MONTANT) as number(30,3)) AS montantsanstaux,
            CAST (SUM (montantavectsaux)as number(30,3)) AS montantavectsaux,
            CAST (SUM (MONTANTTVA)as number(30,3)) AS MONTANTTVA,
            CAST (SUM (MONTANTTTC)as number(30,3)) AS MONTANTTTC
       FROM avoirfcavectaux ac
      WHERE etat >= 11 and
   GROUP BY ac.IDDETAILFACTURE;

--mampiakatra avoir HT, TVA, TTC
CREATE OR REPLACE VIEW "FCFILLECOMPLET" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "RANG", "DUREE", "MONTANTAV", "RUBRIQUECPL", "DATY", "TIERS", "IDCATEGORIE", "TYPE", "DEVISEMERE", "EXERCICE", "IDAVOIR", "ETAT", "MTAVOIR", "MONTANTREDUCTION", "MONTANTMAJORATION", "MONTANT", "MONTANTTVA", "MONTANTTTC", "MOISLIB", "MONTANTHTSIMPLE", "CLIENT", "MONTANTAVOIRAVECTSAUX", "MONTANTAVTTCAVECTAUX","MONTANTAVTVAAVECTAUX") AS 
  SELECT fcf.ID,
       fcf.IDMERE,
       fcf.DESIGNATION,
       fcf.QUANTITE,
       fcf.PU,
       fcf.COMPTE,
       fcf.IDPRODUIT,
       fcf.DEVISE,
       fcf.TAUX,
       fcf.IDACTIVITE,
       fcf.TVA,
       fcf.DATEFACT,
       fcf.RUBRIQUE,
       EXTRACT(MONTH FROM fc.DATY)                          AS mois,
       EXTRACT(YEAR FROM fc.DATY)                           AS annee,
       fcf.HEUREDEBUT,
       fcf.HEUREFIN,
       fcf.REDUCTION,
       fcf.MAJORATION,
       fcf.TEST,
       fcf.RANG,
       fcf.DUREE,
       fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) AS montantAV,
       DECODE(fcf.rubrique, NULL, a.rubrique, fcf.rubrique)
                                                            AS rubriquecpl,
       fc.daty,
       fc.tiers,
       fc.idcategorie,
       fc.TYPE,
       fc.devisemere,
       fc.exercice,
       FC.IDAVOIr,
       fc.etat,
       NVL(AV.montantsanstaux, 0)                                   AS mtavoir,
       fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.REDUCTION, 0)
           / 100
                                                            AS montantReduction,
       fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.MAJORATION, 0)
           / 100
                                                            AS montantMajoration,
       fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1)
           + (fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.MAJORATION, 0))
           / 100
           - (fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.REDUCTION, 0))
           / 100
                                                            AS montant,
       (fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1)
            + (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.MAJORATION, 0))
            / 100
           - (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.REDUCTION, 0))
            / 100)
           * NVL(fcf.tva / 100, 0)
                                                            AS montanttva,
       (fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1)
            + (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.MAJORATION, 0))
            / 100
           - (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.REDUCTION, 0))
            / 100)
           * (1 + NVL(fcf.tva / 100, 0))
                                                            AS montantttc,
       m.VAL                                                AS moislib,
       f.MONTANTHTSIMPLE,
       t.nomclt,
       CAST(nvl(av.montantavectsaux, 0) AS  NUMBER (30, 3)) AS  montantavoiravectsaux , 
       CAST(nvl(av.MONTANTTTC, 0) AS NUMBER (30, 3)) as montantavTTCavecTaux,
       CAST(nvl(av.MONTANTTVA, 0) AS NUMBER (30, 3)) as montantavTVAavecTaux
FROM facture_client_fille fcf
         JOIN factureclient fc ON fcf.idmere = fc.id
         LEFT JOIN activite a ON a.id = fcf.idactivite
         LEFT JOIN AVOIRFCAVECTAUX_GRP av
                   ON AV.IDDETAILFACTURE = fcf.id
         LEFT JOIN mois m ON m.ID = EXTRACT(MONTH FROM fc.DATY)
         LEFT JOIN facture_client_filleTTC f ON f.ID = fcf.ID
         left join client_union t on fc.TIERS = t.cdclt;

--esorina amin'ny HT, TVA, TTC facture ny avoir HT, TVA, TTC
CREATE OR REPLACE VIEW "CAFCFILLECOMPLET_AVOIR" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "RANG", "DUREE", "MONTANTAV", "RUBRIQUECPL", "DATY", "TIERS", "IDCATEGORIE", "TYPE", "DEVISEMERE", "EXERCICE", "IDAVOIR", "ETAT", "MTAVOIR", "MONTANTREDUCTION", "MONTANTMAJORATION", "MONTANT", "MONTANTTVA", "MONTANTTTC", "MOISLIB", "MONTANTHTSIMPLE", "CLIENT") AS 
  SELECT ff.ID,
          IDMERE,
          DESIGNATION,
          QUANTITE,
          PU,
          COMPTE,
          IDPRODUIT,
          DEVISE,
          TAUX,
          IDACTIVITE,
          TVA,
          DATEFACT,
          RUBRIQUE,
         cast(MOIS as NUMBER(10)),
         cast(ANNEE as NUMBER(10)),
          HEUREDEBUT,
          HEUREFIN,
          REDUCTION,
          MAJORATION,
          TEST,
          RANG,
          DUREE,
         cast(MONTANTAV as NUMBER(30,3)),
          RUBRIQUECPL,
          DATY,
          TIERS,
          IDCATEGORIE,
          ff.TYPE,
          DEVISEMERE,
          EXERCICE,
          IDAVOIR,
          ff.ETAT,
         cast(MTAVOIR as NUMBER(30,2)),
         cast(MONTANTREDUCTION as NUMBER(30,2)),
         cast(MONTANTMAJORATION as NUMBER(30,2)),
         cast(MONTANT-nvl(ff.MONTANTAVOIRAVECTSAUX,0)  as NUMBER(30,2)),
         cast(ff.MONTANTTVA-nvl(ff.montantavTVAavecTaux,0) as NUMBER(30,2)),
         cast(ff.MONTANTTTC-nvl(ff.MONTANTAVTTCAVECTAUX,0) as number(30,2)),
          moislib,
         cast(ff.MONTANTHTSIMPLE-nvl(ff.MONTANTAVOIRAVECTSAUX,0) as NUMBER(30,2)),
          ff.client
     FROM fcfillecomplet ff
     WHERE FF.IDCATEGORIE <> 'CATFCO2' AND FF.IDCATEGORIE <> 'CATFCO1'  and etat>=11;

--tonga dia ilay niala avoir no ampiasaina fa tsy ilay tsotra
CREATE OR REPLACE  VIEW "FACTURE_CLIENT_MF_PAYE_BDG" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "DATY", "TIERS", "TYPE", "TVA", "ETAT", "MONTANTTTC", "MONTANTHT", "MONTANTPAYEPOURC", "MONTANTPAYE", "MONTANTHTPAYE", "EXERCICE", "MOIS", "ANNEE") AS 
  SELECT fcf.ID,
          fcf.IDMERE,
          fcf.DESIGNATION,
          fcf.QUANTITE,
          fcf.PU,
          fcf.COMPTE,
          fcf.IDPRODUIT,
          fcf.DEVISE,
          fcf.TAUX,
          fcf.DATY,
          fcf.TIERS,
          fcf.TYPE,
          fcf.TVA,
          fcf.ETAT,
          (fcf.MONTANTTTC) AS MONTANTTTC,
          (fcf.MONTANT) AS MONTANTHT,
          ROUND ( (l.MONTANTPAYE) / NVL (NULLIF (l.MONTANTTTC, 0), 1), 3)
             AS montantpayepourc,
          ROUND (
               (fcf.MONTANTTTC)
             * ( (l.MONTANTPAYE) / NVL (NULLIF (l.MONTANTTTC, 0), 1)),
             3)
             AS montantpaye,
          ROUND (
               (fcf.MONTANT)
             * ( (l.MONTANTPAYE) / NVL (NULLIF (l.MONTANT, 0), 1)),
             3)
             AS montantHTpaye,
          l.EXERCICE,
          fcf.mois,
          fcf.annee
     FROM FACTURECLIENTMSUM_LIB l
          RIGHT JOIN CAFCFILLECOMPLET_AVOIR fcf ON fcf.IDMERE = l.id
    WHERE l.ETAT >= 11;

--esorina ny avoir HT, TVA, TTC
CREATE OR REPLACE VIEW "FCFILLECOMPLET_ANALYSE" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "RANG", "DUREE", "MONTANTAV", "RUBRIQUECPL", "DATY", "TIERS", "IDCATEGORIE", "TYPE", "DEVISEMERE", "EXERCICE", "IDAVOIR", "ETAT", "MTAVOIR", "MONTANTREDUCTION", "MONTANTMAJORATION", "MONTANT", "MONTANTTVA", "MONTANTTTC", "MOISLIB", "MONTANTHTSIMPLE", "CLIENT", "MONTANTAVOIRAVECTSAUX", "LIBELLERUBRIQUE", "CATCLIENT") AS 
  select fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       cast(fc.QUANTITE as NUMBER(20, 3))           as QUANTITE,
       cast(fc.PU as NUMBER(30, 3))                 as PU,
       fc.COMPTE,
       fc.IDPRODUIT,
       fc.DEVISE,
       cast(fc.TAUX as NUMBER(10, 2))               as TAUX,
       fc.IDACTIVITE,
       cast(fc.TVA as NUMBER(20, 2))                as TVA,
       fc.DATEFACT,
       fc.RUBRIQUE,
       fc.MOIS,
       fc.ANNEE,
       fc.HEUREDEBUT,
       fc.HEUREFIN,
       cast(fc.REDUCTION as NUMBER(20, 2))          as REDUCTION,
       cast(fc.MAJORATION as NUMBER(20, 2))         as MAJORATION,
       cast(TEST as NUMBER(10, 2))                  as TEST,
       fc.RANG,
       cast(fc.DUREE as NUMBER(10, 2))              as DUREE,
       cast(MONTANTAV as NUMBER(30, 3))             as MONTANTAV,
       RUBRIQUECPL,
       DATY,
       TIERS,
       IDCATEGORIE,
       TYPE,
       DEVISEMERE,
       EXERCICE,
       IDAVOIR,
       ETAT,
       cast(MTAVOIR as number(30, 3))               as MTAVOIR, --TSY MIASA
       cast(MONTANTREDUCTION as NUMBER(30, 3))      as MONTANTREDUCTION,
       cast(MONTANTMAJORATION as NUMBER(30, 3))     as MONTANTMAJORATION,
       cast(MONTANT-fc.MONTANTAVOIRAVECTSAUX  as NUMBER(30, 3))               as MONTANT,
       cast(MONTANTTVA-fc.MONTANTAVTVAAVECTAUX as NUMBER(30, 3))            as MONTANTTVA,
       cast(MONTANTTTC-FC.MONTANTAVTTCAVECTAUX as NUMBER(30, 3))            as MONTANTTTC,
       MOISLIB,
       cast(MONTANTHTSIMPLE-fc.MONTANTAVOIRAVECTSAUX as NUMBER(30, 3))       as MONTANTHTSIMPLE,
       fc.CLIENT,
       cast(MONTANTAVOIRAVECTSAUX as NUMBER(30, 3)) as MONTANTAVOIRAVECTSAUX,
       ra.DESIGNATION                               as libelleRubrique,
       cu.CATEGORIE                                 as catClient
from FCFILLECOMPLET fc
         left join RUBRIQUE_ACTIVITE ra on fc.RUBRIQUECPL = ra.id
         left join CLIENT_UNION cu on cu.CDCLT = fc.TIERS
where fc.etat >= 11;


--refresh colonnes 
CREATE OR REPLACE VIEW "JOURNALCAISSELIBCOMPLET_CREE" as
select * from JOURNALCAISSELIBCOMPLET
WHERE etat = 1;

CREATE OR REPLACE VIEW "JOURNALCAISSELIBCOMPLET_VISE" as 
select * from JOURNALCAISSELIBCOMPLET
WHERE etat >= 11;

CREATE OR REPLACE VIEW "JOURNALCAISSELIBRECETTE" AS 
  select * from  journalcaisselibcomplet
where credit>0 ;

CREATE OR REPLACE VIEW "JOURNALCAISSELIBDEPENSE"  AS 
  select * from journalcaisselibcomplet
where debit > 0;

