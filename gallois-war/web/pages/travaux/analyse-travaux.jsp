
<%@page import="mg.spat.TravauxTiersLibComplet"%>
<%@page import="mg.spat.Travaux"%>
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
        TravauxTiersLibComplet trv = new TravauxTiersLibComplet();
        trv.setNomTable("TRAVAUX_TIERSLIBCOMPLET");

        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String[] fin = utilitaire.Utilitaire.getBorneDatyMoisAnnee(mois, an);

        String listeCrt[] = {"id", "nom", "datedebut", "datefin", "nomtiers", "typetiers"};
        // String libEntete[] = {"nom","datedebut","datefin","montant", "avancement","description","etat","descetypetravaux"};
        String listeInt[] = {""};
        String[] pourcentage = {""};
        String colDefaut[] = {"id", "nom", "description", "datedebut", "datefin", "descetypetravaux", "descriptiontravauxtiers", "nomtiers", "descriptiontiers", "nif", "stat", "contact", "responsable", "adressetiers", "typetiers"};
        String somDefaut[] = {"montanttravauxtiers", "montant", "avancement"};

        PageRechercheGroupe pr = new PageRechercheGroupe(trv, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 18, 2);
        pr.setOrdre("order by datedebut desc ");
        pr.getFormu().getChamp("datedebut").setLibelle("Date travaux  min");
        pr.getFormu().getChamp("datefin").setLibelle("Date travaux  max");
        pr.getFormu().getChamp("nomtiers").setLibelle("Nom Tiers");
        pr.getFormu().getChamp("typetiers").setLibelle("Type Tiers");

        pr.getFormu().getChamp("datedebut").setDefaut(fin[0]);
        pr.getFormu().getChamp("datefin").setDefaut(fin[1]);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("travaux/analyse-travaux.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse travaux</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="travaux/analyse-travaux.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Nom", "Description", "Date Debut", "Date Fin", "Type Travaux", "Travaux Tiers", "Nom Tiers", "Description Tiers", "Nif", "Stat", "Contact", "Responsable", "Adresse Tiers", "Type Tiers", "Montant Travaux Tiers", "Montant", "Avancement"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
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
