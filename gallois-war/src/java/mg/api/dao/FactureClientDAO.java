package mg.port.api.dao;

import facture.FactureClient;
import facture.FactureClientDetails;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import mg.port.api.model.FactureClientDTO;
import mg.port.api.model.FactureClientLigneDTO;
import utilitaire.UtilDB;
import java.util.UUID;
import mg.port.api.model.FactureClientResponse;
import mg.port.api.model.FactureClientRequest;

public class FactureClientDAO {

    private Connection getConnection() throws SQLException {
       

        return (new UtilDB()).GetConn();
    }

    public List<FactureClientDTO> findAll() throws SQLException {

        List<FactureClientDTO> result = new ArrayList<>();

        String sql = "SELECT * " +
                "FROM  FACTURECLIENT " +
                "ORDER BY DATY DESC";

        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                result.add(mapFactureClient(rs));
            }
        }

        return result;
    }

    public FactureClientDTO findById(String id) throws SQLException {

        String sql = "SELECT * " +
                "FROM  FACTURECLIENT " +
                "WHERE ID = ?";

        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapFactureClient(rs);
                }
            }
        }

        return null;
    }

    public List<FactureClientLigneDTO> findDetails(String idMere)
            throws SQLException {

        List<FactureClientLigneDTO> result = new ArrayList<>();

        String sql = "SELECT * " +
                "FROM  FACTURE_CLIENT_FILLE " +
                "WHERE IDMERE = ? " +
                "ORDER BY RANG";

        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, idMere);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    result.add(mapFactureClientDetails(rs));
                }
            }
        }

        return result;
    }

    
    // =========================================================
    // CREATE FACTURE + DETAILS
    // =========================================================

    public FactureClientResponse create(
            FactureClientDTO facture,
            List<FactureClientLigneDTO> details)
            throws SQLException {

        Connection conn = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            if (facture == null) {
                throw new IllegalArgumentException("La facture est obligatoire");
            }
            if (details == null || details.isEmpty()) {
                throw new IllegalArgumentException("La facture doit contenir au moins une ligne");
            }

            FactureClient mere = new FactureClient();
            mere.setNomTable("Factureclient");
            mere.setLiaisonFille("idmere");
            mere.setNomClasseFille("facture.FactureClientDetails");

            mere.setDaty(facture.getDaty() != null ? new java.sql.Date(facture.getDaty().getTime()) : new java.sql.Date(System.currentTimeMillis()));
            mere.setTiers(facture.getTiers());
            mere.setDesignation(facture.getDesignation());
            mere.setType(facture.getType() != null ? facture.getType() : "C");
            mere.setIdcategorie(facture.getIdcategorie() != null ? facture.getIdcategorie() : utilitaire.Constante.idCategorieFCDefinitive);
            mere.setIduser(facture.getIduser());
            mere.setRemarque(facture.getRemarque());
            mere.setDate_echeance(facture.getDateEcheance() != null ? new java.sql.Date(facture.getDateEcheance().getTime()) : null);
            Integer etatFacture = facture.getEtat() != null ? facture.getEtat() : utilitaire.ConstanteEtat.getEtatCreer();
            mere.setEtat(etatFacture);
            mere.setTva(facture.getTva() != null ? facture.getTva().doubleValue() : 0d);
            mere.setCode(facture.getCode());
            mere.setIdProvision(facture.getIdprovision());

            List<FactureClientDetails> lignes = new ArrayList<>();
            for (int i = 0; i < details.size(); i++) {
                FactureClientLigneDTO detail = details.get(i);
                FactureClientDetails ligne = new FactureClientDetails();
                ligne.setDesignation(detail.getDesignation());
                ligne.setQuantite(detail.getQuantite() != null ? detail.getQuantite().doubleValue() : 0d);
                ligne.setPu(detail.getPu() != null ? detail.getPu().doubleValue() : 0d);
                ligne.setCompte(detail.getCompte());
                ligne.setIdproduit(detail.getIdproduit());
                ligne.setDevise(detail.getDevise());
                ligne.setTaux(detail.getTaux() != null ? detail.getTaux().doubleValue() : 0d);
                ligne.setIdactivite(detail.getIdactivite());
                ligne.setTva(detail.getTva() != null ? detail.getTva().doubleValue() : 0d);
                ligne.setDatefact(detail.getDatefact() != null ? new java.sql.Date(detail.getDatefact().getTime()) : null);
                ligne.setRubrique(detail.getRubrique());
                ligne.setMois(detail.getMois() != null ? detail.getMois() : 0);
                ligne.setAnnee(detail.getAnnee() != null ? detail.getAnnee() : 0);
                ligne.setHeureDebut(detail.getHeuredebut());
                ligne.setHeureFin(detail.getHeurefin());
                ligne.setReduction(detail.getReduction() != null ? detail.getReduction().doubleValue() : 0d);
                ligne.setMajoration(detail.getMajoration() != null ? detail.getMajoration().doubleValue() : 0d);
                ligne.setRang(detail.getRang() != null ? detail.getRang() : i + 1);
                ligne.setDuree(detail.getDuree() != null ? detail.getDuree().doubleValue() : 0d);
                ligne.setDaty(detail.getDaty() != null ? new java.sql.Date(detail.getDaty().getTime()) : new java.sql.Date(System.currentTimeMillis()));
                ligne.setEstProformaEscale(detail.getEstproformaescale() != null ? detail.getEstproformaescale() : 0);
                lignes.add(ligne);
            }

            mere.setFille(lignes.toArray(new FactureClientDetails[0]));
            mere.createObject(facture.getIduser(), conn);

            conn.commit();
            facture.setId(mere.getId());

            return new FactureClientResponse(facture, details);

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackException) {
                    // ignore
                }
            }
            throw e;

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackException) {
                    // ignore
                }
            }
            throw new SQLException("Erreur lors de la création de la facture : " + e.getMessage(), e);

        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException ignored) {
                }
                try {
                    conn.close();
                } catch (SQLException ignored) {
                }
            }
        }
    }

    // =========================================================
    // INSERT FACTURECLIENT
    // =========================================================

    private void insertFacture(
            Connection conn,
            String id,
            FactureClientDTO f)
            throws SQLException {

        String sql = "INSERT INTO FACTURECLIENT (" +

                "ID, " +
                "DATY, " +
                "TIERS, " +
                "DESIGNATION, " +
                "TYPE, " +
                "TVA, " +
                "REMARQUE, " +
                "IDUSER, " +
                "DATE_ECHEANCE, " +
                "ETAT, " +
                "IDPREVISION, " +
                "IDCATEGORIE, " +
                "IDPROVISION, " +
                "DEVISEMERE, " +
                "ESTDDPMICTSL, " +
                "CODEPRESTATION, " +
                "CODE, " +
                "ESTMICTSL, " +
                "EXERCICE, " +
                "IDAVOIR, " +
                "ESTAUTO, " +
                "TYPEENGAGEMENT, " +
                "POURCOMPTE, " +
                "ESTANCIENNE, " +
                "ARMATEUR, " +
                "PAIEMENT, " +
                "LHT, " +
                "LM, " +
                "TE, " +
                "JNT, " +
                "DATEDEPART, " +
                "HEUREDEPART, " +
                "DATEARRIVEE, " +
                "HEUREARRIVEE, " +
                "BATEAU, " +
                "PROVENANCE, " +
                "DESTINATION, " +
                "ESCALE, " +
                "VOLUME, " +
                "VOLUME100, " +
                "NOMCLT, " +
                "ADRCLT, " +
                "NMSTTCLT, " +
                "TELCLT, " +
                "NIF, " +
                "RC, " +
                "DTTP, " +
                "TP, " +
                "DTQUIT, " +
                "QUIT, " +
                "IDPLACEMENT, " +
                "ESTPROFORMAESCALE, " +
                "CONNEXE, " +
                "EST_SUP_2021" +

                ") VALUES (" +

                "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, " +
                "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, " +
                "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, " +
                "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, " +
                "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, " +
                "?, ?, ?, ?" +

                ")";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            int i = 1;

            ps.setString(i++, id);
            setDate(ps, i++, f.getDaty());
            ps.setString(i++, f.getTiers());
            ps.setString(i++, f.getDesignation());
            ps.setString(i++, f.getType());
            ps.setBigDecimal(i++, f.getTva());
            ps.setString(i++, f.getRemarque());
            ps.setString(i++, f.getIduser());
            setDate(ps, i++, f.getDateEcheance());
            setInteger(ps, i++, f.getEtat());

            ps.setString(i++, f.getIdprevision());
            ps.setString(i++, f.getIdcategorie());
            ps.setString(i++, f.getIdprovision());

            /*
             * DEVISEMERE possède DEFAULT 'Ar'
             * mais comme le DTO peut contenir la valeur,
             * on l'utilise si elle existe.
             */
            if (f.getDevisemere() != null) {
                ps.setString(i++, f.getDevisemere());
            } else {
                ps.setString(i++, "Ar");
            }

            ps.setString(i++, f.getEstddpmictsl());
            ps.setString(i++, f.getCodeprestation());
            ps.setString(i++, f.getCode());
            ps.setString(i++, f.getEstmictsl());

            setInteger(ps, i++, f.getExercice());

            ps.setString(i++, f.getIdavoir());
            setInteger(ps, i++, f.getEstauto());

            if (f.getTypeengagement() != null) {
                ps.setString(i++, f.getTypeengagement());
            } else {
                ps.setString(i++, "normal");
            }

            ps.setString(i++, f.getPourcompte());

            setInteger(ps, i++, f.getEstancienne());

            ps.setString(i++, f.getArmateur());
            ps.setString(i++, f.getPaiement());

            ps.setBigDecimal(i++, f.getLht());
            ps.setBigDecimal(i++, f.getLm());
            ps.setBigDecimal(i++, f.getTe());
            ps.setBigDecimal(i++, f.getJnt());

            setDate(ps, i++, f.getDateDepart());
            ps.setString(i++, f.getHeureDepart());

            setDate(ps, i++, f.getDateArrivee());
            ps.setString(i++, f.getHeureArrivee());

            ps.setString(i++, f.getBateau());
            ps.setString(i++, f.getProvenance());
            ps.setString(i++, f.getDestination());
            ps.setString(i++, f.getEscale());

            ps.setBigDecimal(i++, f.getVolume());
            ps.setBigDecimal(i++, f.getVolume100());

            ps.setString(i++, f.getNomclt());
            ps.setString(i++, f.getAdrclt());
            ps.setString(i++, f.getNmsttclt());
            ps.setString(i++, f.getTelclt());
            ps.setString(i++, f.getNif());
            ps.setString(i++, f.getRc());

            setDate(ps, i++, f.getDttp());
            ps.setString(i++, f.getTp());

            setDate(ps, i++, f.getDtquit());
            ps.setString(i++, f.getQuit());

            ps.setString(i++, f.getIdplacement());

            setInteger(
                    ps,
                    i++,
                    f.getEstproformaescale());

            ps.setString(i++, f.getConnexe());

            setInteger(
                    ps,
                    i++,
                    f.getEstSup2021());

            ps.executeUpdate();
        }
    }

    // =========================================================
    // INSERT FACTURE_CLIENT_FILLE
    // =========================================================

    private void insertDetail(
            Connection conn,
            String id,
            String idMere,
            FactureClientLigneDTO d)
            throws SQLException {

        String sql = "INSERT INTO FACTURE_CLIENT_FILLE (" +

                "ID, " +
                "IDMERE, " +
                "DESIGNATION, " +
                "QUANTITE, " +
                "PU, " +
                "COMPTE, " +
                "IDPRODUIT, " +
                "DEVISE, " +
                "TAUX, " +
                "IDACTIVITE, " +
                "TVA, " +
                "DATEFACT, " +
                "RUBRIQUE, " +
                "MOIS, " +
                "ANNEE, " +
                "HEUREDEBUT, " +
                "HEUREFIN, " +
                "REDUCTION, " +
                "MAJORATION, " +
                "TEST, " +
                "RANG, " +
                "DUREE, " +
                "DATY, " +
                "ESTPROFORMAESCALE" +

                ") VALUES (" +

                "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, " +
                "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, " +
                "?, ?, ?, ?" +

                ")";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            int i = 1;

            ps.setString(i++, id);
            ps.setString(i++, idMere);
            ps.setString(i++, d.getDesignation());

            ps.setBigDecimal(i++, d.getQuantite());
            ps.setBigDecimal(i++, d.getPu());

            ps.setString(i++, d.getCompte());
            ps.setString(i++, d.getIdproduit());
            ps.setString(i++, d.getDevise());

            ps.setBigDecimal(i++, d.getTaux());

            ps.setString(i++, d.getIdactivite());

            ps.setBigDecimal(i++, d.getTva());

            setDate(ps, i++, d.getDatefact());

            ps.setString(i++, d.getRubrique());

            setInteger(ps, i++, d.getMois());
            setInteger(ps, i++, d.getAnnee());

            ps.setString(i++, d.getHeuredebut());
            ps.setString(i++, d.getHeurefin());

            ps.setBigDecimal(i++, d.getReduction());
            ps.setBigDecimal(i++, d.getMajoration());
            ps.setBigDecimal(i++, d.getTest());

            setInteger(ps, i++, d.getRang());

            ps.setBigDecimal(i++, d.getDuree());

            setDate(ps, i++, d.getDaty());

            setInteger(
                    ps,
                    i++,
                    d.getEstproformaescale());

            ps.executeUpdate();
        }
    }

    // =========================================================
    // GENERATION ID
    // =========================================================

    private String generateId() {

        return UUID.randomUUID().toString();
    }

    // =========================================================
    // HELPERS JDBC
    // =========================================================

    private void setDate(
            PreparedStatement ps,
            int index,
            java.util.Date value)
            throws SQLException {

        if (value != null) {
            ps.setTimestamp(
                    index,
                    new java.sql.Timestamp(value.getTime()));
        } else {
            ps.setNull(
                    index,
                    Types.TIMESTAMP);
        }
    }

    private void setInteger(
            PreparedStatement ps,
            int index,
            Integer value)
            throws SQLException {

        if (value != null) {
            ps.setInt(index, value);
        } else {
            ps.setNull(
                    index,
                    Types.INTEGER);
        }
    }

    // =========================================================
    // MAPPING FACTURE
    // =========================================================

    private FactureClientDTO mapFactureClient(
            ResultSet rs)
            throws SQLException {

        FactureClientDTO f = new FactureClientDTO();

        f.setId(rs.getString("ID"));
        f.setDaty(rs.getDate("DATY"));
        f.setTiers(rs.getString("TIERS"));
        f.setDesignation(
                rs.getString("DESIGNATION"));
        f.setType(rs.getString("TYPE"));
        f.setTva(rs.getBigDecimal("TVA"));
        f.setRemarque(rs.getString("REMARQUE"));
        f.setIduser(rs.getString("IDUSER"));
        f.setDateEcheance(
                rs.getDate("DATE_ECHEANCE"));
        f.setEtat(rs.getInt("ETAT"));
        f.setIdprevision(
                rs.getString("IDPREVISION"));
        f.setIdcategorie(
                rs.getString("IDCATEGORIE"));
        f.setIdprovision(
                rs.getString("IDPROVISION"));
        f.setDevisemere(
                rs.getString("DEVISEMERE"));
        f.setEstddpmictsl(
                rs.getString("ESTDDPMICTSL"));
        f.setCodeprestation(
                rs.getString("CODEPRESTATION"));
        f.setCode(rs.getString("CODE"));
        f.setEstmictsl(
                rs.getString("ESTMICTSL"));
        f.setExercice(
                rs.getInt("EXERCICE"));
        f.setIdavoir(
                rs.getString("IDAVOIR"));
        f.setEstauto(
                rs.getInt("ESTAUTO"));
        f.setTypeengagement(
                rs.getString("TYPEENGAGEMENT"));
        f.setPourcompte(
                rs.getString("POURCOMPTE"));
        f.setEstancienne(
                rs.getInt("ESTANCIENNE"));
        f.setArmateur(
                rs.getString("ARMATEUR"));
        f.setPaiement(
                rs.getString("PAIEMENT"));
        f.setLht(rs.getBigDecimal("LHT"));
        f.setLm(rs.getBigDecimal("LM"));
        f.setTe(rs.getBigDecimal("TE"));
        f.setJnt(rs.getBigDecimal("JNT"));
        f.setDateDepart(
                rs.getDate("DATEDEPART"));
        f.setHeureDepart(
                rs.getString("HEUREDEPART"));
        f.setDateArrivee(
                rs.getDate("DATEARRIVEE"));
        f.setHeureArrivee(
                rs.getString("HEUREARRIVEE"));
        f.setBateau(
                rs.getString("BATEAU"));
        f.setProvenance(
                rs.getString("PROVENANCE"));
        f.setDestination(
                rs.getString("DESTINATION"));
        f.setEscale(
                rs.getString("ESCALE"));
        f.setVolume(
                rs.getBigDecimal("VOLUME"));
        f.setVolume100(
                rs.getBigDecimal("VOLUME100"));
        f.setNomclt(
                rs.getString("NOMCLT"));
        f.setAdrclt(
                rs.getString("ADRCLT"));
        f.setNmsttclt(
                rs.getString("NMSTTCLT"));
        f.setTelclt(
                rs.getString("TELCLT"));
        f.setNif(rs.getString("NIF"));
        f.setRc(rs.getString("RC"));
        f.setDttp(rs.getDate("DTTP"));
        f.setTp(rs.getString("TP"));
        f.setDtquit(rs.getDate("DTQUIT"));
        f.setQuit(rs.getString("QUIT"));
        f.setIdplacement(
                rs.getString("IDPLACEMENT"));
        f.setEstproformaescale(
                rs.getInt("ESTPROFORMAESCALE"));
        f.setConnexe(
                rs.getString("CONNEXE"));
        f.setEstSup2021(
                rs.getInt("EST_SUP_2021"));

        return f;
    }

    // =========================================================
    // MAPPING DETAIL
    // =========================================================

    private FactureClientLigneDTO mapFactureClientDetails(
            ResultSet rs)
            throws SQLException {

        FactureClientLigneDTO d = new FactureClientLigneDTO();

        d.setId(rs.getString("ID"));
        d.setIdmere(rs.getString("IDMERE"));
        d.setDesignation(
                rs.getString("DESIGNATION"));
        d.setQuantite(
                rs.getBigDecimal("QUANTITE"));
        d.setPu(
                rs.getBigDecimal("PU"));
        d.setCompte(
                rs.getString("COMPTE"));
        d.setIdproduit(
                rs.getString("IDPRODUIT"));
        d.setDevise(
                rs.getString("DEVISE"));
        d.setTaux(
                rs.getBigDecimal("TAUX"));
        d.setIdactivite(
                rs.getString("IDACTIVITE"));
        d.setTva(
                rs.getBigDecimal("TVA"));
        d.setDatefact(
                rs.getDate("DATEFACT"));
        d.setRubrique(
                rs.getString("RUBRIQUE"));
        d.setMois(
                rs.getInt("MOIS"));
        d.setAnnee(
                rs.getInt("ANNEE"));
        d.setHeuredebut(
                rs.getString("HEUREDEBUT"));
        d.setHeurefin(
                rs.getString("HEUREFIN"));
        d.setReduction(
                rs.getBigDecimal("REDUCTION"));
        d.setMajoration(
                rs.getBigDecimal("MAJORATION"));
        d.setTest(
                rs.getBigDecimal("TEST"));
        d.setRang(
                rs.getInt("RANG"));
        d.setDuree(
                rs.getBigDecimal("DUREE"));
        d.setDaty(
                rs.getDate("DATY"));
        d.setEstproformaescale(
                rs.getInt("ESTPROFORMAESCALE"));

        return d;
    }

}