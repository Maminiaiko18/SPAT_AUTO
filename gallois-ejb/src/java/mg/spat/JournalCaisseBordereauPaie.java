package mg.spat;
import java.sql.Date;
/**
 * View manambatra n Journal Caisse sy ny Ordrement de Paimement 
*/
public class JournalCaisseBordereauPaie extends JournalCaisse{
    private String idFF,numFact,tiersLib,caisse;
    private double montanttotal,montant;
    private Date daty;
    private String observation;

    public Date getDaty(){
        return this.daty;
    }
    public String getObservation() {
        return observation;
    }
    public void setObservation(String observation) {
        this.observation = observation;
    }
    public void setDaty(Date d){
        this.daty=d;
    }
    public String getIdFF(){
        return this.idFF;
    }
    public String getNumFact(){
        return this.numFact;
    }
    public String getTiersLib(){
        return this.tiersLib;
    }
    public String getCaisse(){
        return this.caisse;
    }
    public double getMontantTotal(){
        return this.montanttotal;
    }
    public double getMontant(){
        return this.montant;
    }
    public void setIdFF(String idFF){
        this.idFF=idFF;
    }
    public void setNumFact(String numFact){
        this.numFact=numFact;
    }
    public void setTiersLib(String tiersLib){
        this.tiersLib=tiersLib;
    }
    public void setCaisse(String caisse){
        this.caisse=caisse;
    }
    public void setMontantTotal(double montantT){
        this.montanttotal=montantT;
    }
    public void setMontant(double montant){
        this.montant=montant;
    }
    public JournalCaisseBordereauPaie(){
        this.setNomTable("JOURNALCAISSE_BORDEREAUPAIE");
    }
}
