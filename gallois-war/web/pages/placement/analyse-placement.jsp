<%-- 
    Document   : analyse-journal-de-caisse
    Created on : 2 déc. 2019, 08:22:05
    Author     : Antsa
--%>

<%@page import="mg.spat.placement.PlacementLibComplet"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        PlacementLibComplet journal = new PlacementLibComplet();
        journal.setNomTable("placementlibcomplet_analyse");
        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String[] fin = utilitaire.Utilitaire.getBorneDatyMoisAnnee(mois, an);

        String listeCrt[] = {"id", "date_placement", "date_echeance", "valentite", "valbanque", "numero"};
        String listeInt[] = {"etat", "date_placement", "date_echeance"};
        String[] pourcentage = {""};
        String colDefaut[] = {"id", "date_placement", "date_echeance", "valentite", "valbanque", "numero"};
        String somDefaut[] = {"duree", "interet_recevoir", "montant"};
        String lien[] = {"montant"};
        PageRechercheGroupe pr = new PageRechercheGroupe(journal, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 9, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("date_placement1").setLibelle("Date placement  min");
        pr.getFormu().getChamp("date_echeance1").setLibelle("Date échéance min");
        pr.getFormu().getChamp("date_placement2").setLibelle("Date placement  max");
        pr.getFormu().getChamp("date_echeance2").setLibelle("Date échéance max");

        pr.getFormu().getChamp("date_placement1").setDefaut(fin[0]);
        pr.getFormu().getChamp("date_echeance1").setDefaut(fin[0]);
        pr.getFormu().getChamp("date_placement2").setDefaut(fin[1]);
        pr.getFormu().getChamp("date_echeance2").setDefaut(fin[1]);

        pr.getFormu().getChamp("valentite").setLibelle("Nature");
        pr.getFormu().getChamp("valbanque").setLibelle("Entite");
        pr.setApres("placement/analyse-placement.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Placement</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="placement/analyse-placement.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Entite", "Banque", "Dur&eacute;e", "Interet recevoir", "Montant"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            String lienTableau[] = {
                pr.getLien() + "?but=placement/details-analyse-placementMontant.jsp"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(lien);
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