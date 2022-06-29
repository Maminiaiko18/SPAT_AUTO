<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%@page import="mg.spat.Caisse"%>
<%@page import="facture.BonProvisoire"%>
<%@page import="affichage.PageUpdate"%> 
<%@page import="user.UserEJB"%>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "facture.BonProvisoire",
            nomtable = "bon_provisoire_final",
            apres = "facture/bon-provisoire-fiche.jsp",
            titre = "Modifier bon povisoire";
    
    BonProvisoire  objet = new BonProvisoire();
    objet.setNomTable(nomtable);
    PageUpdate pi = new PageUpdate(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("tiers").setAutre("readonly");
   
    pi.getFormu().getChamp("caisse").setLibelle("Caisse de retrait");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("estOM").setLibelle("Avec ordre de mission");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    
    pi.getFormu().getChamp("etat").setVisible(false);

    affichage.Champ[] liste = new affichage.Champ[1];
    Caisse esc = new Caisse();
    esc.setNomTable("Caisse");
    liste[0] = new Liste("caisse", esc, "val", "id");

    pi.getFormu().changerEnChamp(liste);
            
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

