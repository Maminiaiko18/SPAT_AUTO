package historique;

import bean.*;
import java.sql.*;
import java.util.Vector;


/**
 * <p>Title: Gestion des recettes : Societe du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AnnulationUtilisateurUtil extends GenUtil {

  public AnnulationUtilisateurUtil() {
    super("AnnulationUtilisateur");
  }
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
    /**@todo Implement this bean.GenUtil abstract method*/
    throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
  public Object[] resultatGen (ResultSet rs)
  {
	  try
	  {
		  int i = 0, k = 0;
		  AnnulationUtilisateur temp = null;
		  Vector vect = new Vector();
		  while(rs.next())
		  {                          //String i,String descr, String res, String idEta
			  temp = new AnnulationUtilisateur(rs.getString(1),rs.getString(2),rs.getDate(3));
			  vect.add(i,temp);
			  i++;
		  }

		  AnnulationUtilisateur []retour = new AnnulationUtilisateur[i];

		  while (k < i)
		  {
			  retour[k] = (AnnulationUtilisateur)(vect.elementAt(k));
			  k++;
		  }
		  return retour;
	  }
	  catch (Exception s)
	  {
		  System.out.println("AnnulationUtilisateur "+s.getMessage());
		  return null;
	  }
	  finally
	  {
	    try
	    {
		  if (rs!=null) rs.close();
	    }
	    catch(SQLException e)
	    {
	      System.out.println("Erreur Fermeture SQL AnnulationUtilisateur "+ e.getMessage());
	    }
	  }
  }
}