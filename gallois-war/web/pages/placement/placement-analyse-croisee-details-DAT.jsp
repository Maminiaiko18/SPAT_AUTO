<%@page import="mg.spat.placement.Placement"%>
<%@page import="mg.spat.Report"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
 
        Placement placement = new Placement();
        placement.setNomTable("PLACEMENT_ANALYSE_DAT");
        String listeCrt[] = {"id", "designation", "banque", "anneePlacement"};
        String listeInt[] = {""};
        String libEntete[] = {"id", "designation", "banque", "anneePlacement", "montant","interet_recevoir","interet_net"};
        PageRecherche pr = new PageRecherche(placement, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("anneePlacement").setLibelle("Ann&eacute;e placement");
        
    
        pr.setApres("placement/placement-analyse-croisee-details-DAT.jsp");
        String[] colSomme = {"montant","interet_recevoir","interet_net"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des placements</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=placement/placement-analyse-croisee-details-DAT.jsp" method="post" name="listeplacement" id="listeplacement">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
               <div class="row col-md-12">
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
//            String lienTableau[] = {pr.getLien() + "?but=placement/placement-fiche.jsp"};
//            String colonneLien[] = {"id"};
//            pr.getTableau().setLien(lienTableau);
//            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Designation", "Banque", "Ann&eacute;e placement", "Montant","Interet recevoir","Interet net"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>

