<%@page import="facture.RegulFCProvision"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%> 
<%
try{
    UserEJB u = (user.UserEJB) session.getValue("u");
    String idProvision = request.getParameter("idProvision");
    String  mapping = "facture.RegulFCProvision",
            nomtable = "regulFCProvision",
            apres = "facture/regul-fc-fiche.jsp",
            titre = "Saisie Régul FC Provision";
    
    RegulFCProvision objet = new RegulFCProvision();
    objet.setNomTable(nomtable);
    
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
    pi.getFormu().getChamp("idProvision").setPageAppel("choix/listeFactureClientChoix.jsp");
    pi.getFormu().getChamp("idFacture").setPageAppel("choix/listeFactureClientChoix.jsp");
    
    pi.getFormu().getChamp("idProvision").setAutre("readonly");
    pi.getFormu().getChamp("idFacture").setAutre("readonly");
    
    if(idProvision!=null && !idProvision.isEmpty()){
        pi.getFormu().getChamp("idProvision").setDefaut(idProvision);
    }
    pi.getFormu().getChamp("etat").setVisible(false);
    
    pi.getFormu().getChamp("idProvision").setLibelle("Provision");
    pi.getFormu().getChamp("idFacture").setLibelle("Facture");
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
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>