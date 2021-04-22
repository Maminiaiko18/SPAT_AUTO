<%-- 
    Document   : contrat-modif
    Created on : 17 déc. 2020, 16:09:30
    Author     : Sanda
--%>

<%@page import="mg.spat.compta.ContratChantierLibComplet"%>
<%@page import="affichage.PageUpdate"%> 
<%@page import="user.UserEJB"%>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "mg.spat.compta.ContratChantier",
            nomtable = "contrat_chantier",
            apres = "travaux/contrat-fiche.jsp",
            titre = "Modifier contrat";
    
    ContratChantierLibComplet  objet = new ContratChantierLibComplet();
    objet.setNomTable("CONTRAT_CHANTIER_LIB_COMPLET");
    PageUpdate pi = new PageUpdate(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    ContratChantierLibComplet base = (ContratChantierLibComplet) pi.getBase();
    pi.getFormu().getChamp("idchantier").setPageAppel("choix/listeChantierChoix.jsp");
    pi.getFormu().getChamp("idchantier").setAutre("readonly");
    
    pi.getFormu().getChamp("prestataire").setPageAppel("choix/listeTiersChoix.jsp");
    pi.getFormu().getChamp("prestataire").setAutre("readonly");
    
    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
    
    pi.getFormu().getChamp("nocontrat").setLibelle("No Contrat");
    
    pi.getFormu().getChamp("code_etab").setLibelle("Code Etablissement");
    pi.getFormu().getChamp("code_etab").setAutre("readonly");
    pi.getFormu().getChamp("code_etab").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
    
    pi.getFormu().getChamp("nom_chantier").setVisible(false);
    pi.getFormu().getChamp("nom_prestataire").setVisible(false);
    pi.getFormu().getChamp("projetlib").setVisible(false);
    pi.getFormu().getChamp("code_etablib").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idchantier").setValeurLibelle(base.getNom_chantier());
    pi.getFormu().getChamp("prestataire").setValeurLibelle(base.getNom_prestataire());
    pi.getFormu().getChamp("projet").setValeurLibelle(base.getProjetlib());
    pi.getFormu().getChamp("code_etab").setValeurLibelle(base.getCode_etablib());
    pi.getFormu().getChamp("idchantier").setLibelle("Chantier");
            
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>
    
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="update">
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

