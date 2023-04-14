/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import bean.CGenUtil;
import ded.OrdonnerPayement;
import facture.PaiementFacture;
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
import mg.spat.JournalCaisseLibComplet;
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


@WebServlet(name = "OrdonnerPayementExcel", urlPatterns = {"/OrdonnerPayementExcel"})
public class OrdonnerPayementExcel extends HttpServlet {
     protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("OrdonnerPayementExcel")) {
                OrdonnerPayementExcel(request, response);

            } 
            if (action.equalsIgnoreCase("journalCaisseExel")) {
                journalCaisseExel(request, response);

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
            Logger.getLogger(OrdonnerPayementExcel.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(OrdonnerPayementExcel.class.getName()).log(Level.SEVERE, null, ex);
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
    
    
    public void journalCaisseExel(HttpServletRequest request, HttpServletResponse response) throws IOException{
        String tab= request.getParameter("tab");
        String id= request.getParameter("id");
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
            int headerTaille=1;
            int index= -1;
            JournalCaisseLibComplet jc = (JournalCaisseLibComplet) new JournalCaisseLibComplet().getById(id, "JOURNALCAISSELIBCOMPLET", null);
            Row rowTitre = sheet.createRow(0);
            Cell cellTitre1 = rowTitre.createCell(1);
            cellTitre1.setCellValue("Journal Caisse");
                
            Row rowIDFiche = sheet.createRow(++headerTaille);
             Cell cellFicheIdLib = rowIDFiche.createCell(0);
                    cellFicheIdLib.setCellValue("ID");
                    cellFicheIdLib.setCellStyle(nombrestyle);
             Cell cellFicheId = rowIDFiche.createCell(1);
                    cellFicheId.setCellValue(jc.getId());
                    cellFicheId.setCellStyle(nombrestyle);
                    
            Row rowFicheDateSaisie = sheet.createRow(++headerTaille);
             Cell cellFicheDateSaisieLib = rowFicheDateSaisie.createCell(0);
                    cellFicheDateSaisieLib.setCellValue("Date De Saisie");
                    cellFicheDateSaisieLib.setCellStyle(nombrestyle);
             Cell cellChicheDateSaisie = rowFicheDateSaisie.createCell(1);
                    cellChicheDateSaisie.setCellValue(Utilitaire.datetostring(jc.getDateSaisie()));
                    cellChicheDateSaisie.setCellStyle(nombrestyle);
                    
            Row rowFicheDateEffet = sheet.createRow(++headerTaille);
             Cell cellFicheDateEffetLib = rowFicheDateEffet.createCell(0);
                    cellFicheDateEffetLib.setCellValue("Date D'effet");
                    cellFicheDateEffetLib.setCellStyle(nombrestyle);
             Cell cellFicheDateEffet = rowFicheDateEffet.createCell(1);
                    cellFicheDateEffet.setCellValue(Utilitaire.datetostring(jc.getDateEffet()));
                    cellFicheDateEffet.setCellStyle(nombrestyle);
                    
            Row rowFicheTiers = sheet.createRow(++headerTaille);
             Cell cellFicheTierLib = rowFicheTiers.createCell(0);
                    cellFicheTierLib.setCellValue("Tiers");
                    cellFicheTierLib.setCellStyle(nombrestyle);
             Cell cellFicheTiers = rowFicheTiers.createCell(1);
                    cellFicheTiers.setCellValue(jc.getTierslib());
                    cellFicheTiers.setCellStyle(nombrestyle);
                    
            Row rowFicheNumCheque = sheet.createRow(++headerTaille);
             Cell cellFicheNumChequeLib = rowFicheNumCheque.createCell(0);
                    cellFicheNumChequeLib.setCellValue("Numcheque");
                    cellFicheNumChequeLib.setCellStyle(nombrestyle);
             Cell cellFicheNumCheque = rowFicheNumCheque.createCell(1);
                    cellFicheNumCheque.setCellValue(jc.getNumcheque());
                    cellFicheNumCheque.setCellStyle(nombrestyle);
                    
            headerTaille++;

                    
            if(tab.equals("ventilation-ff")){
                PaiementFacture cht = new PaiementFacture();
                cht.setNomTable("paiementfactureF");
                cht.setIdMvt(id);
                PaiementFacture[] liste = (PaiementFacture[])CGenUtil.rechercher(cht, null, null, "");
                Row row5 = sheet.createRow(++headerTaille);
                Cell cellt = row5.createCell(1);
                cellt.setCellValue("Ventilation FC");
                String[] headers = {"Id", "Facture","Code", "Montant"};
                headerTaille++;
                Row row = sheet.createRow(++headerTaille);
                for(int i=0; i<headers.length; i++){
                    Cell cell = row.createCell(i);
                    cell.setCellValue(headers[i]);
                    sheet.setColumnWidth(i, 30* 256);
                    
                }
                headerTaille++;
                CellStyle cellStyle = wb.createCellStyle();
                CreationHelper createHelper = wb.getCreationHelper();
                cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd/mm/yyyy"));
                for(int i=0; i<liste.length; i++){
                    int cmp = -1;
                    row = sheet.createRow(i+headerTaille);
                    Cell cellId = row.createCell(++cmp);
                        cellId.setCellValue(liste[i].getId());
                        cellId.setCellStyle(nombrestyle);
                    Cell cellFacture = row.createCell(++cmp);
                        cellFacture.setCellValue(liste[i].getIdFact());
                        cellFacture.setCellStyle(nombrestyle);
                    Cell cellCode = row.createCell(++cmp);
                        cellCode.setCellValue(liste[i].getCode());
                        cellCode.setCellStyle(nombrestyle);
                    Cell cellMontant = row.createCell(++cmp);
                        cellMontant.setCellValue(liste[i].getMontant());
                        cellMontant.setCellStyle(nombrestyle);
                    }
            }
            else if(tab.equals("ordonnerpaiement")){
                JournalCaisseLibComplet cht = new JournalCaisseLibComplet();
                cht.setNomTable("OPPaiementJCUnion");
                cht.setId(id);
                JournalCaisseLibComplet[] liste = (JournalCaisseLibComplet[])CGenUtil.rechercher(cht, null, null, "");
                Row row5 = sheet.createRow(++headerTaille);
                Cell cellt = row5.createCell(1);
                cellt.setCellValue("Ordonner paiement");
                String[] headers = {"ID", "Numero OP", "Date saisie", "Date effet", "Tiers", "Montant"};
                 headerTaille++;
                Row row = sheet.createRow(++headerTaille);
                for(int i=0; i<headers.length; i++){
                    Cell cell = row.createCell(i);
                    cell.setCellValue(headers[i]);
                    sheet.setColumnWidth(i, 30* 256);
                    
                }
                headerTaille++;
                //String libEntete[] = {"idordre", "numeroop", "dateSaisie", "dateEffet", "tierslib", "debit"};
                CellStyle cellStyle = wb.createCellStyle();
                CreationHelper createHelper = wb.getCreationHelper();
                cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd/mm/yyyy"));
                for(int i=0; i<liste.length; i++){
                    int cmp = -1;
                    row = sheet.createRow(i+headerTaille);
                    Cell cellIdOrdre = row.createCell(++cmp);
                        cellIdOrdre.setCellValue(liste[i].getIdordre());
                        cellIdOrdre.setCellStyle(nombrestyle);
                    Cell cellNumeroOp = row.createCell(++cmp);
                        cellNumeroOp.setCellValue(liste[i].getNumeroOP());
                        cellNumeroOp.setCellStyle(nombrestyle);
                    Cell cellDateSaisie = row.createCell(++cmp);
                        cellDateSaisie.setCellValue(Utilitaire.datetostring(liste[i].getDateSaisie()));
                        cellDateSaisie.setCellStyle(nombrestyle);
                    Cell cellDateEffet = row.createCell(++cmp);
                        cellDateEffet.setCellValue(Utilitaire.datetostring(liste[i].getDateEffet()));
                        cellDateEffet.setCellStyle(nombrestyle);
                    Cell cellTiersLib = row.createCell(++cmp);
                        cellTiersLib.setCellValue(liste[i].getTiersLib());
                        cellTiersLib.setCellStyle(nombrestyle);
                    Cell cellDebit = row.createCell(++cmp);
                        cellDebit.setCellValue(liste[i].getDebit());
                        cellDebit.setCellStyle(nombrestyle);
                    }
            }
            
            else if(tab.equals("ventilation-fc")){
                PaiementFacture cht = new PaiementFacture();
                cht.setNomTable("paiementfacturelib");
                cht.setIdMvt(id);
                PaiementFacture[] liste = (PaiementFacture[])CGenUtil.rechercher(cht, null, null, "");
                Row row5 = sheet.createRow(++headerTaille);
                Cell cellt = row5.createCell(1);
                cellt.setCellValue("Ventilation FC");
                String[] headers = {"Id", "Facture","Code", "Montant"};
                 headerTaille++;
                Row row = sheet.createRow(++headerTaille);
                for(int i=0; i<headers.length; i++){
                    Cell cell = row.createCell(i);
                    cell.setCellValue(headers[i]);
                    sheet.setColumnWidth(i, 30* 256);
                    
                }
                headerTaille++;
                
                CellStyle cellStyle = wb.createCellStyle();
                CreationHelper createHelper = wb.getCreationHelper();
                cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd/mm/yyyy"));
                for(int i=0; i<liste.length; i++){
                    int cmp = -1;
                    row = sheet.createRow(i+headerTaille);
                    Cell cellId = row.createCell(++cmp);
                        cellId.setCellValue(liste[i].getId());
                        cellId.setCellStyle(nombrestyle);
                    Cell cellFacture = row.createCell(++cmp);
                        cellFacture.setCellValue(liste[i].getIdFact());
                        cellFacture.setCellStyle(nombrestyle);
                    Cell cellCode = row.createCell(++cmp);
                        cellCode.setCellValue(liste[i].getCode());
                        cellCode.setCellStyle(nombrestyle);
                    Cell cellMontant = row.createCell(++cmp);
                        cellMontant.setCellValue(liste[i].getMontant());
                        cellMontant.setCellStyle(nombrestyle);
                    }
            }
            
            
             response.setContentType("application/ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename="+tab+"-"+id+".xls");
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
    

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
     public void OrdonnerPayementExcel(HttpServletRequest request, HttpServletResponse response) throws IOException {    
       
       String id = request.getParameter("id");
       String ded_Id = request.getParameter("ded_Id");
       String tiers = request.getParameter("tiers");
       String numeroop = request.getParameter("numeroop");
       String modepaiementlib = request.getParameter("modepaiementlib");
       String daty1 = request.getParameter("daty1");
       String daty2 = request.getParameter("daty2");
       String etat = request.getParameter("etat");
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
                
                
        OrdonnerPayement tr = new OrdonnerPayement();
        tr.setNomTable("ORDONNERPAYEMENT_LIBETAT");
        String awhere="";
        if(id != null && !id.trim().isEmpty() && id.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND id='"+id+"'";
        }
        
        if(ded_Id != null && !ded_Id.trim().isEmpty() && ded_Id.compareToIgnoreCase("null") != 0 )
        {
            awhere+=" AND ded_Id='"+ded_Id+"'";
        }
        if(tiers != null && !tiers.trim().isEmpty() && tiers.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND tiers='"+tiers+"'";
        }
        if(numeroop != null && !numeroop.trim().isEmpty() && numeroop.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND numeroop='"+numeroop+"'";
        }
         if(modepaiementlib != null && !modepaiementlib.trim().isEmpty() && modepaiementlib.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND modepaiementlib='"+modepaiementlib+"'";
        }
        if(daty1 != null && !daty1.trim().isEmpty() && daty1.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND daty >= '"+daty1+"'";
        }
        if(daty2 != null && !daty2.trim().isEmpty() && daty2.compareToIgnoreCase("null") != 0)
        {
            awhere+=" AND daty <= '"+daty2+"'";
        }
         if(etat != null && !etat.trim().isEmpty() && etat.compareToIgnoreCase("null") != 0)
        {
            tr.setNomTable(etat);
        }
      
        OrdonnerPayement[] ordonnerpayement = (OrdonnerPayement[])CGenUtil.rechercher(tr, null, null, awhere);
         
             Row row5 = sheet.createRow(0);
              Cell cellt = row5.createCell(1);
              cellt.setCellValue("Liste OP");
            String[] headers = {"id", "Etat", "Numero OP", "Numero compta", "Date", "Tiers", "Montant", "Motif de paiement", "Mode de paiement","Facture"};
            Row row = sheet.createRow(2);
            for(int i=0; i<headers.length; i++){
                Cell cell = row.createCell(i);
                cell.setCellValue(headers[i]);
            }
            
            CellStyle cellStyle = wb.createCellStyle();
            CreationHelper createHelper = wb.getCreationHelper();
            cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd/mm/yyyy"));
            int cmp = 0;
            for(int i=0; i<ordonnerpayement.length; i++){
                row = sheet.createRow(i+3);
                Cell cell0 = row.createCell(0);
                cell0.setCellValue(ordonnerpayement[i].getId());
                 cell0.setCellStyle(nombrestyle);
                Cell celletatlib = row.createCell(1);
                    celletatlib.setCellValue(ordonnerpayement[i].getEtatlib());
                    celletatlib.setCellStyle(nombrestyle);
                Cell cellNumeroop = row.createCell(2);
                    cellNumeroop.setCellValue(ordonnerpayement[i].getNumeroop());
                    cellNumeroop.setCellStyle(nombrestyle);
                Cell cellNumeroCompta = row.createCell(3);
                    cellNumeroCompta.setCellValue(ordonnerpayement[i].getNumeroCompta());
                    cellNumeroCompta.setCellStyle(nombrestyle);
                Cell cellDaty = row.createCell(4);
                    cellDaty.setCellValue(Utilitaire.formatterDaty(ordonnerpayement[i].getDaty()));
                    cellDaty.setCellStyle(nombrestyle);
                Cell celltiers = row.createCell(5);
                    celltiers.setCellValue(ordonnerpayement[i].getTiers());
                    celltiers.setCellStyle(nombrestyle);
                Cell cellMontant = row.createCell(6);
                    cellMontant.setCellValue(ordonnerpayement[i].getMontant());
                    cellMontant.setCellStyle(nombrestyle);
                Cell cellRemarque = row.createCell(7);
                    cellRemarque.setCellValue(ordonnerpayement[i].getRemarque());
                    cellRemarque.setCellStyle(nombrestyle);
                Cell Modepaiementlib = row.createCell(8);
                    Modepaiementlib.setCellValue(ordonnerpayement[i].getModepaiementlib());
                    Modepaiementlib.setCellStyle(nombrestyle);
                Cell cellded_Id = row.createCell(9);
                    cellded_Id.setCellValue(ordonnerpayement[i].getDed_Id());
                    cellded_Id.setCellStyle(nombrestyle);
                 Cell celldaty1 = row.createCell(11);
                System.out.println("===="+ordonnerpayement[i].getDaty());
                }
            
            response.setContentType("application/ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=listeOP.xls");
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
