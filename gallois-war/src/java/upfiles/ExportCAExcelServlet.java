package upfiles;

import mg.spat.EtatGrandCAExcel;
import utilitaire.Utilitaire;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/export/excel/ca")
public class ExportCAExcelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Méthode centrale de traitement de la requête.
     * Délègue la logique métier à EtatGrandCAExcel.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"CA_Export_du_" + 
                          request.getParameter("datedebut") + "_au_" + request.getParameter("datefin") + ".xlsx\"");
        response.setCharacterEncoding("UTF-8");

        String datedebut = request.getParameter("datedebut");
        String datefin = request.getParameter("datefin");

        if (datedebut == null || datedebut.trim().isEmpty()) {
            datedebut = Utilitaire.dateDuJour();
        }
        if (datefin == null || datefin.trim().isEmpty()) {
            datefin = Utilitaire.dateDuJour();
        }

        try {
            
            EtatGrandCAExcel exporter = new EtatGrandCAExcel(datedebut, datefin);
            exporter.export(response.getOutputStream());
            
        } catch (Exception e) {
            getServletContext().log("Erreur lors de l'export Excel CA", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                             "Erreur lors de la génération du fichier Excel : " + e.getMessage());
        }
    }
}