
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
    try {
        FactureClient base = new FactureClient();
        base.setNomTable("factureClientValide");


        String listeCrt[] = {"id","daty","tierslib","designation","date_echeance","escale","categorielib"};
        String listeInt[] = {"daty","date_echeance"};
        String colDefaut[] = {"id","daty","tierslib","escale","designation","categorielib","tva","date_echeance"};
        String[] pourcentage = {};
        String somDefaut[] = {"montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
        
        
        PageRechercheGroupe pr = new PageRechercheGroupe(base, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 18, somDefaut.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/factureclient-analyse.jsp");
        
        pr.getFormu().getChamp("daty1").setLibelle("Date debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date fin");
        pr.getFormu().getChamp("tierslib").setLibelle("Client");
        pr.getFormu().getChamp("date_echeance1").setLibelle("Date échéance min");
        pr.getFormu().getChamp("date_echeance2").setLibelle("Date échéance max");
        pr.getFormu().getChamp("categorielib").setLibelle("Catégorie");
        pr.creerObjetPagePourc();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse facture client</h1>
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
