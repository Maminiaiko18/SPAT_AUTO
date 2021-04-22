<%-- 
    Document   : analyse-personnel
    Created on : 19 nov. 2019, 17:56:59
    Author     : pro
--%>

<%@page import="mg.spat.AnalysePersonnel"%>
<%@page import="mg.spat.FactureAnalyse"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="lc.Direction"%>

<%
    try {
        AnalysePersonnel analysePersonnel = new AnalysePersonnel();
        analysePersonnel.setNomTable("analysePersonnelUnion");
        String listeCrt[] = {"sa_compteurnumero", "nom", "prenom", "emploioccupe", "categorie","sexe","type"};
        String listeInt[] = {""};
        String[] pourcentage = {};
        String colDefaut[] = {"nom", "prenom", "sexe", "emploioccupe", "categorie","type"};
        String somDefaut[] = {"effectif"};

        String colToHide[] = {};

        PageRechercheGroupe pr = new PageRechercheGroupe(analysePersonnel, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 5, 0);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("sa_compteurnumero").setLibelle("Numero compteur");
        pr.getFormu().getChamp("emploioccupe").setLibelle("Emplois Occup&eacute;");
        pr.setApres("rh/analyse-personnel.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyses ressources humaines</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="rh/analyse-personnel.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            pr.getTableau().setColonneCacher(colToHide);
            pr.getTableauRecap().setColonneCacher(colToHide);
            out.println(pr.getTableauRecap().getHtml());

        %>
        <br>
        <%            
 /* String lienTableau[] = {pr.getLien() + "?but=rh/details-analyse-personnelValeurCumul.jsp"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(lien);*/
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