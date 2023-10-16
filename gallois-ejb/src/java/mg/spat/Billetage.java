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
    private String idtransfert;
    private String caissedepart;

    public String getCaissedepart() {
        return caissedepart;
    }

    public void setCaissedepart(String caissedepart) {
        this.caissedepart = caissedepart;
    }

    public String getIdtransfert() {
        return idtransfert;
    }

    public void setIdtransfert(String idtransfert) {
        this.idtransfert = idtransfert;
    }

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

    public void genererTransfert(Connection c, String user) throws Exception{
        MvttIntraCaisse mvm = new MvttIntraCaisse();
        mvm.setVisaArrive(false);
        String nomcaisse = "";
        if(this.getCaisse().compareToIgnoreCase(Constante.caisseCentraleEspece)==0) nomcaisse="CAISSE RECETTES";
        else nomcaisse = "CAISSE DEPENSES";
        if(this.getCaissedepart() == null || this.getCaissedepart().compareToIgnoreCase("")==0)
        {    
            mvm.setDaty(this.getDaty());
            mvm.setCaissedepart(this.getCaisse());
            mvm.setCaissearrivee(Constante.COFFRE_PRINCIPAL);
            mvm.setModepaiement(Constante.modepaiementDefaut);
            mvm.setMontant(this.getMontant());
            mvm.setDesignation("Transfert du "+Utilitaire.formatterDaty(this.getDaty())+" de la caisse "+nomcaisse+" vers la COFFRE PRINCIPAL");
            mvm.createObject(user, c);
            mvm.validerObject(user, c);
        }else {
            mvm.setDaty(this.getDaty());
            mvm.setCaissedepart(this.getCaissedepart());
            mvm.setCaissearrivee(this.getCaisse());
            mvm.setModepaiement(Constante.modepaiementDefaut);
            mvm.setMontant(this.getMontant());
            mvm.setDesignation("Transfert du "+Utilitaire.formatterDaty(this.getDaty())+" de la COFFRE PRINCIPAL vers la "+nomcaisse);
            mvm.createObject(user, c);
            mvm.validerObject(user, c);
        }
        this.setIdtransfert(mvm.getId());
        this.genererTranferDetails(c, user, mvm.getId());
    }   

    public void genererTranferDetails(Connection c, String user,String idmere) throws Exception{
        DetailsBilletage[] details = this.getDetails(c);
        for(DetailsBilletage d : details){
            MvtIntraCaisseFille fille = new MvtIntraCaisseFille();
            fille.setReference(d.getBillet());
            fille.setRemarque(String.valueOf(d.getNombre()));
            fille.setIdmere(idmere);
            fille.createObject(user, c);
        }
    }
    
    public Object validerObject(String u, Connection c) throws Exception
    {
        if(this.getCaisse().compareToIgnoreCase(Constante.caisseCentraleEspece)==0 || this.getCaisse().compareToIgnoreCase(Constante.caisseDepense)==0){
            genererTransfert(c,u);
        }
        //this.genererReportVise(c, u);
        return super.validerObject(u, c);
    }
}
