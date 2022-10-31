<%-- 
    Document   : client-tp-liste
    Created on : 31 oct. 2022, 10:41:30
    Author     : NAEPHA
--%>

<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.ClientTP"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        ClientTP base = new ClientTP();
        base.setNomTable("client_tplib");

        String listeCrt[] = {"cdclt", "tp", "dttp"};
        String listeInt[] = {"dttp"};
        String libEntete[] = {"cdclt", "nomclt", "tp", "dttp"};

        PageRecherche pr = new PageRecherche(base, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        pr.getFormu().getChamp("cdclt").setLibelle("ID");
        pr.getFormu().getChamp("tp").setLibelle("TP");
        pr.getFormu().getChamp("dttp1").setLibelle("Date Min");
        pr.getFormu().getChamp("dttp2").setLibelle("Date Max");
        
        pr.setApres("facture/client-tp-liste.jsp");
        
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
        <h1>Liste des clients TP</h1>
    </section>
    <section class="content">
        <form action='<%=pr.getLien() + "?but=facture/client-tp-liste.jsp" %>' method="post" name="liste" id="liste">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
               <%
            String lienTableau[] = {pr.getLien() + "?but=facture/client-tp-fiche.jsp"};
            String colonneLien[] = {"cdclt"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <%
            String libelleAffiche[] = {"ID", "Nom", "TP", "Date"};
            pr.getTableau().setLibelleAffiche(libelleAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>

