package mg.port.api.service;

import mg.port.api.dao.FactureClientDAO;
import mg.port.api.model.FactureClientRequest;
import mg.port.api.model.FactureClientResponse;

public class FactureClientService {

    private final FactureClientDAO dao;

    public FactureClientService() {
        dao = new FactureClientDAO();
    }

    public FactureClientResponse creer(
            FactureClientRequest request)
            throws Exception {

        if (request == null) {
            throw new IllegalArgumentException(
                    "Request obligatoire");
        }

        if (request.getFacture() == null) {
            throw new IllegalArgumentException(
                    "Facture obligatoire");
        }

        if (request.getDetails() == null ||
                request.getDetails().isEmpty()) {

            throw new IllegalArgumentException(
                    "Aucune ligne dans la facture");
        }

        return dao.create(
                request.getFacture(),
                request.getDetails());
    }
}