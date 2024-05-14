
<%@page import="mg.allosakafo.produits.Produits"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>

<%
    String champReturn = request.getParameter("champReturn");
    Produits produit = new Produits();
    produit.setNomTable("ProduitLibComplet");
    //produit.setNomTable("tiers_prestataire");
    String libEntete[] = {"id","nom","typeproduit","prixl"};
    String listeCrt[] = {"id","nom","typeproduit","prixl"};
    String listeInt[] = {""};
    PageRechercheChoix pr = new PageRechercheChoix(produit, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("produitChoix.jsp");

    Liste[] listes = new Liste[1];
    TypeObjet produitCat = new TypeObjet();
    produitCat.setNomTable("PRODUITCATEGORIE");
    listes[0] = new Liste("typeproduit", produitCat, "desce", "desce");
    pr.getFormu().changerEnChamp(listes);
    pr.getFormu().getChamp("typeproduit").setLibelle("Type produit");
    pr.setChampReturn(champReturn);
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>SPAT</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1>Choix Produit</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    
                    <% 
                         String libEnteteAffiche[] = {"id", "nom", "type produit","prixl"};
                        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
