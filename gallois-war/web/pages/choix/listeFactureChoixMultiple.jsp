<%-- 
    Document   : listeFactureChoixMultiple
    Created on : 16 janv. 2021, 00:15:00
    Author     : Lenovo
--%>

<%@page import="facturefournisseur.EtatFactureMontantDaty"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
  String champReturn = request.getParameter("champReturn");
    EtatFactureMontantDaty factmontant = new EtatFactureMontantDaty();
    factmontant.setNomTable("EtatFactureMontantDaty");
    String listeCrt[] = {"id","nomfournisseur","designation"};
    String listeInt[] = {};
    String libEntete[] = {"id","nomfournisseur","designation","montantTTC","montantPaye","reste"};
    PageRechercheChoix pr = new PageRechercheChoix(factmontant, request, listeCrt, listeInt, 3, libEntete,libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    
  pr.getFormu().getChamp("nomfournisseur").setLibelle("fournisseur");
    
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeFactureChoixMultiple.jsp");
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
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Choix Facture</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choixMultiple/apresChoixMultiple.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <%
                        String libEnteteAff[] = {"id","fournisseur","designation","montant TTC","montant payé","reste à payer"};
                        pr.getTableau().setLibeEntete(libEnteteAff);
                        out.println(pr.getTableau().getHtmlWithMultipleCheckbox()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
