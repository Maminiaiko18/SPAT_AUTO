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
import utilitaire.Utilitaire;

/**
 *
 * @author john
 */
public class Billetage extends ClassEtat{
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
    
    public void genererReportVise(Connection c, String user) throws Exception{
        Billetage b = new Billetage();
        b = (Billetage)this.getById(this.getId(), "BILLETAGE", c);
        Report report = new Report();
        report.setDaty(Utilitaire.dateDuJourSql());
        report.setCaisse(Constante.caisseCentraleEspece);
        double montant = AdminGen.calculSommeDouble(getDetails(c), "montant");
        report.setMontant(montant);
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
