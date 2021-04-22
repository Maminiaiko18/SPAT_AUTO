<%-- 
    Document   : formateur-saisie
    Created on : 14 oct. 2015, 03:00:56
    Author     : user
--%>
<%@page import="mg.cnaps.formation.FormFormateur"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageInsert"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    FormFormateur a = new FormFormateur();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("id_etablissement").setLibelle("Etablissement");
    pi.getFormu().getChamp("nom").setLibelle("Nom");
    pi.getFormu().getChamp("niveau").setLibelle("Niveau");
    pi.getFormu().getChamp("experience").setLibelle("Exp&eacute;rience");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("remarque").setLibelle("Remarque");
    pi.getFormu().getChamp("id_etablissement").setPageAppel("choix/formetablissementChoix.jsp");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1 align="center">Saisie de Formateur</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="formateur" id="formateur"  data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="configuration/formateur-liste.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormFormateur">
    </form>
</div>
