/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import avoir.AvoirFC;
import avoir.AvoirFF;
import bean.CGenUtil;
import ded.OrdonnerPayement;
import java.sql.Connection;
import utilitaire.UtilDB;
import facture.FactureClient;
import facture.FactureFournisseur;
import javax.servlet.http.HttpServletRequest;
import mg.spat.placement.DetailsPlacements;
import mg.spat.placement.Placement;
import utilitaire.Constante;
import bean.TypeObjet;

/**
 *
 * @author Samyen-Lee
 */
public class JournalCaisseData {

    HttpServletRequest request;
    FactureClient facture;
    FactureAnalyse factureAnalyse;
    MvtcaisseOrdonnerpayementFacture jcInfo;
    OrdonnerPayement op;
    AvoirFC avoirFC;
    AvoirFF avoirFF;
    Placement placement;
    DetailsPlacements detailsPlacement;
    TypeObjet pbc;

    public JournalCaisseData(HttpServletRequest request) {
        this.request = request;
    }
    
    public void initPlacementBanqueCaisse(Connection c) throws Exception{
        pbc=new TypeObjet();
        pbc.setNomTable("placement_banque_caisse");
        TypeObjet[] liste = (TypeObjet[])  CGenUtil.rechercher(pbc, null, null, c, " and val ='"+this.placement.getBanque()+"'");
        if(liste.length>0){
            pbc=liste[0];
        }
    }
    
    private void initFactureAnalyse(Connection c, String idFact) throws Exception {
        boolean checkFact = idFact.startsWith(Constante.fcPrefix);
        FactureAnalyse temporaire = new FactureAnalyse();
        String vue = request.getParameter("vue");

        if (vue != null) {
            temporaire.setNomTable(vue);
        } else {
            temporaire.setNomTable("ANALYSEGLOBALEFACTURE_ANALYSE");
        }
        if (checkFact) {
            temporaire.setNmfact(idFact);
        } else {
            temporaire.setId(idFact);
        }

        FactureAnalyse[] liste = (FactureAnalyse[]) CGenUtil.rechercher(temporaire, null, null, c, "");
        if (liste != null && liste.length > 0) {
            factureAnalyse = liste[0];
        }

        if (!checkFact) {
            factureAnalyse.setReste(factureAnalyse.getMontantreste());
            factureAnalyse.setClient(factureAnalyse.getTiers());
        }
    }
    
    private void initOP(Connection c, String idOrdre) throws Exception {
        OrdonnerPayement ordP = new OrdonnerPayement();
        op = (OrdonnerPayement) ordP.getById(idOrdre, "ORDONNERPAYEMENT_TIERSLIB", c);
        if(op.getDed_Id()!=null && op.getDed_Id().startsWith("AVRFC")){
           AvoirFC av = new AvoirFC();
           avoirFC = (AvoirFC) av.getById(op.getDed_Id(), av.getNomTable(), c);
        }
    }
    
    private void initJCInfo(Connection c, String idOrdre) throws Exception {
        MvtcaisseOrdonnerpayementFacture ordre = new MvtcaisseOrdonnerpayementFacture(idOrdre);
        ordre.setNomTable("JOURNALCAISSE_INFO");
        jcInfo = ordre.getOrdre(c);
    }
    
    private void initPlacement(Connection c, String idPlacement) throws Exception {
        Placement plc = new Placement();
        plc.setId(idPlacement);
        if (request.getParameter("param") != null && request.getParameter("param").equalsIgnoreCase("sortie")) {
            this.placement = plc.getPlacement(c);
        } else {
            detailsPlacement = placement.getDetailsPlacement(c);
        }
    }
    
    private void initAvoirFC(Connection c, String idAvoirFC) throws Exception {
        AvoirFC avoir = new AvoirFC();
        avoirFC = (AvoirFC) avoir.getById(idAvoirFC, "AvoirFC_montant", c);
        if(avoirFC == null){
            throw new Exception("Avoir introuvable ou non visé");
        }
    }
    
    private void initAvoirFF(Connection c, String idAvoirFF) throws Exception {
        AvoirFF obj = new AvoirFF();
        avoirFF = (AvoirFF) obj.getById(idAvoirFF, "AvoirFF_montant", c);
        if(avoirFF == null){
            throw new Exception("Avoir introuvable ou non visé");
        }
    }

    public void init(Connection c) throws Exception {
        boolean ouvert = false;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                ouvert = true;
            }

            String idFact = request.getParameter("idFacture");
            String idFactures = request.getParameter("idFactures");
            String idFacturesF = request.getParameter("idFacturesF");
            String idOP = request.getParameter("id");
            String idplacement = request.getParameter("idplacement");
            String idAvoirFC = request.getParameter("idAvoir");
            String idAvoirFF = request.getParameter("idAvoirFF");

            if (idFact != null && !idFact.trim().isEmpty()) {
                initFactureAnalyse(c, idFact);
            }
            if (idFactures != null && !idFactures.trim().isEmpty()) {
                facture = FactureClient.grouperFacture(idFactures, c);
            }else if (idFacturesF != null && !idFacturesF.trim().isEmpty()) {
                facture = FactureFournisseur.grouperFacture(idFacturesF, c);
            }
            if (idOP != null && !idOP.trim().isEmpty()) {
                initJCInfo(c, idOP);
                initOP(c, idOP);
            }
            if ((idplacement != null) && !(idplacement.trim().isEmpty())) {
                initPlacement(c, idplacement);
                initPlacementBanqueCaisse(c);
            }
            if ((idAvoirFC != null) && !(idAvoirFC.trim().isEmpty())) {
                initAvoirFC(c, idAvoirFC);
            }
            if ((idAvoirFF != null) && !(idAvoirFF.trim().isEmpty())) {
                initAvoirFF(c, idAvoirFF);
            }
            
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }
    }

    public AvoirFF getAvoirFF() {
        return avoirFF;
    }

    public void setAvoirFF(AvoirFF avoirFF) {
        this.avoirFF = avoirFF;
    }

    public Placement getPlacement() {
        return placement;
    }

    public void setPlacement(Placement placement) {
        this.placement = placement;
    }

    public DetailsPlacements getDetailsPlacement() {
        return detailsPlacement;
    }

    public void setDetailsPlacement(DetailsPlacements detailsPlacement) {
        this.detailsPlacement = detailsPlacement;
    }

    public AvoirFC getAvoirFC() {
        return avoirFC;
    }

    public void setAvoirFC(AvoirFC avoirFC) {
        this.avoirFC = avoirFC;
    }

    public OrdonnerPayement getOp() {
        return op;
    }

    public void setOp(OrdonnerPayement op) {
        this.op = op;
    }

    public MvtcaisseOrdonnerpayementFacture getJcInfo() {
        return jcInfo;
    }

    public void setJcInfo(MvtcaisseOrdonnerpayementFacture jcInfo) {
        this.jcInfo = jcInfo;
    }

    public FactureAnalyse getFactureAnalyse() {
        return factureAnalyse;
    }

    public void setFactureAnalyse(FactureAnalyse factureAnalyse) {
        this.factureAnalyse = factureAnalyse;
    }

    public FactureClient getFacture() {
        return facture;
    }

    public void setFacture(FactureClient facture) {
        this.facture = facture;
    }

    public TypeObjet getPbc() {
        return pbc;
    }

    public void setPbc(TypeObjet pbc) {
        this.pbc = pbc;
    }
    
    
}
