package facture;

import java.sql.Date;
import bean.ClassMAPTable;

public class SuiviProvision extends ClassMAPTable{
    private String id;
    private Date daty;
    private String caisse;
    private String numpiece;
    private String libelle;
    private double credit;
    private String tiers;
    private double montant;
    private String code;
    private String codeprovision;
    private String numcheque;
    private Date datefacture;
    private double montantprovision;
    private Date dateliaison;
    private Date datepaiement;

    public Date getDatepaiement() {
        return datepaiement;
    }

    public void setDatepaiement(Date datepaiement) {
        this.datepaiement = datepaiement;
    }

    public String getNumcheque() {
        return numcheque;
    }

    public void setNumcheque(String numcheque) {
        this.numcheque = numcheque;
    }

    public Date getDateliaison() {
        return dateliaison;
    }

    public void setDateliaison(Date dateliaison) {
        this.dateliaison = dateliaison;
    }

    public double getMontantprovision() {
        return montantprovision;
    }

    public void setMontantprovision(double montantprovision) {
        this.montantprovision = montantprovision;
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

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public String getNumpiece() {
        return numpiece;
    }

    public void setNumpiece(String numpiece) {
        this.numpiece = numpiece;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCodeprovision() {
        return codeprovision;
    }

    public void setCodeprovision(String codeprovision) {
        this.codeprovision = codeprovision;
    }

    public Date getDatefacture() {
        return datefacture;
    }

    public void setDatefacture(Date datefacture) {
        this.datefacture = datefacture;
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
}
