
<%@page import="utilitaire.Utilitaire"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="avoir.RegulAvoirFC"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%> 
<%@page import="mg.spat.Tva"%> 
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    
    String  mapping = "avoir.RegulAvoirFC",
            nomtable = "regulAvoirFC",
            apres = "avoir/avoirFC-liste.jsp",
            titre = "Regul Avoir FC",
            idavoir = request.getParameter("idAvoir");
    
    RegulAvoirFC objet = new RegulAvoirFC();
    objet.setNomTable(nomtable);
    
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
    pi.getFormu().getChamp("idFacture").setLibelle("Facture");
    
    pi.getFormu().getChamp("idFacture").setPageAppel("choix/listeFactureClientChoix.jsp");
    pi.getFormu().getChamp("idFacture").setAutre("readonly");
    
    pi.getFormu().getChamp("idAvoir").setLibelle("Avoir");
    pi.getFormu().getChamp("idAvoir").setAutre("readonly");
    
    if((idavoir != null)&&(idavoir != "")){
        pi.getFormu().getChamp("idAvoir").setDefaut(idavoir);
        apres = "avoir/avoirFC-fiche.jsp?id="+idavoir;
    }
            
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


