create table MereCA
(
    id    varchar2(100)
        constraint MereCA_pk primary key,
    val   varchar2(500),
    desce varchar2(500)
);

CREATE SEQUENCE seqMereCA
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seqMereCA
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqMereCA.nextval INTO retour FROM dual;
    return retour;
END;


    create table CompteCA
    (
        id varchar2(100) constraint CompteCA_pk primary key ,
            val varchar2(500),
            desce  varchar2(500) constraint fk_CompteCA references mereCA
    );



CREATE SEQUENCE seqCompteCA
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seqCompteCA
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqCompteCA.nextval INTO retour FROM dual;
    return retour;
END;

create view CA_vide as
select cast('-' as varchar2(100)) as id,
       cast('-' as varchar2(100)) as Libelle,
       cast(0 as number(30, 3))   as ancienCumul,
       cast(0 as number(30, 3))   as regul,
       cast(0 as number(30, 3))   as regulEetP,
       cast(0 as number(30, 3))   as avoirEetP,
    cast(0 as number(30,3)) as  comptant ,
    cast(0 as number(30,3)) as  credit ,
     cast(0 as number(30,3)) as estTotal
from dual;


INSERT INTO MereCA VALUES('MCA1','7060','Assistances aux navires');
INSERT INTO MereCA VALUES('MCA2','7061','Prestations connexes');
INSERT INTO MereCA VALUES('MCA3','7063','Prestations de convention');
INSERT INTO MereCA VALUES('MCA4','7063','Prestations de convention');
INSERT INTO MereCA VALUES('MCA5','7064','MICTSL');
INSERT INTO MereCA VALUES('MCA6','7065','Prestations diverses');
INSERT INTO MereCA VALUES('MCA7','7066','Prestations hydrocarbures');
INSERT INTO MereCA VALUES('MCA8','7067','Prestation s marchandises');
INSERT INTO MereCA VALUES('MCA9','7068','Prestations  navires');
create or replace view COMPTECAFACTURE as
select fdc."ID",cca."VAL",cca."DESCE",
       IDMERE,
       DESIGNATION,
       QUANTITE,
       PU,
       IDPRODUIT,
       DEVISE,
       TAUX,
       QTELIVREE,
       RESTEALIVRER,
       MONTANTTAUX,
       MONTANT,
       MONTANTAVOIRSANSTAUX,
       MONTANTAVOIRAVECTAUX,
       TVA,
       IDACTIVITE,
       ACTIVITELIB,
       HEUREDEBUT,
       HEUREFIN,
       MOISLIB,
       TAUXEURO,
       MONTANTHTEURO,
       MONTANTTVAEURO,
       MONTANTTAXE,
       MAJORATION,
       REDUCTION,
       DATEFACT,
       RUBRIQUE,
       RANG,
       DATY, mca.val                      as valMereCA, mca.desce as desceMereCA,
       extract(month from fdc.daty) as mois,
       extract(year from fdc.daty)  as annee,
       cca.val                      as compte
from CompteCA cca,
     MereCA mca,
     FACT_CLT_FILL_LIB_REST_TAXE fdc
where fdc.compte like cca.val || '%'
  and fdc.compte is not null
/
  
  create view CompteCAFactureMoisAn as
select cca.rubrique,
       cca.compte,
       cca.DESCE                           as mere,
       cast(sum(montant) as number(32, 3)) as montant,
       cca.mois,
       cca.annee
from CompteCAFacture cca
group by cca.rubrique, cca.DESCE, cca.mois, cca.annee, cca.compte;


INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70601','MCA1');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70602','MCA1');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70603','MCA1');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70604','MCA1');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70605','MCA1');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70606','MCA1');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70607','MCA1');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70610','MCA2');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70611','MCA2');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70630','MCA3');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70631','MCA4');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70632','MCA4');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70634','MCA4');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70640','MCA5');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70641','MCA5');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70642','MCA5');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70651','MCA6');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70652','MCA6');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70653','MCA6');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70662','MCA7');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70670','MCA8');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70671','MCA8');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70672','MCA8');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70680','MCA9');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70681','MCA9');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70682','MCA9');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70683','MCA9');
INSERT INTO COMPTECA  VALUES (SEQCOMPTECA.NEXTVAL,'70684','MCA9');


create or replace view CompteCAAvoir as
select fdc.ID,
       IDMERE,
       IDDETAILFACTURE,
       MONTANT,
       --COMPTE,
       REMISE,
       DATY,
       IDFACTURE,
       ETAT,
       DESIGNATION,
       CODE,
       CATEGORIE,
       MOTIF,
       TYPE,
       extract(month from fdc.daty) as mois,
       extract(year from fdc.daty)  as annee,
       cca.val                      as compte
from CompteCA cca,
     MereCA mca,
     AVOIRFCFILLE_FM fdc
where fdc.compte like cca.val || '%'
  and fdc.compte is not null;
  
  
  
create or replace view AVOIRFCFILLE_FACTURE as
select fc.*,
       fcf.RUBRIQUE

from AVOIRFCFILLE_FM fc
    left join FACTURE_CLIENT_MONTANT fcf on fc.IDDETAILFACTURE = fcf.ID;
	

	create or replace view COMPTECAAVOIR as
select fdc.ID,
       IDMERE,
       IDDETAILFACTURE,
       MONTANT,
       --COMPTE,
       REMISE,
       DATY,
       IDFACTURE,
       ETAT,
       DESIGNATION,
       CODE,
       CATEGORIE,
       MOTIF,
       TYPE,
       extract(month from fdc.daty) as mois,
       extract(year from fdc.daty)  as annee,
       cca.val                      as compte,
       fdc.RUBRIQUE,
       cca.desce
from CompteCA cca,
     MereCA mca,
     AVOIRFCFILLE_FACTURE fdc
where fdc.compte like cca.val || '%';

create view CompteCAAvoirMoisAn as
select cca.rubrique,
       cca.compte,
       cca.DESCE                           as mere,
       cast(sum(montant) as number(32, 3)) as montant,
       cca.mois,
       cca.annee
from CompteCAAvoir cca
group by cca.rubrique, cca.DESCE, cca.mois, cca.annee, cca.compte;


create view CompteCAFactAvoir as
select cca.*, ccavoir.montant as avoir
from CompteCAFactureMoisAn cca
         left join CompteCAAvoirMoisAn ccavoir on cca.mois = ccavoir.mois and cca.annee = ccavoir.annee and
                                                  cca.compte=ccavoir.compte and    cca.mere=ccavoir.mere;