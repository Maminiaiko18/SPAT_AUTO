<%-- 
    Document   : formFormateurChoix
    Created on : 13 oct. 2015, 13:22:10
    Author     : user
--%>
<%@page import="facturefournisseur.FactureFournisseurLibelle"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>


<%
    String champReturn = request.getParameter("champReturn");
    FactureFournisseurLibelle e = new FactureFournisseurLibelle();
    String listeCrt[]={"id","fournisseur", "remarque","daty","exercice"};
    String listeInt[]={"daty","exercice"};
    String libEntete[]={"id","Daty","fournisseur", "designation","remarque", "exercice","montantttc"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 2, libEntete, 6);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("factureClientChoix.jsp");
    pr.setChampReturn(champReturn);
    pr.getFormu().getChamp("id").setLibelleAffiche("ID");
    pr.getFormu().getChamp("remarque").setLibelleAffiche("Chantier");
    pr.getFormu().getChamp("daty1").setLibelleAffiche("Date min");
    pr.getFormu().getChamp("daty2").setLibelleAffiche("Date Max");
    pr.getFormu().getChamp("exercice1").setLibelleAffiche("exercice min");
    pr.getFormu().getChamp("exercice2").setLibelleAffiche("exercice max");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Amadia</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1>Liste Facture clients</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="formateur" id="formateur">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
//                    String lienTableau[] = {pr.getLien() + "?but=employeur/employeur-fiche.jsp"};
//                    String colonneLien[] = {"id"};
                    String libelles[]={"id","Date","Fournisseur", "Designation","Chantier", "Exercice","Montant TTC"};
//		    pr.getTableau().setLien(lienTableau);
//                    pr.getTableau().setColonneLien(colonneLien);
                    pr.getTableau().setLibelleAffiche(libelles);
                    out.println(pr.getTableauRecap().getHtml());    
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
