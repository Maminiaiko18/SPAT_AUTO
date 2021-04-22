create or replace view ETATFACTUREMONTANT as
SELECT f.id,
       f.daty,
       f.idfournisseur,
       f.idtva,
       f.montantHt,
       f.montanttva,
       f.montantttc,
       f.remarque,
       f.dateemission,
       f.designation,
       f.iddevise,
       f.numfact,
       f.datyecheance,
       f.etat,
       COALESCE(op.montant, 0)                AS montantpaye,
       f.montantttc - COALESCE(op.montant, 0) AS reste,
       f.entite,
       f.designation                          AS nomfournisseur,
       case
           when av.type = 'TYPEAV0001' then nvl(av.montant, 0)
           else 0 END                         AS MONTANTAVOIRHT
        ,
       case
           when av.type = 'TYPEAV0002' then nvl(av.montant, 0)
           else 0 end                         as montantavoirttc,

       case
           when ad.type = 'TYPEAV0001' then ad.montant
           when ad.type = 'TYPEAV0002' then ad.montant
           else 0 end                         as tet
FROM facturefournisseurlettremtt f
         LEFT JOIN LIAISONINTRATABLE_OP_PARFACT op ON f.id = op.ID1
         left join avoir_visesm av on av.idfacture = f.id
         left join additif_visesm ad on ad.idfacture = f.id
    group by f.id, f.daty, f.idfournisseur, f.idtva, f.montantHt, f.montanttva, f.montantttc, f.remarque, f.dateemission, f.designation, f.iddevise, f.numfact, f.datyecheance, f.etat, COALESCE(op.montant, 0), f.montantttc - COALESCE(op.montant, 0), f.entite, f.designation, case
           when av.type = 'TYPEAV0001' then nvl(av.montant, 0)
           else 0 END, case
           when av.type = 'TYPEAV0002' then nvl(av.montant, 0)
           else 0 end, case
           when ad.type = 'TYPEAV0001' then ad.montant
           when ad.type = 'TYPEAV0002' then ad.montant
           else 0 end
/

create or replace view ETATFACTUREMONTANTDATYRETENU as
SELECT DISTINCT efm.id,
                efm.daty,
                efm.idfournisseur,
                t.nom                                                  AS nomfournisseur,
                efm.idtva,
                --efm.montantttc,
                efm.remarque                                           AS remarque,
                efm.dateemission,
                efm.designation,
                efm.iddevise,
                efm.numfact,
                efm.datyecheance,
                efm.etat,
                dff.NUMID,
                COALESCE(efm.montantpaye, 0)                           AS montantpaye,
                COALESCE(efm.reste, 0)                                 AS reste,
                ''                                                     AS entite,
                dff.montantttc                                         AS montantttdevise,
                ''                                                     AS budget,
                0                                                      AS retenue,
                ff.MONTANt                                             AS montant,


                av.montantavoirttc                                     as montantavoir,
                ad.montantadditifttc                                   as montantadditif,
                (ff.MONTANT - nvl(av.MONTANT, 0) + nvl(ad.montant, 0)) as montantnet,
                nvl(efm.montantht, 0)                                  as montantht,
                nvl(efm.montanttva, 0)                                 as montanttva,
                nvl(efm.montantttc, 0)                                 as montantttc,
                nvl(av.montantavoirht, 0)                              as montantavoirht,
                nvl(av.montantavoirtva, 0)                             as montantavoirtva,
                nvl(av.montantavoirttc, 0)                             as montantavoirttc,
                nvl(ad.montantadditifht, 0)                            as montantadditifht,
                nvl(ad.montantadditiftva, 0)                           as montantadditiftva,
                nvl(ad.montantadditifttc, 0)                           as montantadditifttc
                -- cast((ff.MONTANT - nvl(av.MONTANT, 0) + nvl(ad.montant, 0)) *(efm.IDTVA / 100) as number(25, 2))                                                          as montanttva
FROM etatfacturemontant efm
         JOIN facturefournisseur dff ON dff.id = efm.id
         LEFT JOIN tiers t ON dff.idfournisseur = t.id
         join facturefournisseur_SumMtt ff on ff.id = efm.id
         left join AVOIR_VISESM_grouper av on av.idfacture = ff.id
         left join additif_VISESM_grouper ad on ad.idfacture = ff.id
/

alter table regulBP
    add etat number(10);

create or replace view ETATFACTUREMONTANTDATY
            (ID, DATY, IDFOURNISSEUR, NOMFOURNISSEUR, IDTVA, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT,
             DATYECHEANCE, ETAT, MONTANTPAYE, RESTE, ENTITE, MONTANTTTDEVISE, BUDGET, RETENUE, NUMID, TIERSLIB, TVA,
             MONTANT, MONTANTAVOIR, MONTANTADDITIF, MONTANTNET, MONTANTTVA, MONTANTTTC, MONTANTTOTALAPAYER, TYPE)
as
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
           END                                                   AS etat,
       nvl(op.MONTANT, 0)                                      as montantpaye,
       RESTE                                                     AS reste,
       et.entite,
       et.montantttdevise,
       et.budget,
       et.retenue,
       et.NUMID,
       t.NOM                                                     as tierslib,
       et.IDTVA                                                  as tva,
       et.montantht + et.montantadditifht - et.montantavoirht    as montant,
       (et.montantavoir),
       (et.montantadditif),
       (et.montantnet),
       et.montanttva + et.montantadditiftva - et.montantavoirtva as montanttva,
       et.montantttc + et.montantadditifttc - et.montantavoirttc as montantttc,
       et.montantttc + et.montantadditifttc - et.montantavoirttc as montantTotalApayer,
       ff.TYPE
FROM etatfacturemontantdatyretenu et
         join facturefournisseur_SumMtt ff on ff.id = et.id
         left join TIERS t on t.id = et.idfournisseur
         left join LIAISONINTRATABLE_OP_PARFACT op on op.ID1 = et.id
/

create view ordonnerpayement_bp
as
select rf.idbon,
       sum(op.montant) as montant
from regulfacture rf
         join liaisonintratable l on rf.IDFACTURE = l.id1
         join ordonnerpayement op on op.id = l.id2
where op.etat >= 11
group by rf.idbon;

create or replace view mouvementdepart as
    select *from MOUVEMENTLIBCOMPLET where typemvt = 'TPMM00003' and ETAT>=11;
create or replace view mouvementarrive as
    select *from MOUVEMENTLIBCOMPLET where typemvt = 'TPMM00004' and ETAT>=11;


CREATE OR REPLACE VIEW TOUCHE_DE_NAVIRE AS
select *
from mouvementdepart ma
        where DATE_DEPART = (select max(DATE_DEPART) from mouvementdepart m where m.ESCALE=ma.ESCALE )
UNION

select *from MOUVEMENTARRIVE ma
        where DATEARRIVEE= (select min(m.DATEARRIVEE) from MOUVEMENTARRIVE m where m.ESCALE=ma.ESCALE);

CREATE or replace VIEW regulbp_libcomplet as
select reg.ID,
       reg.IDBON,
       bp.LIBELLE as IDBONlib,
       reg.MONTANT,
       reg.DATY,
       reg.IDUSER ,
       ut.NOMUSER as IDUSERlib,
       reg.ETAT
from regulbp reg
        join BON_PROVISOIRE bp on bp.id=reg.IDBON
        join UTILISATEUR ut on ut.REFUSER=reg.IDUSER ;
     
        CREATE or replace VIEW regulbp_libcomplet as
select reg.ID,
       reg.IDBON,
       bp.LIBELLE as IDBONlib,
       reg.MONTANT,
       reg.DATY,
       reg.IDUSER ,
       ut.NOMUSER as IDUSERlib,
       reg.ETAT
from regulbp reg
        join BON_PROVISOIRE bp on bp.id=reg.IDBON
        join UTILISATEUR ut on ut.REFUSER=reg.IDUSER ;


        alter table CODE_ACTE
    add categorie varchar2(100);
 drop TABLE lienpredicat;
create table lienpredicat
(
    id       varchar2(100)
        constraint lienpredicat_pk primary key,
    predicat varchar2(500),
        lien varchar2(500)

) ;

     create view OrdonnerPayement_libetat as
select
        op.*,
       case when etat =0 then 'annule'
            when etat=1 then 'cree'
            when  etat=11 then 'vise' end as etatlib
from OrdonnerPayement op;

create OR REPLACE view LIAISONINTRATABLE_OP_VISE AS
select lt.*,op.DED_ID,
       op.MONTANT AS MONTANTOP,
       op.etat
from LIAISONINTRATABLE lt
         join ORDONNERPAYEMENT op on op.id = lt.ID2
WHERE OP.ETAT>=11;

---2
create or replace view LIAISONINTRATABLE_OP_PARFACT as
select id1 , sum(MONTANT) as montant,DED_ID,sum(MONTANTOP) as MONTANTOP
from LIAISONINTRATABLE_OP_VISE
    group by id1,DED_ID
/

--3

create or replace view ETATFACTUREMONTANT as
SELECT f.id,
       f.daty,
       f.idfournisseur,
       f.idtva,
       f.montantHt,
       f.montanttva,
       f.montantttc,
       f.remarque,
       f.dateemission,
       f.designation,
       f.iddevise,
       f.numfact,
       f.datyecheance,
       f.etat,
       case when op.DED_ID like '%;%' then
       COALESCE(op.montant, 0)
           else sum(COALESCE (op.MONTANTOP, 0)) end  AS montantpaye,
       f.montantttc -  case when op.DED_ID like '%;%' then
       COALESCE(op.montant, 0)
           else sum(COALESCE(op.MONTANTOP, 0)) end AS reste,
       f.entite,
       f.designation                          AS nomfournisseur,
       case
           when av.type = 'TYPEAV0001' then nvl(av.montant, 0)
           else 0 END                         AS MONTANTAVOIRHT
        ,
       case
           when av.type = 'TYPEAV0002' then nvl(av.montant, 0)
           else 0 end                         as montantavoirttc,

       case
           when ad.type = 'TYPEAV0001' then ad.montant
           when ad.type = 'TYPEAV0002' then ad.montant
           else 0 end                         as tet
FROM facturefournisseurlettremtt f
         LEFT JOIN LIAISONINTRATABLE_OP_PARFACT op ON f.id = op.ID1
         left join avoir_visesm av on av.idfacture = f.id
         left join additif_visesm ad on ad.idfacture = f.id
    group by op.DED_ID,f.id, f.daty, f.idfournisseur, f.idtva, f.montantHt, f.montanttva, f.montantttc, f.remarque, f.dateemission, f.designation, f.iddevise, f.numfact, f.datyecheance, f.etat, COALESCE(op.montant, 0), f.montantttc - COALESCE(op.montant, 0), f.entite, f.designation, case
           when av.type = 'TYPEAV0001' then nvl(av.montant, 0)
           else 0 END, case
           when av.type = 'TYPEAV0002' then nvl(av.montant, 0)
           else 0 end, case
           when ad.type = 'TYPEAV0001' then ad.montant
           when ad.type = 'TYPEAV0002' then ad.montant
           else 0 end
/

create OR REPLACE view LIAISONINTRATABLE_OP_VISE AS
select lt.*,op.DED_ID,
       op.MONTANT AS MONTANTOP,
       op.etat
from LIAISONINTRATABLE lt
         join ORDONNERPAYEMENT op on op.id = lt.ID2
WHERE OP.ETAT>=11;

---2
create or replace view LIAISONINTRATABLE_OP_PARFACT as
select id1 , sum(MONTANT) as montant,DED_ID,sum(MONTANTOP) as MONTANTOP
from LIAISONINTRATABLE_OP_VISE
    group by id1,DED_ID
/

--3
select *from LIAISONINTRATABLE_OP_PARFACT where DED_ID='FF000269';

create or replace view ETATFACTUREMONTANT as
SELECT f.id,
       f.daty,
       f.idfournisseur,
       f.idtva,
       f.montantHt,
       f.montanttva,
       f.montantttc,
       f.remarque,
       f.dateemission,
       f.designation,
       f.iddevise,
       f.numfact,
       f.datyecheance,
       f.etat,
       case when op.DED_ID like '%;%' then
       sum(COALESCE(op.montant, 0))
           else sum(COALESCE (op.MONTANTOP, 0)) end  AS montantpaye,
       f.montantttc -  case when op.DED_ID like '%;%' then
       sum(COALESCE(op.montant, 0))
           else sum(COALESCE(op.MONTANTOP, 0)) end AS reste,
       f.entite,
       f.designation                          AS nomfournisseur,
       case
           when av.type = 'TYPEAV0001' then nvl(av.montant, 0)
           else 0 END                         AS MONTANTAVOIRHT
        ,
       case
           when av.type = 'TYPEAV0002' then nvl(av.montant, 0)
           else 0 end                         as montantavoirttc,

       case
           when ad.type = 'TYPEAV0001' then ad.montant
           when ad.type = 'TYPEAV0002' then ad.montant
           else 0 end                         as tet
FROM facturefournisseurlettremtt f
         LEFT JOIN LIAISONINTRATABLE_OP_PARFACT op ON f.id = op.ID1
         left join avoir_visesm av on av.idfacture = f.id
         left join additif_visesm ad on ad.idfacture = f.id
    group by op.DED_ID,f.id, f.daty, f.idfournisseur, f.idtva, f.montantHt, f.montanttva, f.montantttc, f.remarque, f.dateemission, f.designation, f.iddevise, f.numfact, f.datyecheance, f.etat, COALESCE(op.montant, 0), f.montantttc - COALESCE(op.montant, 0), f.entite, f.designation, case
           when av.type = 'TYPEAV0001' then nvl(av.montant, 0)
           else 0 END, case
           when av.type = 'TYPEAV0002' then nvl(av.montant, 0)
           else 0 end, case
           when ad.type = 'TYPEAV0001' then ad.montant
           when ad.type = 'TYPEAV0002' then ad.montant
           else 0 end
/



--4
create or replace view ETATFACTUREMONTANTDATYRETENU as
SELECT DISTINCT efm.id,
                efm.daty,
                efm.idfournisseur,
                t.nom                                                  AS nomfournisseur,
                efm.idtva,
                --efm.montantttc,
                efm.remarque                                           AS remarque,
                efm.dateemission,
                efm.designation,
                efm.iddevise,
                efm.numfact,
                efm.datyecheance,
                efm.etat,
                dff.NUMID,
                COALESCE(efm.montantpaye, 0)                           AS montantpaye,
                COALESCE(efm.reste, 0)                                 AS reste,
                ''                                                     AS entite,
                dff.montantttc                                         AS montantttdevise,
                ''                                                     AS budget,
                0                                                      AS retenue,
                ff.MONTANt                                             AS montant,


                av.montantavoirttc                                     as montantavoir,
                ad.montantadditifttc                                   as montantadditif,
                (ff.MONTANT - nvl(av.MONTANT, 0) + nvl(ad.montant, 0)) as montantnet,
                nvl(efm.montantht, 0)                                  as montantht,
                nvl(efm.montanttva, 0)                                 as montanttva,
                nvl(efm.montantttc, 0)                                 as montantttc,
                nvl(av.montantavoirht, 0)                              as montantavoirht,
                nvl(av.montantavoirtva, 0)                             as montantavoirtva,
                nvl(av.montantavoirttc, 0)                             as montantavoirttc,
                nvl(ad.montantadditifht, 0)                            as montantadditifht,
                nvl(ad.montantadditiftva, 0)                           as montantadditiftva,
                nvl(ad.montantadditifttc, 0)                           as montantadditifttc
                -- cast((ff.MONTANT - nvl(av.MONTANT, 0) + nvl(ad.montant, 0)) *(efm.IDTVA / 100) as number(25, 2))                                                          as montanttva
FROM etatfacturemontant efm
         JOIN facturefournisseur dff ON dff.id = efm.id
         LEFT JOIN tiers t ON dff.idfournisseur = t.id
         join facturefournisseur_SumMtt ff on ff.id = efm.id
         left join AVOIR_VISESM_grouper av on av.idfacture = ff.id
         left join additif_VISESM_grouper ad on ad.idfacture = ff.id
/



--

create or replace  view ETATFACTUREMONTANTDATY
            (ID, DATY, IDFOURNISSEUR, NOMFOURNISSEUR, IDTVA, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT,
             DATYECHEANCE, ETAT, MONTANTPAYE, RESTE, ENTITE, MONTANTTTDEVISE, BUDGET, RETENUE, NUMID, TIERSLIB, TVA,
             MONTANT, MONTANTAVOIR, MONTANTADDITIF, MONTANTNET, MONTANTTVA, MONTANTTTC, MONTANTTOTALAPAYER, TYPE)
as
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
           END                                                   AS etat,
       nvl(et.montantpaye, 0)                                      as montantpaye,
       RESTE                                                     AS reste,
       et.entite,
       et.montantttdevise,
       et.budget,
       et.retenue,
       et.NUMID,
       t.NOM                                                     as tierslib,
       et.IDTVA                                                  as tva,
       et.montantht + et.montantadditifht - et.montantavoirht    as montant,
       (et.montantavoir),
       (et.montantadditif),
       (et.montantnet),
       et.montanttva + et.montantadditiftva - et.montantavoirtva as montanttva,
       et.montantttc + et.montantadditifttc - et.montantavoirttc as montantttc,
       et.montantttc + et.montantadditifttc - et.montantavoirttc as montantTotalApayer,
       ff.TYPE
FROM etatfacturemontantdatyretenu et
         join facturefournisseur_SumMtt ff on ff.id = et.id
         left join TIERS t on t.id = et.idfournisseur
/