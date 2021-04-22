<%-- 
    Document   : prevision-statistique-activite-liste
    Created on : 30 nov. 2019, 17:13:59
    Author     : Antsa
--%>

<%@page import="mg.spat.PrevisionStatistiqueActivite"%>
<%@page import="affichage.PageRecherche"%>
<% 
    PrevisionStatistiqueActivite previ = new PrevisionStatistiqueActivite();
    previ.setNomTable("prevision_stat_activite_lib");
    String listeCrt[] = {"id","idclient","rubrique","cumul","daty"};
    String listeInt[] = {"cumul","daty"};
    String libEntete[] = {"id","idclient","rubrique","cumul","daty"};
    PageRecherche pr = new PageRecherche(previ, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("idclient").setLibelle("Client");
    pr.getFormu().getChamp("cumul1").setLibelle("Nombre min");
    pr.getFormu().getChamp("cumul2").setLibelle("Nombre max");
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.setApres("capitainerie/statistique-activite/prevision-statistique-activite-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeprevisionstatactivite.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Prévision Statistique Activité</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/statistique-activite/prevision-statistique-activite-liste.jsp" method="post" name="listeprevisionstatactivite" id="listeprevisionstatactivite">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capitainerie/statistique-activite/prevision-statistique-activite-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","client","rubrique","nombre","date"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
