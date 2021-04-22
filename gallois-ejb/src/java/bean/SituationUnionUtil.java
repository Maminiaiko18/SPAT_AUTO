package bean;

import java.sql.*;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class SituationUnionUtil extends GenUtil {

  public SituationUnionUtil() {
    super("situationDedBc","bean.SituationUnion");
  }
  public SituationUnion[] findSituationUnion(String nomTable,String id)
  {
    this.setNomTable(nomTable);
    return (SituationUnion[]) this.rechercher(1,id) ;
  }
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
    /**@todo Implement this bean.GenUtil abstract method*/
    throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
}