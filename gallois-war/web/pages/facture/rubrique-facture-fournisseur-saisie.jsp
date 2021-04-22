<%-- 
    Document   : rubrique-facture-fournisseur-saisie
    Created on : 9 févr. 2021, 11:03:08
    Author     : Sanda
--%>

<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%@page import="rubrique.RubriqueFactureFournisseur"%>
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Utilitaire"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "rubrique.RubriqueFactureFournisseur",
            nomtable = "rubriqueFactureFournisseur",
            apres = "facture/rubrique-facture-fournisseur-fiche.jsp",
            titre = "Rubrique Facture Fournisseur";
    
    RubriqueFactureFournisseur  objet = new RubriqueFactureFournisseur();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    affichage.Champ[] listeUnit = new affichage.Champ[1];
    TypeObjet branche=new TypeObjet();
    branche.setNomTable("natureoperation");
    listeUnit[0]=new Liste("designation",branche,"val","id");
    pi.getFormu().changerEnChamp(listeUnit);
    pi.getFormu().getChamp("designation").setLibelle("Nature opération");
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
