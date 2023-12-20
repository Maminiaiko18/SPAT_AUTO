/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Constante;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author nouta
 */
public class Avenant extends ClassEtat {
    private String id,idTiers,objet,devise,unite,typedroitport,typeDuree,numeros,idContrat;
    private String idTierslib,contratlib,etatlib,tierslib,unitelib,idengagement,designationengagement;
    private double duree,droit_entree,redevance_fixe,redevance_variable,droit_port,redevance_domaniale,redevance_locative,pipeline,montant;
    private Date date_signature,debut_avenant,fin_avenant;
    private int rang,controleMontant;
    
    public Avenant() {
        super.setNomTable("AVENANT");
    }

    public Avenant(String idTiers, String objet, String unite, String idContrat, double duree, double montant, Date date_signature, Date debut_avenant, Date fin_avenant, int rang) {
        super.setNomTable("AVENANT");
        this.setIdTiers(idTiers);
        this.setObjet(objet);
        this.setUnite(unite);
        this.setIdContrat(idContrat);
        this.setDuree(duree);
        this.setMontant(montant);
        this.setDate_signature(date_signature);
        this.setDebut_avenant(debut_avenant);
        this.setFin_avenant(fin_avenant);
        this.setRang(rang);
    }

    public String getIdTierslib() {
        return idTierslib;
    }

    public void setIdTierslib(String idTierslib) {
        this.idTierslib = idTierslib;
    }

    public String getContratlib() {
        return contratlib;
    }

    public void setContratlib(String contratlib) {
        this.contratlib = contratlib;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdTiers() {
        return idTiers;
    }

    public void setIdTiers(String idTiers) {
        this.idTiers = idTiers;
    }

    public String getObjet() {
        return objet;
    }

    public void setObjet(String objet) {
        this.objet = objet;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getUnite() {
        return unite;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }

    public String getTypedroitport() {
        return typedroitport;
    }

    public void setTypedroitport(String typedroitport) {
        this.typedroitport = typedroitport;
    }

    public String getTypeDuree() {
        return typeDuree;
    }

    public void setTypeDuree(String typeDuree) {
        this.typeDuree = typeDuree;
    }

    public String getNumeros() {
        return numeros;
    }

    public void setNumeros(String numeros) {
        this.numeros = numeros;
    }

    public String getIdContrat() {
        return idContrat;
    }

    public void setIdContrat(String idContrat) {
        this.idContrat = idContrat;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
    }

    public double getDroit_entree() {
        return droit_entree;
    }

    public void setDroit_entree(double droit_entree) {
        this.droit_entree = droit_entree;
    }

    public double getRedevance_fixe() {
        return redevance_fixe;
    }

    public void setRedevance_fixe(double redevance_fixe) {
        this.redevance_fixe = redevance_fixe;
    }

    public double getRedevance_variable() {
        return redevance_variable;
    }

    public void setRedevance_variable(double redevance_variable) {
        this.redevance_variable = redevance_variable;
    }

    public double getDroit_port() {
        return droit_port;
    }

    public void setDroit_port(double droit_port) {
        this.droit_port = droit_port;
    }

    public double getRedevance_domaniale() {
        return redevance_domaniale;
    }

    public void setRedevance_domaniale(double redevance_domaniale) {
        this.redevance_domaniale = redevance_domaniale;
    }

    public double getRedevance_locative() {
        return redevance_locative;
    }

    public void setRedevance_locative(double redevance_locative) {
        this.redevance_locative = redevance_locative;
    }

    public double getPipeline() {
        return pipeline;
    }

    public void setPipeline(double pipeline) {
        this.pipeline = pipeline;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public Date getDate_signature() {
        return date_signature;
    }

    public void setDate_signature(Date date_signature) {
        this.date_signature = date_signature;
    }

    public Date getDebut_avenant() {
        return debut_avenant;
    }

    public void setDebut_avenant(Date debut_avenant) {
        this.debut_avenant = debut_avenant;
    }

    public Date getFin_avenant() {
        return fin_avenant;
    }

    public void setFin_avenant(Date fin_avenant) {
        this.fin_avenant = fin_avenant;
        if(getMode().equals("modif"))
            this.fin_avenant = Utilitaire.ajoutJourDate(this.getDebut_avenant(), (int) Math.ceil(this.getDuree()-1));
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public String getUnitelib() {
        return unitelib;
    }

    public void setUnitelib(String unitelib) {
        this.unitelib = unitelib;
    }

    public String getIdengagement() {
        return idengagement;
    }

    public void setIdengagement(String idengagement) {
        this.idengagement = idengagement;
    }

    public String getDesignationengagement() {
        return designationengagement;
    }

    public void setDesignationengagement(String designationengagement) {
        this.designationengagement = designationengagement;
    }

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
    }

    public int getControleMontant() {
        return controleMontant;
    }

    public void setControleMontant(int controleMontant) {
        this.controleMontant = controleMontant;
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
        this.preparePk("AVT", "GETSEQAVENANT");
        this.setId(makePK(c));
    }
    
     @Override
    public Object validerObject(String u, Connection c) throws Exception {
        boolean ouvert = false;
        
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                ouvert = true;
                c.setAutoCommit(false);
            }
            if(this.getRang() != 0){
                Contrat contrat = (Contrat)(new Contrat()).getById(this.getIdContrat(), null, c);
                Engagement engagement = new Engagement();
                engagement.setDesignation(this.getObjet());
                engagement.setCodeEtablissement(contrat.getCodeetablissement());
                engagement.setProjet(contrat.getProjet());
                engagement.setIdLC(contrat.getIdLC());
                engagement.setDaty(Utilitaire.dateDuJourSql());
                engagement.setTiers(this.getIdTiers());
                engagement.setAnnee(Utilitaire.getAneeEnCours());
                engagement.setIdavenant(this.getId());
                engagement.setMontant(this.getMontant());
                engagement.setIdtype(Constante.idTypeEngContrat);
                engagement.createObject(u, c);
                
                EngagementFille engfille = new EngagementFille(engagement.getId(), this.getObjet(), this.getMontant());
                engfille.createObject(u, c);
                
                engagement.setType(Constante.typeEngagementAvenant);
                if(this.getControleMontant() == 0)engagement.validerObject(u, c);
                else engagement.validerObjectSansControleMontant(u, c);
            }
            
            super.validerObject(u, c);
            c.commit();
            
            return this;
        }
        catch(Exception e){
            if(ouvert && c != null) c.rollback();
            throw e;
        }
        finally{
            if(ouvert && c != null) c.close();
        }
    }
}
