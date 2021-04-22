<%-- 
    Document   : code-etablissement-liste
    Created on : 22 janv. 2021, 14:51:12
    Author     : ACER
--%>

<%@page import="mg.cnaps.formation.CodeEtablissement"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        CodeEtablissement ce = new CodeEtablissement();
        ce.setNomTable("CODEETABLISSEMENT_LIB");
        String listeCrt[] = {"id", "val","desce","departement","service"};
        String listeInt[] = {};
        String libEntete[] = {"id", "val","desce","departement","service"};
        PageRecherche pr = new PageRecherche(ce, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("val").setLibelle("Désignation");
        pr.getFormu().getChamp("desce").setLibelle("Description");
        pr.getFormu().getChamp("departement").setLibelle("Département");

        pr.setApres("fin/code-etablissement-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des codes </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=fin/code-etablissement-liste.jsp" method="post" name="listeCodes" id="listeCodes">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=fin/code-etablissement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien); 
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Désignation", "Description","Département","Service"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>
