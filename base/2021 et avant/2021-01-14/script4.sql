
create view MODEPAIEMENTCV as
    select *
        from MODEPAIEMENT where id in('pay2','pay3');
-- Auto-generated SQL script #202101141410
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND0000201','Consignataire','fa fa-cog',4,3,'MEN00740');
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE)
	VALUES ('MEND0000202','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=capitainerie/consignataire-liste.jsp',1,4,'MEND0000201');


CREATE VIEW ANALYSEGLOBALEFACTURE_PAYE AS
select *
from ANALYSEGLOBALEFACTURE
where reste = 0;

CREATE VIEW ANALYSEGLOBALEFACTURE_NON_PAYE AS
select *
from ANALYSEGLOBALEFACTURE
where reste > 0; 

    
