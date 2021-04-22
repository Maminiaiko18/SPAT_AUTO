<%-- 
    Document   : tarifRubriqueFactureClient-saisie
    Created on : 11 févr. 2021, 14:54:19
    Author     : Sanda
--%>

<%@page import="rubrique.TarifRubriqueFactureClient"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%> 
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "rubrique.TarifRubriqueFactureClient",
            nomtable = "tarifRubriqueFactureClient",
            apres = "facture/tarifRubriqueFactureClient-fiche.jsp",
            titre = "Tarif rubrique facture client saisie";
    
    TarifRubriqueFactureClient  objet = new TarifRubriqueFactureClient();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
     affichage.Champ[] liste = new affichage.Champ[2];
     TypeObjet liste1 = new TypeObjet();
     liste1.setNomTable("devise");
     liste[0] = new Liste("iddevise", liste1, "desce", "id");
     TypeObjet liste2 = new TypeObjet();
     liste2.setNomTable("natureoperation");
     liste[1] = new Liste("idnature", liste2, "desce", "id");
     pi.getFormu().changerEnChamp(liste);
	
     pi.getFormu().getChamp("etat").setVisible(false);
     pi.getFormu().getChamp("iddevise").setLibelle("Devise");
     pi.getFormu().getChamp("idNature").setLibelle("Nature");
     pi.getFormu().getChamp("prixUnitaire").setLibelle("Prix Unitaire");
     pi.getFormu().getChamp("borne_inf").setLibelle("Borne inférieur");
     pi.getFormu().getChamp("borne_sup").setLibelle("Borne supérieur");
            
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

