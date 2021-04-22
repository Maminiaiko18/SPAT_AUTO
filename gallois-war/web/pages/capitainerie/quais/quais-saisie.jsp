<%-- 
    Document   : mouvement-saisie
    Created on : 6 nov. 2019, 11:20:59
    Author     : Notiavina
--%>

<%@page import="mg.spat.Quais"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Quais quai = new Quais();
    PageInsert pi = new PageInsert(quai, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    affichage.Champ[] liste = new affichage.Champ[1];
    
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("typequais");
    liste[0] = new Liste("typequais", mvt, "VAL", "id");
    
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("val").setLibelle("Nom");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("typequais").setLibelle("type Quais");
    pi.getFormu().getChamp("pays").setPageAppel("choix/listePaysChoix.jsp");
    pi.getFormu().getChamp("pays").setAutre("readonly");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un Quais</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="capitainerie/quais/quais-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.Quais">
    </form>
</div>
    <% }catch(Exception ex){
    ex.printStackTrace();
}%>