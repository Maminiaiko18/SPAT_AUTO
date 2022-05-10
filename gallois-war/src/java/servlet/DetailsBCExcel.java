/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import bean.CGenUtil;
import data.DetailsBcData;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;
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
import mg.spat.stock.BonDeCommandeFille;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;

/**
 *
 * @author Princie
 */
@WebServlet(name = "DetailsBCExcel", urlPatterns = {"/DetailsBCExcel"})
public class DetailsBCExcel extends HttpServlet {
     protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("detailsBcExcel")) {
                detailsBcExcel(request, response);

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
            Logger.getLogger(DetailsBCExcel.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(DetailsBCExcel.class.getName()).log(Level.SEVERE, null, ex);
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
    
     public void detailsBcExcel(HttpServletRequest request, HttpServletResponse response) throws IOException {    
        String id = request.getParameter("id");
        
        try {
            HSSFWorkbook wb = new HSSFWorkbook();
            Sheet sheet = wb.createSheet("new sheet");
            HSSFCellStyle style = wb.createCellStyle();
            style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            style.setBorderTop(HSSFCellStyle.BORDER_THIN);
            style.setBorderRight(HSSFCellStyle.BORDER_THIN);
            style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

            HSSFCellStyle nombrestyle = wb.createCellStyle();
            nombrestyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            nombrestyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
            nombrestyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
            nombrestyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            nombrestyle.setAlignment(CellStyle.ALIGN_RIGHT);
            nombrestyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
             
            
                //cell0.setCellValue(attestations[i].getIdmedicament());
                
                
    DetailsBcData data=new DetailsBcData(request.getParameter("id"));                                 
    data.setBCOrderByProduitAsc("AS_BONDECOMMANDE_LIBELLE_lib","BC_BL_LIVRE");
    BonDeCommandeFille[] liste = data.getBcFille();
    double total = data.getBc().getMontantTTC();
    double tva=data.getBc().getMontanttva();
    double remise=data.getBc().getMontantRemise();
             Row row5 = sheet.createRow(0);
              Cell cellt = row5.createCell(1);
                cellt.setCellValue("SPAT");
                
             Row row6 = sheet.createRow(1);
              Cell cellti = row6.createCell(1);   
                cellti.setCellValue("DEPARTEMENT  GESTION DES");
                
              Row row7 = sheet.createRow(2);
              Cell celltit = row7.createCell(1);  
                celltit.setCellValue("CONTRATS  ET FACTURATION");
                
            String[] headers = {"Produit", "Quantite Commandee", "Quantite Livre","Reste a Livrer","Unite","P.U","Montant","Montant Remise","TVA","Montant BL","Montant BL Reste"};
            
            Row row = sheet.createRow(5);
            for(int i=0; i<headers.length; i++){
                Cell cell = row.createCell(i);
                cell.setCellValue(headers[i]);
            }
            
            CellStyle cellStyle = wb.createCellStyle();
            CreationHelper createHelper = wb.getCreationHelper();
            cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd/mm/yyyy"));
            //int indice[] = {0, 1, 2, 3, 4, 5, 11, 17};
            //short[] width = {65, 63, 61, 61, 61, 59, 59, 53 };
            int cmp = 0;
            for (int i = 0; i < liste.length; i++) {
                double montant = liste[i].getQuantite() * liste[i].getPu();
                row = sheet.createRow(i+6);
                Cell cell0 = row.createCell(0);
                cell0.setCellValue(liste[i].getProduit());
                 cell0.setCellStyle(nombrestyle);
                //sheet.setColumnWidth(indice[cmp], width[cmp] * 100);
                //if(attestations[i].getIdmedicament()!= null)
                    Cell celling = row.createCell(1);
                celling.setCellValue(Utilitaire.formaterAr(liste[i].getQuantite()));
                celling.setCellStyle(nombrestyle);
                    Cell cellgetQuantitelivre = row.createCell(2);
                cellgetQuantitelivre.setCellValue(Utilitaire.formaterAr(liste[i].getQuantitelivre()));
                cellgetQuantitelivre.setCellStyle(nombrestyle);
                Cell cell1 = row.createCell(3);
                    cell1.setCellValue(Utilitaire.formaterAr(liste[i].getQuantitereste()));
                    cell1.setCellStyle(nombrestyle);
                Cell cellunit = row.createCell(4);
                    cellunit.setCellValue(liste[i].getUnite());
                    cellunit.setCellStyle(nombrestyle);
                Cell getPu = row.createCell(5);
                    getPu.setCellValue(Utilitaire.formaterAr(liste[i].getPu()));
                    getPu.setCellStyle(nombrestyle);
                Cell montant1 = row.createCell(6);
                    montant1.setCellValue(Utilitaire.formaterAr(montant));
                    montant1.setCellStyle(nombrestyle);
                Cell Montantremise = row.createCell(7);
                    Montantremise.setCellValue(Utilitaire.formaterAr(liste[i].getMontantremise()));
                    Montantremise.setCellStyle(nombrestyle);
                Cell Tva = row.createCell(8);
                    Tva.setCellValue(Utilitaire.formaterAr(liste[i].getTva()));
                    Tva.setCellStyle(nombrestyle);
                Cell Montantbl = row.createCell(9);
                    Montantbl.setCellValue(Utilitaire.formaterAr(liste[i].getMontantbl()));
                    Montantbl.setCellStyle(nombrestyle);
                Cell Montantblreste = row.createCell(10);
                    Montantblreste.setCellValue(Utilitaire.formaterAr(liste[i].getMontantblreste()));
                    Montantblreste.setCellStyle(nombrestyle);
                
                }
            int size = liste.length + 6;

            Row rowMontantHT = sheet.createRow(size);
            Cell cellrowMontantHT1  = rowMontantHT.createCell(5);
            cellrowMontantHT1.setCellValue("Montant HT");
             cellrowMontantHT1.setCellStyle(nombrestyle);
            Cell cellrowMontantHT  = rowMontantHT.createCell(6);
            cellrowMontantHT.setCellValue(Utilitaire.formaterAr(data.getBc().getMontant()));
            cellrowMontantHT.setCellStyle(nombrestyle);
            
            Row rowMontantTVA = sheet.createRow(size+ 1);
            Cell cellrowMontantTVA  = rowMontantTVA.createCell(5);
            cellrowMontantTVA.setCellStyle(nombrestyle);
            cellrowMontantTVA.setCellValue("Montant TVA");
            Cell cellrowMontantTVA1  = rowMontantTVA.createCell(6);
            cellrowMontantTVA1.setCellValue(Utilitaire.formaterAr(tva));
            cellrowMontantTVA1.setCellStyle(nombrestyle);
            
            Row rowMontantRemise = sheet.createRow(size + 2);
            Cell cellMontantRemise  = rowMontantRemise.createCell(5);
            cellMontantRemise.setCellStyle(nombrestyle);
            cellMontantRemise.setCellValue("Montant Remise");
            Cell cellMontantRemise1  = rowMontantRemise.createCell(6);
            cellMontantRemise1.setCellValue(Utilitaire.formaterAr(remise));
            cellMontantRemise1.setCellStyle(nombrestyle);
            
             Row rowMontantTTC = sheet.createRow(size + 3);
            Cell cellMontantTTC  = rowMontantTTC.createCell(5);
            cellMontantTTC.setCellValue("Montant TTC");
            cellMontantTTC.setCellStyle(nombrestyle);
            Cell cellMontantTTC1  = rowMontantTTC.createCell(6);
            cellMontantTTC1.setCellValue(Utilitaire.formaterAr(total));
            cellMontantTTC1.setCellStyle(nombrestyle);
            
           
            
            
                    
            
            
            response.setContentType("application/ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=Details_BC.xls");
            ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
            wb.write(outByteStream);
            byte[] outArray = outByteStream.toByteArray();
            OutputStream outStream = response.getOutputStream();
            outStream.write(outArray);
            outStream.flush();
        } catch (Exception e) {
            e.printStackTrace();
            PrintWriter out = response.getWriter();
            response.setContentType("text/html; charset=UTF-8");
            out.write("<script type=\"text/javascript\">alert('"+e.getMessage()+"'); history.back(); </script>");
            out.flush();
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
