/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import avoir.AvoirFC;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import ded.OrdonnerPayement;
import facture.EtatProvision;
import facture.FactureClient;
import facture.PaiementFacture;
import factureclient.PayementFacture;
import facturefournisseur.RegulFacture;
import java.sql.Connection;
import java.sql.Date;
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
            
                FactureClient fc = findFactureClient(c);
                if(fc != null) {
                    if(fc.getEtat()<ConstanteEtat.getEtatValider()) throw new Exception ("Facture Client non visee");
                    if(this.getCredit() > fc.getMontantreste()) throw new Exception("Montant superieur au reste a payer");
                }

                AvoirFC avoir = findAvoirFC(c);
                if(avoir != null) {
                    if(avoir.getEtat()<ConstanteEtat.getEtatValider()) throw new Exception ("Avoir non visee");
                    if(this.getDebit() > avoir.getMontantreste()) throw new Exception("Montant superieur au reste a payer");
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

    public void traitementOP(UserEJBBean user, Connection c) throws Exception {
        OrdonnerPayement ordonnerPayement = new OrdonnerPayement(this.getIdordre());
        ordonnerPayement = (OrdonnerPayement) ordonnerPayement.getById(this.getIdordre(), ordonnerPayement.getNomTable(), c);
        ordonnerPayement.setMontant(Math.abs(this.getDebit() - this.getCredit()));

        if (ordonnerPayement.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("OP non visé");
        }
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
    
    public void checkMontantFactureClient(Connection c) throws Exception {
        FactureClient fc = new FactureClient();

        fc = (FactureClient) fc.getById(this.getIdplacement(), "FACTURE_CLIENT_UNION", c);

        if (fc != null) {
            //if(fc.getMontantreste() <= 0) throw new Exception("Facture déjà payée en totalité" + fc.getId());
            System.out.println("MontantReste="+fc.getMontantreste()+" et credit="+this.getCredit());
            
            if(this.getIdTypeCheque().equals(Constante.typeCheque)) {
                if(this.getCredit() != fc.getMontantreste()) throw new Exception("Une facture au comptant doit etre payee en totalite");
            }
            
            if (fc.getMontantreste() < this.getCredit()) {
                throw new Exception("Montant supérieur au reste à payer");
            }
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
            /*if (this.getIdordre() != null) {
                this.traitementOP(user, c); 
                OrdonnerPayement op = getOP("ordonnerpayementAvoirFC", c); // ho an'ny avoir
                if(op != null) {
                    if(op.getType().compareTo("1")==0) throw new Exception("Impossible a payer : avoir interne");
                    PaiementFacture paiementFact = new PaiementFacture();
                    paiementFact.setIdMvt(this.getId());
                    paiementFact.setIdFact(op.getIdfacture());
                    paiementFact.setMontant(-op.getMontant());
                    
                    paiementFact.createObject(refuser, c);
                }
            }else{*/
                if (this.getIdplacement() != null) {
                    if (!this.getIdplacement().startsWith("FC")) {
                        this.traitementPlacement(user, c);
                    }
                    
                    genererPaiement(c, refuser);

                    /*FactureClient fc = findFactureClient(c);
                    if(fc != null) {
                        checkMontantFactureClient(c); 
                        PaiementFacture paiementFact = new PaiementFacture();
                        paiementFact.setIdMvt(this.getId());
                        paiementFact.setIdFact(fc.getId());
//                        paiementFact.setMontant(this.getCredit());
                        paiementFact.setMontant(fc.getMontantttc());

                        paiementFact.createObject(refuser, c);
                    }*/
                }
            //}

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
    
    public FactureClient findFactureClient(Connection c) throws Exception{
        FactureClient fc = new FactureClient();
        fc.setNomTable("facture_client_union");
        String where = String.format(" and id = '%s' ", this.getIdplacement());
        FactureClient[] result = (FactureClient[])CGenUtil.rechercher(fc, null, null, c, where);
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
            pf.setNomTable("paiementfacture");
            String awhere = String.format(" and idmvt = '%s' ", this.getId());
            PayementFacture[] result = (PayementFacture[])CGenUtil.rechercher(pf, null, null, c, awhere);
            return result;
        } finally {
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
        } finally {
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
            FactureClient fc = findFactureClient(c);
            if(fc != null){
                PaiementFacture pf = new PaiementFacture();
                pf.setIdMvt(this.getId());
                pf.setIdFact(this.getIdplacement());
                pf.setMontant(genererMontantPaiement(c));
                pf.createObject(refuser, c);
                
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

    private double genererMontantPaiement(Connection c) throws Exception{
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    public double getMontantResteProvision(Connection c)throws Exception{
        double result = 0.;
        int verify = 0;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                verify = 1;
            }
            EtatProvision ep = new EtatProvision();
            String awhere = String.format(" and idProvision = '%s' ", this.getIdplacement());
            EtatProvision[] etatProv = (EtatProvision[])CGenUtil.rechercher(ep, null, null, c, awhere);
            result = etatProv[0].getResteProvision(c);
        }finally{
            if(c!=null && verify==1) c.close();
        }
        return result;
    }
}
