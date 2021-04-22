<%-- 
    Document   : coursdevise-saisie
    Created on : 2 févr. 2021, 17:11:08
    Author     : Sanda
--%>

<%@page import="fin.Coursdevise"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%> 
<%@page import="utilitaire.Utilitaire"%> 
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "fin.Coursdevise",
            nomtable = "coursdevise",
            apres = "fin/coursdevise-fiche.jsp",
            titre = "Saisie cours devise";
    
    Coursdevise  objet = new Coursdevise();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
     affichage.Champ[] liste = new affichage.Champ[1];
     TypeObjet liste1 = new TypeObjet();
     liste1.setNomTable("devise");
//     liste1.setNomTable("devisedemat");
     liste[0] = new Liste("iddevise", liste1, "val", "id");
     pi.getFormu().changerEnChamp(liste);
	
     pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
     pi.getFormu().getChamp("daty").setLibelle("Date");
     pi.getFormu().getChamp("iddevise").setLibelle("devise");
            
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
