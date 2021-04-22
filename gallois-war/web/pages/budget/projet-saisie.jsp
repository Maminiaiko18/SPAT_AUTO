<%-- 
    Document   : projet-saisie
    Created on : 29 déc. 2020, 08:56:33
    Author     : Sanda
--%>


<%@page import="projet.Projet"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "projet.Projet",
            nomtable = "projet",
            apres = "budget/projet-fiche.jsp",
            titre = "Nouveau projet";
    
    Projet  objet = new Projet();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
//    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
//    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("section_budget").setVisible(false);
    pi.getFormu().getChamp("montant_credit").setLibelle("montant credit");
            
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
