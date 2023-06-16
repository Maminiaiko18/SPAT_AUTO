package mg.spat;

import java.sql.Connection;
import java.sql.Date;

import avoir.AvoirFC;
import bean.ClassEtat;

public class AdditifJc extends ClassEtat{
    private String id;
    private Date daty;
    private String idjc;
    private double montant;
    private String remarque;
    private String etatlib;

     public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        JournalCaisse jc  = new JournalCaisse();
        jc.setNomTable("journalcaisse");
        jc = (JournalCaisse)jc.getById(this.getIdjc(), null, c);
        jc.setMontant(jc.getMontant()+this.getMontant());
        jc.updateToTableWithHisto(u, c);
        super.validerObject(u, c);
        return this;
    }

     public AdditifJc() {
        this.setNomTable("AdditifJc");
    }

    public String getIdjc() {
        return idjc;
    }

    public void setIdjc(String idjc) {
        this.idjc = idjc;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("ADD", "getseqAdditifJc");
        this.setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
       return this.id;
    }
    @Override
    public String getAttributIDName() {
        return "id";
    }
}
