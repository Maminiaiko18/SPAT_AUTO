 CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE, CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE, DATEFACT, POSTE, POSTELIB, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, VOLUME, VOLUMEARRONDI, CARGAISON, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, SURFACE, NB5JOURS, QUAI, FLOTTE, CATEGORIE_FLOTTE, UNITELIB, ESTPETROLIER) AS
  SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         as navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,

       ra.CATEGORIE,
       cf.val                                        as categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               as DATEFACT,
       ac.POSTE,
       pd.VALQUAIS                                   as postelib,
       ac.DATEDEBUT,
       ac.HEUREDEBUT,
       ac.DATEFIN,
       ac.HEUREFIN,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       nvl(pre.cargaison,'-') as cargaison,

       pre.id                                        AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       CASE
           WHEN ac.heuredebut BETWEEN '05:00:00' AND '19:00:00'
               THEN
               'JOUR'
           ELSE
               'NUIT'
           END
                                                     AS estJour,
       CASE
           WHEN ac.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                     AS estFerie,
       occ.idmanoeuvrebord                           AS manoeuvre,
       CASE
           WHEN TO_CHAR(ac.daty, 'DAY') = 'DIMANCHE'
               OR TO_CHAR(ac.daty, 'DAY') = 'SAMEDI'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                     AS estWeekend,
       occ.IDNATUREOPERATION                         AS natureoperation,
       CASE
           WHEN ((60 * 24 * (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                             to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) - 60) / 15 < 0
               THEN
               0
           ELSE
               ROUND(((60 * 24 * (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                                  to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) - 60) / 15)
           END
                                                     AS nbQuartHeure,
       CASE
           WHEN 24 * (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) < 0 THEN 0
           ELSE ROUND(24 * (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                            to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')))
           END
                                                     AS nbHeure,
       CASE
           WHEN (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                 to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) < 0 THEN 0
           WHEN round((to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                       to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) = 0 THEN 1
           ELSE case when round(to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))<round((to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')),1) then round(to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))+1
               else round(to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) end
           END
                                                     AS nbJour,
       q.typequais,
       cast(nv.LHT * nv.lm as NUMBER(20, 2))         as surface,
       CASE
           WHEN (to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                 to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) < 0 THEN 0
           ELSE case
                    when round((to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                                to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss'))) between 0 and 5
                        then 1
                    else round(trunc((to_date(ac.DATEFIN || ' ' || ac.HEUREFIN, 'dd-mm-yy hh24:mi:ss') -
                                      to_date(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT, 'dd-mm-yy hh24:mi:ss')) / 5) + 1)
               end
           END                                       as nb5jours,
       pd2.QUAI,
       occ.IDMATERIEL_NAVAL                          as flotte,
       cm.IDCATEGORIE                                as categorie_flotte,
       ua.VAL                                        as unitelib,
       case
           when nv.TYPE = 'TP0001' then 'TRUE'
           else 'FALSE' end                          as estPetrolier
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf on ra.categorie = cf.id
         left join PREVISION pre on pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         left join POSTEDESTINATAIRELIBCOMPLET pd on pd.ID = ac.POSTE
         left join UNITE_ACTIVITE ua on ua.ID = ra.UNITE
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
         LEFT JOIN occupationmaterielnaval occ ON occ.id = ac.REFOBJET
         left join MATERIEL_NAVAL cm on cm.id = occ.IDMATERIEL_NAVAL;

create view factureClientDetailsValide as
select *
from FACTURE_CLIENT_MONTANTTC
    where IDMERE not in (select id from ProvisionFactureDefinitive);
	
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MEDI0001259', 'Edition MICTSL', 'fa fa-edit', '/spat/pages/globalnegoce.jsp?but=facture/edition-mictsl.jsp', 7, 2, 'MEN0002');

INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MEDI002135', 'Etat de provision', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=facture/etat-provision.jsp', 6, 3, 'MEN00068');

INSERT INTO SPAT_CAPITAINERIE.MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MEDI000324', 'Categorie Facture Client', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=categorieFC', 12, 3, 'MEN00505');


CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_VM
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE,MOIS,ANNEE,TIERS)
AS
select fcf.ID,
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
       mois,
       ANNEE,
       TIERS
from facture_client_fille fcf
         join factureclient fc on fcf.IDMERE = fc.ID
where fc.etat >= 11;

CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_VM
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, TIERS)
AS
select fcf.ID,
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
       mois,
       ANNEE,
       TIERS
from facture_client_fille fcf
         join factureclient fc on fcf.IDMERE = fc.ID
where fc.etat >= 11;


CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANTTC
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX,
             MONTANTAVOIRAVECTAUX, MONTANTTVA, MONTANTTAXE, MONTANTTC)
AS
select fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       fc.IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATIONMERE,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       fc.MONTANT,
       fc.MONTANTTAUX,
       fc.MONTANTAVOIRSANSTAUX,
       fc.MONTANTAVOIRAVECTAUX,
       cast((fc.pu * QUANTITE * fc.TVA) / 100 as NUMBER(20, 2))                      as montanttva,
       cast((fc.pu * QUANTITE * fc.TVA) / 100 as NUMBER(20, 2))                      as montanttaxe,
       cast((fc.pu * QUANTITE) + (fc.pu * QUANTITE * fc.TVA) / 100 as NUMBER(20, 2)) as montanttc
from facture_client_montant fc;


create or replace view FACTURE_CLIENT_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT,IDCATEGORIE,IDPROVISION,IDPREVISION)
as
SELECT fi."ID",
       fi."IDMERE",
       fi."DESIGNATION",
       fi."QUANTITE",
       fi."PU",
       fi."COMPTE",
       fi."IDPRODUIT",
       fi."DEVISE",
       fi."TAUX",
       fc.daty,
       fc.tiers,
       fc.designation AS designationmere,
       fc.TYPE,
       decode(fi.tva, null, fc.tva, fi.tva),
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.IDPREVISION
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;
		 


create or replace view FACTURE_CLIENT_MONTANT as
select fm.ID,
       fm.IDMERE,
       fm.DESIGNATION,
       fm.QUANTITE,
       fm.PU,
       fm.COMPTE,
       fm.IDPRODUIT,
       fm.DEVISE,
       fm.TAUX,
       fm.DATY,
       fm.TIERS,
       fm.DESIGNATIONMERE,
       fm.TYPE,
       fm.TVA,
       fm.REMARQUE,
       fm.IDUSER,
       fm.DATE_ECHEANCE,
       fm.ETAT,
       IDPREVISION,
       IDPROVISION,
       IDCATEGORIE,
       cast(fm.pu * fm.quantite as number(30, 2))                 as Montant,
       cast((fm.pu * fm.quantite) * fm.taux as NUMBER(30, 2))     as montanttaux,
       nvl(montantsanstaux, 0)                                    as montantavoirsanstaux,
       cast(nvl((montantsanstaux * fm.TAUX), 0) as number(30, 2)) as montantavoiravectaux
from facture_client_Mere_fille fm
         left join avoirfcavectaux_grp grp on grp.IDDETAILFACTURE = fm.ID;
		 
CREATE OR REPLACE VIEW FACTURE_CLIENT_ENARTIARY
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS,
             DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION,
             IDPREVISION, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MONTANTTVA,
             MONTANTTAXE, MONTANTTC, MONTANTPAYEPOURC, MONTANTPAYE,montantreste)
AS
select fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       fc.IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATIONMERE,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.IDPREVISION,
       fc.MONTANT,
       fc.MONTANTTAUX,
       fc.MONTANTAVOIRSANSTAUX,
       fc.MONTANTAVOIRAVECTAUX,

       cast((fc.MONTANTTAUX * fc.TVA) / 100 as NUMBER(20, 2))                    as montanttva,
       cast((fc.pu * fc.QUANTITE * fc.TVA) / 100 as NUMBER(20, 2))               as montanttaxe,
       cast((fc.MONTANTTAUX) + (fc.MONTANTTAUX * fc.TVA) / 100 as NUMBER(20, 2)) as montanttc,
       nvl(mf.MONTANTPAYEPOURC, 0),
       nvl(mf.MONTANTPAYE, 0),
       cast((fc.MONTANTTAUX) + (fc.MONTANTTAUX * fc.TVA) / 100 as NUMBER(20, 2))-nvl(mf.MONTANTPAYE, 0) as montantreste
from facture_client_montant fc
         left join FACTURE_CLIENT_MEREF_paye mf on mf.id = fc.ID;

create or replace view factureClientDetailsValide as
select *
from FACTURE_CLIENT_ENARTIARY
where IDMERE not in (select id from ProvisionFactureDefinitive);



CREATE OR REPLACE VIEW FACTURE_CLIENT_ENARTIARY
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS,
             DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION,
             IDPREVISION, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MONTANTTVA,
             MONTANTTAXE, montantavoir, MONTANTTC, MONTANTPAYEPOURC, MONTANTPAYE, montantreste)
AS
select fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       fc.IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATIONMERE,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.IDPREVISION,
       fc.MONTANT,
       fc.MONTANTTAUX,
       fc.MONTANTAVOIRSANSTAUX,
       fc.MONTANTAVOIRAVECTAUX,

       cast((fc.MONTANTTAUX * fc.TVA) / 100 as NUMBER(20, 2)) as      montanttva,
       cast((fc.pu * fc.QUANTITE * fc.TVA) / 100 as NUMBER(20, 2)) as montanttaxe,
       cast(fc.MONTANTAVOIRAVECTAUX as NUMBER(20, 2)) as              montantavoir,
       cast(((fc.MONTANTTAUX) + (fc.MONTANTTAUX * fc.TVA) / 100) -
            fc.MONTANTAVOIRAVECTAUX as NUMBER(20, 2)) as              montanttc,
       nvl(mf.MONTANTPAYEPOURC, 0),
       nvl(mf.MONTANTPAYE, 0),
       cast((fc.MONTANTTAUX) + (fc.MONTANTTAUX * fc.TVA) / 100 as NUMBER(20, 2)) -
       nvl(mf.MONTANTPAYE, 0) as                                      montantreste
from facture_client_montant fc
         left join FACTURE_CLIENT_MEREF_paye mf on mf.id = fc.ID;