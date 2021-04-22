/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mihary
 */
public class JournalCaisseSubReport {
    List<JournalCaisse> journal;

    public JournalCaisseSubReport(JournalCaisse debit,JournalCaisse[] credit) {
        List liste = new ArrayList();
        for(JournalCaisse c : credit){
            liste.add(c);
        }
            liste.add(debit);
        this.setJournal(liste);  
    }

    public List<JournalCaisse> getJournal() {
        return journal;
    }

    public void setJournal(List<JournalCaisse> journal) {
        this.journal = journal;
    }

}
