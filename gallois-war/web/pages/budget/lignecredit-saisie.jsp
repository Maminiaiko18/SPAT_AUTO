<%-- 
    Document   : lignecredit-saisie
    Created on : 9 févr. 2021, 09:58:25
    Author     : Sanda
--%>

<%@page import="affichage.Liste"%> 
<%@page import="affichage.PageInsert"%>
<%@page import="bean.TypeObjet"%>  
<%@page import="lignecredit.LigneCredit"%>
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Utilitaire"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "lignecredit.LigneCredit",
            nomtable = "lignecredit",
            apres = "budget/lignecredit-fiche.jsp",
            titre = "Ligne Credit saisie";
    
    LigneCredit  objet = new LigneCredit();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
    affichage.Champ[] liste = new affichage.Champ[2];
    TypeObjet liste1 = new TypeObjet();
    liste1.setNomTable("TypeLingeCredit");
    liste[0] = new Liste("idTypeLingeCredit", liste1, "val", "id");
    Liste liste2 = new Liste("mois");
    liste2.makeListeMois();
    liste[1] = liste2;
    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("Annee").setDefaut(Utilitaire.getAnneeEnCours());
    pi.getFormu().getChamp("Creditinitial").setLibelle("Credit initial");
    pi.getFormu().getChamp("Idtypelingecredit").setLibelle("Type");

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
