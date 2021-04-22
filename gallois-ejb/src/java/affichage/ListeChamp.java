/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package affichage;

import java.util.List;

/**
 *
 * @author tahina
 */
public class ListeChamp {
    Champ[] listeChamp;
    Formulaire formu;

    public Formulaire getFormu() {
        return formu;
    }

    public void setFormu(Formulaire formu) {
        this.formu = formu;
    }

    public ListeChamp(Champ[]ls) throws Exception
    {
        setListeChamp(ls);
    }
    public ListeChamp(List<Champ> ls) throws Exception
    {
        setListeChamp(ls);
    }
    public ListeChamp(Formulaire f,List<Champ> ls) throws Exception
    {
        setListeChamp(ls);
        setFormu(f);
    }
    public Champ[] getListeChamp() {
        return listeChamp;
    }

    public void setListeChamp(Champ[] listeChamp) {
        this.listeChamp = listeChamp;
    }
    public void setListeChamp(List<Champ> listeCham) {
        int i=0;
        listeChamp=new Champ[listeCham.size()];
        for(Champ c:listeCham)
        {
            listeChamp[i]=c;
            i++;
        }
    }
    public void setVisible(boolean sv) throws Exception
    {
        for(Champ e:getListeChamp())
        {
            e.setVisible(sv);
        }
        
    }
    public void setValeur(Object val) throws Exception
    {
        for(Champ e:getListeChamp())
        {
            e.setValeur(val.toString());
        }
    }
    public void setAutre(String autre) throws Exception
    {
        for(Champ e:getListeChamp())
        {
            e.setAutre(autre);
        }
    }
    
    public void setAutocomplete(String aff,String val,String nomT,String aW)throws Exception
    {
        for(Champ e:getListeChamp())
        {
            e.setAutocomplete(aff, val, nomT, aW);
        }
    }
    public void setDeroulanteDependante(String autre,String nomColonneFiltreAutre,String event)throws Exception
    {
        int i=0;
        for(Champ e:getListeChamp())
        {
            Liste mere=(Liste)e;
            mere.setDeroulanteDependante(this.getFormu() ,autre+"_"+i, nomColonneFiltreAutre, event);
            i++;
        }
    }
    
}
