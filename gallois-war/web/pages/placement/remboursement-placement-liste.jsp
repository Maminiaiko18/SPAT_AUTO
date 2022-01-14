<%-- 
    Document   : remboursement-placement-liste
    Created on : 14 janv. 2022, 15:13:13
    Author     : andri
--%>

<%@page import="mg.spat.RemboursementPlacement"%>
<%@page import="affichage.PageRecherche"%>

<% 
    RemboursementPlacement remboursementPlacement = new RemboursementPlacement();
    remboursementPlacement.setNomTable("remboursementplacementlib");
    String listeCrt[] = {"id","daty","idplacement","entite","banque"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","daty","idplacement","entite","banque"};
    PageRecherche pr = new PageRecherche(remboursementPlacement, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("entite").setLibelle("Entite");
    pr.getFormu().getChamp("banque").setLibelle("Banque");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("placement/remboursement-placement-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste liaison placement</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=placement/remboursement-placement-liste.jsp" method="post" name="remboursementPlacement" id="listeremboursementPlacement">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=placement"
                    + "/remboursement-placement-fiche.jsp",pr.getLien() + "?but=placement"
                    + "/placement-fiche.jsp"};
            String colonneLien[] = {"id","Idplacement"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Date","Placement","Entite","Banque"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

