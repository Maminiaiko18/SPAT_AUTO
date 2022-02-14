
<%@page import="java.sql.Date"%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
    try {
        FactureFournisseur base = new FactureFournisseur();
        base.setNomTable("factfourn_msum_libv");


        String listeCrt[] = {"id","daty","tierslib","designation","date_echeance","escale","categorielib"};
        String listeInt[] = {"daty","date_echeance"};
        String colDefaut[] = {"id","daty","tierslib","designation","categorielib","tva","date_echeance"};
        String[] pourcentage = {};
        String somDefaut[] = {"montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
        
        
        PageRechercheGroupe pr = new PageRechercheGroupe(base, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 18, somDefaut.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/facture-fournisseur-analyse.jsp");
        
        pr.getFormu().getChamp("daty1").setLibelle("Date debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date fin");
        Date finMois = utilitaire.Utilitaire.getLastDayOfDateSQL(utilitaire.Utilitaire.dateDuJourSql());
        Date debutMois = utilitaire.Utilitaire.dateDuJourSql();
        debutMois.setDate(1);
        String awhere = "";
        if(request.getParameter("daty1") == null || request.getParameter("daty1").isEmpty()){
            pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.stringToDateJ("dd/MM/yyyy", debutMois));
            awhere = awhere + String.format(" and daty>= '%s'", Utilitaire.stringToDateJ("dd/MM/yyyy", debutMois));
            pr.setAWhere(awhere);
        }
        if(request.getParameter("daty2") == null || request.getParameter("daty2").isEmpty()){
            pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.stringToDateJ("dd/MM/yyyy", finMois));
            awhere = awhere + String.format(" and daty<= '%s'", Utilitaire.stringToDateJ("dd/MM/yyyy", finMois));
            pr.setAWhere(awhere);
        }                
        
        
        pr.getFormu().getChamp("tierslib").setLibelle("Client");
        pr.getFormu().getChamp("date_echeance1").setLibelle("Date echeance min");
        pr.getFormu().getChamp("date_echeance2").setLibelle("Date echeance max");
        pr.getFormu().getChamp("categorielib").setLibelle("Categorie");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Factures fournisseurs</h1>
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
