   CREATE TABLE tiers_patrimoine 
   (	ID VARCHAR2(100) CONSTRAINT PK_tiers_patrimoine PRIMARY KEY, 
	NOM VARCHAR2(500), 
	DESCRIPTION VARCHAR2(500), 
	NIF VARCHAR2(200), 
	STAT VARCHAR2(200), 
	CONTACT VARCHAR2(100), 
	RESPONSABLE VARCHAR2(200), 
	ADRESSE VARCHAR2(200), 
	TYPE VARCHAR2(200), 
	ETAT NUMBER(10,0)
	
   );

     
    create view union_clientmat_tiers_pat as
    select cdclt as id ,
           nomclt as val,
           adrclt as desce
    from clientmat 
union select id,
                nom as val,
                adresse as desce
                from tiers_patrimoine;

      create view DETAILSPATRIMOINE_LIB as 
        select det.id,
                pa.libelle as idpatrimoine,
                det.natureObjet,
                 det.surfaceOccupe,            
                 det.surfaceDisponible,
                   det.remarque,
                   u.val  as utilisateur,
                   det.date_debut_contrat,
                   det.date_fin_contrat
        
        from Details_Patrimoine det 
                left join union_clientmat_tiers_pat u on u.id=det.utilisateur
                left join patrimoine pa on pa.id=det.idpatrimoine;


                 CREATE VIEW Details_Patrimoine_GROOUPER AS
           select IDPATRIMOINE, SUM(SURFACEOCCUPE) AS SURFACEOCCUPE  from Details_Patrimoine GROUP BY IDPATRIMOINE;

              CREATE VIEW Patrimoine_I AS
        select PAT.*,
               NVL(de.surfaceoccupe,0) AS surfaceoccupe
        from Patrimoine PAT
               LEFT JOIN Details_Patrimoine_GROOUPER DE ON DE.IDPATRIMOINE=PAT.ID;

          CREATE OR REPLACE VIEW PATRIMOINELIB_ANALYSE_SUP
           (ID, IDOBJET, IDTYPEPATRIMOINE, REMARQUE, ETAT, LIBELLE, DESCRIPTION, MONTANT, OCCUPANT, DEBUT_CONTRAT, FIN_CONTRAT, UTILISATION, NOMBRE,SUPERFICIE_OCCUPEE,SUPERFICIE_DISPONIBLE) AS
            (select AN.*,
            CAST(pat.surfaceoccupe AS NUMBER(10,2)) AS SUPERFICIE_OCCUPEE ,
            CAST(PAT.SUPERFICIE AS NUMBER(10,2)) AS SUPERFICIE_DISPONIBLE
            from patrimoinelib_analyse AN
                JOIN Patrimoine_I PAT ON PAT.ID=AN.ID);