<%-- 
    Document   : analyse-effectif-syndicat
    Created on : 21 janv. 2020, 11:16:01
    Author     : rajao
--%>

<%@page import="mg.spat.relationhumaine.EffectifSyndicat"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="lc.Direction"%>

<%
    try {
        EffectifSyndicat effectifSyndicat = new EffectifSyndicat();
        effectifSyndicat.setNomTable("analyse_effectif_syndicat");
        String listeCrt[] = {"id","matriculesalarie","nom","prenom","genre","syndicat","postesyndicat"};
        String listeInt[] = {""};
        String[] pourcentage = {""};
        String colDefaut[] = {"id","matriculesalarie","nom","prenom","genre","syndicat","postesyndicat","datenaissance"};
        String somDefaut[] = {"nombre"};
        PageRechercheGroupe pr = new PageRechercheGroupe(effectifSyndicat, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 9, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("Matriculesalarie").setLibelle("Matricule Salarié");
        pr.getFormu().getChamp("Postesyndicat").setLibelle("Poste syndicat");
       
        pr.setApres("rh/analyse-effectif-syndicat.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyses effectif par syndicats</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="rh/analyse-effectif-syndicat.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
          
            out.println(pr.getTableauRecap().getHtml());

        %>
        <br>
        <%            /*String libEnteteAffiche[] = {"Emploi occupe", "Sexe", "Categorie", "Nombre","Valeur cumul"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);*/
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