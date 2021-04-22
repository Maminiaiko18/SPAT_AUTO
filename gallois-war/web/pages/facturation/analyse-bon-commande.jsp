
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
        mvt.setNomTable("v_analyse_bon_commande_analyse");

        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String fin = String.valueOf(utilitaire.Utilitaire.getNombreJourMois(mois, an));

        String listeCrt[] = {"boncommande", "categorie"};
        String libEntete[] = {"boncommande", "categorie", "quantite", "facture", "nonfacture", "paye", "nonpaye"};
        String listeInt[] = {""};
        String[] pourcentage = {""};
        String colDefaut[] = {"boncommande", "categorie", "quantite"};
        String somDefaut[] = {"montanttotal", "montantfacture", "montantnonfacture", "montantpaye", "montantnonpaye"};

        PageRechercheGroupe pr = new PageRechercheGroupe(mvt, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 8, 2);

        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("facturation/analyse-bon-commande.jsp");
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
        <form action="<%=pr.getLien()%>?but=facturation/analyse-bon-commande.jsp" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="facturation/analyse-bon-commande.jsp" />
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
            String lienTableau[]
                    = {pr.getLien() + "?but=facturation/details-analyse-boncommandeMontanttotal.jsp",
                        pr.getLien() + "?but=facturation/details-analyse-boncommandeMontantfacture.jsp",
                        pr.getLien() + "?but=facturation/details-analyse-boncommandeMontantnonfacture.jsp",
                        pr.getLien() + "?but=facturation/details-analyse-boncommandeMontantpaye.jsp",
                        pr.getLien() + "?but=facturation/details-analyse-boncommandeMontantnonpaye.jsp"
                    };
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(somDefaut);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
            out.println(pr.getInsertLienModal());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
