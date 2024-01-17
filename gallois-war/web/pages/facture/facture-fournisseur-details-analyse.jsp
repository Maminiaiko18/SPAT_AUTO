
<%@page import="facture.FactureFournisseurDetails"%>
<%@page import="java.sql.Date"%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
    try {
        FactureFournisseurDetails base = new FactureFournisseurDetails();
        base.setNomTable("FACTFOURN_FILL_LIB_REST_TAXE");


        String listeCrt[] = {"id", "idmere", "designation", "devise", "compte", "daty"};
        String listeInt[] = {"daty"};
        String colDefaut[] = {"id", "idmere", "designation", "devise", "compte","daty"};
        String[] pourcentage = {};
        String somDefaut[] = {"quantite", "pu", "montant", "montanttva", "montantreduction", "montantTTC"};
        
        
        PageRechercheGroupe pr = new PageRechercheGroupe(base, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, somDefaut.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/facture-fournisseur-details-analyse.jsp");
        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
        
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Factures fournisseurs D&eacute;tails</h1>
    </section>
    <section class="content">
        <form action='<%= pr.getLien() + "?but="+pr.getApres() %>' method="post" name="analyse" id="analyse">
            <% out.println(pr.getFormu().getHtmlEnsemble()); %>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <% out.println(pr.getTableauRecap().getHtml()); %>
        <br>
        <%
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
