<%-- 
    Document   : liaison-placement-liste
    Created on : 22 nov. 2019, 15:03:33
    Author     : john
--%>

<%@page import="mg.spat.placement.Liaisonplacement"%>
<%@page import="affichage.PageRecherche"%>

<% 
    Liaisonplacement liaisonPlacement = new Liaisonplacement();
    liaisonPlacement.setNomTable("liaisonplacementlib");
    String listeCrt[] = {"id","identite","idbanque"};
    String listeInt[] = {};
    String libEntete[] = {"id","identite","idbanque"};
    PageRecherche pr = new PageRecherche(liaisonPlacement, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.getFormu().getChamp("idbanque").setLibelle("Banque");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("placement/liaison-placement-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste liaison placement</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=placement/liaisonplacement-liste.jsp" method="post" name="listeliaisonplacement" id="listeliaisonplacement">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=placement"
                    + "/liaison-placement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Identite","Banque"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

