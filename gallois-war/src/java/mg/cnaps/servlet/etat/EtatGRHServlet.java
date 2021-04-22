/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.servlet.etat;

import bean.CGenUtil;
import bean.UnionIntraTable;
import java.io.File;
import java.io.IOException;
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
import mg.cnaps.formation.AttestationFormation;
import mg.cnaps.formation.AttestationPriseCharge;
import mg.cnaps.formation.FormDemande;
import mg.cnaps.formation.FormPartInfoComplet;
import mg.cnaps.formation.FormService;
import mg.spat.etat.servlet.UtilitaireImpression;
import net.sf.jasperreports.engine.JRException;
import reporting.ReportingCdn;
import reporting.ReportingUtils;
import user.UserEJB;
import utilitaire.Utilexcel;
import utilitaire.Utilitaire;

/**
 *
 * @author anthonyandrianaivoravelona
 */
@WebServlet(name = "EtatGRHServlet", urlPatterns = {"/EtatGRHServlet"})
public class EtatGRHServlet extends HttpServlet {
    String nomJasper = "";
    ReportingCdn.Fonctionnalite fonctionnalite = ReportingCdn.Fonctionnalite.PAIE;
    
    public String getReportPath() throws IOException {
        return getServletContext().getRealPath(File.separator + "report" + File.separator + getNomJasper() + ".jasper");
    }
    public String getNomJasper() {
        return nomJasper;
    }

    public void setNomJasper(String nomJasper) {
        this.nomJasper = nomJasper;
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String action = request.getParameter("action");
        if(action.equalsIgnoreCase("exportDemandeFormation")) exportDemandeFormation(request, response);
        else if(action.equalsIgnoreCase("exportListeParticipant")) exportListeParticipant(request, response);
        else if(action.equalsIgnoreCase("attestationFormation")) attestationFormation(request, response);
        else if(action.equalsIgnoreCase("convocation")) convocationFormation(request, response);
    }
    
    private void convocationFormation(HttpServletRequest request, HttpServletResponse response) throws IOException, JRException, Exception {
        String id = request.getParameter("id");
        String titreformation = request.getParameter("titre");
        String materiel = request.getParameter("materiel");
        String autre = request.getParameter("autre");
        setNomJasper("convocation_formation");
        UtilitaireImpression.imprimer(request, response, "CONVOCATION_DE_FORMATION", new HashMap(), FormService.getConvocationFormationMod2(id, materiel, titreformation, autre), getReportPath());
    }
    private void attestationFormation(HttpServletRequest request, HttpServletResponse response) throws IOException, JRException, Exception {
        String id = request.getParameter("id");
        List<AttestationFormation> laf =FormService.getAttestationFormation(id);
        setNomJasper("attestation_formation");
        UtilitaireImpression.imprimer(request, response, "ATTESTATION_DE_FORMATION", new HashMap(), laf, getReportPath());
    }
    private void exportListeParticipant(HttpServletRequest request, HttpServletResponse response) throws IOException, JRException, Exception {
        String id = request.getParameter("id");
        FormPartInfoComplet[] formations = (FormPartInfoComplet[]) CGenUtil.rechercher(new FormPartInfoComplet(), null, null, null, " AND FORM_FORMATION='"+id+"'");
        String[] entete = {"IDENTIFIANT", "IDENTIFIANT FORMATION", "IDENTIFIANT PERSONNEL", "PERSONNEL","SERVICE","FONCTION","MATRICULE","NOTE","NOMBRE ABSENCE"}; 
        Utilexcel.createExcel("FORMATION_PARTICIPANT-"+id+".xlsx", "FORMATION", entete, ReportingCdn.Fonctionnalite.DEFAUT,Arrays.asList(formations));
        UtilitaireImpression.loadFileFromServeur(request, response, "FORMATION_PARTICIPANT", id, ReportingCdn.Fonctionnalite.DEFAUT, ReportingUtils.ReportType.XLSX);
    }
    private void exportDemandeFormation(HttpServletRequest request, HttpServletResponse response) throws IOException, JRException, Exception {
        String id = request.getParameter("id");
        UnionIntraTable un = new UnionIntraTable();
	un.setNomTable("FORM_FORMATION_DEMANDE");
	un.setId1(request.getParameter("id"));
	UnionIntraTable[] lun = (UnionIntraTable[]) CGenUtil.rechercher(un, null, null,null, "");
        List<FormDemande> listeDemandeFormation = new ArrayList<FormDemande>();
        FormDemande fd = new FormDemande();
        fd.setNomTable("FORM_DEMANDE_LIBELLE7");
        for (int i = 0; i < lun.length; i++) {
            fd.setId(lun[i].getId2());
            FormDemande[] lfd = (FormDemande[]) CGenUtil.rechercher(fd, null, null,null, "");
            if(lfd.length>0) listeDemandeFormation.add(lfd[0]);
        }
        String[] entete = {"ID", "ETABLISSEMENT", "DOMAINE", "SERVICE","CATEGORIE","TYPE","PERSONNEL","CATEGORIE PROFESSIONNELLE","STATUT PROFESSIONNELLE","TYPE DEMANDE","DATE DEBUT","DATE FIN","LIEU","OBJET","NIVEAU REQUIS","EFFECTIF","COUT","ETAT","MATIERE","EXERCICE","HEURE DEBUT","HEURE FIN","DUREE HEURE DEBUT","DUREE HEURE FIN","TYPE COUT","DIRECTION","FONCTION","ANNEE SCOLAIRE"}; 
        Utilexcel.createExcel("FORMATION_DEMANDE-"+id+".xlsx", "DEMANDE", entete, ReportingCdn.Fonctionnalite.DEFAUT,listeDemandeFormation);
        UtilitaireImpression.loadFileFromServeur(request, response, "FORMATION_DEMANDE", id, ReportingCdn.Fonctionnalite.DEFAUT, ReportingUtils.ReportType.XLSX);
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
            Logger.getLogger(EtatGRHServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(EtatGRHServlet.class.getName()).log(Level.SEVERE, null, ex);
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

}
