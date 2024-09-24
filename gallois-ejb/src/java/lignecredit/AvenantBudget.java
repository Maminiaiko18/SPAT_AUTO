package lignecredit;

import java.sql.Connection;

import bean.ClassMAPTable;

public class AvenantBudget extends ClassMAPTable {
    private String id;
    private String idLigneCredit, source;
    private double montant;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdLigneCredit() {
        return idLigneCredit;
    }

    public void setIdLigneCredit(String idLigneCredit) {
        this.idLigneCredit = idLigneCredit;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("AVBD", "getseqavenantbudget");
        this.setId(makePK(c));
    }

    public AvenantBudget() {
        this.setNomTable("AVENANTBUDGET");
    }
    
}
