/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package reporting;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperPrint;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class ReportingCdn {
    
    static java.util.Properties prop = configuration.CynthiaConf.load();
    static String chemin = prop.getProperty("cdnPDF");
    
    public enum Fonctionnalite {
        TRESORERIE, DN, PAIE, RECETTE, DEFAUT
    }
    public static String getExtension (ReportingUtils.ReportType reportType){
        switch(reportType){
            case PDF :
                return ".pdf";
            case XLSX :
                return ".xlsx";
            case XLS :
                    return ".xls";
        }
        return null;
    }
    public static String cheminFonct (Fonctionnalite fonctionnalite){
        java.util.Properties prop = configuration.CynthiaConf.load();
        switch(fonctionnalite){
            case TRESORERIE :
                return prop.getProperty("cdnTresorerie");
            case DN :
                return prop.getProperty("cdnDN");
            case PAIE :
                return prop.getProperty("cdnPaie");
            case RECETTE :
                return prop.getProperty("cdnRecette");
            case DEFAUT :
                return "/";
        }
        return null;
    }
    public static String cheminReport(Fonctionnalite fonctionnalite){
        return chemin + cheminFonct(fonctionnalite)+"/";
    }
    public static File getFile (String filename, Fonctionnalite fonctionnalite){
        File file = new File(cheminReport(fonctionnalite)+"/"+filename);
        return file;
    }
    private static void exportFileServeurXLS (JasperPrint print, Fonctionnalite fonctionnalite, String fileName) throws FileNotFoundException, JRException{
        String fonct=cheminFonct(fonctionnalite);
        OutputStream output = new FileOutputStream(new File(chemin+fonct+"/"+fileName+".xlsx")); 
        ReportingUtils reporting = new ReportingUtils();
        reporting.exportReport(print, ReportingUtils.ReportType.XLSX, output); 
    }
    private static void exportFileServeurPDF (JasperPrint print, Fonctionnalite fonctionnalite, String fileName) throws FileNotFoundException, JRException{
        String fonct=cheminFonct(fonctionnalite);
        OutputStream output = new FileOutputStream(new File(chemin+fonct+"/"+fileName+".pdf")); 
        JasperExportManager.exportReportToPdfStream(print, output); 
    }
    public static void exportFile(JasperPrint print, Fonctionnalite fonctionnalite, String fileName, ReportingUtils.ReportType typeFile) throws FileNotFoundException, JRException{
        switch(typeFile){
            case XLSX :
                exportFileServeurXLS(print, fonctionnalite, fileName);
            case PDF :
                exportFileServeurPDF(print, fonctionnalite, fileName);
        }
    }
    public static void exportFile(JasperPrint print, Fonctionnalite fonctionnalite, String fileName) throws FileNotFoundException, JRException{
        exportFile(print, fonctionnalite, fileName, ReportingUtils.ReportType.PDF);
    }
    public static void exportFileXLS(JasperPrint print, Fonctionnalite fonctionnalite, String fileName) throws FileNotFoundException, JRException{
        exportFile(print, fonctionnalite, fileName, ReportingUtils.ReportType.XLSX);
    }
    public static boolean checkExistingFile (Fonctionnalite fonctionnalite, String fileName) throws FileNotFoundException{
        File file = getFile(fileName, fonctionnalite);
        if(file.exists()) return true;  
        return false;
    }
    public static void deleteFiles(File path, String id) throws Exception{
        if(path.exists()){
            path.delete();
            UtilitaireServeurPDF.deleteFromServeur(id);
        }
    }
}
