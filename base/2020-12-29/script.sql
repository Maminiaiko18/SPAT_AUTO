create table Projet
(
    id varchar2(100) constraint projet_pk primary key ,
    projet varchar2(500),
    section_budget varchar2(500),
    compte varchar2(500),
    montant_credit number(10,2),
    engage varchar2(200),
    liquide varchar2(200),
    paye number(10,2),
    exercice varchar2(100),
    designation varchar2(500),
    programme varchar2(500),
    activite varchar2(500),
    objectif varchar2(500),
    etat number(10)
);

CREATE SEQUENCE seq_Projet
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seq_Projet
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_Projet.nextval INTO retour FROM dual;
  return retour;
END;


 create table CodeEtablissement
    (
        id varchar2(100) constraint  codeetablissement_pk primary key ,
        val varchar2(500),
        desce varchar2(500)
    );

CREATE SEQUENCE seq_CodeEtablissement
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seq_CodeEtablissement
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_CodeEtablissement.nextval INTO retour FROM dual;
  return retour;
END;

 alter table as_bondecommande add projet varchar2(100) null constraint  as_bondecommande_projet_fk references Projet;
    alter table as_bondecommande add code_etab varchar2(100) null constraint  as_bondecommande_code_fk references CODEETABLISSEMENT;

create or replace view AS_BONDECOMMANDE_LIB as
        select bc.id,
       bc.daty,
       bc.etat,
        bc.remarque,
       bc.designation,
       mp.val as modepaiement,
       tr.nom AS FOURNISSEUR,
       bc.tva,
       bc.NUMBC,
       ce.val as CODE_ETAB,
       pe.designation as PROJET
from as_bondecommande bc
         join modepaiement mp on bc.modepaiement = mp.id
         JOIN tiers tr ON bc.fournisseur = tr.id
        left join CODEETABLISSEMENT ce on ce.id=bc.code_etab
        left join PROJET  pe on pe.id=bc.projet
/

create or replace view AS_BONDECOMMANDE_LIBELLE as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       mp.val as modepaiement,
       bc.fournisseur,
       bc.tva,
       bc.NUMBC,
       ce.val as CODE_ETAB,
       pe.designation as PROJET
from as_bondecommande bc
         join modepaiement mp on bc.modepaiement = mp.id
        left join CODEETABLISSEMENT ce on ce.id=bc.code_etab
        left join PROJET  pe on pe.id=bc.projet
/

create or replace view AS_BONDECOMMANDE_LIBELLECREE as
select *
from AS_BONDECOMMANDE_LIBELLE
where etat = 1
/

create or replace view AS_BONDECOMMANDE_LIBELLEVISE as
select *
from AS_BONDECOMMANDE_LIBELLE
where etat = 11
/


alter table contrat_chantier add tva  number(10,2);
alter table contrat_chantier add noContrat  number(10,2);
alter table contrat_chantier add projet varchar2(100) null constraint projet_contrat_fk references Projet;
alter table contrat_chantier add code_etab varchar2(100) null constraint code_etab_contrat references CodeEtablissement;


 create table historique_contrat
    (
        id varchar2(100) constraint  historique_contrat_pk primary key ,
        idcontrat varchar2(100) constraint historik_contrat_fk references CONTRAT_CHANTIER,
		daty date ,
        montant number(10,2)
    );

    
CREATE SEQUENCE seq_historique_contrat
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

  create or replace FUNCTION get_seq_historique_contrat
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_historique_contrat.nextval INTO retour FROM dual;
  return retour;
END;

create or replace view CONTRAT_CHANTIER_CPLSUM as
    select bc."ID",bc."IDCHANTIER",bc."DESIGNATION",bc."MONTANT",bc."PRESTATAIRE",bc."ETAT",
           ff.idfacture,
           nvl(op.montant, 0)                    as montant_paye,
           bc.montant - nvl(op.montant, 0)    as resteapaye,
           bc.TVA,
           bc.PROJET,
           bc.CODE_ETAB,
           bc.noContrat,
           ce.val as CODE_ETABLIB,
           pe.designation as PROJETLIB
    from ORDONNERPAYEMENTGROUPEFACT op
             join facturefournisseur_final ff on ff.idfacture = op.DED_ID
             right join CONTRAT_CHANTIER bc on bc.IDCHANTIER = ff.IDBL
            left join CODEETABLISSEMENT ce on ce.id=bc.code_etab
            left join PROJET  pe on pe.id=bc.projet;

create table avancement_contrat
(
    id          varchar2(100)
        constraint avancement_contrat_pk primary key,
    idcontrat   varchar2(100) CONSTRAINT AVANCEMENT_CONTRAT_fk references CONTRAT_CHANTIER,
    daty        date,
    pourcentage number(10, 2),
    observation varchar2(4000),
    etat        number(10)
);

CREATE SEQUENCE seq_avancement_contrat
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_avancement_contrat
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_avancement_contrat.nextval INTO retour FROM dual;
    return retour;
END;

    create table liaisonintratable (
        id varchar2(100) constraint  liaisonintratable_pk primary key ,
        id1 varchar2(100),
        id2 varchar2(100),
        montant number(10,2)
);

CREATE SEQUENCE seq_liaisonintratable
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seq_liaisonintratable
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_liaisonintratable.nextval INTO retour FROM dual;
  return retour;
END;



  ALTER TABLE factureFournisseur ADD projet varchar2(100) null constraint factureFournisseur_contrat_fk references projet;
ALTER TABLE factureFournisseur ADD code_etablissement varchar2(100) null constraint code_etablissement_contrat_fk references CodeEtablissement;
ALTER TABLE factureFournisseur ADD numeroOP varchar2(100) null ;

ALTER TABLE detailsfacturefournisseur ADD tva NUMBER(10,2);

CREATE SEQUENCE seqCodeEtablissement
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqCodeEtablissement
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqCodeEtablissement.nextval INTO retour FROM dual;
    return retour;
END;

create view avancement_contratlibcomplet as
    select ac.*,
            ch.DESIGNATION as IDCONTRATlib
        from avancement_contrat ac
        left join CONTRAT_CHANTIER ch on ch.id=ac.IDCONTRAT;


create or replace view CONTRAT_CHANTIER_LIB_COMPLET as
SELECT
	cc.*,
	c2.IDTRAVAUX AS IDTRAVAUX_chantier ,
	c2.NOM AS NOM_chantier ,
	c2.DATYDEBUT AS DATYDEBUT_chantier ,
	c2.DATYFIN AS DATYFIN_chantier ,
	c2.MONTANT AS MONTANT_chantier,
	c2.AVANCEMENT AS AVANCEMENT_chantier,
	c2.IDTIERS AS IDTIERS_chantier,
	c2.ETAT AS ETAT_chantier,
	t2.ID AS ID_PRESTATAIRE ,
	t2.NOM AS NOM_PRESTATAIRE,
	t2.DESCRIPTION AS DESCRIPTION_PRESTATAIRE,
	t2.NIF AS NIF_PRESTATAIRE,
	t2.STAT AS STAT_PRESTATAIRE,
	t2.CONTACT AS  CONTACT_PRESTATAIRE,
	t2.RESPONSABLE AS RESPONSABLE_PRESTATAIRE,
	t2.ADRESSE AS ADRESSE_PRESTATAIRE,
	t2."TYPE" AS TYPE_PRESTATAIRE,
	t2.ETAT AS ETAT_PRESTATAIRE,
    pr.DESIGNATION as projetlib,
    ce.VAL as code_etablib
FROM
	CONTRAT_CHANTIER cc
JOIN CHANTIER c2 ON
	cc.IDCHANTIER = c2.ID
JOIN TIERS t2 ON
	cc.PRESTATAIRE = t2.ID
left join PROJET pr on pr.id=cc.PROJET
left join CODEETABLISSEMENT ce on ce.id=cc.CODE_ETAB
/


create or replace view CONTRAT_CHANTIER_LIB_NOM as
SELECT
	ID ,
	IDCHANTIER ,
	DESIGNATION ,
	MONTANT ,
	NOM_PRESTATAIRE AS PRESTATAIRE ,
	ETAT ,
	NOM_CHANTIER,
    projetlib,
    code_etablib,
    TVA,
    NOCONTRAT
FROM CONTRAT_CHANTIER_LIB_COMPLET
/


alter table avoir drop constraint  FK_AVOIR_TYPE;


create or replace view AS_BONDECOMMANDE_LIBCREE as
SELECT*
FROM AS_BONDECOMMANDE_LIBELLE_lib
WHERE etat = 1
/


create or replace view AS_BONDECOMMANDE_libVISE as
SELECT*
FROM AS_BONDECOMMANDE_LIBELLE_lib
WHERE etat = 11
/

create OR REPLACE view facturefournisseur_analyse as
select ff.*,
       case WHEN ff.REMARQUE like '%CC%' THEN 'CAT'
            WHEN ff.REMARQUE like '%BL%' THEN 'BC'
            WHEN ff.REMARQUE like NULL THEN 'BC'
           END AS TYPEFACT
from ETATFACTUREMONTANTDATY ff;



create or replace view AS_BONDECOMMANDE_LIBELLE_LIB as
select bcl.id,
       bcl.daty,
       bcl.etat,
       bcl.remarque,
       bcl.designation,
       bcl.modepaiement,
       ti.NOM                                as fournisseur,
       bcl.tva,
       bcl.NUMBC,
       bc.montant,
       bc.montanttva,
       bc.montantttc,
       ff.idfacture,
       nvl(op.montant, 0)                    as montant_paye_reel,
       bc.montantttc - nvl(bl.montantttc, 0) as restepayergeneral,
       bc.montantttc - nvl(op.montant, 0)    as resteapayerreel,
       nvl(bl.montantttc, 0)                 as montant_a_payer,
       cast(0 as number(10, 2))              as montantfacture,
       '-'                                   as etatlib,
       BCL.PROJET,
       bcl.CODE_ETAB
from ORDONNERPAYEMENTGROUPEFACT op
         join facturefournisseur_final ff on ff.idfacture = op.DED_ID
         join BONLIVRAISON_FINAL_VISE bl on bl.numbl = ff.IDBL
         right join boncommande_final bc on bc.IDBC = bl.IDBC
         join AS_BONDECOMMANDE_LIBELLE bcl on bcl.ID = bc.idbc
         left join TIERS ti on ti.id = bcl.fournisseur
/

create or replace view AS_BONDECOMMANDE_LIBCREE as
SELECT*
FROM AS_BONDECOMMANDE_LIBELLE_lib
WHERE etat = 1
/


create or replace view AS_BONDECOMMANDE_libVISE as
SELECT*
FROM AS_BONDECOMMANDE_LIBELLE_lib
WHERE etat = 11
/

create or replace view ETATFACTUREMONTANTDATY as
SELECT et.id,
       et.daty,
       et.idfournisseur,
       et.nomfournisseur,
       et.idtva,
       et.remarque,
       et.dateemission,
       et.designation,
       et.iddevise,
       et.numfact,
       et.datyecheance,
       CASE
           WHEN et.etat = 'VALIDER' THEN '11'
           WHEN et.etat = 'CREER' THEN '1'
           ELSE '0'
           END                                                                      AS etat,
       et.montantpaye,
       et.montantnet+et.montanttva - nvl(op.montant,0)                                                        AS reste,
       et.entite,
       et.montantttdevise,
       et.budget,
       et.retenue,
       et.NUMID,
       t.NOM                                                                        as tierslib,
       et.IDTVA                                                                     as tva,
       et.montant,
       et.montantavoir,
       et.montantadditif,
       et.montantnet,
       et.montanttva,
        cast((et.montantnet) +Et.montanttva as number(25, 2)) as montantttc,
       cast((et.montantnet) +Et.montanttva as number(25, 2)) as montantTotalApayer,
       ff.TYPE
FROM etatfacturemontantdatyretenu et
         join facturefournisseur_SumMtt ff on ff.id = et.id
         left join TIERS t on t.id = et.idfournisseur
         left join ordonnerpayementgroupefact op on op.ded_id=et.id
/

create OR REPLACE view facturefournisseur_analyse as
select ff.*,
       case WHEN ff.REMARQUE like '%CC%' THEN 'CONTRAT'
            WHEN ff.REMARQUE like '%BL%' THEN 'BC'
            WHEN (ff.REMARQUE is null AND TYPE LIKE 'TPFF002' )THEN TY.VAL
           END AS TYPEFACTURE
from ETATFACTUREMONTANTDATY ff
        JOIN TYPEFF TY ON TY.ID=fF.TYPE;  


create OR REPLACE view DETAILSFACTUREFOURNISSEUR_MT as
SELECT DETAILSFACTUREFOURNISSEUR."ID",
       DETAILSFACTUREFOURNISSEUR."IDINGREDIENT",
       DETAILSFACTUREFOURNISSEUR."QTE",
       DETAILSFACTUREFOURNISSEUR."PU",
       DETAILSFACTUREFOURNISSEUR."IDMERE",
       DETAILSFACTUREFOURNISSEUR."COMPTE",
       DETAILSFACTUREFOURNISSEUR."PUDEVISE",
       DETAILSFACTUREFOURNISSEUR."IDDQE",
       DETAILSFACTUREFOURNISSEUR."MARGE",
       CAST(0 AS number(10, 2)) AS montant,
       DETAILSFACTUREFOURNISSEUR.TVA
FROM DETAILSFACTUREFOURNISSEUR
/

create view CONTRAT_CHANTIER_TRAVAUX AS
select cc.id, NOM_chantier as idchantier, DESIGNATION, cc.MONTANT, PRESTATAIRE, cc.ETAT, IDTRAVAUX
from CHANTIER ch
         join CONTRAT_CHANTIER_LIB_COMPLET cc on ch.ID = cc.IDCHANTIER
         join TRAVAUX tr on tr.id = ch.IDTRAVAUX;



create view FACTUREFOURNISSEUR_FINAL as
select IDMERE                                        as idfacture,
       sum(QTE * pu)                                 as montant,
       ff.IDTVA                                      as tva,
       (sum(QTE * pu) * IDTVA) / 100                 as montanttva,
       sum(QTE * pu) + (sum(QTE * pu) * IDTVA) / 100 as montantttc,
       REMARQUE                                      as idbl
from DETAILSFACTUREFOURNISSEUR dff
         join FACTUREFOURNISSEUR ff on ff.id = dff.IDMERE
group by IDMERE, IDTVA, REMARQUE
/


create view BONLIVRAISON_FINAL_VISE as
select BLF."NUMBL",BLF."IDBC",BLF."MONTANT",BLF."TVA",BLF."MONTANTTVA",BLF."MONTANTTTC",
       BL.ETAT
from BONLIVRAISON_FINAL BLF
         join AS_BONDELIVRAISON BL ON BL.ID = BLF.NUMBL
         WHERE   BL.ETAT>=11
/


create view BONCOMMANDE_FINAL as
select bcg.IDBC,
       nvl(bcg.montant,0) as montant,
       bc.TVA,
      cast(nvl((bcg.montant*bc.TVA)/100,0) as number(25,2)) as montanttva,
       cast(nvl(bcg.montant,0)+ nvl(( bcg.montant*bc.TVA)/100,0) as number(25,2)) as montantttc
from bondecommande_grouper bcg
         join AS_BONDECOMMANDE bc on bc.id=bcg.IDBC
/


create or replace view AS_BONDECOMMANDE_FILLE_FINAL AS
select bcf.IDBC,
       bcf.UNITE,
       sum(bcf.QUANTITE)                       as quantitecommande,
       sum(bl.quantite)                        as quantitelivre,
       sum(nvl(ff.qte, 0))                     as quantitefacture,
       max(bcf.QUANTITE) - max(bl.quantite)    as restelivre,
       max(bcf.QUANTITE) - sum(nvl(ff.qte, 0)) as restefacture,
       ETAT
from AS_BONDECOMMANDE_FILLE bcf
         join AS_BONDECOMMANDE bc on bcf.IDBC = bc.id
         join quantite_bl bl on bl.idbondecommande = bcf.id
         left join DETAILSFF_groupe ff on ff.IDINGREDIENT = bcf.id
where bc.ETAT >= 11
group by bcf.IDBC, bcf.UNITE, ETAT;



create or replace view AS_BONDECOMMANDE_LIBELLE_LIB as
select       --B.ID AS IBBC,
    distinct bcl.id,
             bcl.daty,
             bcl.etat,
             bcl.remarque,
             bcl.designation,
             bcl.modepaiement,
             ti.NOM                                as fournisseur,
             bcl.tva,
             bcl.NUMBC,
             bc.montant,
             bc.montanttva,
             bc.montantttc,
             ff.idfacture,
             nvl(op.montant, 0)                    as montant_paye_reel,
             bc.montantttc - nvl(bl.montantttc, 0) as restepayergeneral,
             bc.montantttc - nvl(op.montant, 0)    as resteapayerreel,
             nvl(bl.montantttc, 0)                 as montant_a_payer,
             BCL.PROJET,
             bcl.CODE_ETAB,
             ff.montantttc                         as montantfacture,
             case
                 when b.RESTELIVRE > 0 then 'VISE'
                 WHEN B.restelivre = 0 AND B.quantitefacture > 0 THEN 'LIVRE'
                 WHEN B.restelivre = 0 AND B.quantitefacture = 0 THEN 'FACTURER'
                 WHEN bc.montantttc - nvl(op.montant, 0) = 0 THEN 'PAYER'
                 else 'VISE'
                 END                               as etatlib
from ORDONNERPAYEMENTGROUPEFACT op
         join facturefournisseur_final ff on ff.idfacture = op.DED_ID
         join BONLIVRAISON_FINAL_VISE bl on bl.numbl = ff.IDBL
         join boncommande_final bc on bc.IDBC = bl.IDBC
         right join AS_BONDECOMMANDE_LIBELLE bcl on bcl.ID = bc.idbc
         left join AS_BONDECOMMANDE_FILLE_FINAL b on b.IDBC = bCL.ID
         left join TIERS ti on ti.id = bcl.fournisseur
/


create or replace view AS_BONDECOMMANDE_LIBELLE_TIERS as
select bcl.ID,
       bcl.DATY,
       bcl.ETAT,
       bcl.REMARQUE,
       bcl.DESIGNATION,
       bcl.MODEPAIEMENT,
       bcl.FOURNISSEUR,
       bcl.TVA,
       nvl(ti.NOM, '-')                      as nomfournisseur,
       bcl.NUMBC,
       bc.montant,
       bc.montanttva,
       bc.montantttc,
       ff.idfacture,
       nvl(bl.montantttc, 0)                 as montant_A_payer,
       nvl(op.montant, 0)                    as montant_paye_reel,
       bc.montantttc - nvl(bl.montantttc, 0) as restepayergeneral,
       bc.montantttc - nvl(op.montant, 0)    as resteapayerreel,
       case
                 when b.RESTELIVRE > 0 then 'VISE'
                 WHEN B.restelivre = 0 AND B.quantitefacture > 0 THEN 'LIVRE'
                 WHEN B.restelivre = 0 AND B.quantitefacture = 0 THEN 'FACTURER'
                 WHEN bc.montantttc - nvl(op.montant, 0) = 0 THEN 'PAYER'
                 else 'VISE'
                 END                               as etatlib,
       CODE_ETAB,
       PROJET
from ORDONNERPAYEMENTGROUPEFACT op
         join facturefournisseur_final ff on ff.idfacture = op.DED_ID
         join bonlivraison_final bl on bl.numbl = ff.IDBL
          join boncommande_final bc on bc.IDBC = bl.IDBC
         right join AS_BONDECOMMANDE_LIBELLE bcl on bcl.ID = bc.idbc
        --right join AS_BONDECOMMANDE_LIBELLE bcl on bcl.ID = bc.idbc
         left join AS_BONDECOMMANDE_FILLE_FINAL b on b.IDBC = bCL.ID
         left join TIERS ti on ti.id = bcl.fournisseur

/

create or replace view AS_BONDECOMMANDE_LIBELLE_TIERS as
select bcl.ID,
       bcl.DATY,
       bcl.ETAT,
       bcl.REMARQUE,
       bcl.DESIGNATION,
       bcl.MODEPAIEMENT,
       bcl.FOURNISSEUR,
       bcl.TVA,
       nvl(ti.NOM, '-')                      as nomfournisseur,
       bcl.NUMBC,
       bc.montant,
       bc.montanttva,
       bc.montantttc,
       ff.idfacture,
       nvl(bl.montantttc, 0)                 as montant_A_payer,
       nvl(op.montant, 0)                    as montant_paye_reel,
       bc.montantttc - nvl(bl.montantttc, 0) as restepayergeneral,
       bc.montantttc - nvl(op.montant, 0)    as resteapayerreel,
       case
                 when b.RESTELIVRE > 0 then 'VISE'
                 WHEN B.restelivre = 0 AND B.quantitefacture > 0 THEN 'LIVRE'
                 WHEN B.restelivre = 0 AND B.quantitefacture = 0 THEN 'FACTURER'
                 WHEN bc.montantttc - nvl(op.montant, 0) = 0 THEN 'PAYER'
                 else 'CREER'
                 END                               as etatlib,
       CODE_ETAB,
       PROJET
from ORDONNERPAYEMENTGROUPEFACT op
         join facturefournisseur_final ff on ff.idfacture = op.DED_ID
         join bonlivraison_final bl on bl.numbl = ff.IDBL
          join boncommande_final bc on bc.IDBC = bl.IDBC
         right join AS_BONDECOMMANDE_LIBELLE bcl on bcl.ID = bc.idbc
        --right join AS_BONDECOMMANDE_LIBELLE bcl on bcl.ID = bc.idbc
         left join AS_BONDECOMMANDE_FILLE_FINAL b on b.IDBC = bCL.ID
         left join TIERS ti on ti.id = bcl.fournisseur

/

create or replace view AS_BONDECOMMANDE_LIBELLE_LIB as
select       --B.ID AS IBBC,
    distinct bcl.id,
             bcl.daty,
             bcl.etat,
             bcl.remarque,
             bcl.designation,
             bcl.modepaiement,
             ti.NOM                                as fournisseur,
             bcl.tva,
             bcl.NUMBC,
             bc.montant,
             bc.montanttva,
             bc.montantttc,
             ff.idfacture,
             nvl(op.montant, 0)                    as montant_paye_reel,
             bc.montantttc - nvl(bl.montantttc, 0) as restepayergeneral,
             bc.montantttc - nvl(op.montant, 0)    as resteapayerreel,
             nvl(bl.montantttc, 0)                 as montant_a_payer,
             BCL.PROJET,
             bcl.CODE_ETAB,
             ff.montantttc                         as montantfacture,
             case
                 when b.RESTELIVRE > 0 then 'VISE'
                 WHEN B.restelivre = 0 AND B.quantitefacture > 0 THEN 'LIVRE'
                 WHEN B.restelivre = 0 AND B.quantitefacture = 0 THEN 'FACTURER'
                 WHEN bc.montantttc - nvl(op.montant, 0) = 0 THEN 'PAYER'
                 else 'CREER'
                 END                               as etatlib
from ORDONNERPAYEMENTGROUPEFACT op
         join facturefournisseur_final ff on ff.idfacture = op.DED_ID
         join BONLIVRAISON_FINAL_VISE bl on bl.numbl = ff.IDBL
         join boncommande_final bc on bc.IDBC = bl.IDBC
         right join AS_BONDECOMMANDE_LIBELLE bcl on bcl.ID = bc.idbc
         left join AS_BONDECOMMANDE_FILLE_FINAL b on b.IDBC = bCL.ID
         left join TIERS ti on ti.id = bcl.fournisseur
/
