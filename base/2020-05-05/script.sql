insert into menudynamique values('MENU001','Marque',' fa fa-list','/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=Marque_Materiel','6','4','MEN0046');

insert into typequais values('TYP001','Autre','Autre');

insert into quais values('QS001','Autre','Autre','TYP001');

delete from menudynamique where id='MEN0048';


create materialized view consignatairemat
    refresh force on demand as
     select * from clientmat where cdcat = '000';



DROP MATERIALIZED VIEW consignatairemat;

create materialized view consignatairemat
    refresh force on demand as
     select * from SPAT_ANCIEN_FINANCE.V_CLIENT where cdcat = '000';