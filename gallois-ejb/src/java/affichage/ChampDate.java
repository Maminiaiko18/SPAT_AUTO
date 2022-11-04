package affichage;

import utilitaire.Utilitaire;

public class ChampDate extends Champ{
    
    private final String MODEUPDATE = "UPDATE";
    private String mode = "";
    
    public ChampDate(){
        super();
    }
    
    public ChampDate(String nom){
        super(nom);
    }
    
    public ChampDate(String nom, String mode){
        super(nom);
        this.mode = mode;
    }
    
    public void makeHtml() throws Exception{
        String temp = "";
        String val = getValeur();
        System.out.println("mode " + mode);
        if(mode.compareToIgnoreCase(MODEUPDATE) == 0){
            val = Utilitaire.convertDatyFormtoRealDatyFormat(getValeur());
        }else{
            val = Utilitaire.dateDuJour();
        }
        if(getVisible()==false)
        {
            temp = "<input name=" + getNom() + " type='hidden' class=" + getCss() + "  id=" + getNom() + " value='" + val + "' onmouseover=\"datepicker('"+getNom()+"')\" " + getAutre() + ">";
        }
        else {
            temp = "<input name=" + getNom() + " type=" + getType() + " class=" + getCss() + "  id=" + getNom() + " value='" + val + "' onmouseover=\"datepicker('"+getNom()+"')\" " + getAutre() + ">";
        }
        setHtml(temp);
    }
}
