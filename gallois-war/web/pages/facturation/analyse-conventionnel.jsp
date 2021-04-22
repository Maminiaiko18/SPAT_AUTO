<%-- 
    Document   : analyse-conventionnel
    Created on : 8 nov. 2019, 10:52:34
    Author     : john
--%>


<%@page import="mg.spat.FactureAnalyse"%>
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
        FactureAnalyse mvt = new FactureAnalyse();
        mvt.setNomTable("factureconventionnel_analyse");

        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String fin = String.valueOf(utilitaire.Utilitaire.getNombreJourMois(mois, an));
        
        String listeCrt[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "categorie_client", "daty", "client", "numCompte"};
        String libEntete[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "categorie_client", "daty", "client", "numCompte", "designation", "devfact", "mttc", "mtht", "taxe", "mtdevise", "mtavoir", "paye", "reste"};
        String listeInt[] = {"daty"};
        String[] pourcentage = {""};
        String colDefaut[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "client", "categorie_client", "designation", "devfact", "numCompte", "daty"};
        String somDefaut[] = {"mttc", "mtht", "mtavoir", "paye", "reste"};

        PageRechercheGroupe pr = new PageRechercheGroupe(mvt, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 14, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("nmfact").setLibelle("Numero facture");
        pr.getFormu().getChamp("categorie_facture").setLibelle("Categorie facture");
        pr.getFormu().getChamp("categorie_client").setLibelle("Categorie client");
        pr.getFormu().getChamp("daty1").setLibelle("Date debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date fin");
        
        
        pr.getFormu().getChamp("daty1").setDefaut("01/" + mois + "/" + an);
        pr.getFormu().getChamp("daty2").setDefaut(fin + "/" + mois + "/" + an);
        
        pr.getFormu().getChamp("numcompte").setLibelle("Numero de compte");
        pr.setApres("facturation/analyse-conventionnel.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse conventionnelle</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="facturation/analyse-conventionnel.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            //String colonneLien[] = {"gain"};
              String lienTableau[] = {pr.getLien()+
                       "?but=facturation/details-analyse-conventionnelMttc.jsp",
                pr.getLien() + "?but=facturation/details-analyse-conventionnelMtht.jsp",
                pr.getLien() + "?but=facturation/details-analyse-conventionnelMtavoir.jsp",
                pr.getLien() + "?but=facturation/details-analyse-conventionnelPaye.jsp",
                pr.getLien() + "?but=facturation/details-analyse-conventionnelReste.jsp"};
//String colonneLien[] = {"gain"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(somDefaut);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%

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
