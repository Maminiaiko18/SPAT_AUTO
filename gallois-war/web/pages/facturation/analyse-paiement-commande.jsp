
<%@page import="mg.spat.BonCommande"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>

<%@ page import="affichage.*" %>
<%@page import="lc.Direction"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {
        BonCommande mvt = new BonCommande();
        mvt.setNomTable("v_analyse_paiement_commande");

        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String fin = String.valueOf(utilitaire.Utilitaire.getNombreJourMois(mois, an));

        String listeCrt[] = { "categorie"};
        String libEntete[] = { "categorie", "quantite", "montanttotal"};
        String listeInt[] = {""};
        String[] pourcentage = {""};
        String colDefaut[] = { "categorie"};
        String somDefaut[] = {"quantite","montanttotal"};

        PageRechercheGroupe pr = new PageRechercheGroupe(mvt, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 3, 1);
       
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("facturation/analyse-paiement-commande.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse bon de commande</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facturation/analyse-paiement-commande.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            /*String libEnteteAffiche[] = {"id", "Source", "Fournisseur", "Désignation", "Devise facture", "Numéro Compte", "Daty", "Organe demandeur", "Mttc", "Mtht", "Taxe", "Mtavoir", "Payé", "Reste", "Nombre par groupe"};

            pr.getTableau().setLibelleAffiche(libEnteteAffiche);*/
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
