package affichage;

import utilitaire.Utilitaire;

public class ChampCalcul extends Champ{
    public ChampCalcul(){
        super();
    }
    
    public ChampCalcul(String nom){
        super(nom);
    }
    
    public void makeHtml() throws Exception{
        String temp = "";
        if(getVisible()==false)
        {
            temp = "<input name=" + getNom() + " type='hidden' class=" + getCss() + "  id=" + getNom() + " value='" + Utilitaire.doubleWithoutExponential(Utilitaire.stringToDouble(getValeur())) + "' onblur=\"calculer('"+getNom()+"')\" " + getAutre() + ">";
        }
        else {
            temp = "<input name=" + getNom() + " type=" + getType() + " class=" + getCss() + "  id=" + getNom() + " value='" + Utilitaire.doubleWithoutExponential(Utilitaire.stringToDouble(getValeur())) + "' onblur=\"calculer('"+getNom()+"')\" " + getAutre() + ">";
        }
        setHtml(temp);
    }
}
