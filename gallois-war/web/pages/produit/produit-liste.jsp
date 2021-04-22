<%-- 
    Document   : produit-liste.jsp
    Created on : 7 déc. 2020, 10:41:01
    Author     : Lenovo
--%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.allosakafo.produits.Produits" %>
<%
    try{
        Produits prdt = new Produits();
    	if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            prdt.setNomTable(request.getParameter("etat"));
        }
        
        String libEntete[] = {"id","nom","prixl"};
        String listeCrt[] = {"id","nom","prixl"};
        String listeInt[] = {""};
        
        PageRecherche pr = new PageRecherche(prdt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("produit/produit-liste.jsp");
            String[] colSomme = null;
            pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Produit</h1>
    </section>
    <section class="content">
       <form action="<%=pr.getLien()%>?but=produit/produit-liste.jsp" method="post" name="incident" id="incident">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
       </form>
            <%  String lienTableau[] = {pr.getLien() + "?but=produit/produit-fiche.jsp"};
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
            String libEnteteAffiche[] = {"id","nom","prix"};
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