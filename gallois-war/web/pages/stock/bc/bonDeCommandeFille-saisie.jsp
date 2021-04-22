<%-- 
    Document   : additif-saisie
    Created on : 18 déc. 2020, 09:27:13
    Author     : Sanda
--%>

<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%@page import="avoir.Avoir"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Utilitaire"%> 
<%@page import="affichage.Champ"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%> 
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String idmere=request.getParameter("idbc");
    String  mapping = "mg.spat.stock.BonDeCommandeFille",
            nomtable = "AS_BONDECOMMANDE_FILLE",
            apres = "stock/bc/asBonDeCommande-fiche.jsp&id="+idmere,
            titre = "Saisie détails BC";
    
    BonDeCommandeFille  objet = new BonDeCommandeFille();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet liste1 = new TypeObjet();
    liste1.setNomTable("unitechantier");
    liste[0] = new Liste("unite", liste1, "val", "id");
    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("produit").setPageAppel("choix/produitChoix.jsp");
    pi.getFormu().getChamp("idbc").setAutre("readonly");
    pi.getFormu().getChamp("idbc").setDefaut(idmere);
    pi.getFormu().getChamp("idbc").setLibelle("Bon de Commande");
    pi.getFormu().getChamp("pu").setLibelle("Prix Unitaire");
    pi.getFormu().getChamp("quantiteparpack").setVisible(false);
    pi.getFormu().getChamp("montant").setVisible(false);
    
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
