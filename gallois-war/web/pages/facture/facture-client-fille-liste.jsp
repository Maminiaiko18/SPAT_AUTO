<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="facture.FactureClientDetails"%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        FactureClientDetails cht = new FactureClientDetails();
        cht.setNomTable("FACT_CLT_FILL_LIB_REST_TAXE");
        String libEntete[] = {"id", "idmere", "designation", "pu", "quantite", "devise", "compte", "taux", "montanttaux", "tva", "montantTva", "montantHTEuro", "montantTVAEuro", "activitelib", "heureDebut", "heureFin", "reduction", "majoration"};
        String listeCrt[] = {"idmere", "compte", "mois", "annee"};
        String listeInt[] = {"mois", "annee"};

        PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/facture-client-fille-liste.jsp");

        pr.getFormu().getChamp("mois1").setLibelle("mois debut");
        pr.getFormu().getChamp("mois2").setLibelle("mois fin");
        
        pr.getFormu().getChamp("annee1").setLibelle("annee debut");
        pr.getFormu().getChamp("annee2").setLibelle("annee fin");

        String[] colSomme = {"montant"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste facture client details</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/facture-client-fille-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
            String colonneLien[] = {"idmere"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
                out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "idmere", "designation", "pu", "quantité", "devise", "compte", "taux", "montant", "tva", "montant Tva", "HT Euro", "TVA Euro", "Activite", "Heure début", "Heure fin", "RED.%", "MAJ.%"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
