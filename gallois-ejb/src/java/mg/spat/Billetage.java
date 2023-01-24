/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import service.BilletageService;
import service.ClotureService;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.Utilitaire;

/**
 *
 * @author john
 */
public class Billetage extends ClassEtat{
    @Override
    public String toString() {
        return "Billetage [id=" + id + ", caisse=" + caisse + ", daty=" + daty + ", montant=" + montant + ", idcaisse="
                + idcaisse + "]";
    }

    private String id, caisse;
    private Date daty;
    private double montant;
    private String idcaisse;

    public String getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(String idcaisse) {
        this.idcaisse = idcaisse;
    }
    
    
    
    public Billetage() {
        super.setNomTable("billetage");
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
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
    public void controler(Connection c) throws Exception{
        try{
            BilletageService.testDateCloture(this.daty, this.caisse, c);
        }catch(Exception e){
            throw e;
        }
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("BLT", "getseqbilletage");
        this.setId(makePK(c));
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public DetailsBilletage[] getDetails(Connection c) throws Exception{
        DetailsBilletage[] result = (DetailsBilletage[]) CGenUtil.rechercher(new DetailsBilletage(), null, null, c, String.format(" and idmere = '%s' ", this.getId()));
        return result;
    }

    public JournalCaisse[] getJournal(Connection c) throws Exception{
        JournalCaisse filtre = new JournalCaisse();
        filtre.setCaisse(this.getCaisse());
        filtre.setEtat(ConstanteEtat.getEtatValider());
        JournalCaisse[] result = (JournalCaisse[]) CGenUtil.rechercher(filtre, null, null, c,String.format(" AND dateeffet = to_date('%s','YYYY-MM-DD')", this.getDaty().toString()));
        return result;
    }

    public Report getLastReport(Connection c) throws Exception{
        Report filtre = new Report();
        filtre.setCaisse(this.getCaisse());
        Report[] result = (Report[]) CGenUtil.rechercher(filtre, null, null, c, String.format(" AND daty < to_date('%s','YYYY-MM-DD') ORDER BY daty desc", this.getDaty().toString()));
        return result[0];
    }

    public void genererReportVise(Connection c, String user) throws Exception{
        Report report = new Report();
        report.setDaty(this.getDaty());
        report.setCaisse(this.getCaisse());
        report.setMontant(this.getMontant());
        report.setDevise("Ar");
        report.createObject(user, c);
        report.validerObject(user, c);
    }
    
    public Object validerObject(String u, Connection c) throws Exception
    {
        this.genererReportVise(c, u);
        return super.validerObject(u, c);
    }
}
