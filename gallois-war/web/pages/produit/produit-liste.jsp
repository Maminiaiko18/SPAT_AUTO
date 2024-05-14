<%-- 
    Document   : produit-liste.jsp
    Created on : 7 d�c. 2020, 10:41:01
    Author     : Lenovo
--%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.allosakafo.produits.Produits" %>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>
<%
    try{
        Produits prdt = new Produits();
        prdt.setNomTable("ProduitLibComplet");
    	if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            prdt.setNomTable(request.getParameter("etat"));
        }
        
        String libEntete[] = {"id","nom","typeproduit","prixl"};
        String listeCrt[] = {"id","nom","typeproduit","prixl"};
        String listeInt[] = {""};
        
        PageRecherche pr = new PageRecherche(prdt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("produit/produit-liste.jsp");
        Liste[] listes = new Liste[1];
        TypeObjet produitCat = new TypeObjet();
        produitCat.setNomTable("PRODUITCATEGORIE");
        listes[0] = new Liste("typeproduit", produitCat, "desce", "desce");
        pr.getFormu().changerEnChamp(listes);
        pr.getFormu().getChamp("typeproduit").setLibelle("Type produit");

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
            String libEnteteAffiche[] = {"id","nom","type produit","prix"};
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