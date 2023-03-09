CREATE OR REPLACE VIEW ETATBPVRAI
(
   ID,
   MONTANTFACTURE,
   MONTANTPROVISION,
   MONTANTPAYE,
   ECART,
   TIERS,
   TIERSLIB,
   DATY,
   TIERSPROVISION,
   TIERSLIBPROVISION,
   MONTANTRESTE,
   IDPROVISION
)
AS
     SELECT fu.id,
            SUM (NVL (FCUV.MONTANTTTC, 0)) AS montantfacture,
            SUM (fu.MONTANTTTC) AS montantprovision,
            SUM (fu.MONTANTPAYE) AS MONTANTPAYE,
            0 AS ecart,
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0)
               AS MONTANTRESTE,
            ''
       FROM factfourn_msum_lib fu
            LEFT JOIN factfourn_msum_libv FCUV ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib;

CREATE OR REPLACE VIEW LIAISONINTRATABLE_OP_PARFACT_F (ID2, DED_ID, MONTANT, MONTANTOP, NUMFACT) AS
  select op.ID2,
       op.DED_ID,
       sum(OP.MONTANT)                                       as montant,
       sum(op.MONTANTOP)                                        as MONTANTOP,
       LISTAGG(ff.NUMFACT, ';') WITHIN GROUP ( ORDER BY OP.ID1) as numfact
from LIAISONINTRATABLE_OP_VISE OP
         JOIN etatfacturemontantdaty FF ON FF.ID = OP.ID1
group by op.ID2, op.DED_ID;


create view FACTUREFOURNVALIDE as
select * from factfourn_msum_lib where idcategorie<>'CATGFF002';


create view FACTUREFOURNVALIDE_C as
select * from FACTUREFOURNVALIDE where etat=1;

create view FACTUREFOURNVALIDE_V as
select * from FACTUREFOURNVALIDE where etat>=11 and id not in (select id1 from LIAISONINTRATABLE);

create view BPvalide as
select * from factfourn_msum_lib where IDCATEGORIE='CATGFF002';



create view BPvalide_C as
select * from BPvalide where etat=1;

create view BPvalide_V as
select * from BPvalide where etat>=11;

create table REGULFFPROVISION
(
    ID          VARCHAR2(100) not null
        constraint PK_REGULFFPROVISION
            primary key,
    IDPROVISION VARCHAR2(100)
        constraint FK_FACTFOURN_MERE_PROVISIONFF
            references FACTURE_FOURNISSEUR_MERE,
    IDFACTURE   VARCHAR2(100)
        constraint FK_FACTFOURNMERE_REGULFFPROV
            references FACTURE_FOURNISSEUR_MERE,
    ETAT        NUMBER(10)
);


CREATE SEQUENCE seq_REGULFFPROVISION
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_REGULFFPROVISION
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_REGULFFPROVISION.nextval INTO retour FROM dual;
    return retour;
END;


CREATE VIEW REGULFFPROVISIONLIB
            (ID, IDPROVISION, IDFACTURE, ETAT, IDPROVISIONCODE, IDFACTURECODE, ETATLIB) AS
select r.ID,
       r.IDPROVISION,
       r.IDFACTURE,
       r.ETAT,
       f2.code as idprovisioncode,
       f.CODE  as idfacturecode,
       case
           when r.etat = 1 then 'CREE'
           when r.etat >= 11 then 'VISE'
           end as etatlib
from regulFFProvision r
         left join FACTURE_FOURNISSEUR_MERE F on r.IDFACTURE = F.ID
         left join FACTURE_FOURNISSEUR_MERE F2 on r.IDPROVISION = F2.ID;




create view FACTUREFOURNVALIDE_EP as
    select ff.*,
           li.IDJOURNAL,
           li.ETATJC
        from FACTUREFOURNVALIDE  ff
             join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1=ff.ID
where li.IDJOURNAL is null ;

create view FACTUREFOURNVALIDE_P as
    select ff.*,
           li.IDJOURNAL,
           li.ETATJC
        from FACTUREFOURNVALIDE  ff
             join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1=ff.ID;
			 
			 
create or replace view FACTUREFOURNVALIDE_P as
select ff.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       ff.ETAT,
       IDPREVISION,
       ff.MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       ESTDDPMICTSL,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       'PAYE' as ETATLIB
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
where li.IDJOURNAL is not null
  and li.ETATJC = 11;
  
  

create or replace view FACTUREFOURNVALIDE_EP  as
select ff.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       ff.ETAT,
       IDPREVISION,
       ff.MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       ESTDDPMICTSL,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       'ATTENTE DE PAIEMENT' as ETATLIB
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
where ( li.IDJOURNAL is not null
  and li.ETATJC = 1) ;

  
create or replace view FACTUREFOURNVALIDE_V as
select ff.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       ff.ETAT,
       IDPREVISION,
       ff.MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       ESTDDPMICTSL,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       'VISE' as ETATLIB
from FACTUREFOURNVALIDE ff
       left  join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
where (li.IDJOURNAL is  null);


create view FACTUREFOURNVALIDE_TOUS as
select *
from FACTUREFOURNVALIDE_C
union
    select *
from FACTUREFOURNVALIDE_V
union
    select *
from FACTUREFOURNVALIDE_ep

union
    select *
from FACTUREFOURNVALIDE_p;



UPDATE MENUDYNAMIQUE
SET LIBELLE='Saisie', ICONE='fa fa-plus', HREF='/spat/pages/globalnegoce.jsp?but=facture/facture-fournisseur-saisie-vaovao.jsp&mode=1', RANG=2, NIVEAU=5, ID_PERE='MEN00147'
WHERE ID='MEN00149';

UPDATE MENUDYNAMIQUE
SET LIBELLE='Liste', ICONE='fa fa-list', HREF='/spat/pages/globalnegoce.jsp?but=treso/bon-provisoire-liste-nouveau.jsp', RANG=1, NIVEAU=5, ID_PERE='MEN00147'
WHERE ID='MEN00148';

UPDATE MENUDYNAMIQUE
SET LIBELLE='Analyse', ICONE='fa fa-list', HREF='/spat/pages/globalnegoce.jsp?but=treso/bon-provisoire-analyse-nouveau.jsp', RANG=3, NIVEAU=5, ID_PERE='MEN00147'
WHERE ID='MEND00112251';

UPDATE MENUDYNAMIQUE
SET LIBELLE='Etat des bons', ICONE='fa fa-line-chart', HREF='/spat/pages/globalnegoce.jsp?but=treso/etat-bon-provisoire.jsp', RANG=3, NIVEAU=5, ID_PERE='MEN00147'
WHERE ID='MEN00150Z';