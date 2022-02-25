<%-- 
    Document   : additif-saisie
    Created on : 18 d�c. 2020, 09:27:13
    Author     : Sanda
--%>

<%@page import="avoir.Avoir"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Utilitaire"%> 
<%@page import="mg.spat.Liberer"%> 
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "mg.spat.Engagement",
            nomtable = "liberer",
            apres = "depense/liberer-fiche.jsp",
            titre = "Nouvel Liberer";
    
    Liberer  objet = new Liberer();
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
    
    pi.getFormu().getChamp("etat").setVisible(false);
    
    pi.getFormu().getChamp("idengagement").setPageAppel("choix/listeEngagementChoix.jsp");
    pi.getFormu().getChamp("idengagement").setAutre("readonly");
   
    pi.getFormu().getChamp("idengagement").setLibelle("Engagement");

    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>
    
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=apres%>">
        <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> 
	alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>
