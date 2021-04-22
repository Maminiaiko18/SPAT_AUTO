<%-- 
    Document   : avancement-contrat-saisie
    Created on : 29 déc. 2020, 09:59:56
    Author     : Sanda
--%>

<%@page import="avancement.AvancementContrat"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%> 
<%@page import="utilitaire.Utilitaire"%> 
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "avancement.AvancementContrat",
            nomtable = "avancement_contrat",
            apres = "travaux/avancement-contrat-fiche.jsp",
            titre = "Saisie avancement contrat";
    
    AvancementContrat  objet = new AvancementContrat();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    String apresContrat = "";
    if(request.getParameter("idcontrat") != null){
        String idcontrat = request.getParameter("idcontrat");
        pi.getFormu().getChamp("idcontrat").setDefaut(idcontrat);
        pi.getFormu().getChamp("idcontrat").setValeurLibelle(idcontrat);
        apresContrat = "&nocontrat="+idcontrat;        
    }
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("idcontrat").setPageAppel("choix/listeContratChoix.jsp",apresContrat);
    pi.getFormu().getChamp("idcontrat").setAutre("readonly");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idcontrat").setLibelle("Contrat");
            
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

