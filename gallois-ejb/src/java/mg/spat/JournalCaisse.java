/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import ded.OrdonnerPayement;
import facture.FactureClient;
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

    private String id, folio, caisse, numPiece, libelle, remarque, tiers, idTypeCheque, idplacement,valCaisse,valTypeCheque,desceTypeCheque,tiersLib;
    private double sommeCredit;
    
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

    public void controler(Connection c) throws Exception {
        try {
            ClotureService.testDateCloture(this.dateEffet, this.caisse, c);
            Report[] report = (Report[]) CGenUtil.rechercher(new Report(), null, null, c, " and daty >= to_date('" + Utilitaire.dateDuJourSql() + "','yyyy-mm-dd hh24:mi:ss') and caisse='" + this.caisse + "'");
            if (report.length > 0) {
                throw new Exception("Caisse deja reportee");
            }
            //ClotureService.modifSequentiel(this.debit,this.credit,this.dateEffet,this.caisse,c);
            if (this.getTypemvt() != null && this.getTypemvt().compareToIgnoreCase(Constante.financeTypeAnnulation) == 0) {
                return;
            }
            /*
            EtatOP[] sop = (EtatOP[]) CGenUtil.rechercher(new EtatOP(), null, null, " AND ID = '" + this.getIdordre() + "'");
            if (sop.length > 0) {
                if (sop[0].getReste() == 0) {
                    throw new Exception("Mvt Caisse DEJA PAYE");
                }
                if (this.getDebit() > sop[0].getReste()) {
                    throw new Exception("Montant superieur reste a payer");
                }
            }*/
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
            if(fc.getMontantreste() <= 0) throw new Exception("Facture déjà payée en totalité" + fc.getId());
            if (fc.getMontantreste() < this.getCredit()) {
                throw new Exception("Montant supérieur au reste à payer");
            }
        }
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
            if (this.getEtat() >= ConstanteEtat.getEtatValider()) {
                throw new Exception("mouvement caissse deja valide");
            }
            if (this.getIdordre() != null) {
                this.traitementOP(user, c);
            }
            if (this.getIdplacement() != null) {
                if (this.getIdplacement().startsWith("FC")) {
                    checkMontantFactureClient(c);
                } else {
                    this.traitementPlacement(user, c);
                }
            }

            user.updateEtat(this, ConstanteEtat.getEtatValider(), this.getId(), c);

            if (c != null && verif == 1) {
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
}
