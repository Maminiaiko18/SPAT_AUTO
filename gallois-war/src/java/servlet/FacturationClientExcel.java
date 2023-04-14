/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import bean.CGenUtil;
import ded.OrdonnerPayement;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import user.*;
import java.sql.Connection;
import java.util.List;
import bean.ValeurEtiquette;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;
import mg.spat.AnalyseDetails;
import facture.FactureClient;
import affichage.PageRechercheGroupe;

@WebServlet(name = "FactureClientExcel", urlPatterns = {"/FactureClientExcel"})
public class FacturationClientExcel extends HttpServlet {
     protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("FactureClientExcel")) {
                FactureClientExcel(request, response);
            }else if(action.equalsIgnoreCase("FactureAnalyseClientExcel")){
                FactureAnalyseClientExcel(request,response);
            }

        } catch (Exception ex) {
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
            Logger.getLogger(FacturationClientExcel.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(FacturationClientExcel.class.getName()).log(Level.SEVERE, null, ex);
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

    public static void setBordersToMergedCells(HSSFWorkbook workBook, Sheet sheet, List<CellRangeAddress> ls) {

        for (CellRangeAddress rangeAddress : ls) {
            RegionUtil.setBorderLeft(1, rangeAddress, sheet, workBook);
            RegionUtil.setBorderRight(1, rangeAddress, sheet, workBook);
            RegionUtil.setBorderTop(1, rangeAddress, sheet, workBook);
            RegionUtil.setBorderBottom(1, rangeAddress, sheet, workBook);

        }

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
    
     public void FactureClientExcel(HttpServletRequest request, HttpServletResponse response) throws IOException {    
       try {
           String lib=request.getParameter("lib");
           String mois=request.getParameter("mois");
           String annee=request.getParameter("annee");
           System.out.println("-----------------------------------------------");
           System.out.println("Lib : "+lib+" - mois:"+mois+" - annee:"+annee);
           System.out.println("-----------------------------------------------");
       } catch (Exception e) {
            e.printStackTrace();
            PrintWriter out = response.getWriter();
            response.setContentType("text/html; charset=UTF-8");
            out.write("<script type=\"text/javascript\">alert('"+e.getMessage()+"'); history.back(); </script>");
            out.flush();
       }
    }

    public void FactureAnalyseClientExcel(HttpServletRequest request, HttpServletResponse response)throws IOException{
        try {
            user.UserEJB user = (user.UserEJB) request.getSession().getValue("u");

            HSSFWorkbook wb = new HSSFWorkbook();
            Sheet sheet = wb.createSheet("new sheet");

            HSSFCellStyle style = wb.createCellStyle();
            HSSFCellStyle nombrestyle = wb.createCellStyle();
           
            UserEJB u = (user.UserEJB) request.getSession().getValue("u");
            FactureClient recap = new FactureClient();
            recap.setNomTable("FACTURE_CLIENT_UNIONV");
            FactureClient lv = new FactureClient();
            lv.setNomTable("FACTURE_CLIENT_UNIONV");
            String listeCrt[] = {"tierslib","daty"};
            String listeInt[] = {"daty"};
            
            
            String[] pourcentage = {};  
            String somDefaut[] = {"montantreste","montantttc","montantpaye"};
            String colDefaut[] = {"tierslib"};

            PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, 0);
            pr.setUtilisateur(u);
            pr.setLien((String) request.getSession().getValue("lien"));
            pr.creerObjetPagePourc();
            FactureClient[] fc = (FactureClient[])pr.getTableau().getData();
            Row row5 = sheet.createRow(0);
            Cell cellt = row5.createCell(1);
            cellt.setCellValue("Liste Facture Analyse Client");
            String[] headers = {"Tiers", "Montant Reste", "Montant TTC", "MontantPaye"};
            Row row = sheet.createRow(2);
            sheet.autoSizeColumn(50);
            for(int i=0; i<headers.length; i++){
                Cell cell = row.createCell(i);
                cell.setCellValue(headers[i]);
            }
            
            /* Integration donnée + SHEET */
            CellStyle cellStyle = wb.createCellStyle();
            CreationHelper createHelper = wb.getCreationHelper();
            cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd/mm/yyyy"));
            int cmp = 0;
            for(int i=0; i<fc.length; i++){
                row = sheet.createRow(i+3);
                Cell cell0 = row.createCell(0);
                    cell0.setCellValue(fc[i].getTierslib());
                    cell0.setCellStyle(nombrestyle);
                Cell celletatlib = row.createCell(1);
                    celletatlib.setCellValue(Utilitaire.formaterAr(fc[i].getMontantreste()));
                    celletatlib.setCellStyle(nombrestyle);
                Cell cellNumeroop = row.createCell(2);
                    cellNumeroop.setCellValue(Utilitaire.formaterAr(fc[i].getMontantttc()));
                    cellNumeroop.setCellStyle(nombrestyle);
                Cell cellNumeroCompta = row.createCell(3);
                    cellNumeroCompta.setCellValue(Utilitaire.formaterAr(fc[i].getMontantpaye()));
                    cellNumeroCompta.setCellStyle(nombrestyle);
                }
            
            /* finalisation */
            response.setContentType("application/ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=FactureAnalyseClient.xls");
            ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
            wb.write(outByteStream);
            byte[] outArray = outByteStream.toByteArray();
            OutputStream outStream = response.getOutputStream();
            outStream.write(outArray);
            outStream.flush();

        } catch (Exception e) {
            e.printStackTrace();
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
    
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
     

}
