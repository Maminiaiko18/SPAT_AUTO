package mg.spat;


public class GestionProfil {
    private ActeProfil[] liste;

    public ActeProfil[] getListe() {
        return liste;
    }

    public void setListe(ActeProfil[] liste) {
        this.liste = liste;
    }

    public GestionProfil() {
    }

    
    public GestionProfil(ActeProfil[] liste) {
        this.liste = liste;
    }
    public boolean estAutorise(String id, String nomTable, String action){
        boolean retour = false;
        if(liste!=null){
            for(int i=0; i<liste.length; i++){
                if(liste[i].getNomTable().compareTo(nomTable)==0 &&
                    (liste[i].getAction().compareTo(action)==0 || 
                    liste[i].getAction().compareTo("*")==0) ) {
                    return true;
                }
            }
        }
        
        return retour;
    }
    
}

