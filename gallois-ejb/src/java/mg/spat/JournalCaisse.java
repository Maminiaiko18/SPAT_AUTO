/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import avoir.AvoirFC;
import avoir.AvoirFF;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import ded.OrdonnerPayement;
import facture.EtatProvision;
import facture.FactureClient;
import facture.FactureClientDetails;
import facture.FactureFournisseur;
import facture.FactureFournisseurDetails;
import facture.PaiementFacture;
import facture.UtilitaireFacture;
import factureclient.PayementFacture;
import facturefournisseur.RegulFacture;
import java.sql.Connection;
import java.sql.Date;
import java.text.DecimalFormat;
import mg.allosakafo.fin.EtatOP;
import mg.spat.placement.Placement;
import service.ClotureService;
import user.UserEJBBean;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author MEVA
 */
public class JournalCaisse extends ClassEtat {

    private String id, folio, caisse, numPiece, libelle, remarque, tiers, idTypeCheque, idplacement,valCaisse,valTypeCheque,desceTypeCheque,tiersLib,idbanque,idbanquelib;
    private double sommeCredit, sortie, entree;
    private String banque;
    private String descecaisse;

		public Placement findPlacement(Connection c) throws Exception {
			Placement pl = new Placement();
			String nomTable = "placement";
			pl.setNomTable(nomTable);
			Placement[] rsPlacement = null;
			try {
				String query = " and id = '"+this.getIdplacement()+"'";
				rsPlacement = (Placement[]) CGenUtil.rechercher(pl, null, null, c, query);
			} catch(Exception e) {
				throw e;
			}
			return rsPlacement != null && rsPlacement.length > 0 ? rsPlacement[0] : null;
    }
    
    public void viserFacturesRattachees(String user,Connection c) throws Exception{
        if(this.getCredit()>0){
            FactureClient factureclient= findFactureClientAuto(c);
            if(factureclient!=null){
                factureclient.validerObject(user, c);
            }
        }
        if(this.getDebit()>0){
            FactureFournisseur factureFournisseur= findFactureFournisseurAuto(c);
            if(factureFournisseur!=null){
                factureFournisseur.validerObject(user, c);
            }
        }
    }
    
    public FactureClient genererFactureClientAuto(Connection c,String user,String compte, int annee, int mois, double tva) throws Exception{
        //FactureClient factureclient=new FactureClient(Utilitaire.dateDuJourSql(), this.getTiers(), "Facture auto via", Constante.typeChequeAuComptant, Constante.idCategorieFCDefinitive, 1);
        FactureClient factureclient=new FactureClient(Utilitaire.dateDuJourSql(), this.getTiers(), "Facture auto via", Constante.typeAuComptant, Constante.idCategorieFCDefinitive, 1);
        FactureClientDetails detail= new FactureClientDetails(factureclient.getId(), 1, this.getCredit(), compte, "Facture auto via", 1);
        detail.setAnnee(annee);
        detail.setMois(mois);
        detail.setTva(tva);
        FactureClientDetails[] fille = {detail};
        factureclient.setFille(fille);
        
        factureclient.createObject(user, c);
        
    
        return factureclient;
    }

    public FactureClient findFactureClientAuto(Connection c) throws Exception {
        FactureClient fc = new FactureClient();
        String nomTable = "factureclientAuto";
        fc.setNomTable(nomTable);
        FactureClient[] rsFc = null;
        try {
                String query = " and id = '"+this.getIdplacement()+"'";
                rsFc = (FactureClient[]) CGenUtil.rechercher(fc, null, null, c, query);
        } catch(Exception e) {
                throw e;
        }
        return rsFc != null && rsFc.length > 0 ? rsFc[0] : null;
    }

    public FactureFournisseur findFactureFournisseurAuto(Connection c) throws Exception {
        FactureFournisseur fc = new FactureFournisseur();
        String nomTable = "facture_fournisseur_mereAuto";
        fc.setNomTable(nomTable);
        FactureFournisseur[] rsFc = null;
        try {
                String query = " and id = '"+this.getIdplacement()+"'";
                rsFc = (FactureFournisseur[]) CGenUtil.rechercher(fc, null, null, c, query);
        } catch(Exception e) {
                throw e;
        }
        return rsFc != null && rsFc.length > 0 ? rsFc[0] : null;
    }
    
    public String getBanque() {
        return banque;
    }

    public void setBanque(String banque) {
        this.banque = banque;
    }
    
    
    
    public double getSortie() {
        return sortie;
    }

    public void setSortie(double sortie) {
        this.sortie = sortie;
    }

    public double getEntree() {
        return entree;
    }

    public void setEntree(double entree) {
        this.entree = entree;
    }
    
    public String getDesceTypeCheque() {
        return desceTypeCheque;
    }

    public void setDesceTypeCheque(String desceTypeCheque) {
        this.desceTypeCheque = desceTypeCheque;
    }
private String designation, iddevise, idmode, numcheque, typemvt, idordre;
    private double reste;
    private Date dateSaisie, dateEffet;
    private double debit, credit, montant;

    public String getTiersLib() {
        return tiersLib;
    }
    
    public void setTiersLib(String tiersLib) {
        this.tiersLib = tiersLib;
    }

    public String getValCaisse() {
        return valCaisse;
    }

    public void setValCaisse(String valCaisse) {
        this.valCaisse = valCaisse;
    }

    public String getValTypeCheque() {
        return valTypeCheque;
    }

    public void setValTypeCheque(String valTypeCheque) {
        this.valTypeCheque = valTypeCheque;
    }
    
    public String getIdplacement() {
        return idplacement;
    }

    public void setIdplacement(String idplacement) {
        this.idplacement = idplacement;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getIdbanque() {
        return idbanque;
    }

    public void setIdbanque(String idbanque) {
        this.idbanque = idbanque;
    }

    public String getIdbanquelib() {
        return idbanquelib;
    }

    public void setIdbanquelib(String idbanquelib) {
        this.idbanquelib = idbanquelib;
    }

    public JournalCaisse() {
        super.setNomTable("journalcaisse");
    }

    public JournalCaisse(String folio, String caisse, String numPiece, String libelle, String remarque, Date dateSaisie, Date dateEffet, double debit, double credit) throws Exception {
        super.setNomTable("journalcaisse");
        this.setFolio(folio);
        this.setCaisse(caisse);
        this.setNumPiece(numPiece);
        this.setLibelle(libelle);
        this.setRemarque(remarque);
        this.setDateSaisie(dateSaisie);
        this.setDateEffet(dateEffet);
        this.setDebit(debit);
        this.setCredit(credit);
    }

    public JournalCaisse(String id, String folio, String caisse, String numPiece, String libelle, String remarque, String tiers, String idTypeCheque, String idplacement, String valCaisse, String valTypeCheque, String desceTypeCheque, String tiersLib, double sommeCredit, double sortie, double entree, String banque, String designation, String iddevise, String idmode, String numcheque, String typemvt, String idordre, double reste, Date dateSaisie, Date dateEffet, double debit, double credit, double montant) {
        this.id = id;
        this.folio = folio;
        this.caisse = caisse;
        this.numPiece = numPiece;
        this.libelle = libelle;
        this.remarque = remarque;
        this.tiers = tiers;
        this.idTypeCheque = idTypeCheque;
        this.idplacement = idplacement;
        this.valCaisse = valCaisse;
        this.valTypeCheque = valTypeCheque;
        this.desceTypeCheque = desceTypeCheque;
        this.tiersLib = tiersLib;
        this.sommeCredit = sommeCredit;
        this.sortie = sortie;
        this.entree = entree;
        this.banque = banque;
        this.designation = designation;
        this.iddevise = iddevise;
        this.idmode = idmode;
        this.numcheque = numcheque;
        this.typemvt = typemvt;
        this.idordre = idordre;
        this.reste = reste;
        this.dateSaisie = dateSaisie;
        this.dateEffet = dateEffet;
        this.debit = debit;
        this.credit = credit;
        this.montant = montant;
    }

    
    
    public JournalCaisse(String folio, String caisse, String numPiece, String libelle, String remarque, String tiers, String idTypeCheque, Date dateSaisie, Date dateEffet, double debit, double credit) throws Exception {
        super.setNomTable("journalcaisse");
        this.setFolio(folio);
        this.setCaisse(caisse);
        this.setNumPiece(numPiece);
        this.setLibelle(libelle);
        this.setRemarque(remarque);
        this.setDateSaisie(dateSaisie);
        this.setDateEffet(dateEffet);
        this.setDebit(debit);
        this.setCredit(credit);
        this.setTiers(tiers);
        this.setIdTypeCheque(idTypeCheque);
    }

    public JournalCaisse(String folio, String caisse, String numPiece, String libelle, String remarque, Date dateSaisie, Date dateEffet, double debit) throws Exception {
        super.setNomTable("journalcaisse");
        this.setFolio(folio);
        this.setCaisse(caisse);
        this.setNumPiece(numPiece);
        this.setLibelle(libelle);
        this.setRemarque(remarque);
        this.setDateSaisie(dateSaisie);
        this.setDateEffet(dateEffet);
        this.setDebit(debit);
    }
    
    public JournalCaisse(String id, String folio, String caisse, String numPiece, String libelle, String remarque, String tiers, String idTypeCheque, String idplacement, String valCaisse, String valTypeCheque, String desceTypeCheque, String tiersLib, String idbanque, String idbanquelib, double sommeCredit, double sortie, double entree, String banque, String designation, String iddevise, String idmode, String numcheque, String typemvt, String idordre, double reste, Date dateSaisie, Date dateEffet, double debit, double credit, double montant) {
        this.id = id;
        this.folio = folio;
        this.caisse = caisse;
        this.numPiece = numPiece;
        this.libelle = libelle;
        this.remarque = remarque;
        this.tiers = tiers;
        this.idTypeCheque = idTypeCheque;
        this.idplacement = idplacement;
        this.valCaisse = valCaisse;
        this.valTypeCheque = valTypeCheque;
        this.desceTypeCheque = desceTypeCheque;
        this.tiersLib = tiersLib;
        this.idbanque = idbanque;
        this.idbanquelib = idbanquelib;
        this.sommeCredit = sommeCredit;
        this.sortie = sortie;
        this.entree = entree;
        this.banque = banque;
        this.designation = designation;
        this.iddevise = iddevise;
        this.idmode = idmode;
        this.numcheque = numcheque;
        this.typemvt = typemvt;
        this.idordre = idordre;
        this.reste = reste;
        this.dateSaisie = dateSaisie;
        this.dateEffet = dateEffet;
        this.debit = debit;
        this.credit = credit;
        this.montant = montant;
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("CAS", "getseqjcaisse");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public String getNumPiece() {
        return numPiece;
    }

    public void setNumPiece(String numPiece) {
        this.numPiece = numPiece;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public String getIdTypeCheque() {
        return idTypeCheque;
    }

    public void setIdTypeCheque(String idTypeCheque) {
        this.idTypeCheque = idTypeCheque;
    }

    public Date getDateSaisie() {
        return dateSaisie;
    }

    public void setDateSaisie(Date dateSaisie) {
        if (this.getMode().equals("modif")) {
            dateSaisie = Utilitaire.string_date("YYYY-MM-dd", Utilitaire.dateDuJour());
        }
        this.dateSaisie = dateSaisie;
    }

    public Date getDateEffet() {
        return dateEffet;
    }

    public void setDateEffet(Date dateEffet) {
        this.dateEffet = dateEffet;
    }

    public double getDebit() {
        /*if (!this.getMode().equalsIgnoreCase("modif")) {
            return credit;
        }*/

        return debit;
    }

    public void setDebit(double debit) throws Exception {
        if (this.getMode().equals("modif")) {
            if (debit < 0) {
                throw new Exception("Montant debit invalide");
            }
        }
        if (this.getMode().equals("modif")&&debit>0&&this.getCredit()!=0) {
                throw new Exception("Montant credit deja saisie");
        }
        this.debit = debit;
    }

    public double getSommeCredit() {
        return sommeCredit;
    }

    public void setSommeCredit(double sommeCredit) {
        this.sommeCredit = sommeCredit;
    }

    public double getCredit() {
        /*if (!this.getMode().equalsIgnoreCase("modif")) {
            return debit;
        }*/

        return credit;
    }

    public void setCredit(double credit) throws Exception {
        if (this.getMode().equals("modif")) {
            if (credit < 0) {
                throw new Exception("Montant credit invalide");
            }
        }
        if (this.getMode().equals("modif")&&credit>0&&this.getDebit()!=0) {
                throw new Exception("Montant debit deja saisie");
        }
        this.credit = credit;
    }

    public AvoirFC findAvoirFC(Connection c) throws Exception {
        AvoirFC avoir = new AvoirFC();
        avoir.setNomTable("avoirFC_montant");
        AvoirFC[] avoirs = (AvoirFC[]) CGenUtil.rechercher(avoir, null, null, c, " and id = '" + this.getIdplacement() + "'");
        
        return avoirs != null && avoirs.length > 0 ? avoirs[0] : null;
    }

    public void controler(Connection c) throws Exception {
        try {
            ClotureService.testDateCloture(this.dateEffet, this.caisse, c);
            Report[] report = (Report[]) CGenUtil.rechercher(new Report(), null, null, c, " and daty >= to_date('" + Utilitaire.dateDuJourSql() + "','yyyy-mm-dd hh24:mi:ss') and caisse='" + this.caisse + "'");
            if (report.length > 0) {
                throw new Exception("Caisse deja reportee");
            }
            if (this.getTypemvt() != null && this.getTypemvt().compareToIgnoreCase(Constante.financeTypeAnnulation) == 0) {
                return;
            }
            if(this.getIdordre()==null){
                
                if(this.getIdplacement() != null) {
                    FactureClient[] listeFC = findFactureClient(c);
                    if(listeFC != null && listeFC.length > 0) {
                        for(FactureClient fc : listeFC) {
                            if(fc.getEtat()<ConstanteEtat.getEtatValider()) throw new Exception ("Facture Client non visee");
                            if(this.getCredit() > fc.getMontantreste()) throw new Exception("Montant superieur au reste a payer");
                        }
                    }
                

                    AvoirFC avoir = findAvoirFC(c);
                    if(avoir != null) {
                        if(avoir.getEtat()<ConstanteEtat.getEtatValider()) throw new Exception ("Avoir non visee");
                        if(this.getDebit() > avoir.getMontantreste()) throw new Exception("Montant superieur au reste a payer");
                    }
                }
            }
        } catch (Exception e) {
            throw e;
        }
    }
    
    public Date getMaxDate(Connection c) throws Exception {
        String req = "SELECT max(dateeffet) dateeffet FROM JOURNALCAISSE j WHERE CAISSE = '" + this.getCaisse() + "' AND DATEEFFET < '" + Utilitaire.datetostring(this.getDateEffet()) + "' AND etat >= 11";
        System.out.println("req " + req);
        JournalCaisse[] tmp = (JournalCaisse[]) CGenUtil.rechercher(new JournalCaisse(), req, c);
        
        return tmp != null && tmp.length > 0 && tmp[0].getDateEffet() != null ? tmp[0].getDateEffet() : Utilitaire.ajoutJourDate(this.getDateEffet(), -1);
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }

    public String getIdmode() {
        return idmode;
    }

    public void setIdmode(String idmode) {
        this.idmode = idmode;
    }

    public String getNumcheque() {
        return numcheque;
    }

    public void setNumcheque(String numcheque) {
        this.numcheque = numcheque;
    }

    public String getTypemvt() {
        return typemvt;
    }

    public void setTypemvt(String typemvt) {
        this.typemvt = typemvt;
    }

    public String getIdordre() {
        return idordre;
    }

    public void setIdordre(String idordre) {
        this.idordre = idordre;
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public OrdonnerPayement traitementOP(UserEJBBean user, Connection c) throws Exception {
        OrdonnerPayement ordonnerPayement = new OrdonnerPayement(this.getIdordre());
        ordonnerPayement = (OrdonnerPayement) ordonnerPayement.getById(this.getIdordre(), ordonnerPayement.getNomTable(), c);
        ordonnerPayement.setMontant(Math.abs(this.getDebit() - this.getCredit()));

        if (ordonnerPayement.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("OP non visé");
        }
        return ordonnerPayement;
    }
    public Placement estPlacement(Connection c)throws Exception{
        Placement placement = null;
        placement = (Placement) new Placement().getById(this.getIdplacement(), "PLACEMENT", c);
        return placement;
    }
    
    public void traitementPlacement(UserEJBBean user, Connection c) throws Exception {
        Placement placement = estPlacement(c);
        if(placement!=null){
            placement.validerObject(user.getUser().getTuppleID(), c);
        }
    }
    
    public void checkMontantFactureClient(FactureClient fc,Connection c) throws Exception {
        if (fc != null) {
            if(fc.getType().equals(Constante.typeCheque)) {
                if(this.getCredit() != fc.getMontantreste()) throw new Exception("Une facture au comptant doit etre payee en totalite");
            }
            
            if (fc.getMontantreste() < this.getCredit()) {
                throw new Exception("Montant supérieur au reste à payer");
            }
        }
    }
    
    public void checkMontantFactureClient(FactureClient[] fc, Connection c) throws Exception{
        if(fc != null && fc.length > 0){
            double sommeReste = 0;
            for(int i=0; i<fc.length; i++){
                if(fc[i].getEtat() < ConstanteEtat.getEtatValider()) throw new Exception("Facture "+fc[i].getId()+" non visee");
                sommeReste += fc[i].getMontantreste();
            }
            
            if(Utilitaire.stringToDouble((new DecimalFormat("###.###")).format(sommeReste)) < this.getCredit()) throw new Exception("Montant supérieur au reste à payer");
        }
    }
    
    public void checkMontantFactureFournisseur(FactureFournisseur fc,Connection c) throws Exception {

        if (fc != null) {
            if(fc.getType().equals(Constante.typeCheque)) {
                if(this.getDebit() != fc.getMontantreste()) throw new Exception("Une facture au comptant doit etre payee en totalite");
            }
            if (fc.getMontantreste() < this.getDebit()) {
                throw new Exception("Montant supérieur au reste à payer");
            }
        }
    }
    
     public void checkMontantFactureFournisseur(FactureFournisseur[] fc,Connection c) throws Exception {

        if (fc != null && fc.length > 0) {
            double sommeReste = 0;
            for(int i=0; i<fc.length; i++){
                if(fc[i].getEtat() < ConstanteEtat.getEtatValider()) throw new Exception("Facture "+fc[i].getId()+" non visee");
                sommeReste += fc[i].getMontantreste();
            }
            if(Utilitaire.stringToDouble((new DecimalFormat("###.###")).format(sommeReste)) < this.getDebit()) throw new Exception("Montant supérieur au reste à payer");
        }
    }
    
    public OrdonnerPayement getOP(String nomtable, Connection c) throws Exception {
        OrdonnerPayement op = new OrdonnerPayement();
        op.setId(this.getIdordre());
        if(nomtable != null && !nomtable.trim().isEmpty()) op.setNomTable(nomtable);
        return (OrdonnerPayement) op.getById(op.getId(), op.getNomTable(), c);
    }
    @Override
    public void viser(UserEJBBean user, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            
            String refuser = "" + user.getUser().getRefuser();
            
            if (this.getEtat() >= ConstanteEtat.getEtatValider()) {
                throw new Exception("mouvement caissse deja valide");
            }

            if (this.getIdordre() != null) { 
                OrdonnerPayement op = getOP("ordonnerpayementAvoirFC", c); // ho an'ny avoir FC
                if(op != null) {
                    if(op.getType().compareTo("1")==0) throw new Exception("Impossible a payer : avoir interne");
                    controlerPaiementAvoirFC(c, op.getDed_Id());
                    PaiementFacture paiementFact = new PaiementFacture();
                    paiementFact.setIdMvt(this.getId());
                    paiementFact.setIdFact(op.getIdfacture());
                    paiementFact.setMontant(-op.getMontant());
                    
                    paiementFact.createObject(refuser, c);
                }else{
                    OrdonnerPayement opTsotra=this.traitementOP(user, c);
                    if(opTsotra!=null){
                        PaiementFacture[] lpf=opTsotra.genererPaiementFacture(c,this);
                        if(lpf.length>0){
                            for(int i=0;i<lpf.length;i++){
                                lpf[i].createObject(refuser,c);
                            }
                        }
                                              
                    }
                }
            }else{
                if (this.getIdplacement() != null) {
                    if (!this.getIdplacement().startsWith("FC")) {
                        Placement placement = this.findPlacement(c);
                        if(placement.getEtat()<11){
                            placement.validerObject(refuser, c);
                        }
                    }
                    
                    if(this.getIdplacement().startsWith("FC")){
                        String numeroPiece = calculerNumeroPiece(c);
                        this.setNumPiece(numeroPiece);
                    }
                    
                    viserFacturesRattachees(refuser, c);
                    genererPaiement(c, refuser);
                }
            }
           
            if(getIdmode()!=null && getIdmode().equals(Constante.modePaiementEspece) && 
                   getIdTypeCheque()!=null && getIdTypeCheque().equals(Constante.typeChequeAuComptant)){
                this.arrondir();
            }

            user.updateEtat(this, ConstanteEtat.getEtatValider(), this.getId(), c);

            if (verif == 1) {
                c.commit();
            }
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    @Override
    public ClassMAPTable createObject(String u,Connection c)throws Exception{
        if(this.getIdplacement() != null && this.getIdplacement().equalsIgnoreCase("") == false){
            Placement placement = new Placement();
            placement.setId(this.getIdplacement());
            Placement[] tab = (Placement[]) CGenUtil.rechercher(placement, null, null, c, "");
            if(tab.length >0){
                if(tab[0].getEtat() < ConstanteEtat.getEtatValider()){
                    throw new Exception("Ce placement doit être visé");
                }
            }
        }
        return super.createObject(u, c);
    }
    
    public FactureClient[] findFactureClient(Connection c) throws Exception{
        FactureClient fc = new FactureClient();
        fc.setNomTable("facture_client_union");
        String ids = this.getIdplacement().contains(";") ? this.getIdplacement().replace(";", "','") : this.getIdplacement();
        String where = " and id in ('" +ids+"') order by daty asc";
        FactureClient[] result = (FactureClient[])CGenUtil.rechercher(fc, null, null, c, where);
        if (result != null && result.length > 0) 
            return result;
        return null;
    }
    public AvoirFF findAvoirFF(Connection c) throws Exception{
        AvoirFF fc = new AvoirFF();
        fc.setNomTable("avoirFF_montant");
        String where = String.format(" and id = '%s' ", this.getIdplacement());
        AvoirFF[] result = (AvoirFF[])CGenUtil.rechercher(fc, null, null, c, where);
        if (result != null && result.length > 0) 
            return result[0];
        return null;
    }
    
    
    public PayementFacture[] getPayementFactureTous(Connection c) throws Exception{
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            PayementFacture pf = new PayementFacture();
            pf.setNomTable("paiementfacturecp");
            String awhere = String.format(" and idmvt = '%s' ", this.getId());
            PayementFacture[] result = (PayementFacture[])CGenUtil.rechercher(pf, null, null, c, awhere);
            return result;
        }  catch(Exception ex) {
            throw ex;
        }  finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public PayementFacture[] getPayementFacture(Connection c) throws Exception{
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                verif = 1;
            }
            PayementFacture pf = new PayementFacture();
            pf.setNomTable("paiementfactureHorsProvision");
            String awhere = String.format(" and idmvt = '%s' ", this.getId());
            PayementFacture[] result = (PayementFacture[])CGenUtil.rechercher(pf, null, null, c, awhere);
            return result;
        } catch(Exception ex) {
            throw ex;
        }  finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public void genererPaiement(Connection c, String refuser) throws Exception{
        boolean verif = false;
        try{
            if(c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = true;
            }
            AvoirFF avoirFF=this.findAvoirFF(c);
            if(avoirFF!=null){
                avoirFF.controlerPaiement(c);
                PaiementFacture paiementFact = new PaiementFacture();
                paiementFact.setNomTable("paiementfacturef");
                paiementFact.setIdMvt(this.getId());
                paiementFact.setIdFact(avoirFF.getIdfacture());
                paiementFact.setMontant(-avoirFF.getMontant());
                paiementFact.createObject(refuser, c);
            }
            FactureClient[] fcListe = findFactureClient(c);
            if(fcListe != null && fcListe.length > 0){
                checkMontantFactureClient(fcListe, c);
                
                double resteCredit = this.getCredit();
                
                for(FactureClient fc: fcListe) {
                    double aPayer = fc.getMontantreste() < resteCredit ? fc.getMontantreste() : resteCredit;
                                        
                    PaiementFacture pf = new PaiementFacture();
                    pf.setIdMvt(this.getId());
                    pf.setIdFact(fc.getId());
                    pf.setMontant(genererMontantPaiement(c,"etatprovisionvrai",fc.getId(), aPayer)); // this.getCredit() izy taloha
                    pf.createObject(refuser, c);
                    
                    resteCredit -= aPayer;
                    
                    if(resteCredit <= 0) break;
                }
            }
            FactureFournisseur[] ffListe = this.findFactureFournisseur(c);
            if(ffListe != null && ffListe.length >0){
                checkMontantFactureFournisseur(ffListe,c);
                                
                for(FactureFournisseur ff : ffListe){
                    PaiementFacture pf = new PaiementFacture();
                    pf.setNomTable("paiementfacturef");
                    pf.setIdMvt(this.getId());
                    pf.setIdFact(ff.getId());
                    pf.setMontant(genererMontantPaiement(c,"etatbpvrai",ff.getId(),ff.getMontantreste()));//this.getCredit() izy taloha
                    pf.createObject(refuser, c);
                }
            }
            if(verif) c.commit();
        } catch(Exception ex){ 
            if(c != null && verif){
                c.rollback();
            }
            throw ex;
        }finally{
            if(c != null && verif){
                c.close();
            }
        }
    }
    
    public double genererMontantPaiement(Connection c,String nomtable,double montantV) throws Exception {
        boolean verif = false;
        double montant = 0;
        
        try{
            if(c == null) {
                c = new UtilDB().GetConn();
                verif = true;
            }
            
            montant = getMontantResteProvision(c, nomtable);
            
            if(montant >= montantV) montant = montantV;
            
        } catch(Exception ex) {
            throw ex;
        }  finally{
            if(c != null && verif){
                c.close();
            }
        }
        
        return montant;
    }
    
     public double genererMontantPaiement(Connection c,String nomtable,String idFacture,double montantV) throws Exception {
        boolean verif = false;
        double montant = 0;
        
        try{
            if(c == null) {
                c = new UtilDB().GetConn();
                verif = true;
            }
            
            montant = getMontantResteProvision(c, nomtable,idFacture);
            
            if(montant >= montantV) montant = montantV;
            
        } catch(Exception ex) {
            throw ex;
        }  finally{
            if(c != null && verif){
                c.close();
            }
        }
        
        return montant;
    }
    
    public double getMontantResteProvision(Connection c,String nomtable)throws Exception{
        double result = 0.;
        int verify = 0;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                verify = 1;
            }
            EtatProvision ep = new EtatProvision();
            ep.setNomTable(nomtable);//"etatprovisionvrai" ny tsotra
            ep.setId(this.getIdplacement());
            EtatProvision[] etatProv = (EtatProvision[])CGenUtil.rechercher(ep, null, null, c, "");
            if(etatProv.length>0)
                result = etatProv[0].getMontantreste();
        }catch(Exception e){
            throw e;
        }finally{
            if(c!=null && verify==1) c.close();
        }
        return result;
    }
    
    
    public double getMontantResteProvision(Connection c,String nomtable, String idFacture)throws Exception{
        double result = 0.;
        int verify = 0;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                verify = 1;
            }
            EtatProvision ep = new EtatProvision();
            ep.setNomTable(nomtable);//"etatprovisionvrai" ny tsotra
            ep.setId(idFacture);
            EtatProvision[] etatProv = (EtatProvision[])CGenUtil.rechercher(ep, null, null, c, "");
            if(etatProv.length>0)
                result = etatProv[0].getMontantreste();
        }catch(Exception e){
            throw e;
        }finally{
            if(c!=null && verify==1) c.close();
        }
        return result;
    }
    
    public void controlerPaiementAvoirFC(Connection c, String idAvoir) throws Exception{
        boolean verif = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                verif = true;
            }
            OrdonnerPayement op = new OrdonnerPayement();
            op.setNomTable("ORDONNERPAYEMENT_JC_VISE");
            OrdonnerPayement[] tabOp = (OrdonnerPayement[]) CGenUtil.rechercher(op, null, null, c, String.format(" and ded_id = '%s' ", idAvoir));
            if (tabOp.length>0) 
                throw new Exception("Avoir déja payé");
        } catch(Exception ex){
            throw ex;
        } finally{
            if(c!=null && verif)
                c.close();
        }
    }
    
    public String genererCodeModePaiement(){
        if(this.getIdmode().compareToIgnoreCase("pay1") == 0){
            return "E";
        }else if(this.getIdmode().compareToIgnoreCase("pay2") == 0){
            return "C";
        }
        return null;
    }
    public String genererCodeType()
    {
        String result="";
        if(this.getIdTypeCheque().compareToIgnoreCase("TCHQ00001")==0)
        {
            result = "1";
        }
        if(this.getIdTypeCheque().compareToIgnoreCase("TCHQ00002")==0)
        {
            result = "3";
        }
        return result;
    }
    
    public String calculerNumeroPiece(Connection c) throws Exception{
        String dateEffetStr = Utilitaire.datetostring(this.getDateEffet()) ;
        return Utilitaire.genererAnnee(dateEffetStr) + 
                Utilitaire.genererMois(dateEffetStr) + "-" + 
                genererCodeModePaiement() + "-" + 
                genererCodeType() + "-" + 
                UtilitaireFacture.genererSequence(c, "numeropiece",7,dateEffetStr);

    }
    
    public FactureFournisseur[] findFactureFournisseur(Connection c) throws Exception{
        FactureFournisseur ff = new FactureFournisseur();
        //ff.setNomTable("FACTUREFOURNVALIDE_V");
        ff.setNomTable("FACTFOURN_MSUM_LIBV");
        String ids = this.getIdplacement().contains(";") ? this.getIdplacement().replace(";", "','") : this.getIdplacement();
        String where = " and id in ('" +ids+"')";
        FactureFournisseur[] result = (FactureFournisseur[])CGenUtil.rechercher(ff, null, null, c, where);
        if (result != null && result.length > 0) 
            return result;
        return null;
    }
    
    public void insererDansBonProvisoire(String u, Connection con) throws Exception {
        boolean verif = false;
        try{
            if(con == null){
                con = new UtilDB().GetConn();
                con.setAutoCommit(false);
                verif = true;
            }
            
            Date dateDuJour = Utilitaire.dateDuJourSql();
            JournalCaisse transfert = new JournalCaisse(null, Constante.caisseCentraleBP, null, "Transfert bon provisoire", null, dateDuJour, dateDuJour, 0, this.getDebit());
            transfert.setIddevise(this.getIddevise());
            transfert.setIdmode(this.getIdmode());
            transfert.setEtat(ConstanteEtat.getEtatValider());
            
            transfert.createObject(u, con);
            
            if(verif) con.commit();
        }
        catch(Exception ex) {
            if(con != null && verif) con.rollback();
            throw ex;
        }
        finally {
            if(con != null && verif) con.close();
        }
    }

    public String getDescecaisse() {
        return descecaisse;
    }

    public void setDescecaisse(String descecaisse) {
        this.descecaisse = descecaisse;
    }
    
    public void arrondir() throws Exception{
        if(this.getCredit()%100 != 0){
            this.setCredit(this.getCredit() + (100 - this.getCredit()%100));
        }
    }
    
    public FactureFournisseur genererFactureFournisseurAuto(Connection c,String user,String compte) throws Exception{
        
        FactureFournisseur facturefrns = new FactureFournisseur(Utilitaire.dateDuJourSql(), this.getTiers(), "Facture auto via", Constante.typeChequeAuComptantFF, Constante.categorieFFdefault, 1);
        FactureFournisseurDetails detail = new FactureFournisseurDetails(facturefrns.getId(), 1, this.getCredit(), compte, "Facture auto via", 1);
        FactureFournisseurDetails[] fille = {detail};
        facturefrns.setFille(fille);
        
        facturefrns.createObject(user,c);

        return facturefrns;
        
    }
}
