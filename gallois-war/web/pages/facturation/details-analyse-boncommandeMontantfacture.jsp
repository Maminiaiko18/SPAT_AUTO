<%-- 
    Document   : details-analyse-conventionnelMttc
    Created on : 6 déc. 2019, 14:24:56
    Author     : john
--%>

<%@page import="mg.spat.BonCommande"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {
        BonCommande mvt = new BonCommande();
        mvt.setNomTable("v_analyse_bon_commande");

        String listeCrt[] = {"boncommande", "categorie"};
        String libEntete[] ={"boncommande", "categorie", "quantite","montantfacture"};
        String listeInt[] = {""};

        PageRecherche pr = new PageRecherche(mvt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        //PageRecherche pr = new PageRecherche(billetage, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("facturation/details-analyse-boncommandeMontantfacture.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Détails analyse bon commande montant facturé</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facturation/details-analyse-boncommandeMontantfacture.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            //String lienTableau[] = {pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp",pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp"};
            String lienTableau[] = {pr.getLien() + "?but=facturation/analyse-bon-commande.jsp"};
            String colonneLien[] = {"boncommande"};
//String colonneLien[] = {"gain"};
            //System.out.println("ITOOO "+pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp");
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"boncommande", "categorie", "quantite","montantfacture"};
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
