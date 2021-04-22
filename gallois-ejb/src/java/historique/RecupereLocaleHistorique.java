package historique;

import javax.naming.*;

/**
 * <p>Title: Gestion des recettes : société de gestion du port de toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class RecupereLocaleHistorique {
  public static HistoriqueLocalHome recupHome(){
	      try {
		      Context ctx=new InitialContext();
		      Object objRef=ctx.lookup("HistoriqueVVLocal");
		      HistoriqueLocalHome pcLHome=(HistoriqueLocalHome)objRef;
		      return pcLHome;
	      }
	      catch (NamingException ex) {
		      return null;
	      }
    }
}
