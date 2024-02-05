<%-- 
    Document   : liaison-placement-liste
    Created on : 22 nov. 2019, 15:03:33
    Author     : john
--%>

<%@page import="mg.spat.placement.PlacementBanqueCaisse"%>
<%@page import="mg.spat.placement.Liaisonplacement"%>
<%@page import="affichage.PageRecherche"%>

<% 
    PlacementBanqueCaisse plb = new PlacementBanqueCaisse();
    plb.setNomTable("PLACEMENT_BANQUE_CAISSELIB");
    String listeCrt[] = {"id","banquelib","caisselib"};
    String listeInt[] = {};
    String libEntete[] = {"id","banquelib","caisselib"};
    PageRecherche pr = new PageRecherche(plb, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.getFormu().getChamp("banquelib").setLibelle("Banque");
    pr.getFormu().getChamp("caisselib").setLibelle("Caisse");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("placement/placement-banquecaisse-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste liaison caisse et banque</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=placement/placement-banquecaisse-liste.jsp" method="post" name="listeliaisonplacement" id="listeliaisonplacement">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=placement"
                    + "/placement-banquecaisse-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","banquelib","caisselib"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

