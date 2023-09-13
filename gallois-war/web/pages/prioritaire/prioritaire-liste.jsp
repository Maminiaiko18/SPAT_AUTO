
<%@page import="utilisateur.Prioritaire"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.allosakafo.produits.Produits" %>
<%
    try{
        Prioritaire prdt = new Prioritaire();
        prdt.setNomTable("prioritairelib");
    	if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            prdt.setNomTable(request.getParameter("etat"));
        }
        
        String libEntete[] = {"id","utilisateur","roles","etatlib", "ranglib"};
        String listeCrt[] = {"id","utilisateur","roles","etatlib","ranglib"};
        String listeInt[] = {""};
        
        PageRecherche pr = new PageRecherche(prdt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("prioritaire/prioritaire-liste.jsp");
            String[] colSomme = null;
            pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Prioritaire</h1>
    </section>
    <section class="content">
       <form action="<%=pr.getLien()%>?but=prioritaire/prioritaire-liste.jsp" method="post" name="incident" id="incident">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
       </form>
            <%  String lienTableau[] = {pr.getLien() + "?but=prioritaire/prioritaire-fiche.jsp"};
            String colonneLien[] = {"id"};
            String[] urlLienMultiple = {"id"};
            String[] urlLienAffiche = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);           
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] ={"id","utilisateur","roles","etat","rang"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%
    }
    catch(Exception e){
    e.printStackTrace();
}
            
%>