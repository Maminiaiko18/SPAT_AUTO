
create or replace view JOURNALCAISSELIBDEPENSEV as
select * from JOURNALCAISSELIBDEPENSE where etat>=11;

create or replace view JOURNALCAISSELIBRECETTE_VISE as
select *
from JOURNALCAISSELIBRECETTE
where etat = 11;


create view ficheSuiviBudgetVide as
select cast('-' as VARCHAR2(500)) as codeEtb,
       cast('-' as VARCHAR2(500)) as codeProjet,
       cast(sysdate as date) as daty,
       cast(0 as number(10))annee,
       cast('-' as VARCHAR2(500)) as numFacture  from dual;

	   
	   INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MENBDG00031', 'Fiche de suivi budgétaire', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=ligneCredit/fiche-de-suivi-budgétaire.jsp', 3, 3, 'MENBDG0001');

INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MEN00000123', 'Etat ', 'fa fa-check-square', '/spat/pages/globalnegoce.jsp?but=treso/journalcaisse-etat.jsp', 6, 5, 'MEN0031');