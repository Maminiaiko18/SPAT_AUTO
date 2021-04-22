package bean;

import java.lang.reflect.Field;
import utilitaire.Utilitaire;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AdminTypeObjet extends AdminGen {

  public AdminTypeObjet() {
  }
  public static TypeObjet getFromListe(TypeObjet[] liste,String val, String nomCol)
  {
    try {
      TypeObjet temp=new TypeObjet();
      Field[] fl=temp.getFieldList();
      String nomMethode="get"+Utilitaire.convertDebutMajuscule(nomCol);
      for (int k=0;k<liste.length;k++)
      {
        String valGauche=(String)(liste[k].getClass().getMethod(nomMethode,null).invoke(liste[k],null));
          if(valGauche.compareToIgnoreCase(val)==0)
            temp=liste[k];
      }
      return temp;
    }
    catch (Exception ex) {
      return null;
    }
  }
}