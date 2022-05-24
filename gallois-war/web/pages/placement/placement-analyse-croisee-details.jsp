<%@page import="mg.spat.placement.Placement"%>
<%@page import="affichage.PageRecherche"%>

<% 
    Placement liaisonPlacement = new Placement();
    liaisonPlacement.setNomTable("PLACEMENT_ANALYSE");
    String listeCrt[] = {"anneeRembousement","moisRembousement","banque"};
    String listeInt[] = {"anneeRembousement","moisRembousement"};
    String libEntete[] = { "banque","moisPlacementlib","anneePlacement","montant","moisRembousementlib","anneeRembousement","interet_recevoir","interetNet"};
    PageRecherche pr = new PageRecherche(liaisonPlacement, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("placement/placement-analyse-croisee-details.jsp");
    pr.getFormu().getChamp("anneeRembousement1").setLibelle("Annee Remboursement min");
    pr.getFormu().getChamp("anneeRembousement2").setLibelle("Annee Remboursement max");
    pr.getFormu().getChamp("moisRembousement1").setLibelle("Mois Remboursement min");
    pr.getFormu().getChamp("moisRembousement2").setLibelle("Mois Remboursement max");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse placement</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=placement/placement-analyse-croisee-details.jsp" method="post" name="listeliaisonplacement" id="listeliaisonplacement">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Banque", "Mois placement", "Annee placement","Montant","Mois remboursement", "Annee remboursement", "Interet recevoir", "Interet net"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

