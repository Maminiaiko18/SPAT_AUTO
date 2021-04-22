/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

/**
 *
 * @author MEVA
 */
public class JournalCompta {
    private String titre, type;
    private ComptaJournal[] comptaJournal;

    public JournalCompta() {
    }

    public JournalCompta(String titre, String type, ComptaJournal[] comptaJournal) {
        this.titre = titre;
        this.type = type;
        this.comptaJournal = comptaJournal;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public ComptaJournal[] getComptaJournal() {
        return comptaJournal;
    }

    public void setComptaJournal(ComptaJournal[] comptaJournal) {
        this.comptaJournal = comptaJournal;
    }
    
}
