create or replace view recap_caisse as
    select
        jc.dateeffet as daty,
        case
            when cb.id is null then cp.desce
            else cb.desce
        end as libelle,
        jc.numpiece as numero_compte,
		cast(jc.credit - jc.debit as number(10,2)) as montant
    from journalcaisse jc
        left join CAISSE_BANQUE cb on cb.id = jc.caisse
        left join CAISSE_PHYSIQUE cp on cp.id = jc.caisse;

create or replace view recap_treso as
    select
        *
    from recap_caisse
        union
    select
        date_placement as daty,
        'Placement' as libelle,
        null as numero_compte,
        montant
    from placement;
	
alter table placement add banque VARCHAR2(50 BYTE);

delete from banque where id='BANQ000000';
insert into banque values ('BANQ000000','-','-');
update banque set val='-',desce='-' where id='BANQ000000';

alter table placement drop constraint FK_LIAISONPLT;

CREATE OR REPLACE VIEW PLACEMENTLIBCOMPLET ("ID", "ENTITE", "DATE_PLACEMENT", "DATE_ECHEANCE", "DUREE", "MONTANT", "TAUX", "ETAT", "NUMERO", "IDDETAILS", "IDMEREDETAILS", "MOIS", "MONTANT_TERME", "INTERET_RECEVOIR", "INTERET_NET", "IDENTITE", "IDBANQUE", "VALENTITE", "DESCEENTITE", "VALBANQUE", "DESCEBANQUE") AS 
  select
    plt."ID",plt."ENTITE",plt."DATE_PLACEMENT",plt."DATE_ECHEANCE",plt."DUREE",plt."MONTANT",plt."TAUX",plt."ETAT",plt."NUMERO",
    det.ID as iddetails, IDMERE as idmeredetails, MOIS, MONTANT_TERME, INTERET_RECEVOIR, INTERET_NET,
    lp.id as IDENTITE, b.id as IDBANQUE, lp.val as VALENTITE, lp.desce as DESCEENTITE, b.val as VALBANQUE, b.desce as DESCEBANQUE
from placement plt
    join DETAILSPLACEMENT det on plt.ID = det.IDMERE
    join ENTITE lp on lp.id = plt.ENTITE
    join BANQUE b on b.id = plt.banque;
    
CREATE OR REPLACE VIEW PLACEMENTLIBCOMPLETSAVE ("ID", "ENTITE", "DATE_PLACEMENT", "DATE_ECHEANCE", "DUREE", "MONTANT", "TAUX", "ETAT", "NUMERO", "IDDETAILS", "IDMEREDETAILS", "MOIS", "MONTANT_TERME", "INTERET_RECEVOIR", "INTERET_NET", "IDENTITE", "IDBANQUE", "VALENTITE", "DESCEENTITE", "VALBANQUE", "DESCEBANQUE") AS 
  select
    plt."ID",plt."ENTITE",plt."DATE_PLACEMENT",plt."DATE_ECHEANCE",plt."DUREE",plt."MONTANT",plt."TAUX",plt."ETAT",plt."NUMERO",
    det.ID as iddetails, IDMERE as idmeredetails, MOIS, MONTANT_TERME, INTERET_RECEVOIR, INTERET_NET,
    lp.IDENTITE, lp.IDBANQUE, lp.VALENTITE, lp.DESCEENTITE, lp.VALBANQUE, lp.DESCEBANQUE
from placement plt
    join DETAILSPLACEMENT det on plt.ID = det.IDMERE
    join LIAISONPLACEMENTLIBCOMPLET lp on lp.id = plt.ENTITE;
	
insert into menudynamique values ('MEN00174P','Banques','fa fa-money','#',1,3,'MEN0021');

update menudynamique set id_pere='MEN00174P' , rang=1 , niveau=4 where id='MEN00174';
update menudynamique set niveau=5 where id_pere='MEN00174';

update menudynamique set id_pere='MEN00174P' , rang=2 , niveau=4 where id='MEN00171';
update menudynamique set niveau=5 where id_pere='MEN00171';