package affichage;

import java.sql.Connection;
import java.lang.reflect.Field;
import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Date;
import javax.servlet.http.HttpServletRequest;
import utilitaire.Utilitaire;

/**
 * Description: </p>
 * <p>
 * Copyright: Copyright (c) 2005</p>
 * <p>
 * Company: </p>
 *
 * @author unascribed
 * @version 1.0
 */
public class PageUpdate extends PageInsert {

    private bean.ClassMAPTable critere;

    public PageUpdate(ClassMAPTable o, HttpServletRequest req, user.UserEJB u) throws Exception {
        setCritere(o);
        setReq(req);
        setUtilisateur(u);
        makeCritere();
        getData();
        makeFormulaire();
        if (getFormu().getChamp("id") != null) {
            getFormu().getChamp("id").setAutre("readonly");
        }
    }

    public void getData() throws Exception {
        ClassMAPTable[] result = (ClassMAPTable[]) getUtilisateur().getData(getCritere(), null, null, null, "");
        if (result == null || result.length == 0) {
            throw new Exception("Pas de resultat pour votre consultation");
        }
        setBase(result[0]);
    }

    public void makeHtml() {
    }

    public void makeCritere() throws Exception {
        String valeur = getReq().getParameter(getCritere().getAttributIDName());
        Field f = CGenUtil.getField(getCritere(), getCritere().getAttributIDName());
        CGenUtil.setValChamp(getCritere(), f, valeur);
    }

    public void makeFormulaire() throws Exception {
        formu = new Formulaire();
        affichage.Champ[] t = null;
        bean.Champ[] f = bean.ListeColonneTable.getFromListe(getBase(), null);
        // for(int i=)
        t = new Champ[f.length];
        for (int i = 0; i < t.length; i++) {
            //System.out.println(" type java ============== " + f[i].getTypeJava());
            t[i] = new Champ(f[i].getNomColonne());
            t[i].setLibelle(f[i].getNomColonne());
            if (f[i].getNomColonne().compareToIgnoreCase(getBase().getAttributIDName()) == 0) {
                //t[i].setAutre("readonly='readonly'");
                t[i].setType("hidden");
            }
            if(f[i].getNomColonne().compareToIgnoreCase(getBase().getAttributIDName())==0) t[i].setType("hidden");
            if (f[i].getTypeJava().compareToIgnoreCase("java.sql.Date") == 0) {//si le champ est de type date one le met de la forme dd/mm/yyyy
                Object ret = (CGenUtil.getValeurFieldByMethod(getBase(), f[i].getNomColonne()));
                String valDate = null; if(ret!=null) valDate = ret.toString();
                //Date daty = Utilitaire.string_date("dd/MM/yyyy", valDate);
                //System.out.println(" valeur ========== " + daty);
                //String val = Utilitaire.formatterDaty(daty);
                t[i] = new ChampDate(f[i].getNomColonne(),"UPDATE");
                t[i].setLibelle(f[i].getNomColonne());
                //System.out.println(" ========== " + val);
                t[i].setValeur(valDate);
            }
            if (f[i].getTypeJava().compareToIgnoreCase("double") == 0){
                double val = (double)CGenUtil.getValeurFieldByMethod(getBase(), f[i].getNomColonne());
                t[i].setValeur(Utilitaire.doubleWithoutExponential(val));
            }
            else
            {
                t[i].setValeur(String.valueOf(CGenUtil.getValeurFieldByMethod(getBase(),f[i].getNomColonne())));
            }
      }
      formu.setListeChamp(t);
      formu.setObjet(critere);
      //formu.getChamp(getBase().getAttributIDName()).setAutre("readonly='readonly'");
  }
    public bean.ClassMAPTable getCritere() {
        return critere;
    }

    public void setCritere(bean.ClassMAPTable critere) {
        this.critere = critere;
    }

}
