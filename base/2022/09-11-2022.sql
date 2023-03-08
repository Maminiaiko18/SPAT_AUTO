
CREATE OR REPLACE  VIEW FACTURECLIENTAPAYER (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, CODEFILTRE) AS 
  SELECT ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       ETAT,
       CAST(MONTANT AS NUMBER(35, 3))        AS MONTANT,
       CAST(MONTANTTVA AS NUMBER(35, 3))     AS MONTANTTVA,
       CAST(MONTANTAVOIR AS NUMBER(35, 3))   AS MONTANTAVOIR,
       CAST(MONTANTTTC AS NUMBER(35, 3))     AS MONTANTTTC,
       CAST(MONTANTPAYE AS NUMBER(35, 3))    AS MONTANTPAYE,
       CAST(MONTANTRESTE AS NUMBER(35, 3))   AS MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       ETATLIB,
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
       CAST(MONTANTTTCVRAI AS NUMBER(35, 3)) AS MONTANTTTCVRAI,
       ARMATEURLIB,
       EXERCICE ,
       code as codeFiltre
from FACTURE_CLIENT_UNIONV
where MONTANTRESTE > 0;





Create view FACTURECLIENTENRETARD as
select * from  FACTURE_CLIENT_UNIONV where DATE_ECHEANCE< CURRENT_DATE ;

Create view FACTURECLIENTENALERTE AS 
select v.* from  FACTURE_CLIENT_UNIONV v where (CAST((v.DATE_ECHEANCE-CURRENT_DATE) AS integer))<=10 AND (CAST((v.DATE_ECHEANCE-CURRENT_DATE) AS integer)) >=0;


update detformufact set 
condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''', 
rem='AMAR. ET DESAMAR. PETRO NUIT C' where id='DFF0000000023170526';

insert into detformufact values('DFF0000000023170526X','1','1','1.211','UA048','AMAR. ET DESAMAR. PETRO FERIE C','RB0000000021170447',
'([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''',
'[volumeArrondi]','70681');




CREATE OR REPLACE VIEW ETATPROVISIONVRAI (ID, MONTANTFACTURE, MONTANTPROVISION, MONTANTPAYE, ECART, TIERS, TIERSLIB, DATY, TIERSPROVISION, TIERSLIBPROVISION, MONTANTRESTE, IDPROVISION, IDCATEGORIE) AS 
SELECT fu.id,
       cast(SUM(NVL(FCUV.MONTANTTTC, 0)) as NUMBER(30,3)) AS montantfacture,
       cast(SUM(fu.MONTANTTTC) as NUMBER(30,3)) AS montantprovision,
       cast(SUM(fu.MONTANTPAYE) as NUMBER(30,3)) AS MONTANTPAYE,
       cast(SUM(fu.MONTANTPAYE) - SUM(NVL(FCUV.MONTANTTTC, 0)) as NUMBER(30,3)) AS ecart, --RAP
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
       cast(SUM(fu.MONTANTTTC) - NVL(SUM(FCUV.MONTANTTTC), 0) as NUMBER(30,3))
               AS MONTANTRESTE,
            '',
       fu.idcategorie
       --FROM FACTURECLIENTMSUM_LIB  fu
       FROM FACTURE_CLIENT_UNION  fu
            LEFT JOIN FACTURE_CLIENT_UNION_VISE FCUV
               ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib,
            fu.idcategorie;