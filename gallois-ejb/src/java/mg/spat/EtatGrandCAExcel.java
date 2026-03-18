package mg.spat;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import utilitaire.Utilitaire;

import java.io.OutputStream;
import java.util.Map;

public class EtatGrandCAExcel {
    private String datedebut;
    private String datefin;

    private CellStyle headerStyle;
    private CellStyle subHeaderStyle;
    private CellStyle categoryStyle;
    private CellStyle totalStyle;
    private CellStyle generalStyle;
    private CellStyle rightAlignStyle;
    private CellStyle percentStyle;

    public EtatGrandCAExcel(String datedebut, String datefin) {
        this.datedebut = datedebut;
        this.datefin = datefin;
    }

    public void export(OutputStream out) throws Exception {
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Chiffre d'Affaires");
            
            initStyles(workbook);
            
            generateContent(sheet, workbook);
            
            autoSizeColumns(sheet);
            
            workbook.write(out);
            out.flush();
        }
    }

    private void initStyles(Workbook wb) {
        headerStyle = createHeaderStyle(wb);
        subHeaderStyle = createSubHeaderStyle(wb);
        categoryStyle = createCategoryStyle(wb);
        totalStyle = createTotalStyle(wb);
        generalStyle = createGeneralStyle(wb);
        rightAlignStyle = createRightAlignStyle(wb);
        percentStyle = createPercentStyle(wb);
    }

    private void generateContent(Sheet sheet, Workbook wb) throws Exception {
        int rowNum = 0;

        Row titleRow = sheet.createRow(rowNum++);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("CHIFFRE D'AFFAIRES SUR LES FACTURES EMISES DU " + 
                              datedebut + " AU " + datefin);
        titleCell.setCellStyle(generalStyle);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));

        rowNum = createHeaders(sheet, rowNum);

        EtatGrandCA etatGrandCA = new EtatGrandCA(datedebut, datefin, false);
        Map<String, EtatCA> listeCA = etatGrandCA.getListeCA();
        CA totalGeneralGrandRubrique = etatGrandCA.getTotalgeneralgrandrubrique();

        for (Map.Entry<String, EtatCA> entry : listeCA.entrySet()) {
            rowNum = generateCategorie(sheet, rowNum, entry.getKey(), entry.getValue());
        }

        rowNum = generateGrandTotal(sheet, rowNum, totalGeneralGrandRubrique, etatGrandCA);
    }

    private int createHeaders(Sheet sheet, int rowNum) {
        Row headerRow1 = sheet.createRow(rowNum++);
        headerRow1.createCell(0).setCellValue("Libelle");
        headerRow1.getCell(0).setCellStyle(headerStyle);

        headerRow1.createCell(1).setCellValue("Mouvement du mois en cours");
        headerRow1.getCell(1).setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum - 1, rowNum - 1, 1, 5));

        headerRow1.createCell(6).setCellValue("N. Cumule");
        headerRow1.getCell(6).setCellStyle(headerStyle);
        headerRow1.createCell(7).setCellValue("Taux");
        headerRow1.getCell(7).setCellStyle(headerStyle);

        Row headerRow2 = sheet.createRow(rowNum++);
        String[] subHeaders = {"Avoir Int", "Avoir Ext", "Comptant", "Credit", "Total"};
        for (int i = 0; i < subHeaders.length; i++) {
            Cell cell = headerRow2.createCell(i + 1);
            cell.setCellValue(subHeaders[i]);
            cell.setCellStyle(subHeaderStyle);
        }
        return rowNum;
    }

    private int generateCategorie(Sheet sheet, int rowNum, String cle, EtatCA etatCA) {
        Map<String, CA[]> listeParRubrique = etatCA.getListeParRubrique();
        Map<String, CA> sommePartiel = etatCA.getSommePartiel();

        Row catRow = sheet.createRow(rowNum++);
        Cell catCell = catRow.createCell(0);
        catCell.setCellValue(cle != null ? cle.toUpperCase() : "");
        catCell.setCellStyle(categoryStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum - 1, rowNum - 1, 0, 7));

        if (listeParRubrique != null) {
            for (String rubrique : listeParRubrique.keySet()) {
                rowNum = generateRubrique(sheet, rowNum, rubrique, 
                                         listeParRubrique.get(rubrique), 
                                         sommePartiel.get(rubrique));
            }
        }

        CA totalGeneral = etatCA.getTotalGeneral();
        if (totalGeneral != null) {
            rowNum = generateLigneTotal(sheet, rowNum, 
                                       Utilitaire.champNull(totalGeneral.getLibelle().toUpperCase()),
                                       totalGeneral, generalStyle);
        }
        return rowNum;
    }

    private int generateRubrique(Sheet sheet, int rowNum, String rubrique, CA[] listeCA, CA partiel) {

        Row rubRow = sheet.createRow(rowNum++);
        Cell rubCell = rubRow.createCell(0);
        rubCell.setCellValue(rubrique != null ? rubrique.toUpperCase() : "");
        rubCell.setCellStyle(categoryStyle);

        if (listeCA != null) {
            for (CA ca : listeCA) {
                rowNum = generateLigneDetail(sheet, rowNum, ca);
            }
        }

        if (partiel != null) {
            rowNum = generateLigneTotal(sheet, rowNum, "TOTAL " + rubrique.toUpperCase(), partiel, totalStyle);
        }
        return rowNum;
    }

    private int generateLigneDetail(Sheet sheet, int rowNum, CA ca) {
        Row row = sheet.createRow(rowNum++);
        int col = 0;

        row.createCell(col++).setCellValue(Utilitaire.champNull(ca.getLibelle()));
        setNumericCell(row, col++, ca.getAvoirEETPINT(), rightAlignStyle);
        setNumericCell(row, col++, ca.getAvoirEETPEXT(), rightAlignStyle);
        setNumericCell(row, col++, ca.getComptant(), rightAlignStyle);
        setNumericCell(row, col++, ca.getCredit(), rightAlignStyle);
        setNumericCell(row, col++, ca.getTotal(), rightAlignStyle);
        setNumericCell(row, col++, ca.getNCumul(), rightAlignStyle);
        
        // Taux avec format pourcentage
        Cell tauxCell = row.createCell(col++);
        tauxCell.setCellValue(ca.getTaux());
        tauxCell.setCellStyle(percentStyle);

        return rowNum;
    }

    private int generateLigneTotal(Sheet sheet, int rowNum, String libelle, CA ca, CellStyle style) {
        Row row = sheet.createRow(rowNum++);
        int col = 0;

        row.createCell(col++).setCellValue(libelle);
        setNumericCell(row, col++, ca.getAvoirEETPINT(), style);
        setNumericCell(row, col++, ca.getAvoirEETPEXT(), style);
        setNumericCell(row, col++, ca.getComptant(), style);
        setNumericCell(row, col++, ca.getCredit(), style);
        setNumericCell(row, col++, ca.getTotal(), style);
        setNumericCell(row, col++, ca.getNCumul(), style);
        
        Cell tauxCell = row.createCell(col++);
        tauxCell.setCellValue(ca.getTaux());
        tauxCell.setCellStyle(percentStyle);

        return rowNum;
    }

    private int generateGrandTotal(Sheet sheet, int rowNum, CA totalGeneral, EtatGrandCA etatGrandCA) {
        rowNum = generateLigneTotal(sheet, rowNum, "TOTAL GENERAL", totalGeneral, generalStyle);

        Row nbRow = sheet.createRow(rowNum++);
        nbRow.createCell(0).setCellValue("Nombre de factures");
        nbRow.createCell(1).setCellValue(totalGeneral.getNbComptant());
        nbRow.createCell(2).setCellValue(totalGeneral.getNbCredit());
        nbRow.createCell(3).setCellValue(totalGeneral.getNbFactureTotal());
        nbRow.getCell(1).setCellStyle(rightAlignStyle);
        nbRow.getCell(2).setCellStyle(rightAlignStyle);
        nbRow.getCell(3).setCellStyle(rightAlignStyle);

        Row tauxRow = sheet.createRow(rowNum++);
        tauxRow.createCell(0).setCellValue("TAUX");
        tauxRow.createCell(1).setCellValue(etatGrandCA.getPourcAvoir());
        tauxRow.createCell(2).setCellValue(etatGrandCA.getPourComptant());
        tauxRow.createCell(3).setCellValue(etatGrandCA.getPourcCredit());
        tauxRow.getCell(1).setCellStyle(percentStyle);
        tauxRow.getCell(2).setCellStyle(percentStyle);
        tauxRow.getCell(3).setCellStyle(percentStyle);

        return rowNum;
    }

    
    private void setNumericCell(Row row, int col, Double value, CellStyle style) {
        Cell cell = row.createCell(col);
        if (value != null) {
            cell.setCellValue(value);
            cell.setCellStyle(style);
        }
    }

    private void autoSizeColumns(Sheet sheet) {
        for (int i = 0; i < 8; i++) {
            sheet.autoSizeColumn(i);
        }
    }

    
    private CellStyle createHeaderStyle(Workbook wb) {
        CellStyle style = wb.createCellStyle();
        Font font = wb.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 11);
        style.setFont(font);
    style.setAlignment(CellStyle.ALIGN_CENTER);
    style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        setBorders(style);
    style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
    style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setWrapText(true);
        return style;
    }

    private CellStyle createSubHeaderStyle(Workbook wb) {
        CellStyle style = wb.createCellStyle();
        Font font = wb.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 10);
        style.setFont(font);
    style.setAlignment(CellStyle.ALIGN_CENTER);
    style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        setBorders(style);
    style.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex());
    style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        return style;
    }

    private CellStyle createCategoryStyle(Workbook wb) {
        CellStyle style = wb.createCellStyle();
        Font font = wb.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 11);
        style.setFont(font);
    style.setAlignment(CellStyle.ALIGN_LEFT);
    style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
    style.setBorderTop(CellStyle.BORDER_DOUBLE);
    style.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
    style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        return style;
    }

    private CellStyle createTotalStyle(Workbook wb) {
        CellStyle style = wb.createCellStyle();
        Font font = wb.createFont();
        font.setBold(true);
        style.setFont(font);
    style.setAlignment(CellStyle.ALIGN_CENTER);
    style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        setBorders(style);
    style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
    style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        return style;
    }

    private CellStyle createGeneralStyle(Workbook wb) {
        CellStyle style = wb.createCellStyle();
        Font font = wb.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 12);
        style.setFont(font);
    style.setAlignment(CellStyle.ALIGN_LEFT);
    style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
    style.setBorderTop(CellStyle.BORDER_DOUBLE);
    style.setBorderBottom(CellStyle.BORDER_DOUBLE);
    style.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
    style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        return style;
    }

    private CellStyle createRightAlignStyle(Workbook wb) {
        CellStyle style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_RIGHT);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        setBorders(style);
        DataFormat fmt = wb.createDataFormat();
        style.setDataFormat(fmt.getFormat("#,##0.00 \"Ar\""));
        return style;
    }

    private CellStyle createPercentStyle(Workbook wb) {
        CellStyle style = wb.createCellStyle();
        style.setAlignment(CellStyle.ALIGN_RIGHT);
        DataFormat fmt = wb.createDataFormat();
        style.setDataFormat(fmt.getFormat("0.000\"%\""));
        return style;
    }

    private void setBorders(CellStyle style) {
    style.setBorderBottom(CellStyle.BORDER_THIN);
    style.setBorderTop(CellStyle.BORDER_THIN);
    style.setBorderLeft(CellStyle.BORDER_THIN);
    style.setBorderRight(CellStyle.BORDER_THIN);
    }
}
