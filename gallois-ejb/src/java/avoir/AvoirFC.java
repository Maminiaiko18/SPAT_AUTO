/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;


import bean.CGenUtil;
import bean.ClassEtat;
import facture.FactureClient;
import bean.ClassMAPTable;
import bean.ClassMere;
import bean.TypeObjet;
import ded.OrdonnerPayement;
import facture.FactureClientDetails;
import facture.PaiementFacture;
import factureclient.FactureClientDetail;
import java.sql.Connection;
import java.sql.Date;
import mg.spat.JournalCaisse;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;


/**
 *
 * @author
 */
public class AvoirFC extends ClassMere {
    
    private String id;
    private Date daty,datefacture;
    private String idfacture, designationFacture,tiers,tierslib;
    private double montant, montantpaye,montantreste;    
    private String designation;
    private String code;
    private String categorie;
    private String motif;
    private String categorielib;
    private String motiflib;
    private String type;
    private String typelib,codeFacture;
    private double montanttva, montantttc;
    private String cdclt;

    public Date getDatefacture() {
        return datefacture;
    }

    public String getCdclt() {
        return this.cdclt;
    }

    public void setDatefacture(Date datefacture) {
        this.datefacture = datefacture;
    }

    public void setCdclt(String cdclt) {
        this.cdclt = cdclt;
    }

    public String getCodeFacture() {
        return codeFacture;
    }

    public void setCodeFacture(String codeFacture) {
        this.codeFacture = codeFacture;
    }
    
    public double getMontanttva() {
        return montanttva;
    }

    public void setMontanttva(double montanttva) {
        this.montanttva = montanttva;
    }

    public double getMontantttc() {
        return montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }
    

    public String getTypelib() {
        return typelib;
    }

    public void setTypelib(String typelib) {
        this.typelib = typelib;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getMontantpaye() {
        return montantpaye;
    }

    public void setMontantpaye(double montantpaye) {
        this.montantpaye = montantpaye;
    }

    public double getMontantreste() {
        return montantreste;
    }

    public void setMontantreste(double montantreste) {
        this.montantreste = montantreste;
    }


    public String getDesignationFacture() {
        return designationFacture;
    }

    public void setDesignationFacture(String designationFacture) {
        this.designationFacture = designationFacture;
    }

        public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }
    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }    
    
    public AvoirFC() throws Exception {
        setNomTable("AvoirFC");
        this.setLiaisonFille("idmere");
        this.setNomClasseFille("avoir.AvoirFCFille");
    }

    public AvoirFC(String id, Date daty, String idfacture, String designationFacture, String tiers, String tierslib, double montant, double montantpaye, double montantreste, String designation, String code, String categorie, String motif) {
        setNomTable("AvoirFC");   
        this.id = id;
        this.daty = daty;
        this.idfacture = idfacture;
        this.designationFacture = designationFacture;
        this.tiers = tiers;
        this.tierslib = tierslib;
        this.montant = montant;
        this.montantpaye = montantpaye;
        this.montantreste = montantreste;
        this.designation = designation;
        this.code = code;
        this.categorie = categorie;
        this.motif = motif;
    }
    
    
    
    public AvoirFC(String id, Date daty, String idfacture, String designationFacture, String tiers, String tierslib, double montant, double montantpaye, double montantreste) {
        setNomTable("AvoirFC");        
        this.id = id;
        this.daty = daty;
        this.idfacture = idfacture;
        this.designationFacture = designationFacture;
        this.tiers = tiers;
        this.tierslib = tierslib;
        this.montant = montant;
        this.montantpaye = montantpaye;
        this.montantreste = montantreste;
    }    
    
    public AvoirFC(String id, Date daty, String idfacture, String designationFacture, String tiers, String tierslib, double montant, double montantpaye, double montantreste, String designation, String code, String categorie) {
        setNomTable("AvoirFC"); 
        this.id = id;
        this.daty = daty;
        this.idfacture = idfacture;
        this.designationFacture = designationFacture;
        this.tiers = tiers;
        this.tierslib = tierslib;
        this.montant = montant;
        this.montantpaye = montantpaye;
        this.montantreste = montantreste;
        this.designation = designation;
        this.code = code;
        this.categorie = categorie;
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("AVRFC", "get_seqAvoirFC");
        setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
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
    
    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }
    
    public String genererSequence(Connection c, String nomtable, int longueur, String awhere) throws Exception {
        String requete = "SELECT  * FROM %s where 1 < 2 %s";
        requete = String.format(requete, nomtable, awhere);

//        System.out.println("requete " + requete);
        TypeObjet obj = new TypeObjet();
        obj.setNomTable(nomtable);
        TypeObjet[] seq = (TypeObjet[]) CGenUtil.rechercher(obj, requete, c);

        String sequence = "";
        if (seq != null && seq.length > 0) {
            sequence = seq[0].getVal();
        }
        
        if(sequence == null || sequence.isEmpty() || sequence.equals("0")) sequence = "1";
        
        return Utilitaire.completerInt(longueur, sequence);
    } 
    
    @Override
    public ClassMAPTable createObject(String u, Connection c)throws Exception
    {
        this.setId(null);
        this.setCode(this.calculerCode(c));
        return super.createObject(u, c);
    }
    
    public String calculerCode(Connection c) throws Exception {
        String daty = Utilitaire.datetostring(getDaty());
        String annee = Utilitaire.genererAnnee(daty);
        String mois = Utilitaire.genererMois(daty);
        String valCateg = "1".equals(this.getType()) ? "IS" : this.getCategorie(c).getVal();
        
        FactureClient fc = getFactureLiee(null, c);
        if(this.getType()!=null && "2".equals(this.getType()) && fc != null && fc.getIdprevision() != null) valCateg += "S";
        
        String retour = annee+mois+valCateg;
        
        String awhere = String.format(" and id like '%s' and desce = '%s'", this.getCategorie(), "01/" + mois + "/" + Utilitaire.getAnnee(daty));
        
        String seq = this.genererSequence(c, "NUMEROAVOIRFC", 4, awhere);
        return retour += seq;
    }
    
    public TypeObjet getCategorie(Connection c) throws Exception {
        int verif = 0;
	try {
		if (c == null) {
			c = (new UtilDB()).GetConn();
			verif = 1;
		}
		TypeObjet typeObj = new TypeObjet();
		typeObj.setNomTable("categorieAvoirFC");
		String awhere = String.format(" and id = '%s' ", this.getCategorie());
		TypeObjet[] result = (TypeObjet[])CGenUtil.rechercher(typeObj, null, null, c, awhere);
		if(result != null && result.length > 0) 
			return result[0];
		return null;
	} finally {
		if (c != null && verif == 1) {
			c.close();
		}
	}

    
}
    public String getCategorielib() {
        return categorielib;
    }

    public void setCategorielib(String categorielib) {
        this.categorielib = categorielib;
    }

    public String getMotiflib() {
        return motiflib;
    }

    public void setMotiflib(String motiflib) {
        this.motiflib = motiflib;
    }
	
    public FactureClient getFactureLiee(String nomtable, Connection c) throws Exception {
    int verif = 0;
        try {
            if (c == null) {
                    c = (new UtilDB()).GetConn();
                    verif = 1;
            }
            if(nomtable == null || nomtable.compareTo("")==0) nomtable = "facture_client_union";
            FactureClient fc = new FactureClient();
            fc.setNomTable(nomtable);
            String awhere = String.format(" and id = '%s' ", this.getIdfacture());
            FactureClient[] result = (FactureClient[])CGenUtil.rechercher(fc, null, null, c, awhere);
            if(result != null && result.length > 0) 
                    return result[0];
            return null;
        } catch(Exception e){
            throw e;
        }finally {
            if (c != null && verif == 1) {
                    c.close();
            }
        }
    }
	
	/*public FactureClient getFactureLiee(Connection conn)throws Exception{
        int verify =0;
        try{    
            
            if (conn == null) {
                conn = (new UtilDB()).GetConn();
                verify = 1;
            }
            FactureClient fc = new FactureClient();
            fc.setNomTable(nomTable);
            String awhere = String.format(" and id = '%s' ", this.getIdfacture());
            FactureClient[] result = (FactureClient[])CGenUtil.rechercher(fc, null, null, conn, awhere);
            if(result != null && result.length > 0) 
                return result[0];
            return null;
        }finally{
            if(conn!=null && verify == 1) conn.close();
        }
    }*/
    public AvoirFCFille[] getAvoirFilles(String nomTable, Connection c) throws Exception{
        if(nomTable == null){
            nomTable = "avoirFCFille";
        }
        String requete = "SELECT * from %s WHERE idmere = '%s'";
        requete = String.format(requete, nomTable, this.getId());
        AvoirFCFille fille = new AvoirFCFille();
        fille.setNomTable(nomTable);
        AvoirFCFille[] filles = (AvoirFCFille[])CGenUtil.rechercher(fille, requete, c);
        return filles;
         }
         
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        if(this.getType()!=null && this.getType().equals("1")){
            this.getFactureLiee("factureclient",c).annuler(c);
        }
        return super.validerObject(u, c); 
    }
    
    public OrdonnerPayement genererOP(Connection c) throws Exception{
        OrdonnerPayement op = new OrdonnerPayement();
        op.setDed_Id(this.getId());
        AvoirFC avoirFCMontant = new AvoirFC();
        avoirFCMontant.setNomTable("avoirFC_montant");
        AvoirFC[] result = (AvoirFC[])CGenUtil.rechercher(avoirFCMontant, null, null, c, String.format(" and id = '%s' ", this.getId()));
        if(result.length > 0)
            op.setMontant(result[0].getMontant());
        op.setRemarque("Paiement avoir "+this.getId());
        op.setDaty(Utilitaire.dateDuJourSql());
        return op;
    }
    
    public FactureClient creerFactureRempl(Connection c, String user) throws Exception{
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            FactureClient factureLiee = getFactureLiee("factureclient", c);
            factureLiee.setIdavoir(this.getId());
            factureLiee.setEtat(ConstanteEtat.getEtatCreer());
            FactureClientDetails[] details = (FactureClientDetails[])factureLiee.getFille("facture_client_fille",c,"");
            if(details != null && details.length > 0){
                for(int i=0; i<details.length; i++){
                    details[i].setId(null);
                }
            }
            factureLiee.setFille(details);
            factureLiee.createObject(user, c);
            if(verif==1)c.commit();
            return factureLiee;
        } catch(Exception e){
            if(c!=null)c.rollback();
            throw e;
        }finally {
            if (c != null && verif == 1) {
                    c.close();
            }
        }
    }
    
    public FactureClient getFactureRemplacement(String nomtable, Connection c) throws Exception{
        FactureClient base = new FactureClient();
        base.setNomTable(nomtable);
        FactureClient[] result = (FactureClient[]) CGenUtil.rechercher(base, null, null, c, String.format(" and idavoir = '%s' ", this.getId()));
        if(result.length > 0) return result[0];
        return null;
    }
    
    public void libererPaiement(double montant, String u, Connection con) throws Exception{
        if(montant > this.montantreste){
            throw new Exception("Montant à libérer supérieur au montant disponible");
        }
        OrdonnerPayement op = new OrdonnerPayement();
        op.setDed_Id(this.getId());
        op.setMontant(montant);
        op.setDaty(Utilitaire.dateDuJourSql());
        op.setTiers(this.getTiers());
        op.createObject(u, con);
        op.validerObject(u, con);
        JournalCaisse jc =  new JournalCaisse(null, Constante.caisseCentraleBP,null , "Régularisation à partir de l'avoir "+this.getId(), null, Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), montant, 0);
        jc.setTiers(this.getTiers());
        jc.setIdordre(op.getId());
        jc.createObject(u, con);
        jc.validerObject(u, con);
        PaiementFacture contrePaiement = new PaiementFacture(jc.getId(),this.getIdfacture(),-1*montant);
        contrePaiement.createObject(u, con);
    }
}
