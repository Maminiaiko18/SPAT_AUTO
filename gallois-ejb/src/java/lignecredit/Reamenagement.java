package lignecredit;

import java.sql.Connection;

import bean.ClassEtat;

public class Reamenagement extends ClassEtat {
    private String id;
    private String idLigneDepart, idLigneDepartLib, idLigneArrive, idLigneArriveLib;
    private double montant;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdLigneDepart() {
        return idLigneDepart;
    }

    public void setIdLigneDepart(String idLigneDepart) {
        this.idLigneDepart = idLigneDepart;
    }

    public String getIdLigneDepartLib() {
        return idLigneDepartLib;
    }

    public void setIdLigneDepartLib(String idLigneDepartLib) {
        this.idLigneDepartLib = idLigneDepartLib;
    }

    public String getIdLigneArrive() {
        return idLigneArrive;
    }

    public void setIdLigneArrive(String idLigneArrive) {
        this.idLigneArrive = idLigneArrive;
    }

    public String getIdLigneArriveLib() {
        return idLigneArriveLib;
    }

    public void setIdLigneArriveLib(String idLigneArriveLib) {
        this.idLigneArriveLib = idLigneArriveLib;
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

    public Reamenagement() {
        this.setNomTable("REAMENAGEMENT");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("REAM", "getseqreamenagement");
        this.setId(makePK(c));
    }

    public void createAvenant(String u, Connection c) throws Exception {
        AvenantBudget surplus = new AvenantBudget();
        surplus.setIdLigneCredit(this.idLigneArrive);
        surplus.setMontant(this.montant);
        surplus.setSource(this.id);
        surplus.createObject(u, c);

        AvenantBudget moins = new AvenantBudget();
        moins.setIdLigneCredit(this.idLigneDepart);
        moins.setMontant(-1 * this.montant);
        moins.setSource(this.id);
        moins.createObject(u, c);
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        this.createAvenant(u, c);
        this.setNomTable("REAMENAGEMENT");
        return super.validerObject(u, c);
    }

}
