package bean;

import java.sql.ResultSet;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AssociationTableUtil extends GenUtil {

  public AssociationTableUtil() {
    super("AssociationTable","bean.AssociationTable");
  }
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
   /**@todo Implement this bean.GenUtil abstract method*/
   throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
  public AssociationTable[] findAssociationTable(String id, String t1, String t2,String vueLettre,String vueComplet,String tUnion)
     throws Exception
 {
     try
     {
         //UnionIntraTableUtil to = new UnionIntraTableUtil();
         int a[] = {1,2,3,4,5,6};
         String val[] = {id,t1,t2,tUnion,vueLettre,vueComplet};
         AssociationTable at[] = (AssociationTable[])rechercher(a, val);
         return at;
     }
     catch(Exception ex)
     {
       ex.printStackTrace();
         throw new Exception("Erreur dans AssociationTableUtil "+ex.getMessage());
     }
    }
}