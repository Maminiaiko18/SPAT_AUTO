update menudynamique set libelle = 'Prévision' where id = 'MEN0081';
update menudynamique set id_pere = 'MEN0006' where id = 'MEN00211';
Insert into USERHOMEPAGE (ID,CODESERVICE,CODEDIR,IDROLE,URLPAGE) values ('USM0001',null,null,'dg','capitainerie/tableau-affichage.jsp');

CREATE OR REPLACE VIEW POSTEDESTINATAIRELIBTYPEQUAIS (ID, IDQUAI, INTERNE, PAYS, IDPAYS, LONGUEUR, PROFONDEUR, TIRANT, QUAI) AS 
  select p.id,
       q.VAL as idquai,
       tp.val,
       p1.VAL as pays,
       p.pays as idpays,
       longueur,
       profondeur,
       tirant,
       q.VAL  as quai
from POSTEDESTINATAIRE p
         join quais q on q.id = p.QUAI
         join pays p1 on p1.id = p.PAYS
         join typequais tp on q.typequais = tp.id;