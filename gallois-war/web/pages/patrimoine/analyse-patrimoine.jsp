<%-- 
    Document   : analyse-journal-de-caisse
    Created on : 2 déc. 2019, 08:22:05
    Author     : Antsa
--%>

<%@page import="mg.spat.PatrimoineAnalyse"%>
<%@page import="mg.spat.Patrimoine"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        PatrimoineAnalyse stat = new PatrimoineAnalyse();
        stat.setNomTable("PATRIMOINELIB_ANALYSE_SUP");
        String listeCrt[] = {"id", "idTypePatrimoine"};
        String listeInt[] = {""};
        String[] pourcentage = {""};
        String colDefaut[] = {"id", "idTypePatrimoine", "libelle", "description"};
        String somDefaut[] = {"montant","nombre","superficie","superficie_occupee","superficie_disponible"};
        String lien[] = {"montant"};
        PageRechercheGroupe pr = new PageRechercheGroupe(stat, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 5, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("patrimoine/analyse-patrimoine.jsp");
        pr.getFormu().getChamp("idTypePatrimoine").setLibelle(" Type Patrimoine");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse patrimoine</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="patrimoine/analyse-patrimoine.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            //String libEnteteAffiche[] = {"Description", "Montant","Nombre"};
            //pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            
            String lienTableau[] = {pr.getLien()
                + "?but=patrimoine/details-analyse-patrimoineMontant.jsp"};
//String colonneLien[] = {"gain"};
            //pr.getTableau().setLien(lienTableau);
           // pr.getTableau().setColonneLien(lien);
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