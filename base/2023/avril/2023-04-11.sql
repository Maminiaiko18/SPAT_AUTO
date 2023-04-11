------------------------------ 2023-04-07
--------- create table interetplacement

create table InteretPlacement (
    id varchar(100) constraint interetplacement_pk primary key,
    idPlacement constraint interet_placement_fk references Placement(id),
    taux number,
    duree int,
    daty date
);


create sequence seqinteretplacement
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
      
      

CREATE OR REPLACE FUNCTION getseqinteretplacement
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqinteretplacement.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

-----create view
CREATE VIEW PLACEMENTLIB_C
AS
	SELECT 
		* 
	FROM PLACEMENTLIB
	WHERE etat=1;

-----create view
CREATE VIEW PLACEMENTLIB_V
AS 
	SELECT
		* 
	FROM PLACEMENTLIB 
	WHERE etat=11;
-----create view
CREATE VIEW PLACEMENTLIB_EFF as
Select * from placementlib p where EXISTS (select j.idplacement from journalcaisse j WHERE j.IDPLACEMENT=p.id);


-----create view
CREATE OR REPLACE VIEW PLACEMENTLIB_ECHU
AS 
	SELECT
	
		*
	from placementlib 
	where date_echeance < sysdate;


----add column disponible
ALTER TABLE placement ADD  disponible number(30,2);


---------create 
CREATE OR REPLACE VIEW etatjournalcaisselibdepenseC AS 
SELECT *FROM etatjournalcaisselibdepense WHERE ETAT = 1;

--------create 
CREATE OR REPLACE VIEW etatjournalcaisselibdepenseV AS 
SELECT *FROM etatjournalcaisselibdepense WHERE ETAT = 11;

-----
CREATE OR REPLACE  VIEW PLACEMENTLIB AS
SELECT p.*,b.VAL AS banquelib,e.VAL AS valentite FROM placement p
LEFT JOIN BANQUE b ON p.BANQUE = b.id
LEFT JOIN ENTITE e ON e.id = p.ENTITE ;

   
   
   
   
   
   