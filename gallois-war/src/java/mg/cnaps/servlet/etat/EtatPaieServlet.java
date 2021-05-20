package mg.cnaps.servlet.etat;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.TypeObjet;
import bordereau.BordereauFilleLibComplet;
import bordereau.BordereauLibComplet;
import ded.OrdonnerPayementPDF;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import user.*;
import mg.spat.etat.servlet.*;
import reporting.ReportingUtils;
import utilitaire.Utilitaire;
import ded.OrdonnerPayementPDF;
import mg.spat.stock.*;
import utilitaire.ChiffreLettre;
import ded.BonEngagementPDF;
import caisse.SituationComptesData;
import java.util.Collection;
import mg.amadia.stock.EtatdeStockDate;
import mg.amadia.stock.RecapitulatifComptesSubReport;
import mg.amadia.stock.RecapitulatifComptesSubReport;
import mg.spat.JournalCaisse;
import facturefournisseur.*;
import java.sql.Date;
import mg.allosakafo.produits.*;
import mg.spat.FactureAnalyse;
import mg.spat.BonProvisoireComplet;
import utilitaire.UtilDB;
import mg.amadia.facture.*;
import mg.cnaps.formation.CodeEtablissement;
import mg.spat.EtatCaisse;
import service.EtatCaisseService;
import mg.spat.JournalCaisse;
import mg.spat.placement.PlacementLibComplet;
import mg.spat.placement.Placement;
import mg.spat.Caisse;
import mg.spat.JournalCaisseSubReport;
import mg.spat.JournalCaisseMode;
import projet.Projet;
import facture.FactureProforma;
import facture.FactureProformaDetails;

/**
 *
 * @author Manda
 */
@WebServlet(name = "EtatPaieServlet", urlPatterns = {"/Paie"})
public class EtatPaieServlet extends HttpServlet {

    String nomJasper = "";

    public String getReportPath() throws IOException {
        return getServletContext().getRealPath(File.separator + "report" + File.separator + getNomJasper() + ".jasper");
    }

    public String getNomJasper() {
        return nomJasper;
    }

    public void setNomJasper(String nomJasper) {
        this.nomJasper = nomJasper;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws  Exception{
        try{
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("ordonnerpayement")) {
                ordonnerpayement(request, response);
            }else if (action.equalsIgnoreCase("boncommande")) {
                boncommande(request, response);
            }else if (action.equalsIgnoreCase("imprimerBed")) {
                imprimerBed(request, response);
            }else if (action.equalsIgnoreCase("recapitulatifCompteCourant")) {
                recapitulatifCompteCourant(request, response);
            }else if (action.equalsIgnoreCase("imprimerBed2")) {
                imprimerBed2(request, response);
            }else if (action.equalsIgnoreCase("pieceDeCaiseDepense")) {
                pieceDeCaiseDepense(request, response);
            }else if (action.equalsIgnoreCase("pieceDeCaiseRecette")) {
                pieceDeCaiseRecette(request, response);
            }else if (action.equalsIgnoreCase("imprimerBon")) {
                imprimerBon(request, response);
            }else if (action.equalsIgnoreCase("fiche_facture")) {
                fiche_facture(request, response);
            }else if (action.equalsIgnoreCase("journalCaisseDepense")) {
                journalCaisseDepense(request, response);
            }else if (action.equalsIgnoreCase("imprimerFacture")) {
                imprimerFacture(request, response);
            }
            
        } catch(Exception ex){
            ex.printStackTrace();
            response.setContentType("text/html");
            //response.setBufferSize(8192);
            PrintWriter out = response.getWriter();
            out.println("<html>");
            out.println("<head>");
            out.print("<script>alert('" + ex.getMessage() + "');history.back();</script>");
            out.println("</head>");
            out.println("</html>");
            out.close();
            
            throw ex;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EtatPaieServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EtatPaieServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

        
    private void ordonnerpayement(HttpServletRequest request, HttpServletResponse response) throws  Exception {
        try {
            String id = request.getParameter("id");
            OrdonnerPayementPDF op = new OrdonnerPayementPDF();
            op.setId(id);
            op.setNomTable("ordonnerpayement_pdf");
            OrdonnerPayementPDF[] tabOp = (OrdonnerPayementPDF[]) CGenUtil.rechercher( op , null, null, "  ") ;
            Map param = new HashMap();
            if(tabOp.length > 0){
                op = tabOp[0];
                param.put("NUM_OP",op.getNumeroop());
                param.put("DESTINATION",op.getDestination());
                param.put("PAIEMENT",op.getModepaiement());
                param.put("MONTANT",op.getMontant());
                param.put("MONTANT_LETTRE",op.getMontant_lettre());
                param.put("BENEFICIAIRE",op.getBeneficiaire());
                param.put("ADRESSE",op.getAdresse());
                param.put("MOTIF",op.getRemarque());
                param.put("FACTURE",op.getNumfact());
                param.put("DEVISE",op.getDevise());
            }
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("ORDRE_PAYER");
            UtilitaireImpression.imprimer(request, response, "ORDRE_PAYER", param, new ArrayList(), getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private void boncommande(HttpServletRequest request, HttpServletResponse response) throws  Exception {
        try {
            String id = request.getParameter("id");
            BonDeCommande bc = new BonDeCommande();
            bc.setId(id);
            bc.setNomTable("AS_BONDECOMMANDE_LIBELLE_TIERS");
            BonDeCommande[] tabBc = (BonDeCommande[]) CGenUtil.rechercher( bc , null, null, " ") ;
            Map param = new HashMap();
            if(tabBc.length > 0){
                bc = tabBc[0];
                param.put("DATY",bc.getDaty());
                param.put("NOMFOURNISSEUR",bc.getNomfournisseur());
                param.put("ADRESSE",bc.getAdresse());
                param.put("REMARQUE",bc.getRemarque());
                param.put("CODE_ETAB",bc.getCode_etab());
                param.put("DELAI",bc.getDelaipaiement());
                param.put("TOTAL_HT",bc.getMontant());
                param.put("REMISE",bc.getRemise());
                param.put("TOTAL_TVA",bc.getMontanttva());
                param.put("TOTAL_TTC",bc.getMontantTTC());
                
                param.put("MODE_PAIEMENT",bc.getModepaiement());
                param.put("LB",bc.getProjet());
                param.put("REF",bc.getNumbc());
                param.put("TYPE_PAIEMENT",bc.getTypepaiement());
                
                param.put("DELAILIVRAISON",bc.getDelailivraison());
                
                
                String montantString = String.valueOf((int)bc.getMontantTTC());
                long montantLong = Long.valueOf(montantString);        
                param.put("TOTAL_TTC_LETTRE",(ChiffreLettre.convertIntToString(montantLong)).toUpperCase()+" ARIARY ");
            }
            
            BonDeCommandeFille f = new BonDeCommandeFille();
            f.setNomTable("AS_BONDECOMMANDE_FILLE_LIB");
            BonDeCommandeFille[] liste = (BonDeCommandeFille[]) CGenUtil.rechercher( f , null, null, " and IDBC = '"+id+"'") ;
            
            List dataSources = new ArrayList();
            for(BonDeCommandeFille fille : liste){
                dataSources.add(fille);
            }
            
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("bon_de_commande");
            UtilitaireImpression.imprimer(request, response, "bon_de_commande", param, dataSources, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private void imprimerBed(HttpServletRequest request, HttpServletResponse response) throws  Exception {
        try {
            String id = request.getParameter("id");
            BonEngagementPDF be = new BonEngagementPDF();
            be.setId(id);
            BonEngagementPDF[] tabBe = (BonEngagementPDF[]) CGenUtil.rechercher( be , null, null, " ") ;
            Map param = new HashMap();
            if(tabBe.length > 0){
                param.put("id",tabBe[0].getNumeroop());
                param.put("tiers",tabBe[0].getTiers());
            }
            
            List dataSources = new ArrayList();
            dataSources.addAll(Arrays.asList(tabBe));
            
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("suivi-budgetaire");
            UtilitaireImpression.imprimer(request, response, "suivi-budgetaire", param, dataSources, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private void recapitulatifCompteCourant(HttpServletRequest request, HttpServletResponse response) throws  Exception {
        try {
            String daty2 = request.getParameter("daty2");
            String daty1 = request.getParameter("daty1");
            String ingredient = null;
            String colonne = null;
            String ordre = null;
            
            if(request.getParameter("ingredient").equalsIgnoreCase("null") == false)
                ingredient = request.getParameter("ingredient");
            if(request.getParameter("colonne").equalsIgnoreCase("null") == false)
                colonne = request.getParameter("colonne");    
            if(request.getParameter("ordre").equalsIgnoreCase("null") == false)
                ordre = request.getParameter("ordre");
            
            SituationComptesData datas = new SituationComptesData(daty2, daty1, ingredient, colonne, ordre);
            EtatdeStockDate[] recapitulatifComptes = datas.getRecapitulatifComptes();
            EtatdeStockDate[] recapitulatifPlacement = datas.getRecapitulatifPlacement();
            double totalTresorerie = datas.getTotalTresorerie();
            double totalPlacement = datas.getTotalPlacement();
            double total = totalPlacement + totalTresorerie;
            
            ClassMAPTable[] caisseAr = datas.getCaisseAr();
            
            ArrayList tabCaisse = new ArrayList();
            for(ClassMAPTable c : caisseAr){
                tabCaisse.add((EtatdeStockDate)c);
            }
            ClassMAPTable[] banqueDevise = datas.getBanqueDevise();
            ArrayList tabBanqueDevise = new ArrayList();
            for(ClassMAPTable b : banqueDevise){
                tabBanqueDevise.add((EtatdeStockDate)b);
            }
            EtatdeStockDate[] placementAr = datas.getPlacementAr();
            EtatdeStockDate[] placementDevise = datas.getPlacementDevise();
            
            Map param = new HashMap();               
            param.put("total",total);
            
            List dataSources = new ArrayList();
            RecapitulatifComptesSubReport sub = new RecapitulatifComptesSubReport(Arrays.asList(recapitulatifComptes), Arrays.asList(recapitulatifPlacement),tabCaisse,tabBanqueDevise,Arrays.asList(placementAr),Arrays.asList(placementDevise));
            dataSources.add(sub);
            
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("recapitulatifCompteCourant");
            UtilitaireImpression.imprimer(request, response, "recapitulatifCompteCourant", param, dataSources, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private void imprimerBed2(HttpServletRequest request, HttpServletResponse response) throws  Exception {
        try {
            String id = request.getParameter("id");
//            BonEngagementPDF be = new BonEngagementPDF();
//            be.setNomTable("BED_PDF_II");
//            be.setId(id);
//            BonEngagementPDF[] tabBe = (BonEngagementPDF[]) CGenUtil.rechercher( be , null, null, " ") ;
//            Map param = new HashMap();
//            if(tabBe.length > 0){
//                param.put("id",tabBe[0].getNumeroop());
//                param.put("tiers",tabBe[0].getPrestataire());
//                param.put("code_etab",tabBe[0].getCode_etablissement());
//                param.put("projet",tabBe[0].getProjet());
//            }
//            
//            List dataSources = new ArrayList();
//            dataSources.addAll(Arrays.asList(tabBe));
//            
//            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
//            setNomJasper("bed");
//            UtilitaireImpression.imprimer(request, response, "bed", param, dataSources, getReportPath(), rt);
            
            BordereauLibComplet res = new BordereauLibComplet();
            res.setNomTable("bordereauFF_libcomplet");
            res = (BordereauLibComplet)res.getById(id, null, null); 
            if(res != null)
            {
                Map param = new HashMap();
                param.put("numero",res.getNumero());
                BordereauFilleLibComplet fille=new BordereauFilleLibComplet();
                fille.setIdbordereau(id);
                fille.setNomTable("liaisonbordereauFF_libcomplet");
                BordereauFilleLibComplet[] liste = (BordereauFilleLibComplet[]) CGenUtil.rechercher(fille, null, null, "");
                EtatFactureMontantDaty[] etatfmd = (EtatFactureMontantDaty[]) CGenUtil.rechercher(new EtatFactureMontantDaty(), "select * from etatfacturemontantdaty where id in (select idop from liaisonbordereauFF where idbordereau = '" + id + "')");
                
                if(etatfmd.length > 0)
                {
                    FactureFournisseur factf = new FactureFournisseur();
                    factf.setId(etatfmd[0].getId());
                    factf = (FactureFournisseur)factf.getById(factf.getId(), null, null);
                    
                    CodeEtablissement ce = new CodeEtablissement();
                    ce.setNomTable("codeetablissement_libcomplet");
                    ce.setId(factf.getCode_etablissement());
                    ce = (CodeEtablissement)ce.getById(ce.getId(), null, null);
                    param.put("code_etab",ce.getVal());
                    param.put("direction",ce.getDescelib());
                    param.put("departement",ce.getDepartementlib());
                    param.put("service",ce.getServicelib());
                    
                    Projet prj = new Projet();
                    prj.setNomTable("projet");
                    prj.setId(factf.getProjet());
                    prj = (Projet)prj.getById(prj.getId(), null, null);
                    param.put("projet",prj.getDesignation());
                }
                
                param.put("date",res.getDaty());
                param.put("tiers",res.getTierslib());
                
                List dataSources = new ArrayList();
                dataSources.addAll(Arrays.asList(etatfmd));
                
                ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
                setNomJasper("bed");
                UtilitaireImpression.imprimer(request, response, "bed", param, dataSources, getReportPath(), rt);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }private void pieceDeCaiseDepense(HttpServletRequest request, HttpServletResponse response) throws  Exception {
        try {

            String idop = request.getParameter("idop");
            OrdonnerPayementPDF op = new OrdonnerPayementPDF();
            op.setNomTable("OrdonnerPayement_LIB");
            op.setId(idop);
            OrdonnerPayementPDF[] tabOp = (OrdonnerPayementPDF[]) CGenUtil.rechercher( op , null, null, "  ") ;
            Map param = new HashMap();    
            if(tabOp.length > 0){
                tabOp[0].setDevise(" ARIARY");
                
                param.put("daty",Utilitaire.dateDuJourSql());
                param.put("montant",tabOp[0].getMontant());
                param.put("montant_lettre",tabOp[0].getMontant_lettre());
                
                EtatFactureDepService a = new EtatFactureDepService();
                a.setNomTable("ETATFACTUREMONTANTDATY_LIB");
                a.setId(tabOp[0].getDed_Id());
                EtatFactureDepService[] tabFact = (EtatFactureDepService[]) CGenUtil.rechercher( a , null, null, "  ") ;
                if(tabFact.length > 0){
                    param.put("facture_lib",tabFact[0].getDesignation());
                    
                    param.put("direction",tabFact[0].getDirection());
                    param.put("departement",tabFact[0].getDepartement());
                    param.put("service",tabFact[0].getService());
                }
                LiaisonIntraTable liaison = new LiaisonIntraTable();
                liaison.setNomTable("LIAISONINTRATABLE");
                LiaisonIntraTable[] tabLiaison = (LiaisonIntraTable[]) CGenUtil.rechercher( liaison , null, null, " and id2 = '"+idop+"'") ;
                if(tabLiaison.length > 0){
                    param.put("facture_montant",tabLiaison[0].getMontant());
                }
            }else{
                JournalCaisse jc = new JournalCaisse();
                jc.setId(request.getParameter("id"));
                jc.setNomTable("JOURNALCAISSE_LIB");
                JournalCaisse[] tabJournal = (JournalCaisse[]) CGenUtil.rechercher( jc , null, null, " ") ;
                if(tabJournal.length > 0){
                    param.put("daty",tabJournal[0].getDateEffet());
                    param.put("montant",tabJournal[0].getCredit());
                    String montantString = String.valueOf((long)tabJournal[0].getCredit());
                    long montantLong = Long.valueOf(montantString);
                    param.put("montant_lettre",(ChiffreLettre.convertIntToString(montantLong)+" ARIARY ").toUpperCase());
                    param.put("facture_lib",tabJournal[0].getLibelle());
                    param.put("facture_montant",tabJournal[0].getCredit());
                }
                
            }
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("piece_de_caisse_depenses");
            UtilitaireImpression.imprimer(request, response, "piece_de_caisse_depenses", param, new ArrayList(), getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }private void pieceDeCaiseRecette(HttpServletRequest request, HttpServletResponse response) throws  Exception {
        try{
            JournalCaisseMode jc = new JournalCaisseMode();
            jc.setId(request.getParameter("id"));
            jc.setNomTable("JOURNALCAISSE_BANQUE");
            JournalCaisse[] tabJournal = (JournalCaisse[]) CGenUtil.rechercher( jc , null, null, " ") ;
                
            String idFacture = request.getParameter("idFacture");
            FactureAnalyse facture = new FactureAnalyse();
            facture.setNomTable("ANALYSEGLOBALEFACTURE_ANALYSE");
            facture.setNmfact(idFacture);
            FactureAnalyse[] tabFact = (FactureAnalyse[]) CGenUtil.rechercher( facture , null, null, "  ") ;
            Map param = new HashMap();   
            param.put("datyJ",Utilitaire.dateDuJourSql());
            if(tabFact.length > 0){
                param.put("nmFact",tabFact[0].getNmfact());
                param.put("montant",tabFact[0].getMttc());
                param.put("datyFact",tabFact[0].getDaty());
                
                String montantString = String.valueOf((long)tabFact[0].getMttc());
                long montantLong = Long.valueOf(montantString);

                param.put("montantLettre",ChiffreLettre.convertIntToString(montantLong)+" Ariary ");

            }
            else{
                if(tabJournal.length > 0){
                    param.put("montant",tabJournal[0].getDebit());
                    param.put("datyFact",tabJournal[0].getDateEffet());
                    String montantString = String.valueOf((long)tabJournal[0].getDebit());
                    long montantLong = Long.valueOf(montantString);
                    param.put("montantLettre",ChiffreLettre.convertIntToString(montantLong)+" Ariary ");
                }
            }
            if(tabJournal.length > 0){
                param.put("numPiece",tabJournal[0].getNumPiece());
                param.put("client",tabJournal[0].getTiers());
                param.put("operation",tabJournal[0].getLibelle());
                param.put("datyPiece",tabJournal[0].getDateEffet());
            }
            String nomJasper = "piece_de_caisse";
            if(tabJournal[0].getIdmode().equalsIgnoreCase("pay1") == false){
                nomJasper = "piece_de_caisse_banque";
                param.put("banque","");
                param.put("numCheque",tabJournal[0].getNumcheque());
            }
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper(nomJasper);
            UtilitaireImpression.imprimer(request, response, "piece_de_caisse", param, new ArrayList(), getReportPath(), rt);
        }catch(Exception e){
            e.printStackTrace();
        }         
    }
    private void imprimerBon(HttpServletRequest request, HttpServletResponse response) throws  Exception {
        try{
            String id = request.getParameter("id");
            BonProvisoireComplet bon = new BonProvisoireComplet(); 
            bon.setId(id);
            
            BonProvisoireComplet[] tab = (BonProvisoireComplet[]) CGenUtil.rechercher( bon , null, null, "  ") ;
            Map param = new HashMap();   
            if(tab.length > 0){
                param.put("MONTANT",tab[0].getDebit());
                param.put("NUM",tab[0].getNumpiece());
                param.put("DATE",tab[0].getDateeffet());
                param.put("DEMANDEUR",tab[0].getBeneficiairelib());
                
                String montantString = String.valueOf((long)tab[0].getDebit());
                long montantLong = Long.valueOf(montantString);
                param.put("MONTANT_LETTRE",ChiffreLettre.convertIntToString(montantLong)+" Ariary ");
                param.put("MOTIF",tab[0].getRemarque());
                param.put("DESIGNATION",tab[0].getLibelle());
            }
            
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("bon_provisoire");
            UtilitaireImpression.imprimer(request, response, "bon_provisoire", param, new ArrayList(), getReportPath(), rt);
        }catch(Exception e){
            e.printStackTrace();
        }         
    }
        public void fiche_facture(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List dataSource = new ArrayList();
        String id = request.getParameter("id");
        System.out.println(id);
        FactureClientReport pay = null;
        Connection c = null;
        HashMap param = new HashMap();
        this.setNomJasper("facture_client");
        try {
            c = new UtilDB().GetConn();
            pay = FactureService.imprimerFacture(id, c);
            dataSource.add(pay);
            //param.put("MONTANTTOTAL", pay);
            String montantlettre = ChiffreLettre.convertRealToString( pay.getMontantTotal()) +" Ariary " ;
            param.put("montantlettre", montantlettre );
            UtilitaireImpression.imprimer(request, response, "Facture_client" + id, param, dataSource, getReportPath(), ReportingUtils.ReportType.PDF);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }private void journalCaisseDepense(HttpServletRequest request, HttpServletResponse response) throws  Exception {
        try{
            String caisse = request.getParameter("caisse");
            String datyString = request.getParameter("daty");
            Date daty = Utilitaire.dateDuJourSql();
            if (datyString != null && datyString.compareTo("") != 0) {
                daty = Utilitaire.stringDate(datyString);
            }            
            EtatCaisse ec = new EtatCaisse(caisse, daty);
            EtatCaisseService ecS = new EtatCaisseService();
            ecS.genererEtatCaisseData(ec);
            Caisse[] caisses = ecS.getCaisses();
            JournalCaisse debits = new JournalCaisse();
            debits.setLibelle("Recette de la caisse SPAT Journee du "+datyString); 
            debits.setDebit(ecS.getRecette(caisse, daty,null));
            
            JournalCaisse[] credits = ec.getDebits();
            PlacementLibComplet[] placement = ec.getListePlacement();
            
            Map param = new HashMap();   
            if(ec != null ){
                param.put("FOLIO",ec.getFolio());
                param.put("DATY",ec.getDaty());
                param.put("SoldeAnterieur",ec.getSoldeAnterieur());
                param.put("SoldeActuel",ec.getSoldeActuel());
            }
            JournalCaisseSubReport journalCaisseSub = new JournalCaisseSubReport(debits, credits);
            List dataSources = new ArrayList();
            dataSources.add(journalCaisseSub);
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("journal-caisse-depense");
            UtilitaireImpression.imprimer(request, response, "journal-caisse-depense", param, dataSources, getReportPath(), rt);
        }catch(Exception e){
            e.printStackTrace();
        }         
    }
    
    private void imprimerFacture(HttpServletRequest request, HttpServletResponse response) throws  Exception {
        try {
            Map param = new HashMap();
            String id = request.getParameter("id");
            FactureProforma e = new FactureProforma();
            e.setNomTable("factureprofMSum_lib");
            FactureProforma[] mere = (FactureProforma[]) CGenUtil.rechercher(e, null, null, null, " and id = '"+id+"'");
            param.put("daty",Utilitaire.formatterDatySql(mere[0].getDaty()));
            param.put("id",mere[0].getId());
            param.put("client",mere[0].getTierslib());
            param.put("adresse",mere[0].getAdresse());
            param.put("phone",mere[0].getContact());
            param.put("montant",mere[0].getMontant());
            param.put("montantTVA",mere[0].getMontanttva());
            param.put("montantTTC",mere[0].getMontantttc());
            param.put("tva",mere[0].getTva());
            String montantlettre = ChiffreLettre.convertRealToString( new Double( mere[0].getMontantttc() ) ) +" Ariary " ;
            param.put("montantlettre",montantlettre);
            
            FactureProformaDetails cht = new FactureProformaDetails();
            cht.setNomTable("FACTURE_CLIENT_PROFMONTANT");
            FactureProformaDetails[] details = (FactureProformaDetails[]) CGenUtil.rechercher(cht, null, null, null, " and idmere = '"+id+"'");
            ArrayList<FactureProformaDetails> arrList = new ArrayList<FactureProformaDetails>();
            for(int i = 0; i < details.length; i++)
            {
                arrList.add(details[i]);
            }
            mere[0].setListeDetails(arrList);
            
            List dataSources = new ArrayList();
            dataSources.add(mere[0]);
            
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("facture_client2");
            UtilitaireImpression.imprimer(request, response, "facture-proforma", param, dataSources, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
