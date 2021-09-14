<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.EtatProvision"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        EtatProvision base = new EtatProvision();
        base.setNomTable("etat_provisionlib");

        String listeCrt[] = {"id","idFacture", "numpiece", "numProvision", "operation", "tierslib","idnavirelib","idmodelib","idbanquelib"};
        String listeInt[] = {};
        String libEntete[] = {"id","idFacture", "numpiece", "numProvision", "operation", "tierslib","idnavirelib","idmodelib","idbanquelib"};

        PageRecherche pr = new PageRecherche(base, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/etatprovision-liste.jsp");
        
        pr.getFormu().getChamp("id").setLibelle("Id");
        pr.getFormu().getChamp("idFacture").setLibelle("Facture");
        pr.getFormu().getChamp("tierslib").setLibelle("Client");
        pr.getFormu().getChamp("idnavirelib").setLibelle("Navire");
        pr.getFormu().getChamp("idmodelib").setLibelle("Mode");
        pr.getFormu().getChamp("idbanquelib").setLibelle("Banque");
        pr.getFormu().getChamp("numpiece").setLibelle("Numéro pièce");
        pr.getFormu().getChamp("numProvision").setLibelle("Numéro provision");
        pr.getFormu().getChamp("operation").setLibelle("Opération");
        
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.liste.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Etat de provision</h1>
    </section>
    <section class="content">
        <form action='<%=pr.getLien() + "?but=" + pr.getLien() %>' method="post" name="liste" id="liste">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <%
            String libelleAffiche[] = {"Id", "Facture", "Numéro pièce", "Numéro provision", "Opération",  "Client", "Navire", "Mode", "Banque"};
            pr.getTableau().setLibelleAffiche(libelleAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
