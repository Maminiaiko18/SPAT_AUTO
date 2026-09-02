package mg.port.api.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import facture.FactureClient;
import facture.FactureClientDetails;
import mg.port.api.dao.FactureClientDAO;
import mg.port.api.model.FactureClientDTO;
import mg.port.api.model.FactureClientLigneDTO;
import mg.port.api.model.FactureClientRequest;
import mg.port.api.model.FactureClientResponse;
import java.sql.SQLException;
@WebServlet("/api/factureclient")
public class ApiFactureClientServlet extends HttpServlet {

    private FactureClientDAO dao;
    private ObjectMapper mapper;

    @Override
    public void init() throws ServletException {

        dao = new FactureClientDAO();

        mapper = new ObjectMapper();

        mapper.configure(
                SerializationFeature.WRITE_DATES_AS_TIMESTAMPS,
                false);
    }

    /**
     * GET
     *
     * /api/factureclient
     * /api/factureclient?id=XXX
     */
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {

            String id = request.getParameter("id");

            if (id != null && !id.trim().isEmpty()) {

                getOne(id, response);

            } else {

                getAll(response);

            }

        } catch (Exception e) {

            sendError(
                    response,
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    e.getMessage());
        }
    }

    private void getAll(
            HttpServletResponse response)
            throws Exception {

        List<FactureClientDTO> factures = dao.findAll();

        mapper.writeValue(
                response.getWriter(),
                factures);
    }

    private void getOne(
            String id,
            HttpServletResponse response)
            throws Exception {

        FactureClientDTO facture = dao.findById(id);

        if (facture == null) {

            sendError(
                    response,
                    HttpServletResponse.SC_NOT_FOUND,
                    "Facture introuvable : " + id);

            return;
        }

        List<FactureClientLigneDTO> details = dao.findDetails(id);

        Map<String, Object> result = new HashMap<>();

        result.put("facture", facture);
        result.put("details", details);

        mapper.writeValue(
                response.getWriter(),
                result);
    }

    private void sendError(
            HttpServletResponse response,
            int status,
            String message)
            throws IOException {

        response.setStatus(status);

        Map<String, String> error = new HashMap<>();

        error.put(
                "error",
                message != null ? message : "Erreur inconnue");

        mapper.writeValue(
                response.getWriter(),
                error);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {

            FactureClientRequest req = mapper.readValue(
                    request.getInputStream(),
                    FactureClientRequest.class);

            if (req == null || req.getFacture() == null) {

                sendError(
                        response,
                        HttpServletResponse.SC_BAD_REQUEST,
                        "La facture est obligatoire");

                return;
            }

            if (req.getDetails() == null ||
                    req.getDetails().isEmpty()) {

                sendError(
                        response,
                        HttpServletResponse.SC_BAD_REQUEST,
                        "La facture doit contenir au moins une ligne");

                return;
            }

            FactureClientResponse result = dao.create(
                    req.getFacture(),
                    req.getDetails());

            response.setStatus(
                    HttpServletResponse.SC_CREATED);

            mapper.writeValue(
                    response.getWriter(),
                    result);

        } catch (IllegalArgumentException e) {

            sendError(
                    response,
                    HttpServletResponse.SC_BAD_REQUEST,
                    e.getMessage());

        } catch (SQLException e) {

            sendError(
                    response,
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    e.getMessage());

        } catch (Exception e) {

            sendError(
                    response,
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    e.getMessage());
        }
    }

}