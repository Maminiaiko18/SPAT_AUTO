CREATE OR REPLACE VIEW "FC_FILLE_LIBELLE_PROF" ("ID", "IDMERE", "RUBRIQUE", "DESIGNATION", "PU", "QUANTITE", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "PRODUIT_LIB", "ACTIVITELIB", "DATEFACT", "RUBRIQUELIB", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "MAJORATION", "REDUCTION", "RANG", "DATY", "MONTANT", "DUREE", "IDRUBRIQUE", "ESTPROFORMAESCALE") AS 
  SELECT
    fi.ID,
    fi.IDMERE,
    (fi.RUBRIQUE) as RUBRIQUE,
    fi.DESIGNATION,
    fi.PU,
    fi.QUANTITE,
    fi.COMPTE,
    fi.IDPRODUIT,
    fi.DEVISE,
    fi.TAUX,
    fi.IDACTIVITE,
    fi.TVA,
    pr.nom AS produit_lib,
    ac.DESIGNATION AS activitelib,
    TO_DATE(fi.DATEFACT, 'dd/MM/YY') AS DATEFACT,
    nvl(ra.DESIGNATION, r1.DESIGNATION) AS rubriquelib,
    fi.MOIS,
    fi.ANNEE,
    fi.HEUREDEBUT,
    fi.HEUREFIN,
    nvl(fi.MAJORATION, 0) as MAJORATION,
    nvl(fi.REDUCTION, 0) as REDUCTION,
    fi.rang as rang,
    case
        when fi.IDACTIVITE is not null then ac.datefin
        else fc.DATY
    end as daty,
    cast(
        fi.QUANTITE * NVL(fi.DUREE, 1) * fi.pu as number(30, 3)
    ) AS MONTANT,
    fi.DUREE AS DUREE,
    ra.ID as idrubrique,
    fi.estProformaEscale
FROM
    FC_FILLE_RANGFINAL_PROF fi
    LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
    LEFT JOIN activite_PROF ac ON ac.id = fi.IDACTIVITE
    LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = ac.RUBRIQUE
    LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fi.RUBRIQUE
    LEFT JOIN FACTURECLIENT_PROF fc ON fc.ID = fi.IDMERE;
	
	
CREATE OR REPLACE  VIEW "FACTURECLIENT_UNION_ORDRE_PROF" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDPREVISION", "MONTANT", "MONTANTTVA", "MONTANTTTCVRAI", "MONTANTTTC", "MONTANTAVOIR", "MONTANTPAYE", "MONTANTRESTE", "TIERSLIB", "CONTACT", "ADRESSE", "ESCALE", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "DEVISEMERE", "PAIEMENT", "PAIEMENTLIB", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "ETATLIB", "ARMATEURLIB", "EXERCICE", "POURCOMPTE", "POURCOMPTELIB", "DATEDEPART", "HEUREDEPART", "DATEARRIVEE", "HEUREARRIVEE", "BATEAU", "BATEAULIB", "PROVENANCE", "PROVENANCELIB", "DESTINATION", "DESTINATIONLIB", "PAVILLON", "PAVILLONLIB", "MONTANTAPRED", "MONTANTHTSIMPLE", "MONTANTSANSREDUCTION") AS 
  select
    fcu.ID,
    fcu.DATY,
    fcu.TIERS,
    fcu.DESIGNATION,
    fcu.TYPE,
    fcu.TVA,
    fcu.REMARQUE,
    fcu.IDUSER,
    fcu.DATE_ECHEANCE,
    cast(fcu.ETAT as number(10)),
    fcu.IDPREVISION,
    cast(fcu.MONTANT as number(30, 2)),
    cast(fcu.MONTANTTVA as number(30, 2)),
    cast(fcu.montantTTCvrai as number(30, 2)),
    cast(fcu.MONTANTTTC as NUMBER(30, 2)),
    cast(fcu.MONTANTAVOIR as NUMBER(30, 2)),
    cast(fcu.MONTANTPAYE as NUMBER(30, 2)),
    cast(fcu.MONTANTRESTE as NUMBER(30, 2)),
    fcu.TIERSLIB,
    fcu.CONTACT,
    fcu.ADRESSE,
    fcu.ESCALE,
    fcu.TYPELIB,
    fcu.IDCATEGORIE,
    fcu.CATEGORIELIB,
    fcu.IDPROVISION,
    fcu.IDPROVISIONLIB,
    fcu.DEVISEMERE,
    fcu.paiement,
    fcu.paiementlib,
    fcu.CODEPRESTATION,
    fcu.CODEPRESTATIONLIB,
    fcu.CODE,
    fcu.ESTMICTSL,
    fcu.CODEPROVISION,
    fcu.ETATLIB,
    fcu.ARMATEURLIB,
    fcu.EXERCICE,
    fcu.POURCOMPTE,
    fcu.POURCOMPTELIB,
    fcu.datedepart,
    fcu.heuredepart,
    fcu.datearrivee,
    fcu.heurearrivee,
    fcu.bateau,
    fcu.bateaulib,
    fcu.provenance,
    fcu.provenancelib,
    fcu.destination,
    fcu.destinationlib,
    fcu.pavillon,
    fcu.pavillonlib,
    cast(cg.MONTANTREDUCTION as NUMBER(30, 2)) AS montantapRed,
    cast(cg.MONTANTHTSIMPLE as NUMBER(30, 2)),
    cast(
        nvl(cg.MONTANT + cg.MONTANTREDUCTION, 0) as NUMBER(30, 2)
    ) as montantsansreduction
from
    FACTURE_CLIENT_UNION_PROF fcu
    LEFT JOIN CAFCFILLECOMPLET_GRPPROF2 cg ON fcu.ID = cg.IDMERE;
	
	

CREATE OR REPLACE  VIEW "FACTURE_CLIENT_UNION_PROF" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "MONTANTPAYE", "MONTANTRESTE", "TIERSLIB", "CONTACT", "ADRESSE", "IDPREVISION", "ESCALE", "ETATLIB", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "MONTANTTTCVRAI", "ARMATEURLIB", "EXERCICE", "IDAVOIR", "POURCOMPTE", "POURCOMPTELIB", "ARMATEUR", "PAIEMENT", "PAIEMENTLIB", "LHT", "LM", "TE", "JNT", "DATEDEPART", "HEUREDEPART", "DATEARRIVEE", "HEUREARRIVEE", "BATEAU", "BATEAULIB", "PROVENANCE", "PROVENANCELIB", "DESTINATION", "DESTINATIONLIB", "PAVILLON", "PAVILLONLIB", "NOMCLT", "ADRCLT", "NMSTTCLT", "TELCLT", "NIF", "RC", "DTTP", "TP", "DTQUIT", "QUIT", "CDCLT") AS 
  SELECT
            ID,
            DATY,
            TIERS,
            DESIGNATION,
            TYPE,
            CAST(TVA AS NUMBER(20, 2)) AS TVA,
            REMARQUE,
            IDUSER,
            DATE_ECHEANCE,
            CAST(ETAT AS NUMBER(10)) AS ETAT,
            CAST(MONTANT AS NUMBER(32, 2)) AS MONTANT,
            CAST(MONTANTTVA AS NUMBER(32, 2)) AS MONTANTTVA,
            CAST(MONTANTAVOIR AS NUMBER(32, 2)) AS MONTANTAVOIR,
            CAST(CASE
                WHEN ABS(MONTANTRESTE) < 50
                AND MONTANTRESTE != 0 THEN MONTANTPAYE 
                ELSE MONTANTTTC 
            END  AS NUMBER(32, 2))AS MONTANTTTC,
            CAST(MONTANTPAYE AS NUMBER(32, 2)) AS MONTANTPAYE,
            CAST(CASE
                WHEN ABS(MONTANTRESTE) < 50
                AND MONTANTRESTE != 0 THEN MONTANTPAYE - MONTANTPAYE --here
                ELSE MONTANTRESTE
            END  AS NUMBER(32, 2)) AS MONTANTRESTE,
            TIERSLIB,
            CONTACT,
            ADRESSE,
            IDPREVISION,
            ESCALE,
            CASE
                  WHEN ETAT = 1 THEN 'CREE(E)'
                  WHEN ETAT = 11 THEN 'VISE(E)'
            END AS ETATLIB,
            TYPELIB,
            IDCATEGORIE,
            CATEGORIELIB,
            IDPROVISION,
            IDPROVISIONLIB,
            DEVISEMERE,
            CODEPRESTATION,
            CODEPRESTATIONLIB,
            CODE,
            ESTMICTSL,
            CODEPROVISION,
            CAST(MONTANTTTCVRAI AS NUMBER(32, 2)) AS MONTANTTTCVRAI,
            ARMATEURLIB,
            EXERCICE,
            IDAVOIR,
            POURCOMPTE,
            POURCOMPTELIB,
            ARMATEUR,
            PAIEMENT,
            PAIEMENTLIB,
            CAST (LHT AS NUMBER(10, 2)) AS LHT,
            CAST (LM AS NUMBER(10, 2)) AS LM,
            CAST (TE AS NUMBER(10, 2)) AS TE,
            CAST (JNT AS NUMBER(10, 2)) AS JNT,
            DATEDEPART,
            HEUREDEPART,
            DATEARRIVEE,
            HEUREARRIVEE,
            BATEAU,
            BATEAULIB,
            PROVENANCE,
            PROVENANCELIB,
            DESTINATION,
            DESTINATIONLIB,
            PAVILLON,
            PAVILLONLIB,
            NOMCLT,
            ADRCLT,
            NMSTTCLT,
            TELCLT,
            NIF,
            RC,
            DTTP,
            TP,
            DTQUIT,
            QUIT,
            CDCLT
        FROM
            FACTURECLIENTMSUM_LIBPROF;
			


CREATE OR REPLACE  VIEW "FCFILLECOMPLETPROF2" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "RANG", "DUREE", "MONTANTAV", "RUBRIQUECPL", "DATY", "TIERS", "IDCATEGORIE", "TYPE", "DEVISEMERE", "EXERCICE", "IDAVOIR", "ETAT", "MTAVOIR", "MONTANTREDUCTION", "MONTANTMAJORATION", "MONTANT", "MONTANTTVA", "MONTANTTTC", "MOISLIB", "MONTANTHTSIMPLE", "CLIENT", "MONTANTAVOIRAVECTSAUX", "MONTANTAVTTCAVECTAUX", "MONTANTAVTVAAVECTAUX", "CODE", "DATEFACTUREFILLE") AS 
  SELECT
    fcf.ID,
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
    EXTRACT(
        MONTH
        FROM
            fc.DATY
    ) AS mois,
    EXTRACT(
        YEAR
        FROM
            fc.DATY
    ) AS annee,
    fcf.HEUREDEBUT,
    fcf.HEUREFIN,
    fcf.REDUCTION,
    fcf.MAJORATION,
    fcf.TEST,
    fcf.RANG,
    fcf.DUREE,
    fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) AS montantAV,
    DECODE(fcf.rubrique, NULL, a.rubrique, fcf.rubrique) AS rubriquecpl,
    fc.daty,
    fc.tiers,
    fc.idcategorie,
    fc.TYPE,
    fc.devisemere,
    fc.exercice,
    FC.IDAVOIr,
    fc.etat,
    NVL(AV.montantsanstaux, 0) AS mtavoir,
    fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.REDUCTION, 0) / 100 AS montantReduction,
    fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.MAJORATION, 0) / 100 AS montantMajoration,
    fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) + (
        fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.MAJORATION, 0)
    ) / 100 - (
        fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.REDUCTION, 0)
    ) / 100 AS montant,
    (
        fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) + (
            fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.MAJORATION, 0)
        ) / 100 - (
            fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.REDUCTION, 0)
        ) / 100
    ) * NVL(fcf.tva / 100, 0) AS montanttva,
    (
        fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) + (
            fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.MAJORATION, 0)
        ) / 100 - (
            fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.REDUCTION, 0)
        ) / 100
    ) * (1 + NVL(fcf.tva / 100, 0)) AS montantttc,
    m.VAL AS moislib,
    f.MONTANTHTSIMPLE,
    t.nomclt,
    CAST(nvl(av.montantavectsaux, 0) AS NUMBER (30, 3)) AS montantavoiravectsaux,
    CAST(nvl(av.MONTANTTTC, 0) AS NUMBER (30, 3)) as montantavTTCavecTaux,
    CAST(nvl(av.MONTANTTVA, 0) AS NUMBER (30, 3)) as montantavTVAavecTaux,
    fc.code,
    fcf.daty AS datefacturefille
FROM
    facture_client_fille_prof fcf
    JOIN factureclient_prof fc ON fcf.idmere = fc.id
    LEFT JOIN activite_prof a ON a.id = fcf.idactivite
    LEFT JOIN AVOIRFCAVECTAUX_GRP av ON AV.IDDETAILFACTURE = fcf.id
    LEFT JOIN mois m ON m.ID = EXTRACT(
        MONTH
        FROM
            fc.DATY
    )
    LEFT JOIN facture_client_filleTTC_prof f ON f.ID = fcf.ID
    left join client_union t on fc.TIERS = t.cdclt;
	


CREATE OR REPLACE  VIEW  "FACTURE_CLIENT_FILLETTC_PROF" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "MONTANTHTSIMPLE", "MONTANTMAJ", "MONTANTRED", "MONTANTNET", "MONTANTTVA", "MONTANTTTC", "DUREE") AS 
  select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.MONTANTMAJ,
       ff.MONTANTRED,
       ff.MONTANTNET,
       ff.MONTANTTVA,
       cast(montantNET + montantTVA as number(30, 3)) as montantTTC,
       ff.DUREE
from FACTURE_CLIENT_FILLETVA_PROF ff;



CREATE OR REPLACE  VIEW "FACTURE_CLIENT_FILLETVA_PROF" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "MONTANTHTSIMPLE", "MONTANTMAJ", "MONTANTRED", "MONTANTNET", "DUREE", "MONTANTTVA") AS 
  select ff."ID",
       ff."IDMERE",
       ff."DESIGNATION",
       ff."QUANTITE",
       ff."PU",
       ff."COMPTE",
       ff."IDPRODUIT",
       ff."DEVISE",
       ff."TAUX",
       ff."IDACTIVITE",
       ff."TVA",
       ff."DATEFACT",
       ff."RUBRIQUE",
       ff."MOIS",
       ff."ANNEE",
       ff."HEUREDEBUT",
       ff."HEUREFIN",
       ff."REDUCTION",
       ff."MAJORATION",
       ff."TEST",
       ff."MONTANTHTSIMPLE",
       ff."MONTANTMAJ",
       ff."MONTANTRED",
       ff."MONTANTNET",
       ff.DUREE,
       cast((montantNET * tva) / 100 as number(30, 3)) as montantTVA
from facture_client_filleNet_PROF ff;


CREATE OR REPLACE  VIEW "FACTURE_CLIENT_FILLENET_PROF" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "MONTANTHTSIMPLE", "MONTANTMAJ", "MONTANTRED", "MONTANTNET", "DUREE") AS 
  select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.MONTANTMAJ,
       ff.MONTANTRED,
       cast(montantHTSimple + montantMaj - montantRed as number(30, 3)) as montantNET,
       ff.DUREE
from facture_client_filleMR_PROF ff;


CREATE OR REPLACE  VIEW "FACTURE_CLIENT_FILLEMR_PROF" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "MONTANTHTSIMPLE", "DUREE", "MONTANTMAJ", "MONTANTRED") AS 
  select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.DUREE,
       cast((montantHTSimple * majoration) / 100 as number(30, 3)) as montantMaj,
       cast((montantHTSimple * reduction) / 100 as number(30, 3))  as montantRed
from facture_client_filleHT_PROF ff;


CREATE OR REPLACE  VIEW "FACTURE_CLIENT_FILLEHT_PROF" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "MONTANTHTSIMPLE", "DUREE") AS 
  select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       cast(ff.quantite * ff.pu * nvl(ff.duree, 1) as number(30, 3)) as montantHTSimple,
       ff.DUREE
from facture_client_fille_prof ff;


CREATE OR REPLACE VIEW "FACTURECLIENTVALIDEIMP_PROF" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "MONTANTPAYE", "MONTANTRESTE", "TIERSLIB", "CONTACT", "ADRESSE", "IDPREVISION", "ESCALE", "ETATLIB", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "MONTANTTTCVRAI", "ARMATEURLIB", "EXERCICE", "TYPECLIENTLIB", "POURCOMPTE", "POURCOMPTELIB", "CODEFILTRE", "PAIEMENT", "PAIEMENTLIB", "LHT", "LM", "TE", "JNT", "DATEDEPART", "HEUREDEPART", "DATEARRIVEE", "HEUREARRIVEE", "BATEAU", "BATEAULIB", "PROVENANCE", "PROVENANCELIB", "DESTINATION", "DESTINATIONLIB", "PAVILLON", "PAVILLONLIB", "NOMCLT", "ADRCLT", "NMSTTCLT", "TELCLT", "NIF", "RC", "DTTP", "TP", "DTQUIT", "QUIT", "CDCLT", "MONTANTAPRED", "MONTANTHTSIMPLE", "MONTANTSANSREDUCTION") AS 
  SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       cast(fc.TVA as number(30, 2))                                   as TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(fc.MONTANT as NUMBER(30, 2))                               as MONTANT,
       cast(fc.MONTANTTVA as NUMBER(30, 2))                            as MONTANTTVA,
       cast(fc.MONTANTAVOIR as NUMBER(30, 2))                          as MONTANTAVOIR,
       cast(fc.MONTANTTTC as NUMBER(30, 2))                            as MONTANTTTC,
       cast(fc.MONTANTPAYE as NUMBER(30, 2))                           as MONTANTPAYE,
       cast(fc.MONTANTRESTE as NUMBER(30, 2))                          as MONTANTRESTE,
       fc.TIERSLIB,
       fc.CONTACT,
       fc.ADRESSE,
       fc.IDPREVISION,
       fc.ESCALE,
       fc.ETATLIB,
       fc.TYPELIB,
       fc.IDCATEGORIE,
       fc.CATEGORIELIB,
       fc.IDPROVISION,
       fc.IDPROVISIONLIB,
       fc.DEVISEMERE,
       fc.CODEPRESTATION,
       fc.CODEPRESTATIONLIB,
       fc.CODE,
       ESTMICTSL,
       CAST(fc.MONTANTTTCVRAI AS NUMBER(35, 2))                        AS MONTANTTTCVRAI,
       fc.ARMATEURLIB,
       EXERCICE,
       nvl(fc.typelib, '-')                                            as typeclientlib,
       fc.pourcompte,
       fc.pourcomptelib,
       fc.code                                                         as codeFiltre,
       fc.paiement,
       fc.paiementlib,
       cast(fc.LHT as NUMBER(30, 2))                                   AS LHT,
       cast(fc.LM as NUMBER(30, 2))                                    AS LM,
       cast(fc.TE as NUMBER(30, 3))                                    AS TE,
       cast(fc.JNT as NUMBER(30, 2))                                   AS JNT,
       fc.datedepart,
       fc.heuredepart,
       fc.datearrivee,
       fc.heurearrivee,
       fc.bateau,
       fc.bateaulib,
       fc.provenance,
       fc.provenancelib,
       fc.destination,
       fc.destinationlib,
       fc.pavillon,
       fc.pavillonlib,
       fc.nomclt,
       fc.adrclt,
       fc.nmsttclt,
       fc.telclt,
       fc.nif,
       fc.rc,
       fc.dttp,
       fc.tp,
       fc.dtquit,
       fc.quit,
       fc.cdclt,
       cast(cg.MONTANTREDUCTION as NUMBER(30, 2))                      AS montantapRed,
       cast(cg.MONTANTHTSIMPLE as NUMBER(30, 2)),
       cast(nvl(cg.MONTANT + cg.MONTANTREDUCTION, 0) as NUMBER(30, 2)) as montantsansreduction
FROM FACTURE_CLIENT_UNION_PROF fc
         LEFT JOIN CAFCFILLECOMPLET_GRPPROF2 cg ON fc.ID = cg.IDMERE;
		 
		 


CREATE OR REPLACE  VIEW "PREVISIONLIBCOMPLETPDF_PROF" ("ID", "DATE_RADE", "PROVENANCE", "NAVIRE", "CONSIGNATAIRE", "CARGAISON", "PILOTE", "DATE_ARRIVEE", "HEURE_ARRIVEE", "DATE_DEPART", "HEURE_DEPART", "DESTINATION", "ETAT", "QUAIPROVENANCE", "VALQUAISPROVENANCE", "PAYSPROVENANCE", "VALPAYSPROVENANCE", "QUAIDESTINATION", "VALQUAISDESTINATION", "PAYSDESTINATION", "VALPAYSDESTINATION", "INTERNEPOVENANCE", "LONGUEURPROVENANCE", "TIRANTPROVENANCE", "PROFONDEURPROVENANCE", "REFERENCENAVIRE", "NOMNAVIRE", "PAVILLONNAVIRE", "JNTNAVIRE", "JBTNAVIRE", "PLTNAVIRE", "LHTNAVIRE", "LMNAVIRE", "TENAVIRE", "VOLUMENAVIRE", "REMARQUENAVIRE", "ETATNAVIRE", "VALCONSIGNATAIRE", "DESCECONSIGNATAIRE", "VALCARGAISON", "DESCECARGAISON", "VALPILOTE", "DESCEPILOTE", "INTERNEDESTINATION", "LONGUEURDESTINATION", "TIRANTDESTINATION", "PROFONDEURDESTINATION", "DESCEPROVENANCE", "DESCEDESTINATION", "VALTYPEQUAISPROVENANCE", "DESCETYPEQUAISPROVENANCE", "VALTYPEQUAISDESTINATION", "DESCETYPEQUAISDESTINATION", "DESCEQUAISPROVENANCE", "DESCEQUAISDESTINATION", "TYPEQUAISPROVENANCE", "TYPEQUAISDESTINATION", "TYPENAVIRE", "TYPENAVIRELIB", "ESCALE", "NOVOYAGE", "ARMATEUR", "ARMATEURLIB", "MAJORATION", "REDUCTION", "PAVILLONLIB", "DESIGNATION", "CODE", "TONNAGE") AS 
  SELECT pre.ID,
          pre.date_rade,
          pre.provenance,
          pre.navire,
          pre.consignataire,
          pre.cargaison,
          pre.pilote,
          pre.date_arrivee,
          pre.heure_arrivee,
          pre.date_depart,
          pre.heure_depart,
          esca.DESTINATION as destination,
          pre.etat,
          pro.QUAI AS QUAIPROVENANCE,
          q.VAL AS valquaisprovenance,
          q.PAYS AS paysprovenance,
          pa.VAL AS valpaysprovenance,
          pr.QUAI AS QUAIDESTINATION,
          q1.val AS valquaisdestination,
          q1.PAYS AS paysdestination,
          pa1.VAL AS valpaysdestination,
          pro.INTERNE AS INTERNEPOVENANCE,
          q.LONGUEUR AS longueurprovenance,
          q.TIRANT AS tirantprovenance,
          q.PROFONDEUR AS profondeurprovenance,
          na.REFERENCE AS referencenavire,
          na.NOM AS nomnavire,
          na.PAVILLON AS pavillonnavire,
          na.JNT AS jntnavire,
          na.JBT AS jbtnavire,
          na.PLT AS pltnavire,
          na.LHT AS lhtnavire,
          na.LM AS lmnavire,
          na.TE AS tenavire,
          na.VOLUME AS volumenavire,
          na.REMARQUE AS remarquenavire,
          na.ETAT AS etatnavire,
          con.NOMCLT AS valconsignataire,
          con.ADRCLT AS desceconsignataire,
          car.VAL AS valcargaison,
          car.DESCE AS descecargaison,
          pi.VAL AS valpilote,
          pi.DESCE AS descepilote,
          pr.INTERNE AS INTERNEDESTINATION,
          q1.LONGUEUR AS longueurdestination,
          q1.TIRANT AS tirantdestination,
          q1.PROFONDEUR AS profondeurdestination,
          pa.DESCE AS desceprovenance,
          pa1.DESCE AS descedestination,
          t.VAL AS valtypequaisprovenance,
          t.DESCE AS descetypequaisprovenance,
          t2.val AS valtypequaisdestination,
          t2.DESCE AS descetypequaisdestination,
          q.DESCE AS descequaisprovenance,
          q1.DESCE AS descequaisdestination,
          q.TYPEQUAIS AS typequaisprovenance,
          q1.TYPEQUAIS AS typequaisdestination,
          na.TYPE AS typenavire,
          tn.VAL AS typenavirelib,
          pre.escale,
          pre.NOVOYAGE,
          pre.ARMATEUR,
          cons.NOMCLT AS ARMATEURLIB,
          0 AS majoration,
          0 AS reduction,
          pay.val AS pavillonlib,
          CAST ('' AS VARCHAR2 (500)) AS DESIGNATION,
          CAST ('' AS VARCHAR2 (500)) AS CODE,
          pre.TONNAGE
     FROM PREVISION_PROF pre
          LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
          LEFT JOIN NAVIRE na ON na.id = pre.NAVIRE
          LEFT JOIN PAYS pay ON pay.id = na.pavillon
          LEFT JOIN clientmat con ON con.CDCLT = pre.CONSIGNATAIRE
          LEFT JOIN CARGAISON car ON car.id = pre.CARGAISON
          LEFT JOIN commandant pi ON pi.ID = pre.PILOTE
          left join MOUVEMENTDEPART_ESCPROF esca on esca.ESCALE=pre.id
          LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = esca.DESTINATION
          LEFT JOIN QUAIS q ON q.id = pro.QUAI
          LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
          LEFT JOIN PAYS pa ON pa.id = q.PAYS
          LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
          LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
          LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
          LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
          LEFT JOIN clientmat cons ON cons.CDCLT = pre.ARMATEUR;
		  


CREATE OR REPLACE VIEW "PREVISIONFICHEPROF" ("ID", "NOMNAVIRE", "VALCONSIGNATAIRE", "VALCARGAISON", "VALPILOTE", "VALQUAISPROVENANCE", "VALPAYSPROVENANCE", "VALQUAISDESTINATION", "VALPAYSDESTINATION", "DATE_ARRIVEE", "HEURE_ARRIVEE", "DATE_DEPART", "HEURE_DEPART", "ETAT", "TYPE", "ESCALE", "NOVOYAGE", "IDNAVIRE", "ARMATEUR", "ARMATEURLIB", "TONNAGE") AS 
  select id
     , nomnavire
     , valconsignataire
     , valcargaison
     , valpilote
     , valquaisprovenance
     , valpaysprovenance
     , valquaisdestination
     , valpaysdestination
     , date_arrivee
     , heure_arrivee
     , date_depart
     , heure_depart
     , etat
     , typenavirelib as type
     , ESCALE
     , NOVOYAGE
     , NAVIRE        as idnavire
     , ARMATEUR
     , ARMATEURLIB
     , TONNAGE
from PREVISIONLIBCOMPLETPROF;