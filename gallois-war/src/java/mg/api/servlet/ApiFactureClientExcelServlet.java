package mg.port.api.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;

import mg.port.api.model.FactureClientImportConfig;
import mg.port.api.model.FactureClientRequest;
import mg.port.api.model.FactureClientResponse;
import mg.port.api.service.ExcelFactureClientReader;
import mg.port.api.service.FactureClientService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.List;
import java.io.FileWriter;
import java.io.PrintWriter;
import mg.port.api.model.ExcelFactureClientImportResult;

@WebServlet("/api/factureclient/import-excel")
public class ApiFactureClientExcelServlet
                extends HttpServlet {

        private ExcelFactureClientReader reader;
        private FactureClientService service;
        private ObjectMapper mapper;

        @Override
        public void init()
                        throws ServletException {

                reader = new ExcelFactureClientReader();

                service = new FactureClientService();

                mapper = new ObjectMapper();
        }

        @Override
        protected void doPost(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                response.setCharacterEncoding("UTF-8");
                response.setContentType("application/json;charset=UTF-8");

                try {

                        /*
                         * =====================================================
                         * CONFIGURATION
                         * =====================================================
                         */
                        String cheminConfig = "D:/factures/config-facture.json";

                        File configFile = new File(cheminConfig);

                        if (!configFile.exists()) {

                                throw new Exception(
                                                "Fichier de configuration introuvable : "
                                                                + cheminConfig);
                        }

                        /*
                         * =====================================================
                         * LECTURE CONFIG JSON
                         * =====================================================
                         */
                        FactureClientImportConfig config;

                        try (FileInputStream fis = new FileInputStream(configFile)) {

                                config = mapper.readValue(
                                                fis,
                                                FactureClientImportConfig.class);
                        }

                        if (config == null) {

                                throw new Exception(
                                                "Configuration vide");
                        }

                        if (config.getCheminExcel() == null ||
                                        config.getCheminExcel()
                                                        .trim()
                                                        .isEmpty()) {

                                throw new Exception(
                                                "cheminExcel obligatoire dans la configuration");
                        }

                        /*
                         * =====================================================
                         * LECTURE EXCEL
                         * =====================================================
                         */
                        
                        ExcelFactureClientImportResult importResult = reader.lire(
                                        config.getCheminExcel(),
                                        config);

                        FactureClientResponse resultImportExport = null;
                        FactureClientResponse resultPrepay = null;
                        FactureClientResponse resultOV = null;

                        /*
                         * =====================================================
                         * 1. DDP IMPORT + DDP EXPORT
                         * =====================================================
                         */
                        FactureClientRequest factureImportExport = importResult.getFactureImportExport();

                        if (factureImportExport != null
                                        && factureImportExport.getDetails() != null
                                        && !factureImportExport.getDetails().isEmpty()) {

                                resultImportExport = service.creer(factureImportExport);
                        }

                        /*
                         * =====================================================
                         * 2. DDP MARCHANDISE - PREPAY
                         * =====================================================
                         */
                        FactureClientRequest facturePrepay = importResult.getFacturePrepay();

                        if (facturePrepay != null
                                        && facturePrepay.getDetails() != null
                                        && !facturePrepay.getDetails().isEmpty()) {

                                resultPrepay = service.creer(facturePrepay);
                        }

                        /*
                         * =====================================================
                         * 3. DDP MARCHANDISE - OV
                         * =====================================================
                         */
                        FactureClientRequest factureOV = importResult.getFactureOV();

                        if (factureOV != null
                                        && factureOV.getDetails() != null
                                        && !factureOV.getDetails().isEmpty()) {

                                resultOV = service.creer(factureOV);
                        }
                        List<FactureClientResponse> resultats = new ArrayList<>();

                        if (resultImportExport != null) {
                                resultats.add(resultImportExport);
                        }

                        if (resultPrepay != null) {
                                resultats.add(resultPrepay);
                        }

                        if (resultOV != null) {
                                resultats.add(resultOV);
                        }

                        /*
                         * =====================================================
                         * RÉPONSE
                         * =====================================================
                         */
                        response.setStatus(
                                        HttpServletResponse.SC_CREATED);

                        Map<String, Object> results = new HashMap<>();

                        results.put("factureImportExport", resultImportExport);
                        results.put("facturePrepay", resultPrepay);
                        results.put("factureOV", resultOV);
                        /*
                         * =====================================================
                         * LOG
                         * =====================================================
                         */
                        ecrireLog(
                                        config.getCheminExcel(),
                                        resultats);
                        response.setStatus(
                                        HttpServletResponse.SC_CREATED);

                        mapper.writeValue(
                                        response.getWriter(),
                                        results);

                } catch (Exception e) {

                        e.printStackTrace();
                        response.setCharacterEncoding("UTF-8");
                        response.setContentType(
                                        "application/json;charset=UTF-8");
                        response.setStatus(
                                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

                        Map<String, String> error = new HashMap<>();

                        error.put(
                                        "error",
                                        e.getClass().getName());

                        error.put(
                                        "message",
                                        e.getMessage() != null
                                                        ? e.getMessage()
                                                        : "Aucun message d'erreur");

                        mapper.writeValue(
                                        response.getWriter(),
                                        error);
                }
        }

        private void ecrireLog(
                        String cheminExcel,
                        List<FactureClientResponse> resultats) {

                try {

                        File excelFile = new File(cheminExcel);

                        File dossier = excelFile.getParentFile();

                        String nomLog = "import-facture.log";

                        File fichierLog = new File(dossier, nomLog);

                        try (PrintWriter writer = new PrintWriter(
                                        new FileWriter(
                                                        fichierLog,
                                                        true))) {

                                writer.println(
                                                "==================================================");

                                writer.println(
                                                "IMPORT FACTURE CLIENT");

                                writer.println(
                                                "Date : " + new java.util.Date());

                                writer.println(
                                                "Fichier Excel : "
                                                                + excelFile.getAbsolutePath());

                                writer.println(
                                                "Nombre de factures créées : "
                                                                + resultats.size());

                                writer.println();

                                for (int i = 0; i < resultats.size(); i++) {

                                        FactureClientResponse result = resultats.get(i);

                                        writer.println(
                                                        "Facture " + (i + 1));

                                        writer.println(
                                                        "Résultat : "
                                                                        + result);

                                        writer.println();
                                }

                                writer.println(
                                                "==================================================");

                                writer.println();

                        }

                } catch (Exception e) {

                        /*
                         * Le problème de log ne doit pas
                         * faire échouer la création des factures.
                         */
                        e.printStackTrace();
                }
        }
}