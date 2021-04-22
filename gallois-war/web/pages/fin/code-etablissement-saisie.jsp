<%-- 
    Document   : code-etablissement-saisie
    Created on : 22 janv. 2021, 17:03:50
    Author     : Sanda
--%>
<%@page import="lc.Direction"%>
<%@page import="mg.cnaps.formation.CodeEtablissement"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="affichage.Liste" %>
<%@ page import="affichage.PageInsert" %>

<%
    try{
    UserEJB u;
    CodeEtablissement a;
    String nomtable = "CodeEtablissement", 
           butee = "fin/code-etablissement-fiche.jsp" ,
           classee = "mg.cnaps.formation.CodeEtablissement" ,
           titree = "Saisie code etablissement " ;
    String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new CodeEtablissement();
    a.setNomTable(nomtable);
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    affichage.Champ[] liste = new affichage.Champ[3];
    Direction entite = new Direction();
    entite.setNomTable("direction");
    liste[0] = new Liste("desce", entite,"libelledir","iddir");
    TypeObjet entite1 = new TypeObjet();
    entite1.setNomTable("departement");
    liste[1] = new Liste("departement", entite1,"VAL","id");
    TypeObjet entite2 = new TypeObjet();
    entite2.setNomTable("service");
    liste[2] = new Liste("service", entite2,"VAL","id");
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("val").setLibelle("Code");
    pi.getFormu().getChamp("desce").setLibelle("Direction");
    
   
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box-fiche">
                <div class="box">
                    <h1><%= titree %></h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="formabsence">
                         <%
                            pi.getFormu().makeHtmlInsertTabIndex();
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <input name="acte" type="hidden" id="acte" value="insert">
                        <input name="bute" type="hidden" id="bute" value="<%= butee %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classee %>">
                        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomtable %>">

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> 
	alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>
