
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
    try {
        FactureFournisseur base = new FactureFournisseur();
        base.setNomTable("BPvalide");


        String listeCrt[] = {"id","daty","tierslib","designation","date_echeance"};
        String listeInt[] = {"daty","date_echeance"};
        String colDefaut[] = {"id","daty","tierslib","designation","tva","date_echeance"};
        String[] pourcentage = {};
        String somDefaut[] = {"montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
        
        
        PageRechercheGroupe pr = new PageRechercheGroupe(base, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 18, somDefaut.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("treso/bon-provisoire-analyse-nouveau.jsp");
        
        pr.getFormu().getChamp("daty1").setLibelle("Date debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date fin");
        pr.getFormu().getChamp("tierslib").setLibelle("Client");
        pr.getFormu().getChamp("date_echeance1").setLibelle("Date echeance min");
        pr.getFormu().getChamp("date_echeance2").setLibelle("Date echeance max");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Bon Provisoire</h1>
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
