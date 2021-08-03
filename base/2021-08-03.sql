alter table coursdevise add estMICTSL varchar2(200);
CREATE OR REPLACE VIEW coursdeviselib AS
SELECT  CDV.*,
        CASE
            WHEN CDV.ESTMICTSL = 0 THEN 'NON'
            WHEN CDV.ESTMICTSL = 1 THEN 'OUI'
            END AS estMICTSLlib
FROM COURSDEVISE CDV;

create or replace view coursdeviseNonMICTSL  as select * from coursdevise where estMICTSL is null or estMICTSL<>1;

alter table facture_client_fille add reduction number(20,2);
alter table facture_client_fille add majoration number(20,2);
alter table factureclient add estDDPMICTSL varchar2(200);