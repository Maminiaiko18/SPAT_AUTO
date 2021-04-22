<%-- 
    Document   : details-analyse-conventionnelMtavoir
    Created on : 9 déc. 2019, 15:05:03
    Author     : Antsa
--%>
<%@page import="mg.spat.StatistiqueActivite"%>
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
        StatistiqueActivite stat = new StatistiqueActivite();
        stat.setNomTable("STAT_ACTIVITE_LIB");
        String listeCrt[] = {"id", "idclient", "rubrique", "daty"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "idclient", "rubrique", "daty", "cumul"};

        PageRecherche pr = new PageRecherche(stat, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        //PageRecherche pr = new PageRecherche(billetage, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("daty1").setLibelle("Date debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date fin");
        pr.getFormu().getChamp("idclient").setLibelle("Client");
        pr.setApres("capitainerie/statistique-activite/analyse-statistique-activite.jsp");
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
        <h1>Détails analyse statistique activité Cumul</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/statistique-activite/analyse-statistique-activite.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            //String lienTableau[] = {pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp",pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp"};
            String lienTableau[] = {pr.getLien() + "?but=capitainerie/statistique-activite/analyse-statistique-activite.jsp"};
            String colonneLien[] = {"nmfact"};
//String colonneLien[] = {"gain"};
            //System.out.println("ITOOO "+pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp");
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "idclient", "rubrique", "daty", "cumul"};
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