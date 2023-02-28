
-----------add column (montantbudget, montantav, montantap)
ALTER TABLE BORDEREAUFF 
ADD (montantbudget number(30,2),
montantav number(30,2),
montantap number(30,2));


------------add column(montantbudget, montantav, montantap)
CREATE OR REPLACE  VIEW BORDEREAUFF_LIBCOMPLET (ID, DATY, NUMERO, DESIGNATION, ETAT, TIERS, TIERSLIB,montantbudget, montantav, montantap) AS 
  select br.ID,br.DATY,br.NUMERO,br.DESIGNATION,br.ETAT,br.TIERS,
           fup.NOM as tierslib,montantbudget, montantav, montantap
        from bordereauFF br
        left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id=br.TIERS;



------------add column(montantbudget, montantav, montantap)
CREATE OR REPLACE  VIEW BORDEREAUFF_LIB_MONTANT (ID, DATY, NUMERO, DESIGNATION, ETAT, TIERS, MONTANT,montantbudget, montantav, montantap) AS 
  SELECT bf.ID,
       bf.DATY,
       bf.NUMERO,
       bf.DESIGNATION,
       bf.ETAT,
       bf.TIERSLIB  as TIERS,
       NVL(MO.MONTANT, 0) as montant,
       montantbudget,
       montantav,
       montantap
FROM BORDEREAUFF_LIBCOMPLET BF
         LEFT JOIN LIAISONBORDEREAUFF_SUM_MONTANT MO ON MO.IDBORDEREAU = BF.ID;

        