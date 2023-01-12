<%-- 
    Document   : client-quit-liste
    Created on : 31 oct. 2022, 12:14:22
    Author     : NAEPHA
--%>

<%@page import="facture.FactureClient"%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.tr.Traite"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        FactureClient base = new FactureClient();
        base.setNomTable("FCTRAITE_CPLT");

        String listeCrt[] = {"idTraite"};
        String listeInt[] = {};
        String libEntete[] = {"idfc", "factureclientlib", "tiers", "daty", "montant", "etat"};

        PageRecherche pr = new PageRecherche(base, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("idtraite").setLibelle("Traite");

        pr.setApres("facture/inc/fftraite-liste.jsp");

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.liste.submit();
    }
</script>
    <section class="content-header">
        <h1>Liste de Facture Client</h1>
    </section>
    <section class="content">
        <%
            String libelleAffiche[] = {"Id Facture", "Facture client", "Tiers", "Date", "Montant", "Etat"};
            String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
            String colonneLien[] = {"idfc"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            pr.getTableau().setLibelleAffiche(libelleAffiche);
            out.println(pr.getTableau().getHtml());
        %>
    </section>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>

