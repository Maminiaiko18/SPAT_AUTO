update AVOIRFF set CATEGORIE='CT001X' ;
alter table AVOIRFF drop constraint FK_AVOIRFF_CATEGORIEAVOIRFC;
alter table AVOIRFF add constraint FK_AVOIRFF_CATEGORIEAVOIRFF foreign key (CATEGORIE) references CATEGORIEAVOIRFF(id);

create view rubrique_MICTSL as
select * from rubrique_activite where categorie='CATFC002' and volume is not null;



alter table avoirff drop constraint FK_AVOIRFF_MOTIFAVOIRFC;

create view facture_fourn_mere_vide as
select cast('' as varchar2(500))  as id,
       cast('' as date)           as daty,
       cast('' as varchar2(100))  as tiers,
       cast('' as varchar2(1000)) as designation,
       cast('' as varchar2(500))  as type,
       cast('' as varchar2(1000)) as remarque,
       cast('' as varchar2(200))  as code,
       cast(0 as number(30, 3))   as montant
from DUAL;


alter table as_bondelivraison drop constraint AS_BON_FK;
alter table as_bondelivraison add constraint fk_as_bonliv_factfournmere foreign key (IDBC) references FACTURE_FOURNISSEUR_MERE(id);



CREATE OR REPLACE VIEW FACTFOURN_MONTANT
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDPROVISION, IDCATEGORIE, MONTANT, MONTANTTAUX,
             MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MAJORATION, REDUCTION, MONTANTMAJORATION, MONTANTREDUCTION,
             IDACTIVITE, DATEFACT, RUBRIQUE)
AS
SELECT fm.ID,
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
       CAST(fm.pu * fm.quantite AS NUMBER(30, 3))                                             AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3))
                                                                                              AS montanttaux,
       NVL(montantsanstaux, 0)                                                                AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 3))
                                                                                              AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)                                                                  as MAJORATION,
       NVL(fm.REDUCTION, 0)                                                                   as REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3)) as montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) AS NUMBER(30, 3))  as montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirffavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;


alter table facture_fournisseur_mere add idBL varchar2(100) constraint fk_factfournmere_asbondeliv references AS_BONDELIVRAISON(id);
alter table facture_fournisseur_fille add idBLF varchar2(100) constraint fk_factfournfille_asbondelivfi references AS_BONDELIVRAISON_FILLE(id);


CREATE OR REPLACE VIEW FACTFOURN_FILLE_PLUS
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, MONTANT, TVA, IDACTIVITE, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION, IDBLF)
AS
SELECT f.ID,
       f.IDMERE,
       f.DESIGNATION,
       f.QUANTITE,
       f.PU,
       f.COMPTE,
       f.IDPRODUIT,
       f.DEVISE,
       f.TAUX,
       CAST(0.0 AS NUMBER(30, 3)) AS montant,
       f.tva,
       f.IDACTIVITE,
       f.DATEFACT,
       f.RUBRIQUE,
       f.MOIS,
       f.ANNEE,
       f.HEUREDEBUT,
       f.HEUREFIN,
       f.MAJORATION,
       f.REDUCTION,
       f.IDBLF
FROM FACTURE_FOURNISSEUR_FILLE f
WHERE 1 > 2;


INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MEDI0001270', 'Import Excel', 'fa fa-edit', '/spat/pages/globalnegoce.jsp?but=import/ImportExcel.jsp', 4,
        3, 'MDO000004');
