

<%@page import="mg.spat.relationhumaine.InfoCongePermission"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    InfoCongePermission pj = new InfoCongePermission();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.getFormu().getChamp("date_debut_conge").setLibelle("Date début congé");
    pi.getFormu().getChamp("date_fin_conge").setLibelle("Date fin congé");
    pi.getFormu().getChamp("date_debut_permission").setLibelle("Date début permission");
    pi.getFormu().getChamp("date_fin_permission").setLibelle("Date fin permission");
    pi.getFormu().getChamp("nombrepermission").setLibelle("Nombre permission");
    pi.getFormu().getChamp("idPersonnel").setLibelle("Personnel");
    pi.getFormu().getChamp("idPermission").setVisible(false);
    
    pi.getFormu().getChamp("idPersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie conge et permission</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="carriere/conge-permission-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.InfoCongePermission">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>