
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.cnaps.configuration.Configuration"%>
<%
    Configuration sg = new Configuration();

    String listeCrt[] = {"id", "desce", "remarque", "daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id", "desce", "remarque", "daty", "valmin", "valmax"};
    
    PageRecherche pr = new PageRecherche(sg, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("configuration/configuration-liste.jsp");
    
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("desce").setLibelle("Description");
    
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Configuration</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=configuration/configuration-liste.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=configuration/configuration-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Description", "Remarque", "Date", "Min", "Max"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

