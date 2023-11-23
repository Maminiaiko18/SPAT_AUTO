<%-- 
    Document   : contrat-saisie
    Created on : 17 déc. 2020, 15:46:31
    Author     : Sanda
--%>

<%@page import="affichage.Champ"%> 
<%@page import="affichage.Liste"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="mg.spat.compta.ContratChantier"%>
<%@page import="mg.spat.Tva"%> 
<%@page import="user.UserEJB"%>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "mg.spat.compta.ContratChantier",
            nomtable = "contrat_chantier",
            apres = "travaux/contrat-fiche.jsp",
            titre = "Saisie contrat";
    
    ContratChantier  objet = new ContratChantier();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
    affichage.Champ[] liste = new affichage.Champ[1];
    Tva tva = new Tva();
    liste[0] = new Liste("tva", tva, "valeurtva", "valeurtva");
    pi.getFormu().changerEnChamp(liste);
        
    pi.getFormu().getChamp("idchantier").setPageAppel("choix/listeChantierChoix.jsp");
    pi.getFormu().getChamp("idchantier").setAutre("readonly");
    pi.getFormu().getChamp("prestataire").setPageAppel("choix/listeTiersChoix.jsp");
    pi.getFormu().getChamp("prestataire").setAutre("readonly");
    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("code_etab").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
    pi.getFormu().getChamp("code_etab").setAutre("readonly");

    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idchantier").setDefaut(request.getParameter("idchantier"));
    if(request.getParameter("idchantier") != null && request.getParameter("nom") != null){
        pi.getFormu().getChamp("idchantier").setValeurLibelle(request.getParameter("nom"));
    }
    pi.getFormu().getChamp("idchantier").setLibelle("Chantier");
    pi.getFormu().getChamp("code_etab").setLibelle("Code etablissement");
            
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
