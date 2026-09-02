package mg.port.api.service;

import mg.port.api.model.ExcelFactureClientImportResult;
import mg.port.api.model.FactureClientDTO;
import mg.port.api.model.FactureClientImportConfig;
import mg.port.api.model.FactureClientLigneDTO;
import mg.port.api.model.FactureClientRequest;

import org.apache.poi.ss.usermodel.*;

import java.io.File;
import java.io.FileInputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ExcelFactureClientReader {

        public ExcelFactureClientImportResult lire(
                        String cheminFichier,
                        FactureClientImportConfig config)
                        throws Exception {

                if (config == null) {
                        throw new Exception("Configuration obligatoire");
                }

                if (config.getFacture() == null) {
                        throw new Exception("Configuration facture obligatoire");
                }

                if (config.getDetail() == null) {
                        throw new Exception("Configuration detail obligatoire");
                }

                ExcelFactureClientImportResult result = new ExcelFactureClientImportResult();

                List<FactureClientLigneDTO> detailsImportExport = new ArrayList<>();

                List<FactureClientLigneDTO> detailsPrepay = new ArrayList<>();

                List<FactureClientLigneDTO> detailsOV = new ArrayList<>();

                BigDecimal totalImportExport = BigDecimal.ZERO;
                BigDecimal totalPrepay = BigDecimal.ZERO;
                BigDecimal totalOV = BigDecimal.ZERO;

                try (
                                FileInputStream fis = new FileInputStream(new File(cheminFichier));

                                Workbook workbook = WorkbookFactory.create(fis)) {

                        /*
                         * =====================================================
                         * 1. DDP EXPORT
                         * =====================================================
                         */

                        Sheet sheetExport = workbook.getSheet("DDP Export");

                        if (sheetExport == null) {
                                throw new Exception(
                                                "La feuille 'DDP Export' est introuvable");
                        }

                        BigDecimal totalExport = lireDDPExport(
                                        sheetExport,
                                        detailsImportExport,
                                        config);

                        totalImportExport = totalImportExport.add(totalExport);

                        /*
                         * =====================================================
                         * 2. DDP IMPORT
                         * =====================================================
                         */

                        Sheet sheetImport = workbook.getSheet("DDP Import");

                        if (sheetImport == null) {
                                throw new Exception(
                                                "La feuille 'DDP Import' est introuvable");
                        }

                        BigDecimal totalImport = lireDDPImport(
                                        sheetImport,
                                        detailsImportExport,
                                        config);

                        totalImportExport = totalImportExport.add(totalImport);

                        /*
                         * =====================================================
                         * 3. DAU PAYE
                         * =====================================================
                         */

                        // Sheet sheetDAUPaye = workbook.getSheet("DAU payé");
                        Sheet sheetDAUPaye = trouverFeuille(
                                        workbook,
                                        "DAU paye");

                        if (sheetDAUPaye == null) {
                                StringBuilder feuilles = new StringBuilder();

                                for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
                                        feuilles.append("[")
                                                        .append(workbook.getSheetName(i))
                                                        .append("] ");
                                }
                                throw new Exception(
                                                "La feuille 'DAU payé' est introuvable" + feuilles.toString());
                        }

                        BigDecimal[] totauxMarchandise = lireDAUPaye(
                                        sheetDAUPaye,
                                        detailsPrepay,
                                        detailsOV,
                                        config);

                        totalPrepay = totauxMarchandise[0];
                        totalOV = totauxMarchandise[1];
                }

                /*
                 * =====================================================
                 * CREATION DES FACTURES
                 * =====================================================
                 */

                if (!detailsImportExport.isEmpty()) {

                        FactureClientRequest requestImportExport = construireRequest(
                                        "DDP Import + DDP Export",
                                        detailsImportExport,
                                        totalImportExport,
                                        config);

                        result.setFactureImportExport(
                                        requestImportExport);
                }

                if (!detailsPrepay.isEmpty()) {

                        FactureClientRequest requestPrepay = construireRequest(
                                        "DDP Marchandise PREPAY",
                                        detailsPrepay,
                                        totalPrepay,
                                        config);

                        result.setFacturePrepay(
                                        requestPrepay);
                }

                if (!detailsOV.isEmpty()) {

                        FactureClientRequest requestOV = construireRequest(
                                        "DDP Marchandise OV",
                                        detailsOV,
                                        totalOV,
                                        config);

                        result.setFactureOV(
                                        requestOV);
                }

                return result;
        }

        /*
         * =========================================================
         * DDP EXPORT
         * =========================================================
         */

        private BigDecimal lireDDPExport(
                        Sheet sheet,
                        List<FactureClientLigneDTO> details,
                        FactureClientImportConfig config)
                        throws Exception {

                BigDecimal total = BigDecimal.ZERO;

                for (int rowIndex = 1; rowIndex <= sheet.getLastRowNum(); rowIndex++) {

                        Row row = sheet.getRow(rowIndex);

                        if (row == null) {
                                continue;
                        }

                        String designation = getString(row.getCell(0));

                        String rubriqueExcel = getString(row.getCell(1));

                        String quantite = getString(row.getCell(2));

                        String pu = getString(row.getCell(3));

                        String montantHT = getString(row.getCell(4));

                        if (designation == null ||
                                        designation.trim().isEmpty()) {

                                continue;
                        }

                        if ("TOTAL".equalsIgnoreCase(
                                        designation.trim())) {

                                continue;
                        }

                        FactureClientLigneDTO detail = construireDetail(config);

                        detail.setDesignation(
                                        designation);

                        detail.setRubrique(
                                        config.getDetail().getRubrique());

                        detail.setQuantite(
                                        toBigDecimal(quantite));

                        detail.setPu(
                                        toBigDecimal(pu));

                        detail.setRang(
                                        details.size() + 1);

                        details.add(detail);

                        BigDecimal ht = toBigDecimal(montantHT);

                        if (ht != null) {
                                total = total.add(ht);
                        }
                }

                return total;
        }

        /*
         * =========================================================
         * DDP IMPORT
         * =========================================================
         */

        private BigDecimal lireDDPImport(
                        Sheet sheet,
                        List<FactureClientLigneDTO> details,
                        FactureClientImportConfig config)
                        throws Exception {

                BigDecimal total = BigDecimal.ZERO;

                for (int rowIndex = 1; rowIndex <= sheet.getLastRowNum(); rowIndex++) {

                        Row row = sheet.getRow(rowIndex);

                        if (row == null) {
                                continue;
                        }

                        String designation = getString(row.getCell(0));

                        String quantite = getString(row.getCell(2));

                        String pu = getString(row.getCell(3));

                        String montantHT = getString(row.getCell(4));

                        if (designation == null ||
                                        designation.trim().isEmpty()) {

                                continue;
                        }

                        if ("TOTAL".equalsIgnoreCase(
                                        designation.trim())) {

                                continue;
                        }

                        FactureClientLigneDTO detail = construireDetail(config);

                        detail.setDesignation(
                                        designation);

                        detail.setQuantite(
                                        toBigDecimal(quantite));

                        detail.setPu(
                                        toBigDecimal(pu));

                        detail.setRang(
                                        details.size() + 1);

                        details.add(detail);

                        BigDecimal ht = toBigDecimal(montantHT);

                        if (ht != null) {
                                total = total.add(ht);
                        }
                }

                return total;
        }

        private Sheet trouverFeuille(
                        Workbook workbook,
                        String nomRecherche)
                        throws Exception {

                if (workbook == null) {
                        throw new Exception("Workbook obligatoire");
                }

                if (nomRecherche == null ||
                                nomRecherche.trim().isEmpty()) {

                        throw new Exception(
                                        "Nom de feuille obligatoire");
                }

                /*
                 * =====================================================
                 * Normalisation du nom recherché
                 * =====================================================
                 *
                 * On utilise volontairement le nom sans accent
                 * pour éviter les problèmes d'encodage.
                 *
                 * Exemple :
                 *
                 * "DAU payé" -> "dau paye"
                 * "DAU PAYÉ" -> "dau paye"
                 * "Dau paye" -> "dau paye"
                 */

                String recherche = normaliserNomFeuille(nomRecherche);

                /*
                 * =====================================================
                 * Recherche de la feuille
                 * =====================================================
                 */

                for (int i = 0; i < workbook.getNumberOfSheets(); i++) {

                        String nomFeuille = workbook.getSheetName(i);

                        if (nomFeuille == null) {
                                continue;
                        }

                        String nomNormalise = normaliserNomFeuille(nomFeuille);

                        if (recherche.equals(nomNormalise)) {

                                return workbook.getSheetAt(i);
                        }
                }

                /*
                 * =====================================================
                 * Feuille introuvable
                 * =====================================================
                 */

                StringBuilder feuilles = new StringBuilder();

                for (int i = 0; i < workbook.getNumberOfSheets(); i++) {

                        if (i > 0) {
                                feuilles.append(" | ");
                        }

                        feuilles.append("[")
                                        .append(workbook.getSheetName(i))
                                        .append("]");
                }

                throw new Exception(
                                "La feuille '"
                                                + nomRecherche
                                                + "' est introuvable. "
                                                + "Feuilles disponibles : "
                                                + feuilles.toString());
        }

        /*
         * =========================================================
         * NORMALISATION NOM FEUILLE
         * =========================================================
         */

        private String normaliserNomFeuille(
                        String texte) {

                if (texte == null) {
                        return "";
                }

                /*
                 * Suppression des espaces insécables
                 */
                texte = texte.replace(
                                "\u00A0",
                                " ");

                /*
                 * Suppression des espaces multiples
                 */
                texte = texte.replaceAll(
                                "\\s+",
                                " ");

                /*
                 * Suppression des accents
                 *
                 * "é" -> "e"
                 * "è" -> "e"
                 * "ê" -> "e"
                 * etc.
                 */
                texte = java.text.Normalizer.normalize(
                                texte,
                                java.text.Normalizer.Form.NFD);

                texte = texte.replaceAll(
                                "\\p{M}",
                                "");

                /*
                 * Suppression espaces début / fin
                 */
                texte = texte.trim();

                /*
                 * Insensible à la casse
                 */
                texte = texte.toLowerCase();

                return texte;
        }

        private String normaliserTexte(String texte) {

                if (texte == null) {
                        return "";
                }

                return java.text.Normalizer
                                .normalize(
                                                texte,
                                                java.text.Normalizer.Form.NFD)
                                .replaceAll(
                                                "\\p{M}",
                                                "")
                                .trim()
                                .toLowerCase();
        }

        /*
         * =========================================================
         * DAU PAYE
         * =========================================================
         */

        private BigDecimal[] lireDAUPaye(
                        Sheet sheet,
                        List<FactureClientLigneDTO> detailsPrepay,
                        List<FactureClientLigneDTO> detailsOV,
                        FactureClientImportConfig config)
                        throws Exception {

                BigDecimal totalPrepay = BigDecimal.ZERO;
                BigDecimal totalOV = BigDecimal.ZERO;

                /*
                 * Recherche automatique de l'en-tête
                 */

                int ligneEntete = trouverLigneEntete(
                                sheet,
                                "NUMERO_OV");

                Row header = sheet.getRow(ligneEntete);

                int indexClient = trouverColonne(
                                header,
                                "CLIENT");

                int indexMontantHT = trouverColonne(
                                header,
                                "INVOICE_HT_MGA");

                /*
                 * NUMERO OV
                 */

                int indexNumeroOV = trouverColonne(
                                header,
                                "NUMERO_OV");

                for (int rowIndex = ligneEntete + 1; rowIndex <= sheet.getLastRowNum(); rowIndex++) {

                        Row row = sheet.getRow(rowIndex);

                        if (row == null) {
                                continue;
                        }

                        String client = getString(
                                        row.getCell(indexClient));

                        String montantHT = getString(
                                        row.getCell(indexMontantHT));

                        String numeroOV = getString(
                                        row.getCell(indexNumeroOV));

                        if (client == null ||
                                        client.trim().isEmpty()) {

                                continue;
                        }

                        if (montantHT == null ||
                                        montantHT.trim().isEmpty()) {

                                continue;
                        }

                        /*
                         * Création du détail
                         */

                        FactureClientLigneDTO detail = construireDetail(config);

                        /*
                         * Marchandise :
                         *
                         * designation = CLIENT
                         * quantite = 1
                         * pu = MONTANT HT
                         */

                        detail.setDesignation(
                                        client);

                        detail.setQuantite(
                                        BigDecimal.ONE);

                        detail.setPu(
                                        toBigDecimal(montantHT));

                        /*
                         * =================================================
                         * PREPAY
                         * =================================================
                         */

                        if (numeroOV != null &&
                                        "PREPAY".equalsIgnoreCase(
                                                        numeroOV.trim())) {

                                detail.setRang(
                                                detailsPrepay.size() + 1);

                                detailsPrepay.add(detail);

                                totalPrepay = totalPrepay.add(
                                                toBigDecimal(montantHT));

                        } else if (numeroOV != null &&
                                        estNumerique(numeroOV)) {

                                detail.setRang(
                                                detailsOV.size() + 1);

                                detailsOV.add(detail);

                                totalOV = totalOV.add(
                                                toBigDecimal(montantHT));

                        } else {

                                throw new Exception(
                                                "Valeur NUMERO OV inconnue à la ligne "
                                                                + (rowIndex + 1)
                                                                + " : ["
                                                                + numeroOV
                                                                + "]");
                        }
                }

                return new BigDecimal[] {
                                totalPrepay,
                                totalOV
                };
        }

        /*
         * =========================================================
         * CONSTRUCTION DETAIL
         * =========================================================
         */

        private FactureClientLigneDTO construireDetail(
                        FactureClientImportConfig config)
                        throws Exception {

                FactureClientLigneDTO detail = new FactureClientLigneDTO();

                FactureClientImportConfig.DetailConfig dc = config.getDetail();

                detail.setDevise(
                                dc.getDevise());

                detail.setTaux(
                                dc.getTaux());

                detail.setTva(
                                dc.getTva());

                detail.setRubrique(
                                dc.getRubrique());

                detail.setCompte(
                                dc.getCompte());

                detail.setDuree(
                                dc.getDuree());

                detail.setEstproformaescale(
                                dc.getEstproformaescale());

                detail.setDatefact(
                                parseDate(dc.getDatefact()));

                detail.setDaty(
                                parseDate(dc.getDaty()));

                detail.setMois(
                                dc.getMois());

                detail.setAnnee(
                                dc.getAnnee());

                return detail;
        }

        /*
         * =========================================================
         * CONSTRUCTION FACTURE
         * =========================================================
         */

        private FactureClientRequest construireRequest(
                        String typeImport,
                        List<FactureClientLigneDTO> details,
                        BigDecimal totalHT,
                        FactureClientImportConfig config)
                        throws Exception {

                FactureClientImportConfig.FactureConfig fc = config.getFacture();

                FactureClientDTO facture = new FactureClientDTO();

                facture.setTiers(
                                fc.getTiers());

                facture.setDaty(
                                parseDate(fc.getDaty()));

                facture.setDesignation(
                                fc.getDesignation()
                                                + " - "
                                                + typeImport);

                facture.setType(
                                fc.getType());

                facture.setTva(
                                fc.getTva());

                facture.setRemarque(
                                fc.getRemarque());

                facture.setIduser(
                                fc.getIduser());

                facture.setDateEcheance(
                                parseDate(fc.getDateEcheance()));

                facture.setDateDepart(
                                parseDate(fc.getDateDepart()));

                facture.setDateArrivee(
                                parseDate(fc.getDateArrivee()));

                facture.setEtat(
                                fc.getEtat());

                facture.setDevisemere(
                                fc.getDevisemere());

                facture.setTypeengagement(
                                fc.getTypeengagement());

                facture.setExercice(
                                fc.getExercice());

                facture.setEstauto(
                                fc.getEstauto());

                facture.setEstancienne(
                                fc.getEstancienne());

                facture.setLht(
                                totalHT);

                facture.setLm(
                                BigDecimal.ZERO);

                facture.setTe(
                                BigDecimal.ZERO);

                facture.setJnt(
                                BigDecimal.ZERO);

                facture.setEstproformaescale(
                                fc.getEstproformaescale());

                facture.setEstSup2021(
                                fc.getEstSup2021());

                facture.setIdcategorie(
                                fc.getIdcategorie());

                FactureClientRequest request = new FactureClientRequest();

                request.setFacture(
                                facture);

                request.setDetails(
                                details);

                return request;
        }

        /*
         * =========================================================
         * RECHERCHE EN-TETE
         * =========================================================
         */

        private int trouverLigneEntete(
                        Sheet sheet,
                        String colonneRecherchee)
                        throws Exception {

                DataFormatter formatter = new DataFormatter();

                for (int rowIndex = 0; rowIndex <= sheet.getLastRowNum(); rowIndex++) {

                        Row row = sheet.getRow(rowIndex);

                        if (row == null) {
                                continue;
                        }

                        for (int colIndex = 0; colIndex < row.getLastCellNum(); colIndex++) {

                                Cell cell = row.getCell(colIndex);

                                if (cell == null) {
                                        continue;
                                }

                                String valeur = formatter
                                                .formatCellValue(cell)
                                                .trim();

                                if (valeur.equalsIgnoreCase(
                                                colonneRecherchee)) {

                                        return rowIndex;
                                }
                        }
                }

                throw new Exception(
                                "En-tête introuvable : "
                                                + colonneRecherchee);
        }

        /*
         * =========================================================
         * RECHERCHE COLONNE
         * =========================================================
         */

        private int trouverColonne(
                        Row header,
                        String nomColonne)
                        throws Exception {

                DataFormatter formatter = new DataFormatter();

                for (int i = 0; i < header.getLastCellNum(); i++) {

                        Cell cell = header.getCell(i);

                        if (cell == null) {
                                continue;
                        }

                        String valeur = formatter
                                        .formatCellValue(cell)
                                        .trim();

                        if (valeur.equalsIgnoreCase(
                                        nomColonne)) {

                                return i;
                        }
                }

                throw new Exception(
                                "Colonne introuvable : "
                                                + nomColonne);
        }

        /*
         * =========================================================
         * NUMERIQUE
         * =========================================================
         */

        private boolean estNumerique(String valeur) {

                if (valeur == null || valeur.trim().isEmpty()) {
                        return false;
                }

                String[] numeros = valeur.split(";");

                for (String numero : numeros) {

                        numero = numero.trim();

                        if (numero.isEmpty()) {
                                return false;
                        }

                        // Accepte uniquement des chiffres
                        if (!numero.matches("\\d+")) {
                                return false;
                        }
                }

                return true;
        }

        /*
         * =========================================================
         * STRING EXCEL
         * =========================================================
         */

        private String getString(
                        Cell cell) {

                if (cell == null) {
                        return null;
                }

                DataFormatter formatter = new DataFormatter();

                return formatter
                                .formatCellValue(cell)
                                .trim();
        }

        /*
         * =========================================================
         * BIG DECIMAL
         * =========================================================
         */

        private BigDecimal toBigDecimal(
                        String value) {

                if (value == null ||
                                value.trim().isEmpty()) {

                        return null;
                }

                value = value.trim();

                try {

                        value = value
                                        .replace(" ", "")
                                        .replace("\u00A0", "");

                        if (value.contains(",") &&
                                        value.contains(".")) {

                                if (value.lastIndexOf(",") > value.lastIndexOf(".")) {

                                        value = value.replace(".", "");
                                        value = value.replace(",", ".");

                                } else {

                                        value = value.replace(",", "");
                                }

                        } else if (value.contains(",")) {

                                String[] parts = value.split(",");

                                if (parts.length == 2 &&
                                                parts[1].length() == 3) {

                                        value = value.replace(",", "");

                                } else {

                                        value = value.replace(",", ".");
                                }
                        }

                        return new BigDecimal(value);

                } catch (NumberFormatException e) {

                        throw new NumberFormatException(
                                        "Valeur numérique invalide dans Excel : ["
                                                        + value
                                                        + "]");
                }
        }

        /*
         * =========================================================
         * DATE
         * =========================================================
         */

        private Date parseDate(
                        String value)
                        throws Exception {

                if (value == null ||
                                value.trim().isEmpty()) {

                        return null;
                }

                SimpleDateFormat sdf = new SimpleDateFormat(
                                "yyyy-MM-dd");

                sdf.setLenient(false);

                return sdf.parse(value);
        }
}