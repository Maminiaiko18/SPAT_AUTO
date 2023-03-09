create view ffregul_vise as 
select * from ffregul 
where etat>=11;

create or replace view BON_PROVISOIRE_LIBCOMPLET as
SELECT bnp.*,
       c.VAL AS valcaisse,
       DESCE AS descecaisse,
       uni.NOM||' '||uni.PRENOM as beneficiairelib
FROM bon_provisoire_rst bnp
         JOIN caisse c ON bnp.CAISSE = c.ID
         left join v_union_personnel uni on uni.id=bnp.BENEFICIAIRE
/
