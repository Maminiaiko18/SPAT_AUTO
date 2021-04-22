<%-- 
    Document   : liaisonDetailsBCProduit-liste.jsp
    Created on : 7 déc. 2020, 10:49:21
    Author     : Lenovo
--%>

<%@page import="affichage.PageRecherche"%>
<%@page import="mg.allosakafo.produits.LiaisonDetailsBCProduitLibelle" %>
<%
    LiaisonDetailsBCProduitLibelle lBCProduit = new LiaisonDetailsBCProduitLibelle();
    	if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            lBCProduit.setNomTable(request.getParameter("etat"));
        }
        
        String libEntete[] = {"id","fournisseur","daty","produit"};
        String listeCrt[] = {"id","fournisseur","daty","produit"};
        String listeInt[] = {"daty"};
        
        PageRecherche pr = new PageRecherche(lBCProduit, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("stock/bc/liaisonDetailsBCProduit-liste.jsp");
            String[] colSomme = null;
            pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Bon de Commande produit</h1>
    </section>
    <section class="content">
               <form action="<%=pr.getLien()%>?but=stock/bc/liaisonDetailsBCProduit-liste.jsp" method="post" name="incident" id="incident">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
       </form>
                   <%  String lienTableau[] = {pr.getLien() + "?but=stock/bc/liaisonDetailsBCProduit-fiche.jsp"};
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
            String libEnteteAffiche[] = {"id","fournisseur","date","produit"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
