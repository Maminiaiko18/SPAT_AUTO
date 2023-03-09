
create view QUANTITE_BL as
select numbl, SUM(quantite) AS QUANTITE
from AS_BONDELIVRAISON_FILLE
group by numbl
/

create or replace view QUANTITELIVRE as
select b.id_bc, sum(bl.QUANTITE) as qtelivre
from AS_BONDELIVRAISON b
         join quantite_bl bl on bl.NUMBL = b.ID
group by ID_BC
/

create or replace view AS_BONDECOMMANDE_FILLE_FINAL as
select bcf.IDBC,

       sum(bcf.QUANTITE)                            as quantitecommande,
       sum(nvl(bl.qtelivre, 0))                     as quantitelivre,
       sum(nvl(ff.qte, 0))                          as quantitefacture,
       sum(bcf.QUANTITE) - sum(nvl(bl.qtelivre, 0)) as restelivre,
       sum(bcf.QUANTITE) - sum(nvl(ff.qte, 0))      as restefacture,
       ETAT
from bondecommande_sumqte bcf
         left join quantitelivre bl on bl.ID_BC = bcf.IDBC
         left join DETAILSFF_groupe ff on ff.IDINGREDIENT = bcf.IDBC
group by bcf.IDBC, ETAT
/


create table regulfacture
(
    id varchar2(100) constraint regulfacture_pk primary key ,
    daty date,
    idbon varchar2(100) constraint bon_regul_fk references BON_PROVISOIRE,
    idfacture varchar2(100) constraint ff_regulfact_fk references FACTUREFOURNISSEUR,
    remarque varchar2(500)
);


CREATE SEQUENCE seq_regulfacture
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seq_regulfacture
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_regulfacture.nextval INTO retour FROM dual;
  return retour;
END;

CREATE OR REPLACE
FORCE VIEW CONTRAT_CHANTIER_CPLSUM AS 
SELECT
	bc.ID,
	bc.IDCHANTIER,
	cH.nom AS CHANTIERLIB ,
	bc.DESIGNATION,
	bc.MONTANT,
	bc.PRESTATAIRE,
	ti.nom AS PRESTATAIRElib,
	bc.ETAT,
	ff.idfacture,
	nvl(op.montant, 0) AS montant_paye,
	bc.montant - nvl(op.montant, 0) AS resteapaye,
	bc.TVA,
	bc.PROJET,
	bc.CODE_ETAB,
	bc.noContrat,
	ce.val AS CODE_ETABLIB,
	pe.designation AS PROJETLIB
FROM
	ORDONNERPAYEMENTGROUPEFACT op
JOIN facturefournisseur_final ff ON
	ff.idfacture = op.DED_ID
RIGHT JOIN CONTRAT_CHANTIER bc ON
	bc.IDCHANTIER = ff.IDBL
LEFT JOIN CODEETABLISSEMENT ce ON
	ce.id = bc.code_etab 
LEFT JOIN CHANTIER cH ON
	ch.id = bc.IDCHANTIER 
LEFT JOIN TIERS ti ON 
	ti.id = bc.PRESTATAIRE 
LEFT JOIN PROJET pe ON
	pe.id = bc.projet;


create or replace view as_bondecommande_libelle_lib
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR,
             TVA, NUMBC, MONTANT, MONTANTTVA, MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL,
             RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET, CODE_ETAB, MONTANTFACTURE, ETATLIB)
AS

select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                                as fournisseur,
       bc.tva,
       bc.NUMBC,
       nvl(lfac.montantht, 0),
       nvl(lfac.montanttva, 0),
       nvl(lfac.montantttc, 0),
       ''                                                    as idfacture,
       nvl(lfac.montantpayer, 0)                             as montant_paye_reel,
       nvl(lfac.montantttc, 0) - nvl((lfac.montantpayer), 0) as resteapayegeneral,
       nvl(lfac.montantttc, 0) - nvl((lfac.montantpayer), 0) as resteapayerreel,
       nvl(lfac.montantttc, 0)                               as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       lfac.montantttc                                       as montantfacture,
       case
           when bcf.RESTELIVRE > 0 then 'VISE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) != 0 and
                lfac.montantttc - nvl(lfac.montantpayer, 0) != 0 THEN 'LIVRE'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) != 0 THEN 'FACTURER'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYER'
           else 'CREER'
           END                                               as etatlib
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join bondelivraison_cmpl_groupe lfac on lfac.ID_BC = bc.ID
         left join TIERS ti on ti.ID = bc.fournisseur;

create or replace view DETAILSFFBONLIVRAISON as
select Detfac.id,
       Detfac.QTE,
       Detfac.pu,
       Detfac.IDMERE,
       Detfac.COMPTE,
       Detfac.IDINGREDIENT,
       NVL((select sum(bonF.quantite)
            from AS_BONDELIVRAISON_fille bonF
                     join as_bondelivraison bon on bon.id = bonF.NUMBL
            where etat = 11
              and bonF.iddetailsfacturefournisseur = Detfac.id
            group by iddetailsfacturefournisseur), 0)       as livre,
       QTE - NVL((select sum(bonF.quantite)
                  from AS_BONDELIVRAISON_fille bonF
                           join as_bondelivraison bon on bon.id = bonF.NUMBL
                  where etat = 11
                    and bonF.iddetailsfacturefournisseur = Detfac.id
                  group by iddetailsfacturefournisseur), 0) as reste,
       Detfac.iddqe,
       Detfac.pu*Detfac.qte as montant,
       TVA,
       (Detfac.pu*Detfac.qte)*tva/100 as montanttva,
       (Detfac.pu*Detfac.qte )+(Detfac.pu*Detfac.qte)*tva/100 as montantttc
from detailsfacturefournisseur Detfac
/

CREATE VIEW avancement_contrat_etat_lib as
select ac.ID,
       IDCONTRAT,
       DATY,
       POURCENTAGE,
       OBSERVATION,
       case when ETAT=1 then 'CREE(E)'
            WHEN ETAT>=11 THEN 'VISE(E)' END  AS ETAT
 from avancement_contrat ac
order by ac.ID desc;

CREATE OR REPLACE VIEW avancement_contrat_etat_lib as
select ac.ID,
       IDCONTRAT,
       DATY,
       POURCENTAGE,
       OBSERVATION,
       case when ETAT=1 then 'CREE(E)'
            WHEN ETAT>=11 THEN 'VISE(E)' END  AS ETATLIB
 from avancement_contrat ac
order by ac.ID desc;

CREATE VIEW ffregul AS SELECT e.*,r.IDBON FROM ETATFACTUREMONTANTDATY e JOIN regulFacture r ON e.id = r.IDFACTURE ;

create table regulBP
(
    id varchar2(100) constraint regulBP_pk primary key ,
        idbon varchar2(100) constraint fk_bon_provisoire references BON_PROVISOIRE,
        montant number(30,2),
        daty date,
        idUser NUMBER(10) constraint fk_utilisateur references UTILISATEUR
);

CREATE SEQUENCE seq_regulBP
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_regulBP
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_regulBP.nextval INTO retour FROM dual;
    return retour;
END;

create view regulbp_libcomplet as
select re.*,
       pro.LIBELLE as idbonlib,
       ut.NOMUSER as iduserlib
from regulbp re
        join BON_PROVISOIRE pro on pro.id=re.IDBON
        join UTILISATEUR ut on re.idUser = ut.REFUSER;

create or replace view as_bondecommande_libelle_lib
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR,
             TVA, NUMBC, MONTANT, MONTANTTVA, MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL,
             RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET, CODE_ETAB, MONTANTFACTURE, ETATLIB)
AS

select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                                as fournisseur,
       bc.tva,
       bc.NUMBC,
       nvl(lfac.montantht, 0),
       nvl(lfac.montanttva, 0),
       nvl(lfac.montantttc, 0),
       ''                                                    as idfacture,
       nvl(lfac.montantpayer, 0)                             as montant_paye_reel,
       nvl(lfac.montantttc, 0) - nvl((lfac.montantpayer), 0) as resteapayegeneral,
       nvl(lfac.montantttc, 0) - nvl((lfac.montantpayer), 0) as resteapayerreel,
       nvl(lfac.montantttc, 0)                               as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       lfac.montantttc                                       as montantfacture,
       case
           when bcf.RESTELIVRE > 0 then 'VISE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) != 0
               THEN 'FACTURER'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYER'
           else 'CREER'
           END                                               as etatlib
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join bondelivraison_cmpl_groupe lfac on lfac.ID_BC = bc.ID
         left join TIERS ti on ti.ID = bc.fournisseur;

alter table AVOIR add tva number(10,2);
alter table ADDITIF add tva number(10,2);

create or replace view AVOIR_VISESM as
select IDFACTURE                                                           as idfacture,
       sum(MONTANT)                                                        as montant,
       etat,
       TYPE,
       case
           when av.type = 'TYPEAV0001' then sum(av.montant)
           else cast((select sum(a.MONTANT) / (1 + (ff.TVA / 100))
                      from avoir a
                      where a.TYPE = 'TYPEAV0002'
                        and ff.idmere = a.IDFACTURE group by IDFACTURE) as number(10, 2)) end as montantavoirht,
       case
           when av.type = 'TYPEAV0001' then sum(av.montant)*ff.tva/100
           else cast((select sum(a.MONTANT) *ff.TVA/100
                      from avoir a
                      where a.TYPE = 'TYPEAV0002'
                        and ff.idmere = a.IDFACTURE group by IDFACTURE) as number(10, 2)) end as montantavoirtva,
       case
           when av.TYPE = 'TYPEAV0002' then sum(av.montant)
           else cast((select sum(a.MONTANT) / (1 + (ff.TVA / 100))
                      from avoir a
                      where a.TYPE = 'TYPEAV0001'
                        and ff.idmere = a.IDFACTURE group by IDFACTURE )as number(10, 2) ) end as montantavoirttc
from AVOIR av
         join details_ff_sum ff on ff.idmere = av.IDFACTURE
where ETAT >= 11
group by IDFACTURE, ETAT, type, ff.TVA, IDFACTURE, ff.idmere
/

create or replace view AVOIR_VISESM as
select IDFACTURE                                                                                 as idfacture,
       sum(MONTANT)                                                                              as montant,
       etat,
       TYPE,
       --1 ht
       --2 ttc
       case
           when av.type = '1' then sum(av.montant)
           else cast((select sum(a.MONTANT) / (1 + (av.TVA / 100))
                      from avoir a
                      where a.TYPE = '2'
                        and ff.idmere = a.IDFACTURE
                      group by IDFACTURE) as number(10, 2)) end                                  as montantavoirht,
       case
           when av.type = '1' then sum(av.montant) * av.tva / 100
           else cast((select sum(a.MONTANT) / (1 + (av.TVA / 100))
                      from avoir a
                      where a.TYPE = '2'
                        and ff.idmere = a.IDFACTURE
                      group by IDFACTURE) as number(10, 2)) * av.TVA / 100 end                   as montantavoirtva,
       case
           when av.TYPE = '2' then sum(av.montant)
           else cast((select sum(a.MONTANT)
                      from avoir a
                      where a.TYPE = '1'
                        and ff.idmere = a.IDFACTURE
                      group by IDFACTURE) as number(10, 2)) + sum(av.montant) * av.tva / 100 end as montantavoirttc
from AVOIR av
         join details_ff_sum ff on ff.idmere = av.IDFACTURE
where ETAT >= 11
group by IDFACTURE, ETAT, type, av.TVA, IDFACTURE, idmere
/

create or replace view additif_VISESM as
select IDFACTURE                                                                                 as idfacture,
       sum(MONTANT)                                                                              as montant,
       etat,
       TYPE,
       case
           when av.type = '1' then sum(av.montant)
           else cast((select sum(a.MONTANT) / (1 + (av.TVA / 100))
                      from ADDITIF a
                      where a.TYPE = '2'
                        and ff.idmere = a.IDFACTURE
                      group by IDFACTURE) as number(10, 2)) end                                  as montantadditifht,
       case
           when av.type = '1' then sum(av.montant) * av.tva / 100
           else cast((select sum(a.MONTANT) / (1 + (av.TVA / 100))
                      from ADDITIF a
                      where a.TYPE = '2'
                        and ff.idmere = a.IDFACTURE
                      group by IDFACTURE) as number(10, 2)) * av.TVA / 100 end                   as montantadditiftva,
       case
           when av.TYPE = '2' then sum(av.montant)
           else cast((select sum(a.MONTANT)
                      from ADDITIF a
                      where a.TYPE = '1'
                        and ff.idmere = a.IDFACTURE
                      group by IDFACTURE) as number(10, 2)) + sum(av.montant) * av.tva / 100 end as montantadditifttc
from ADDITIF av
         join details_ff_sum ff on ff.idmere = av.IDFACTURE
where ETAT >= 11
group by IDFACTURE, ETAT, type, av.TVA, IDFACTURE, idmere
/

create or replace view AVOIR_VISESM as
select IDFACTURE                                                                                 as idfacture,
       sum(MONTANT)                                                                              as montant,
       etat,
       TYPE,
       --1 ht
       --2 ttc
       case
           when av.type = '1' then sum(av.montant)
           else cast((select sum(a.MONTANT) / (1 + (nvl(av.TVA,0)) / 100)
                      from avoir a
                      where a.TYPE = '2'
                        and ff.idmere = a.IDFACTURE
                      group by IDFACTURE) as number(10, 2)) end                                  as montantavoirht,
       case
           when av.type = '1' then sum(av.montant) * nvl(av.tva,0) / 100
           else cast((select sum(a.MONTANT) / (1 + (nvl(av.TVA,0)) / 100)
                      from avoir a
                      where a.TYPE = '2'
                        and ff.idmere = a.IDFACTURE
                      group by IDFACTURE) as number(10, 2)) * nvl(av.TVA,0) / 100 end                   as montantavoirtva,
       case
           when av.TYPE = '2' then sum(av.montant)
           else cast((select sum(a.MONTANT)
                      from avoir a
                      where a.TYPE = '1'
                        and ff.idmere = a.IDFACTURE
                      group by IDFACTURE) as number(10, 2)) + sum(av.montant) * nvl(av.tva,0) / 100 end as montantavoirttc
from AVOIR av
         join details_ff_sum ff on ff.idmere = av.IDFACTURE
where ETAT >= 11
group by IDFACTURE, ETAT, type, av.TVA, IDFACTURE, idmere
/


create or replace view additif_VISESM as
select IDFACTURE                                                                                 as idfacture,
       sum(MONTANT)                                                                              as montant,
       etat,
       TYPE,
       case
           when av.type = '1' then sum(av.montant)
           else cast((select sum(a.MONTANT) / (1 + (nvl(av.TVA,0))/ 100)
                      from ADDITIF a
                      where a.TYPE = '2'
                        and ff.idmere = a.IDFACTURE
                      group by IDFACTURE) as number(10, 2)) end                                  as montantadditifht,
       case
           when av.type = '1' then sum(av.montant) * nvl(av.tva,0) / 100
           else cast((select sum(a.MONTANT) / (1 + (nvl(av.TVA,0)) / 100)
                      from ADDITIF a
                      where a.TYPE = '2'
                        and ff.idmere = a.IDFACTURE
                      group by IDFACTURE) as number(10, 2)) * av.TVA / 100 end                   as montantadditiftva,
       case
           when av.TYPE = '2' then sum(av.montant)
           else cast((select sum(a.MONTANT)
                      from ADDITIF a
                      where a.TYPE = '1'
                        and ff.idmere = a.IDFACTURE
                      group by IDFACTURE) as number(10, 2)) + sum(av.montant) * av.tva / 100 end as montantadditifttc
from ADDITIF av
         join details_ff_sum ff on ff.idmere = av.IDFACTURE
where ETAT >= 11
group by IDFACTURE, ETAT, type, av.TVA, IDFACTURE, idmere
/


create view AVOIR_VISESM_grouper as
select idfacture,
       sum(montant)         as montant,
       etat,
       sum(montantavoirht)  as montantavoirht,
       sum(montantavoirtva) as montantavoirtva,
       sum(montantavoirttc) as montantavoirttc
from AVOIR_VISESM av
group by idfacture,etat;

create or replace view additif_VISESM_grouper as
select idfacture,
       sum(montant)         as montant,
       etat,
       sum(montantadditifht)  as montantadditifht,
       sum(montantadditiftva) as montantadditiftva,
       sum(montantadditifttc) as montantadditifttc
from additif_VISESM av
group by idfacture,etat;

  create or replace view as_bondecommande_libs as
  select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.MODEPAIEMENT,
       bc.fournisseur,
       bc.tva,
       bc.NUMBC,
       bc.CODE_ETAB,
       bc.PROJET,
       ti.NOM as fournisseur_lib,
       ce.val as CODE_ETAB_lib,
       pe.designation as PROJET_lib,
       mp.val as modepaiement_lib
from as_bondecommande bc
        join modepaiement mp on bc.modepaiement = mp.id
        left join CODEETABLISSEMENT ce on ce.id=bc.code_etab
        left join PROJET  pe on pe.id=bc.projet
        left join TIERS ti on ti.ID = bc.fournisseur;
        
create or replace view liste_bon_provisoire as
select 
  bp.*,
  rf.idfacture
from bon_provisoire_lib bp 
join regulfacture rf on rf.idbon=bp.id 
join facturefournisseur ff on ff.id=rf.idfacture;
