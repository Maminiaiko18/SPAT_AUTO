<%-- 
    Document   : edition-mictsl
    Created on : 27 juil. 2021, 16:01:36
    Author     : Andriamiary
--%>

<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%@page import="user.UserEJB"%>
<%@page import="facture.EditionMICTSL"%>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "facture.EditionMICTSL",
            nomtable = "editionMICTSLvide",
            apres = "apresFacture.jsp",
            titre = "Gestion MICTSL";
    
    EditionMICTSL  edition = new EditionMICTSL();
    edition.setNomTable(nomtable);
    
    PageInsert pi = new PageInsert(edition, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));  
    
    affichage.Champ[] liste = new affichage.Champ[2];
    TypeObjet mois = new TypeObjet();
    mois.setNomTable("mois");
    liste[0] = new Liste("mois", mois, "VAL", "id");
    
    String[] aff={"Redevance fixe", "Redevance variable","Droit de port","Penalité de retard","Penalite de performance"};
    String[] val={"1","2","3","4","5"};
    Liste lst = new Liste();
    lst.ajouterValeur(val, aff);
    lst.setNom("type");
    liste[1] = lst;
    
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("noteexplicative").setLibelle("Note explicative");
    pi.getFormu().getChamp("annee").setLibelle("Année");
    pi.getFormu().getChamp("annee").setDefaut(Utilitaire.getAnneeEnCours());
            
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>
    
    <form action="<%=pi.getLien()%>?but=apresFacture.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="genererMICTSL">
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