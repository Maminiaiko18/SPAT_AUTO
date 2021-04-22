<%-- 
    Document   : details-analyse-conventionnelMtavoir
    Created on : 9 déc. 2019, 15:05:03
    Author     : Antsa
--%>
<%@page import="mg.spat.FactureAnalyse"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    try {
        FactureAnalyse mvt = new FactureAnalyse();
        mvt.setNomTable("analysefactureconventionnel");
        String listeCrt[] = {"nmfact","client","designation","devfact","numCompte","categorie_facture","sous_categorie_facture","categorie_client","valCat","daty"};
        String libEntete[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "categorie_client", "daty", "client", "numCompte", "designation", "devfact", "mtavoir"};
        String listeInt[] = {"daty"};

        PageRecherche pr = new PageRecherche(mvt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        //PageRecherche pr = new PageRecherche(billetage, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        /*pr.getFormu().getChamp("nmfact").setLibelle("Numero facture");
        pr.getFormu().getChamp("categorie_facture").setLibelle("Categorie facture");
        pr.getFormu().getChamp("categorie_client").setLibelle("Categorie client");
        pr.getFormu().getChamp("daty1").setLibelle("Date debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date fin");

        pr.getFormu().getChamp("numcompte").setLibelle("Numero de compte");*/
        pr.setApres("facturation/analyse-conventionnel.jsp");
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
        <h1>Détails analyse conventionnel MtAvoir</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facturation/details-analyse-conventionnelMtavoir.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            //String lienTableau[] = {pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp",pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp"};
            String lienTableau[] = {pr.getLien() + "?but=facturation/details-analyse-conventionnelMtavoir.jsp"};
            String colonneLien[] = {"nmfact"};
//String colonneLien[] = {"gain"};
            //System.out.println("ITOOO "+pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp");
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "categorie_client", "daty", "client", "numCompte", "designation", "devfact", "mtavoir"};
            //                               "nmfact" , "categorie_facture","sous_categorie_facture","categorie_client","daty","client","numCompte","designation","devfact","mttc","mtht","taxe","mtdevise","mtavoir","paye","reste"
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