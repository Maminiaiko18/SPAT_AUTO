/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.servlet.etat;

import bean.CGenUtil;
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
import mg.spat.stock.BonDeCommandeFille;
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

/**
 *
 * @author Princie
 */
@WebServlet(name = "AnalyseDetailBCsExcel", urlPatterns = {"/AnalyseDetailBCsExcel"})
public class AnalyseDetailBCsExcel extends HttpServlet {
     protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("AnalyseDetailBC")) {
                AnalyseDetailBC(request, response);

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
            Logger.getLogger(AnalyseDetailBCsExcel.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AnalyseDetailBCsExcel.class.getName()).log(Level.SEVERE, null, ex);
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
    
     public void AnalyseDetailBC(HttpServletRequest request, HttpServletResponse response) throws IOException { 
         
        String idbc = request.getParameter("idbc");
       String numbc = request.getParameter("numbc");
       String codelib = request.getParameter("codelib");
       String projetlib = request.getParameter("projetlib");
       String daty1 = request.getParameter("daty1");
       if(daty1.compareToIgnoreCase("null") ==0 ) daty1 = Utilitaire.dateDuJour();
       String daty2 = request.getParameter("daty2");
       if(daty2.compareToIgnoreCase("null") ==0 ) daty2 = Utilitaire.dateDuJour();

       String produit = request.getParameter("produit");
       String fournisseurlib = request.getParameter("fournisseurlib");
        
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
                
                
            BonDeCommandeFille tr = new BonDeCommandeFille();
            tr.setNomTable("AS_BC_ANALYSEFILLE_LIB");
        String awhere="";
        if(idbc != null && !idbc.trim().isEmpty() && idbc.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND idbc='"+idbc+"'";
        }
        
        if(numbc != null && !numbc.trim().isEmpty() && numbc.compareToIgnoreCase("null") != 0 )
        {
            awhere+=" AND numbc='"+numbc+"'";
        }
        if(projetlib != null && !projetlib.trim().isEmpty() && projetlib.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND projetlib='"+projetlib+"'";
        }
        if(codelib != null && !codelib.trim().isEmpty() && codelib.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND codelib='"+codelib+"'";
        }
        if(daty1 != null && !daty1.trim().isEmpty() && daty1.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND daty >= '"+daty1+"'";
        }
        if(daty2 != null && !daty2.trim().isEmpty() && daty2.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND daty <= '"+daty2+"'";
        }
        if(produit != null && !produit.trim().isEmpty() && produit.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND produit='"+produit+"'";
        }
         if(fournisseurlib != null && !fournisseurlib.trim().isEmpty() && fournisseurlib.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND fournisseurlib='"+fournisseurlib+"'";
        }
      
        BonDeCommandeFille[] attestations = (BonDeCommandeFille[])CGenUtil.rechercher(tr, null, null, awhere);
            //Connection c = null;
            //try{
               /*c = new UtilDB().GetConn();
                
                String awhere = " and etudiant like '%"+Utilitaire.champNull(etudiant)+"%' "
                        + " and promotion like '%"+Utilitaire.champNull(promotion)+"%' "
                        + " and mention like '%"+Utilitaire.champNull(mention)+"%' "
                        + " and optionetu like '%"+Utilitaire.champNull(optionetu)+"%' ";
                
                if(datesoutenance1 != null && !datesoutenance1.trim().isEmpty()){
                    awhere += String.format(" and datesoutenance >= '%s' ", datesoutenance1.trim());
                } 
                
                if(datesoutenance2 != null && !datesoutenance2.trim().isEmpty()){
                    awhere += String.format(" and datesoutenance <= '%s' ", datesoutenance2.trim());
                } 
                System.out.println("awhere = " + awhere);
                attestations = (Attestation[])CGenUtil.rechercher(new Attestation(), null, null, c, awhere);
            } finally{
                if(c != null) c.close();
            }*/
            
           
             Row row5 = sheet.createRow(0);
              Cell cellt = row5.createCell(1);
                cellt.setCellValue("SPAT");
                
             Row row6 = sheet.createRow(1);
              Cell cellti = row6.createCell(1);   
                cellti.setCellValue("DEPARTEMENT GESTION DES");
                
              Row row7 = sheet.createRow(2);
              Cell celltit = row7.createCell(1);  
                celltit.setCellValue("CONTRATS ET FACTURATIONS");
                
             /*Row row1 = sheet.createRow(3);
              Cell celltitre = row1.createCell(1);
                celltitre.setCellValue("date "+attestations[0].getDaty());
                
                Row row2 = sheet.createRow(4);
              Cell celldaty = row2.createCell(1);*/
                //celldaty.setCellValue("Demande de prix n°: "+id);
                
            String[] headers = {"IDBC","NUMBC", "date", "code", "projet", "produit", "quantite", "unite", "pu", "montant HT", "fournisseur"};
            Row row = sheet.createRow(12);
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
            for(int i=0; i<attestations.length; i++){
                row = sheet.createRow(i+13);
                Cell cell0 = row.createCell(0);
                cell0.setCellValue(attestations[i].getIdbc());
                 
                //sheet.setColumnWidth(indice[cmp], width[cmp] * 100);
                //if(attestations[i].getIdmedicament()!= null)
                    Cell celling = row.createCell(1);
                celling.setCellValue(attestations[i].getNumbc());
                
                  Cell cellDaty = row.createCell(2);
                cellDaty.setCellValue(Utilitaire.formatterDaty( attestations[i].getDaty()));
                
                
                Cell cell1 = row.createCell(3);
                    cell1.setCellValue(attestations[i].getCodelib());
                Cell cellProjet = row.createCell(4);
                    cellProjet.setCellValue(attestations[i].getProjetlib());
                Cell cellproduit = row.createCell(5);
                    cellproduit.setCellValue(attestations[i].getProduit());
                   
                Cell cellquantite = row.createCell(6);
                    cellquantite.setCellValue(attestations[i].getQuantite());
                Cell cellUnite = row.createCell(7);
                    cellUnite.setCellValue(attestations[i].getUnite());
                Cell cellPu = row.createCell(8);
                    cellPu.setCellValue(attestations[i].getPu());
                Cell cellmontantht = row.createCell(9);
                    cellmontantht.setCellValue(attestations[i].getMontantht());
                Cell cellfournisseurlib = row.createCell(10);
                    cellfournisseurlib.setCellValue(attestations[i].getFournisseurlib());
                
                    
                
                }
            
            response.setContentType("application/ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=Analyse_detailsBC.xls");
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


/**
 *
 * @author Nouta
 */
