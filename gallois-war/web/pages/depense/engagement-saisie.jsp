<%-- 
    Document   : additif-saisie
    Created on : 18 d�c. 2020, 09:27:13
    Author     : Sanda
--%>

<%@page import="avoir.Avoir"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Utilitaire"%> 
<%@page import="mg.spat.Engagement"%> 
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "mg.spat.Engagement",
            nomtable = "engagement",
            apres = "depense/engagement-fiche.jsp",
            titre = "Nouvel Engagement";
    
    Engagement  objet = new Engagement();
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
    
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("projet").setVisible(false);
    pi.getFormu().getChamp("codeEtablissement").setVisible(false);
    
    pi.getFormu().getChamp("codeEtablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
    pi.getFormu().getChamp("codeEtablissement").setAutre("readonly");
    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("idLC").setPageAppel("choix/listeBudgetDepenseChoix.jsp","idLC;idLClibelle;idLClibelle;idLClibelle");
    pi.getFormu().getChamp("idLC").setAutre("readonly");

    pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    pi.getFormu().getChamp("codeEtablissement").setLibelle("Code &Eacute;tablissement");
    pi.getFormu().getChamp("dispoAvant").setLibelle("Disponible Avant");
    pi.getFormu().getChamp("dispoApres").setLibelle("Disponible Apres");
    pi.getFormu().getChamp("idLC").setLibelle("Budget");
    
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
