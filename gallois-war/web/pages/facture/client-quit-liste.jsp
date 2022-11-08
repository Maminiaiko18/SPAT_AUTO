<%-- 
    Document   : client-quit-liste
    Created on : 31 oct. 2022, 12:14:22
    Author     : NAEPHA
--%>

<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.ClientQuit"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        ClientQuit base = new ClientQuit();
        base.setNomTable("client_quitlib");

        String listeCrt[] = {"id", "quit", "dtquit"};
        String listeInt[] = {"dtquit"};
        String libEntete[] = {"id", "nomclt", "quit", "dtquit"};

        PageRecherche pr = new PageRecherche(base, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        pr.getFormu().getChamp("id").setLibelle("ID");
        pr.getFormu().getChamp("quit").setLibelle("Quit");
        pr.getFormu().getChamp("dtquit1").setLibelle("Date Min");
        pr.getFormu().getChamp("dtquit2").setLibelle("Date Max");
        
        pr.setApres("facture/client-quit-liste.jsp");
        
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
        <h1>Liste des clients Quit</h1>
    </section>
    <section class="content">
        <form action='<%=pr.getLien() + "?but=facture/client-quit-liste.jsp" %>' method="post" name="liste" id="liste">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
               <%
            String lienTableau[] = {pr.getLien() + "?but=facture/client-quit-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <%
            String libelleAffiche[] = {"ID", "Nom", "Quit", "Date"};
            pr.getTableau().setLibelleAffiche(libelleAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>

