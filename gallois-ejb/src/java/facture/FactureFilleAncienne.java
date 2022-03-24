/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author Nouta
 */
public class FactureFilleAncienne extends ClassMAPTable{
    private String nmfact,cdtarif,libprt;
    private int id;
    private double qtenb,duree,maj,red,mttligne,mttligar,mtttax,tauxtarif;
    private Date dtprvprt,dtprt,hrprvprt,hrdebprt,hrfinprt;

    public FactureFilleAncienne() {
        super.setNomTable(" FACTPRTMAT");
    }
    

    public String getNmfact() {
        return nmfact;
    }

    public void setNmfact(String nmfact) {
        this.nmfact = nmfact;
    }

    public String getCdtarif() {
        return cdtarif;
    }

    public void setCdtarif(String cdtarif) {
        this.cdtarif = cdtarif;
    }

    public String getLibprt() {
        return libprt;
    }

    public void setLibprt(String libprt) {
        this.libprt = libprt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getQtenb() {
        return qtenb;
    }

    public void setQtenb(double qtenb) {
        this.qtenb = qtenb;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
    }

    public double getMaj() {
        return maj;
    }

    public void setMaj(double maj) {
        this.maj = maj;
    }

    public double getRed() {
        return red;
    }

    public void setRed(double red) {
        this.red = red;
    }

    public double getMttligne() {
        return mttligne;
    }

    public void setMttligne(double mttligne) {
        this.mttligne = mttligne;
    }

    public double getMttligar() {
        return mttligar;
    }

    public void setMttligar(double mttligar) {
        this.mttligar = mttligar;
    }

    public double getMtttax() {
        return mtttax;
    }

    public void setMtttax(double mtttax) {
        this.mtttax = mtttax;
    }

    public double getTauxtarif() {
        return tauxtarif;
    }

    public void setTauxtarif(double tauxtarif) {
        this.tauxtarif = tauxtarif;
    }

    
    public Date getDtprvprt() {
        return dtprvprt;
    }

    public void setDtprvprt(Date dtprvprt) {
        this.dtprvprt = dtprvprt;
    }

    public Date getDtprt() {
        return dtprt;
    }

    public void setDtprt(Date dtprt) {
        this.dtprt = dtprt;
    }

    public Date getHrprvprt() {
        return hrprvprt;
    }

    public void setHrprvprt(Date hrprvprt) {
        this.hrprvprt = hrprvprt;
    }

    public Date getHrdebprt() {
        return hrdebprt;
    }

    public void setHrdebprt(Date hrdebprt) {
        this.hrdebprt = hrdebprt;
    }

    public Date getHrfinprt() {
        return hrfinprt;
    }

    public void setHrfinprt(Date hrfinprt) {
        this.hrfinprt = hrfinprt;
    }

    @Override
    public String getTuppleID() {
        return  nmfact;
    }

    @Override
    public String getAttributIDName() {
        return "nmfact";
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CR","GETSEQFACTPRTMAT");
        setNmfact(makePK(c));
    }
    
    public FactureClientDetails genererFactureFille() throws Exception {
        FactureClientDetails fcd = new FactureClientDetails();
        fcd.setDesignation(this.getLibprt());
        fcd.setQuantite(this.getQtenb());
        fcd.setDuree(this.getDuree() == 0 ? 1 : this.getDuree());
        fcd.setMajoration(this.getMaj());
        fcd.setReduction(this.getRed());
        fcd.setHeureDebut(this.getHrdebprt() == null ? null : Utilitaire.datetostring(this.getHrdebprt()));
        fcd.setHeureFin(this.getHrfinprt() == null ? null : Utilitaire.datetostring(this.getHrfinprt()));
        fcd.setPu(this.getMttligar()/this.getQtenb());
        return fcd;
    }
    
}
