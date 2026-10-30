package mg.port.api.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mg.port.api.model.TiersCreateRequest;
import bean.UploadPj;
import mg.spat.Tiers;
import utilitaire.UtilDB;

public class TiersDAO {

    public Tiers create(TiersCreateRequest request, String userId, String nifDocumentName,
            String statDocumentName) throws Exception {
        Connection connection = null;
        try {
            connection = new UtilDB().GetConn();
            connection.setAutoCommit(false);

            try (PreparedStatement statement = connection.prepareStatement(
                    "SELECT ID FROM TIERS WHERE (TRIM(NIF) = ? OR TRIM(STAT) = ?) AND ROWNUM = 1")) {
                statement.setString(1, request.getNif());
                statement.setString(2, request.getStat());
                try (ResultSet result = statement.executeQuery()) {
                    if (result.next()) {
                        throw new DuplicateTierIdentifierException(
                                "Un tiers utilise déjà le NIF ou le STAT fourni");
                    }
                }
            }

            try (PreparedStatement statement = connection.prepareStatement(
                    "SELECT ID FROM TYPECLIENT WHERE ID = ?")) {
                statement.setString(1, request.getType().trim());
                try (ResultSet result = statement.executeQuery()) {
                    if (!result.next()) {
                        throw new IllegalArgumentException("Type de tiers inconnu");
                    }
                }
            }

            Tiers tiers = new Tiers();
            tiers.setNom(request.getNom().trim());
            tiers.setDescription(request.getDescription());
            tiers.setNif(request.getNif());
            tiers.setStat(request.getStat());
            tiers.setContact(request.getContact());
            tiers.setResponsable(request.getResponsable());
            tiers.setAdresse(request.getAdresse());
            tiers.setType(request.getType().trim());
            tiers.setCompteAuxFournisseur(request.getCompteAuxFournisseur());
            tiers.setCompteAuxClient(request.getCompteAuxClient());
            tiers.setCin(request.getCin());
            tiers.setCp(request.getCp());
            tiers.setIduser(userId);

            tiers.createObject(userId, connection);

            UploadPj nifEvidence = new UploadPj("ATTACHER_FICHIER", "GETSEQ_ATTACHER_FICHIER",
                    "FLE", "Justificatif NIF verifie via API", nifDocumentName, tiers.getId());
            nifEvidence.construirePK(connection);
            nifEvidence.insertToTableWithHisto(userId, connection);

            UploadPj statEvidence = new UploadPj("ATTACHER_FICHIER", "GETSEQ_ATTACHER_FICHIER",
                    "FLE", "Justificatif STAT verifie via API", statDocumentName, tiers.getId());
            statEvidence.construirePK(connection);
            statEvidence.insertToTableWithHisto(userId, connection);

            connection.commit();
            return tiers;
        } catch (Exception e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (Exception ignored) {
                }
            }
            throw e;
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception ignored) {
                }
            }
        }
    }

    public static class DuplicateTierIdentifierException extends Exception {
        public DuplicateTierIdentifierException(String message) {
            super(message);
        }
    }
}
