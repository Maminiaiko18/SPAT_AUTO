
------------nampiana etat ny liaisonengagement

ALTER TABLE LIAISONENGAGEMENT ADD etat integer;
--mila atao ity update ity
--UPDATE LIAISONENGAGEMENT SET etat =11;

CREATE OR REPLACE VIEW liaisonengagement_valide AS 
 SELECT l.* FROM liaisonengagement l
 JOIN AS_BONDECOMMANDE_grp a ON l.ID2=a.IDBC
 where l.etat>=11
UNION 
 SELECT l.* FROM liaisonengagement l
 JOIN factfournmfvalide_grp f ON f.idmere=l.ID2 
 where l.etat>=11;
