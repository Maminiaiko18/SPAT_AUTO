/**
 * 25 ao�t 2015
 *
 * @author Manda
 */

package reporting;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRPrintPage;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.oasis.JROdtExporter;
import net.sf.jasperreports.engine.export.ooxml.JRDocxExporter;
import net.sf.jasperreports.engine.export.ooxml.JRPptxExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.Exporter;
import net.sf.jasperreports.export.ReportExportConfiguration;
import net.sf.jasperreports.export.SimpleDocxReportConfiguration;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOdtReportConfiguration;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfReportConfiguration;
import net.sf.jasperreports.export.SimplePptxReportConfiguration;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;

    public class ReportingUtils {

    public ReportingUtils() {
    }

    private JasperPrint jasperPrint = null;

    public void PDF(String reportPath, List dataSource, Map param, OutputStream out) throws JRException, IOException {
        jasperPrint = fillReport(reportPath, dataSource, param);
        exportReport(jasperPrint, ReportType.PDF, out);
    }

    public void DOCX(String reportPath, List dataSource, Map param, OutputStream out) throws JRException, IOException {
        jasperPrint = fillReport(reportPath, dataSource, param);
        exportReport(jasperPrint, ReportType.DOCX, out);
    }

    public void XLSX(String reportPath, List dataSource, Map param, OutputStream out) throws JRException, IOException {
        jasperPrint = fillReport(reportPath, dataSource, param);
        exportReport(jasperPrint, ReportType.XLSX, out); 
        //exportReport(jasperPrint, ReportType.XLSX, out);
    }

    public void ODT(String reportPath, List dataSource, Map param, OutputStream out) throws JRException, IOException {
        jasperPrint = fillReport(reportPath, dataSource, param);
        exportReport(jasperPrint, ReportType.ODT, out);
    }

    public void PPT(String reportPath, List dataSource, Map param, OutputStream out) throws JRException, IOException {
        jasperPrint = fillReport(reportPath, dataSource, param);
        exportReport(jasperPrint, ReportType.PPT, out);
    }

    public void export(String reportPath, List dataSource, Map param, OutputStream out, ReportType reportType) throws JRException {
        jasperPrint = fillReport(reportPath, dataSource, param);
        exportReport(jasperPrint, reportType, out);
    }
    
    public void export(String reportPath, List dataSource, Map param, OutputStream out, int pageIndex) throws JRException {
        jasperPrint = fillReport(reportPath, dataSource, param);
        exportReportSpecPageStart(jasperPrint, out, pageIndex);
    }

    public JasperPrint fillReport(String reportPath, List dataSource, Map param) throws JRException {
        if (dataSource == null || dataSource.isEmpty()) {
            return JasperFillManager.fillReport(reportPath, param, new JREmptyDataSource());
        } else {
            JRBeanCollectionDataSource beanCollectionDataSource = new JRBeanCollectionDataSource(dataSource);
            return JasperFillManager.fillReport(reportPath, param, beanCollectionDataSource);
        }
    }

    
    public void exportReport(JasperPrint jasperPrint, ReportType reporType, OutputStream out) throws JRException {
        try{ 
            Exporter jRExporter = null;
            switch (reporType) {
                case PDF:
                    jRExporter = new JRPdfExporter();
                    ReportExportConfiguration configuration = new SimplePdfReportConfiguration();
                    jRExporter.setConfiguration(configuration);
                    break;

                case DOCX:
                    jRExporter = new JRDocxExporter();
                    SimpleDocxReportConfiguration configurationDocx = new SimpleDocxReportConfiguration();
                    break;

                case XLSX:
                    jRExporter = new JRXlsxExporter();
                    SimpleXlsxReportConfiguration configurationXLS = new SimpleXlsxReportConfiguration();
                    configurationXLS.setDetectCellType(true);//Set configuration as you like it!!
                    configurationXLS.setCollapseRowSpan(false);
                    jRExporter.setConfiguration(configurationXLS);
                    break;

                case PPT:
                    jRExporter = new JRPptxExporter();
                    SimplePptxReportConfiguration configurationPpt = new SimplePptxReportConfiguration();
                    break;

                case ODT:
                    jRExporter = new JROdtExporter();
                    SimpleOdtReportConfiguration configurationOdt = new SimpleOdtReportConfiguration();
                    break;

            }
            jRExporter.setExporterInput(new SimpleExporterInput(jasperPrint));
            jRExporter.setExporterOutput(new SimpleOutputStreamExporterOutput(out));
            jRExporter.exportReport();
        }
        catch(JRException jreException){
            jreException.printStackTrace();
            throw jreException;
        }
        catch(Exception e){
            e.printStackTrace();
            throw e;
        }
        
    }
    
    public void exportReportSpecPageStart(JasperPrint jasperPrint, OutputStream out, int pageStart) throws JRException {    	
    	try {
    		Exporter jRExporter = new JRPdfExporter();
    		SimplePdfReportConfiguration configuration = new SimplePdfReportConfiguration();
            configuration.setStartPageIndex(pageStart);
            jRExporter.setConfiguration(configuration);   
            jRExporter.setExporterInput(new SimpleExporterInput(jasperPrint));
            jRExporter.setExporterOutput(new SimpleOutputStreamExporterOutput(out));
            jRExporter.exportReport();
    	} catch(JRException jreException){
            jreException.printStackTrace();
            throw jreException;
        }
        catch(Exception e){
            e.printStackTrace();
            throw e;
        }
    }

    public enum ReportType {
        PDF, DOCX, XLSX, ODT, PPT, XLS
    }

    private String setName(ReportType reportType) {

        return null;

    }
}
