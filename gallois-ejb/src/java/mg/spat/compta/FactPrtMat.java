/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author john
 */
public class FactPrtMat extends ClassMAPTable{
    private String nmfact,cdtarif,libprt;
    private double id,qtenb,duree,maj,red,mttligne,mttligar,mtttaxe,tauxtarif;
    private Date dtprvprt,dtprt,hrprvprt,hrdebprt,hrfinprt;
    @Override
    public String getTuppleID() {
        return nmfact;
    }

    @Override
    public String getAttributIDName() {
        return "nmfact";
    }
    
    public FactPrtMat() {
        this.setNomTable("factprtmat");
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

    public double getId() {
        return id;
    }

    public void setId(double id) {
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

    public double getMtttaxe() {
        return mtttaxe;
    }

    public void setMtttaxe(double mtttaxe) {
        this.mtttaxe = mtttaxe;
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
    
}
