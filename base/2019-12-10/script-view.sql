
  CREATE OR REPLACE FORCE VIEW V_ANALYSE_BON_COMMANDE_ANALYSE AS 
  (select * from V_ANALYSE_BON_COMMANDE);
  
  
  CREATE OR REPLACE FORCE VIEW factureConcessionnaire_Analyse as
  (select * from analysefactureConcessionnaire);
  
  
  CREATE OR REPLACE FORCE VIEW factureconventionnel_Analyse as
  (select * from analysefactureconventionnel); 
  
  
  CREATE OR REPLACE FORCE VIEW analyseecriture_Analyse as
  (select * from analyseecriture);
 

  CREATE OR REPLACE FORCE VIEW analyseglobalefacture_Analyse as
  (select * from analyseglobalefacture);
  
  
  CREATE OR REPLACE FORCE VIEW patrimoinelib_analyse_Analyse as
  (select * from patrimoinelib_analyse);
  
  
  CREATE OR REPLACE FORCE VIEW analyse_personnelmat_Analyse as
  (select * from analyse_personnelmat);
  
  
  CREATE OR REPLACE FORCE VIEW PLACEMENTLIBCOMPLET_Analyse as
  (select * from PLACEMENTLIBCOMPLET);
  
  
   CREATE OR REPLACE FORCE VIEW STAT_ACTIVITE_LIB_Analyse as
  (select * from STAT_ACTIVITE_LIB);
  