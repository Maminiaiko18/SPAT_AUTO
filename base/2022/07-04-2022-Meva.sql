 CREATE OR REPLACE  VIEW "ECARTAVOIRFCPARFILLE" ("ID", "IDACTIVITE", "MONTANTTTC", "ECART", "ETAT") AS 
  select 
id , 
idactivite , 
montantavoiravectsaux
montantttc , 
(montantttc-montantavoiravectsaux) as ecart , 
etat
from FCFILLECOMPLET  ;


 CREATE OR REPLACE VIEW "ACTIVITESNONFACTUREES" ("ID", "DESIGNATION", "CLIENT", "RUBRIQUE", "QTE", "MOIS", "MOISLIB", "ANNEE", "DATY", "BATEAU", "ETAT", "RUBRIQUELIB", "NAVIRE", "BATEAULIB", "POIDS", "LONGUEUR", "LARGEUR", "AUTRES", "PU", "DEVISE", "COMPTE", "UNITE", "DIRECTION", "CONDITION", "TVA", "OBJET", "REDEVANCE", "CLIENTLIB", "REDEVANCELIB", "DIRECTIONLIB", "ETATLIB", "CATEGORIE", "CATEGORIELIB", "REFOBJET", "TYPESOURCE", "DATEFACT", "POSTE", "POSTELIB", "DATEDEBUT", "HEUREDEBUT", "DATEFIN", "HEUREFIN", "VOLUME", "VOLUMEARRONDI", "CARGAISON", "IDPRESTATION", "ESTNATIONAL", "ESTJOUR", "ESTFERIE", "MANOEUVRE", "ESTWEEKEND", "NATUREOPERATION", "NBQUARTHEURE", "NBHEURE", "NBJOUR", "TYPEQUAIS", "SURFACE", "NB5JOURS", "QUAI", "FLOTTE", "CATEGORIE_FLOTTE", "UNITELIB", "TAUX", "TIRANT") AS 

 SELECT ID,
          DESIGNATION,
          CLIENT,
          RUBRIQUE,
         cast(QTE as number(10,2)),
         cast(MOIS as number(10)),
          MOISLIB,
         cast(ANNEE as number(10)),
          DATY,
          BATEAU,
         cast(ETAT as NUMBER(10)),
          RUBRIQUELIB,
          NAVIRE,
          BATEAULIB,
         cast(POIDS as NUMBER(30,3)),
         cast(LONGUEUR as NUMBER(30,3)),
         cast(LARGEUR as NUMBER(30,3)),
          AUTRES,
          PU,
          DEVISE,
          COMPTE,
          UNITE,
          DIRECTION,
          CONDITION,
         cast(TVA as NUMBER(10,2)),
          OBJET,
          REDEVANCE,
          CLIENTLIB,
          REDEVANCELIB,
          DIRECTIONLIB,
          ETATLIB,
          CATEGORIE,
          CATEGORIELIB,
          REFOBJET,
          TYPESOURCE,
          DATEFACT,
          POSTE,
          POSTELIB,
          DATEDEBUT,
          HEUREDEBUT,
          DATEFIN,
          HEUREFIN,
          VOLUME,
          VOLUMEARRONDI,
          CARGAISON,
          IDPRESTATION,
          ESTNATIONAL,
          ESTJOUR,
          ESTFERIE,
          MANOEUVRE,
          ESTWEEKEND,
          NATUREOPERATION,
         cast(NBQUARTHEURE as NUMBER(20)),
         cast(NBHEURE as number(20)),
         cast(NBJOUR as NUMBER(20)),
          TYPEQUAIS,
          SURFACE,
         cast(NB5JOURS as NUMBER(20)),
          QUAI,
          FLOTTE,
          CATEGORIE_FLOTTE,
          UNITELIB,
         cast(TAUX as NUMBER(10,3)),
         cast(TIRANT as NUMBER(18,3))
     FROM ACTIVITELIBCOMPLET ac
    WHERE id not IN (select idactivite from ecartAvoirFCParFille where ecart = 0 and etat>=11 AND idactivite IS NOT null);


    CREATE OR REPLACE VIEW "FACTURE_CLIENT_FILLE_LIBELLE" ("ID", "IDMERE", "RUBRIQUE", "DESIGNATION", "PU", "QUANTITE", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "PRODUIT_LIB", "ACTIVITELIB", "DATEFACT", "RUBRIQUELIB", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "MAJORATION", "REDUCTION", "RANG", "DATY", "MONTANT", "DUREE", "IDRUBRIQUE") AS 
  SELECT fi.ID,
       fi.IDMERE,
       (fi.RUBRIQUE)                                                     as RUBRIQUE,
       fi.DESIGNATION,
       fi.PU,
       fi.QUANTITE,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fi.IDACTIVITE,
       fi.TVA,
       pr.nom                                                            AS produit_lib,
       ac.DESIGNATION                                                    AS activitelib,
       TO_DATE(fi.DATEFACT, 'dd/MM/YY')                                  AS DATEFACT,
       nvl(ra.DESIGNATION, r1.DESIGNATION)                               AS rubriquelib,
       fi.MOIS,
       fi.ANNEE,
       fi.HEUREDEBUT,
       fi.HEUREFIN,
       nvl(fi.MAJORATION, 0)                                             as MAJORATION,
       nvl(fi.REDUCTION, 0)                                              as REDUCTION,
       fi.rang                                                           as rang,
       case when fi.IDACTIVITE is not null then ac.datefin else fc.DATY end as daty,

       cast(fi.QUANTITE * NVL(fi.DUREE, 1) * fi.pu as number(30, 3))     AS MONTANT,
       fi.DUREE                                                          AS DUREE,
       ra.ID                                                             as idrubrique
FROM facture_client_fille_rangfinal fi
         LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
         LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = ac.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fi.RUBRIQUE
         LEFT JOIN FACTURECLIENT fc ON fc.ID = fi.IDMERE;



         