<%-- 
    Document   : newjsp
    Created on : 23 oct. 2015, 11:39:12
    Author     : user
--%>
<%@page import="mg.cnaps.formation.FormAbsence"%>
<%@page import="bean.CGenUtil"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    FormAbsence a = new FormAbsence();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    String idform=request.getParameter("idformation");
    String idpers=request.getParameter("idpers");
    if(idform!=null && idform.compareToIgnoreCase("")!=0){
        pi.getFormu().getChamp("id_formation").setDefaut(idform);
        pi.getFormu().getChamp("log_personnel").setDefaut(idpers);
    }
    pi.getFormu().getChamp("id_formation").setLibelle("Formation");
    pi.getFormu().getChamp("log_personnel").setLibelle("Personnel");
    pi.getFormu().getChamp("date_absence").setLibelle("Date d'absence");
    pi.getFormu().getChamp("date_absence").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pi.getFormu().getChamp("motif").setLibelle("Motif");
    pi.getFormu().getChamp("remarque").setLibelle("Remarque");
    pi.getFormu().getChamp("remarque").setVisible(false);
    
    pi.getFormu().getChamp("id_formation").setPageAppel("choix/formFormationChoix.jsp");
    pi.getFormu().getChamp("log_personnel").setPageAppel("choix/listeIdentificationChoix.jsp");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1 align="center">Absences</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="absence" id="absence" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="formation/absence-liste.jsp">
<!--        <input name="bute" type="hidden" id="bute" value="formation/formation-fiche.jsp&id=<%=idform%>">-->
        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormAbsence">
        <input name="nomtable" type="hidden" id="nomtable" value="FORM_ABSENCE">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% } %>
