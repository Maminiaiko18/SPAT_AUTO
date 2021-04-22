<%-- 
    Document   : details-analyse-conventionnelMtavoir
    Created on : 9 déc. 2019, 15:05:03
    Author     : Antsa
--%>

<%@page import="mg.spat.placement.PlacementLibComplet"%>
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
        PlacementLibComplet journal = new PlacementLibComplet();

        String listeCrt[] = {"id", "date_placement", "date_echeance", "valentite", "valbanque", "numero"};
        String listeInt[] = {"etat", "date_placement", "date_echeance"};
        String libEntete[] = {"id", "date_placement", "date_echeance", "valentite", "valbanque", "numero","montant"};
        
        PageRecherche pr = new PageRecherche(journal, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        //PageRecherche pr = new PageRecherche(billetage, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("placement/analyse-placement.jsp");
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
        <h1>Détails analyse placement Montant</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=placement/analyse-placement.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            //String lienTableau[] = {pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp",pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp"};
            String lienTableau[] = {pr.getLien() + "?but=placement/analyse-placement.jsp"};
            String colonneLien[] = {"nmfact"};
//String colonneLien[] = {"gain"};
            //System.out.println("ITOOO "+pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp");
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "date_placement", "date_echeance", "valentite", "valbanque", "numero","montant"};
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