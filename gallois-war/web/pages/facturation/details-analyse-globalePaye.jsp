<%-- 
    Document   : details-analyse-conventionnelMtavoir
    Created on : 9 déc. 2019, 15:05:03
    Author     : Antsa
--%>
<%@page import="mg.spat.FactureAnalyse"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    try {
        FactureAnalyse fact = new FactureAnalyse();
        String nomTable = "analyseglobalefacture";
        if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0) {
            nomTable = request.getParameter("table");
        }
        fact.setNomTable(nomTable);

        String listeCrt[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "categorie_client", "daty", "client", "numCompte"};
        String libEntete[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "categorie_client", "daty", "client", "numCompte", "designation", "devfact", "paye"};
        String listeInt[] = {"daty"};

        PageRecherche pr = new PageRecherche(fact, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        //PageRecherche pr = new PageRecherche(billetage, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
    
        pr.setApres("facturation/details-analyse-globalePaye.jsp");
        String[] colSomme = {"paye"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Détails analyse globale Payé</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facturation/details-analyse-globalePaye.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
                              <div class="col-md-4">
                    table : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("analyseglobalefacture") == 0) {%>    
                        <option value="analyseglobalefacture" selected>Tous</option>
                        <% } else { %>
                        <option value="analyseglobalefacture" >Tous</option>
                        <% } %>
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("ANALYSEGLOBALEAUCOMPTANT") == 0) {%>    
                        <option value="ANALYSEGLOBALEAUCOMPTANT" selected>Au comptant</option>
                        <% } else { %>
                        <option value="ANALYSEGLOBALEAUCOMPTANT" >Au comptant</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("analysefactureacredit") == 0) {%>    
                        <option value="analysefactureacredit" selected>A crédit</option>
                        <% } else { %>
                        <option value="analysefactureacredit" >A crédit</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("analysefactureproformat") == 0) {%>
                        <option value="analysefactureproformat" selected>Pro format</option>
                        <% }
                            { %>
                        <option value="analysefactureproformat" >Pro format</option>
                        <% }%>
                    </select>
                </div>
            </div>
        </form>
        <%
            //String lienTableau[] = {pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp",pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp"};
            String lienTableau[] = {pr.getLien() + "?but=facturation/analyse-globale.jsp"};
            String colonneLien[] = {"nmfact"};
//String colonneLien[] = {"gain"};
            //System.out.println("ITOOO "+pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp");
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "categorie_client", "daty", "client", "numCompte", "designation", "devfact", "paye"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %> 
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>