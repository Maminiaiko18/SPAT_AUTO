package affichage;

import bean.CGenUtil;
import facture.FactureClientDetails;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.util.ArrayList;
import mg.cnaps.configuration.Configuration;
import mg.spat.exploitant.Activite;
import utilitaire.UtilDB;

public class Essai {

  public Essai() {
  }
  public static void main(String[] args) {
    try{
        Connection c=new UtilDB().GetConn();
        Activite crt=new Activite();
        crt.setId("ACT0000000002190747");
        crt.setNomTable("ACTIVITELIBCOMPLET");
        Activite[] listeAct=(Activite[])CGenUtil.rechercher(crt, null, null, c, "");
        Configuration[] result=(Configuration[])CGenUtil.rechercher(new Configuration(), null, null, c, " and (upper(typeconfig) like 'FACT%' or upper(typeconfig) like 'ACT%')  ");
        Activite.setTousConfig(result);
        ArrayList<FactureClientDetails> lfact= listeAct[0].creerDetailsFacture(c);
        System.out.println("Nb de ligne "+lfact.size());
        for(FactureClientDetails det : lfact)
        {
            System.out.println("pu = "+det.getPu()+" qte = "+det.getQuantite()+" tva "+det.getTva()+" devise "+det.getDevise());
            
        }
    }
    catch(Exception f)
    {
        f.printStackTrace();
      System.out.println("erreur ambany indray e");
    }
  }
}